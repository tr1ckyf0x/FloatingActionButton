//
//  FloatingActionButton.swift
//  
//
//  Created by Vladislav Lisianskii on 06.02.2022.
//

import SwiftUI

public struct FloatingActionButton<ImageView: View>: ViewModifier {
    public let color: Color
    public let image: ImageView
    public let size: CGFloat
    public let margin: CGFloat

    public let action: () -> Void

    public init(
        color: Color,
        image: ImageView,
        size: CGFloat = 60,
        margin: CGFloat = 15,
        action: @escaping () -> Void
    ) {
        self.color = color
        self.image = image
        self.size = size
        self.margin = margin
        self.action = action
    }

    public func body(content: Content) -> some View {
        GeometryReader { geometryReader in
            ZStack {
                Color.clear // allows the ZStack to fill the entire screen
                content
                button(geometryReader)
            }
        }
    }
}

extension FloatingActionButton {
    @ViewBuilder private func button(_ geometryProxy: GeometryProxy) -> some View {
        image
            .imageScale(.large)
            .frame(width: size, height: size)
            .background(Circle().fill(color))
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
            .onTapGesture(perform: action)
            .offset(x: (geometryProxy.size.width - size) / 2 - margin,
                    y: (geometryProxy.size.height - size) / 2 - margin)
    }
}

#if DEBUG
struct FloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .foregroundColor(.white)
            .modifier(
                FloatingActionButton(
                    color: .blue,
                    image: Image(systemName: "plus").foregroundColor(.white),
                    action: {}
                )
            )

    }
}
#endif
