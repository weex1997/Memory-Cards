//
//  CardCollectionViewCell.swift
//  memory color
//
//  Created by Wedad Almehmadi on 08/01/2023.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    


    @IBOutlet weak var FrontViewImage: UIImageView!
    
    @IBOutlet weak var BackViewImage: UIImageView!
    
    var card:Card?
        
        func configureCell(card:Card) {

            // accessibility
            isAccessibilityElement = true
            
            // Keep track of the card this cell represents
            self.card = card
            
            // Set the front image view to the image that represents the card
            FrontViewImage.image = UIImage(named: card.imageName)
            
            // Reset the state of the cell by checking the flipped status of the card and then showing the front or the back imageview accordingly
            
            if card.isMatched == true {
                BackViewImage.alpha = 0
                FrontViewImage.alpha = 0
                return
            }
            else {
                BackViewImage.alpha = 1
                FrontViewImage.alpha = 1
            }
            
            if card.isFlipped == true {
                // Show the front image view
                flipUp(speed: 0)
            }
            else {
                // Show the back image view
                flipDown(speed: 0, delay: 0)
            }
            
        }
        
        func flipUp(speed:TimeInterval = 0.3) {
            
            // Flip up animation
            UIView.transition(from: BackViewImage, to: FrontViewImage, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
            
            // Set the status of the card
            card?.isFlipped = true
        }
        
        func flipDown(speed:TimeInterval = 0.3, delay:TimeInterval = 0.5) {
            
            // Set the status of the card
            card?.isFlipped = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                
                // Flip down animation
                UIView.transition(from: self.FrontViewImage, to: self.BackViewImage, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
                
            }
            
           
        }
        
        func remove() {
            
            // Make the image views invisible
            BackViewImage.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                
                self.FrontViewImage.alpha = 0
                
            }, completion: nil)
        }
    }
