Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164750AbeCBDyE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:54:04 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37452 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164732AbeCBDwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:52:00 -0500
X-Google-Smtp-Source: AG47ELslkPM/CRvgLOSGAsC1L0QVHYtHSi0HSLhQ5Dor2cAHKPLM16bN2dumG+6hjF7nwQj7t3xR5Q==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
Date: Fri,  2 Mar 2018 09:20:40 +0530
Message-Id: <20180302035045.14660-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/gpio/actions,owl-gpio.txt  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
new file mode 100644
index 000000000000..d2939ca6cfaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
@@ -0,0 +1,95 @@
+* Actions Semi OWL GPIO controller bindings
+
+The GPIOs are organized as individual banks/ports with variable number
+of GPIOs. Each bank is represented as an individual GPIO controller.
+
+Required properties:
+- compatible            : Should be "actions,s900-gpio"
+- reg                   : Address and range of the GPIO controller registers.
+- gpio-controller       : Marks the device node as a GPIO controller.
+- #gpio-cells           : Should be <2>. The first cell is the gpio number
+                          and the second cell is used to specify optional
+                          parameters.
+- interrupt-controller  : Marks the device node as an interrupt controller.
+- #interrupt-cells      : Specifies the number of cells needed to encode an
+                          interrupt.  Shall be set to 2.  The first cell
+                          defines the interrupt number, the second encodes
+                          the trigger flags described in
+                          bindings/interrupt-controller/interrupts.txt
+
+Optional properties:
+- gpio-ranges           : Mapping between GPIO and pinctrl
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
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpiob: gpiob@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 32 32>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpioc: gpioc@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 64 12>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpiod: gpiod@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 76 30>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpioe: gpioe@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 106 32>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpiof: gpiof@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 138 8>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
-- 
2.14.1
