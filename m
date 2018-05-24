Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755301AbeEXF6q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:58:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43524 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeEXF6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:58:43 -0400
X-Google-Smtp-Source: AB8JxZo+sog5SrYAlpynlGl1SWkh3qA9YFSJ4vjpxg54gtxIPZwORvu88od/IP2LBMEamVyujHyJJg==
Date: Thu, 24 May 2018 08:58:39 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH 5/9] clk: bd71837: Devicetree bindings for ROHM BD71837 PMIC
Message-ID: <20180524055838.GF4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC clock output.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/clock/rohm,bd71837-clock.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
new file mode 100644
index 000000000000..9759fd145781
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
@@ -0,0 +1,37 @@
+ROHM BD71837 Power Management Integrated Circuit clock bindings
+
+BD71837 clock node should be sub node of the BD71837 MFD node.
+See BD71837 MFD bindings at
+Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+
+Required properties:
+- compatible		: Should be "rohm,bd71837-clk"
+- clock-frequency	: Should be 32768
+- #clock-cells		: Should be 0
+
+Optional properties:
+- clock-output-names	: Should contain name for output clock.
+  Name "bd71837-32k-out" is used if this is not given.
+
+
+Example:
+
+pmic: bd71837@4b {
+	compatible = "rohm,bd71837";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x4b>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <29 GPIO_ACTIVE_LOW>;
+	interrupt-names = "irq";
+	#interrupt-cells = <1>;
+	interrupt-controller;
+
+	/* Clock node */
+	clk: bd71837-32k-out {
+		compatible = "rohm,bd71837-clk";
+		#clock-cells = <0>;
+		clock-frequency  = <32768>;
+		clock-output-names = "bd71837-32k-out";
+	};
+};
-- 
2.14.3
