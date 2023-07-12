import UIKit

class KeyboardViewController: UIInputViewController {

    var keyboardView: UIView!

    var currentKeyboard: KeyRows = .english

    enum KeyRows: CaseIterable {
        case english, hebrew, swissGerman

        var keys: [String] {
            switch self {
                case .english:
                    return [
                        "QWERTYUIOP",
                        "ASDFGHJKL",
                        "ZXCVBNM",
                        "1234567890"
                    ]
                case .hebrew:
                    return [
                        "קראטוןםפ",
                        "שדגכעיחלךף",
                        "זסבהנמצתץ",
                        "1234567890"
                    ]
                case .swissGerman:
                    return [
                        "QWERTZUIOPÜ",
                        "ASDFGHJKLÖÄ",
                        "YXCVBNM",
                        "1234567890"
                    ]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 250))
        keyboardView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(keyboardView)

        createKeyboardLayout()
    }

    func createKeyboardLayout() {
//        for view in keyboardView.subviews {
//            view.removeFromSuperview()
//        }
//
//        let keyRows = currentKeyboard.keys
//
//        for (rowIndex, rowKeys) in keyRows.enumerated() {
//            for (index, key) in rowKeys.enumerated() {
//                let keyButton = UIButton(type: .system)
//                keyButton.setTitle(String(key), for: [])
//                keyButton.sizeToFit()
//                keyButton.frame = CGRect(x: index * 32, y: rowIndex * 50, width: 30, height: 40)
//                keyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
//
//                // Modify the appearance of the keys
//                keyButton.backgroundColor = .white
//                keyButton.layer.cornerRadius = 5
//                keyButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
//
//                keyboardView.addSubview(keyButton)
//            }
//        }

        for view in keyboardView.subviews {
            view.removeFromSuperview()
        }

        let keyRows = currentKeyboard.keys
        let keyWidth: CGFloat = 30
        let keySpacing: CGFloat = 2
        let keyHeight: CGFloat = 40
        let rowSpacing: CGFloat = 50

        for (rowIndex, rowKeys) in keyRows.enumerated() {
            let totalRowWidth = CGFloat(rowKeys.count) * (keyWidth + keySpacing) - keySpacing
            let startX = (keyboardView.frame.width - totalRowWidth) / 2

            for (index, key) in rowKeys.enumerated() {
                let keyButton = UIButton(type: .system)
                keyButton.setTitle(String(key), for: [])
                keyButton.sizeToFit()
                keyButton.frame = CGRect(x: startX + CGFloat(index) * (keyWidth + keySpacing), y: CGFloat(rowIndex) * rowSpacing, width: keyWidth, height: keyHeight)
                keyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)

                // Modify the appearance of the keys
                keyButton.backgroundColor = .white
                keyButton.layer.cornerRadius = 5
                keyButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)

                keyboardView.addSubview(keyButton)
            }
        }

        // Add a delete button
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(systemName: "delete.left"), for: .normal)
        deleteButton.sizeToFit()
        deleteButton.frame = CGRect(x: 280, y: 200, width: 40, height: 40)
        deleteButton.addTarget(self, action: #selector(deleteKeyPressed), for: .touchUpInside)

        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 5
        deleteButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)

        keyboardView.addSubview(deleteButton)

        // Add a space button
        let spaceButton = UIButton(type: .system)
        spaceButton.setTitle("Space", for: [])
        spaceButton.sizeToFit()
        spaceButton.frame = CGRect(x: 120, y: 200, width: 80, height: 40)
        spaceButton.addTarget(self, action: #selector(spaceKeyPressed), for: .touchUpInside)

        spaceButton.backgroundColor = .white
        spaceButton.layer.cornerRadius = 5
        spaceButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)

        keyboardView.addSubview(spaceButton)

        // Add a return button
        let returnButton = UIButton(type: .system)
        returnButton.setImage(UIImage(systemName: "return.right"), for: .normal)
        returnButton.sizeToFit()
        returnButton.frame = CGRect(x: 200, y: 200, width: 70, height: 40)
        returnButton.addTarget(self, action: #selector(returnKeyPressed), for: .touchUpInside)

        returnButton.backgroundColor = .white
        returnButton.layer.cornerRadius = 5
        returnButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)

        keyboardView.addSubview(returnButton)

        // Add a switch button
        let switchButton = UIButton(type: .system)
        switchButton.setTitle("Switch", for: [])
        switchButton.sizeToFit()
        switchButton.frame = CGRect(x: 0, y: 200, width: 80, height: 40)
        switchButton.addTarget(self, action: #selector(switchKeyboard), for: .touchUpInside)

        switchButton.backgroundColor = .white
        switchButton.layer.cornerRadius = 5
        switchButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)

        keyboardView.addSubview(switchButton)
    }

    @objc func keyPressed(_ sender: UIButton) {
        let key = sender.title(for: []) ?? ""
        (textDocumentProxy as UIKeyInput).insertText(key)
    }

    @objc func deleteKeyPressed() {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }

    @objc func spaceKeyPressed() {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }

    @objc func returnKeyPressed() {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }

    @objc func switchKeyboard() {
        let allKeyboards = KeyRows.allCases
        if let currentIndex = allKeyboards.firstIndex(of: currentKeyboard), currentIndex + 1 < allKeyboards.count {
            currentKeyboard = allKeyboards[currentIndex + 1]
        } else {
            currentKeyboard = allKeyboards.first!
        }
        createKeyboardLayout()
    }
}
