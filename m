Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeC1RyU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:54:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46907 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbeC1RyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:54:15 -0400
X-Google-Smtp-Source: AIpwx49b9LeuG9KlRgWo3A9ONkRnrA52mCPHjlMbDc34OIc8W6CkmOGWAp3Ux83raMwwTsAOaZMZDg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 4/9] dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
Date: Wed, 28 Mar 2018 23:16:58 +0530
Message-Id: <20180328174703.19778-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/gpio/actions,owl-gpio.txt  | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
new file mode 100644
index 000000000000..34283e9195ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
@@ -0,0 +1,87 @@
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
+- ngpios                : Specifies the number of GPIO lines.
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
+Examples:
+
+       gpioa: gpio@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x000c>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 0 32>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpiob: gpio@e01b000c {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b000c 0x0 0x000c>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 32 32>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpioc: gpio@e01b0018 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0018 0x0 0x000c>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 64 12>;
+               ngpios = <12>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpiod: gpio@e01b0024 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0024 0x0 0x000c>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 76 30>;
+               ngpios = <30>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpioe: gpio@e01b0030 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0030 0x0 0x000c>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 106 32>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
+
+       gpiof: gpio@e01b00f0 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b00f0 0x0 0x000c>;
+               gpio-controller;
+               #gpio-cells = <2>;
+               gpio-ranges = <&pinctrl 0 138 8>;
+               ngpios = <8>;
+               interrupt-controller;
+               #interrupt-cells = <2>;
+       };
-- 
2.14.1
