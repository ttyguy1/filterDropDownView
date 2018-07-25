//
//  ViewController.swift
//  filterTab
//
//  Created by Tyler Middleton on 7/25/18.
//  Copyright © 2018 Tyler Middleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addInputAccessoryForTextFields(textFields: [startField, endField], dismissable: true, previousNextable: true)
        
        showFilterView()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        showFilterView()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        startField.inputAccessoryView = toolbar
        startField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let dateStr = formatter.string(from: datePicker.date)
        startField.text = dateStr
        self.filterView.frame.origin.y = -128
    }
    
    func showDatePicker1(){
        //Formate Date
        datePicker1.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        endField.inputAccessoryView = toolbar
        endField.inputView = datePicker1
        
        datePicker1.addTarget(self, action: #selector(handleDatePicker2(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker2(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let dateStr = formatter.string(from: datePicker1.date)
        endField.text = dateStr
    }
    
    @objc func showFilterView() {
        if filterView.frame.origin.y == 88 {
            UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.filterView.frame.origin.y = -58
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.filterView.frame.origin.y = 88
            }, completion: nil)
        }
        
    }
    
}

extension UIViewController {
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: UIImage(named: "leftArrow1"), style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem(image: UIImage(named: "rightArrow1"), style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
}

