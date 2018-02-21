Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966185AbeBUQDJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:03:09 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33979 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754733AbeBUQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:03:04 -0500
X-Google-Smtp-Source: AH8x225UC8uNhjGliRpIEo2mNdVUSSy6gbip0Hz2CaSoNc2NrniF1h+QSZ/0FXk0nNeFV16PIR9Ghw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
Date: Wed, 21 Feb 2018 21:30:39 +0530
Message-Id: <20180221160044.15089-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/gpio/actions,owl-gpio.txt  | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
new file mode 100644
index 000000000000..855197e587a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
@@ -0,0 +1,76 @@
+* Actions Semi OWL GPIO controller bindings
+
+The GPIOs are organized as individual banks/ports with variable number
+of GPIOs. Each bank is represented as an individual GPIO controller.
+
+Required properties:
+- compatible      : Should be "actions,s900-gpio"
+- reg             : Address and range of the GPIO controller registers.
+- gpio-controller : Marks the device node as a GPIO controller.
+- #gpio-cells     : Should be <2>. The first cell is the gpio number and
+                    the second cell is used to specify optional parameters.
+
+Optional properties:
+- gpio-ranges     : Mapping between GPIO and pinctrl
+
+Note: Each GPIO port should have an alias correctly numbered in "aliases"
+node.
+
+Examples:
+
+aliases {
+        gpio0 = &gpioa;
+        gpio1 = &gpiob;
+        gpio2 = &gpioc;
+        gpio3 = &gpiod;
+        gpio4 = &gpioe;
+        gpio5 = &gpiof;
+};
+
+       gpioa: gpioa@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 0 32>;
+       };
+
+       gpiob: gpiob@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 32 32>;
+       };
+
+       gpioc: gpioc@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 64 12>;
+       };
+
+       gpiod: gpiod@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 76 30>;
+       };
+
+       gpioe: gpioe@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 106 32>;
+       };
+
+       gpiof: gpiof@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 138 8>;
+       };
-- 
2.14.1
