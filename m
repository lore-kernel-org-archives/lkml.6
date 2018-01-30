Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeA3MJA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:09:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41349 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeA3MI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:08:57 -0500
X-Google-Smtp-Source: AH8x226wOjuwZB1FibTUmY3c7NfMZUVs+Yjw4/mW/TNIyAMtAhfUTZdQZPRjYlVo+mPOhibb1aWaDA==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/2] dt-bindings: gpio: Add Spreadtrum GPIO controller documentation
Date: Tue, 30 Jan 2018 20:07:42 +0800
Message-Id: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the Spreadtrum
GPIO controller. The gpios will be supported by the GPIO
generic library.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-sprd.txt         |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
new file mode 100644
index 0000000..eca97d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
@@ -0,0 +1,28 @@
+Spreadtrum GPIO controller bindings
+
+The controller's registers are organized as sets of sixteen 16-bit
+registers with each set controlling a bank of up to 16 pins. A single
+interrupt is shared for all of the banks handled by the controller.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-gpio".
+- reg: Define the base and range of the I/O address space containing
+the GPIO controller registers.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be <2>. The first cell is the gpio number and
+the second cell is used to specify optional parameters.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be <2>. Specifies the number of cells needed
+to encode interrupt source.
+- interrupts: Should be the port interrupt shared by all the gpios.
+
+Example:
+	ap_gpio: gpio@40280000 {
+		compatible = "sprd,sc9860-gpio";
+		reg = <0 0x40280000 0 0x1000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.7.9.5
