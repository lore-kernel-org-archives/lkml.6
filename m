Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCEOhv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:37:51 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35206 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeCEOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:37:44 -0500
X-Google-Smtp-Source: AG47ELutb1BiDphaUhXeJhNsx2Q/Ng7ZtnYe+YvRvBXo/Y9r3BIfpocpDRQrSpOn7P3wwBryHzQ3dQ==
From: musashino.open@gmail.com
To: f.fainelli@gmail.com
Cc: hauke@hauke-m.de, zajec5@gmail.com, jonmason@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH] ARM: dts: BCM5301X: add missing LEDs for Buffalo WZR-900DHP
Date: Mon,  5 Mar 2018 23:36:03 +0900
Message-Id: <1520260563-4167-1-git-send-email-musashino.open@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: INAGAKI Hiroshi <musashino.open@gmail.com>

Buffalo WZR-900DHP has 8 LEDs, but there is not LED definitions in the
dts and cannot configure these LEDs.
I Added missing LED definitions for WZR-900DHP.

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 8bef642..fa8f917 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -35,6 +35,79 @@
 		       0x88000000 0x08000000>;
 	};
 
+	spi {
+		compatible = "spi-gpio";
+		num-chipselects = <1>;
+		gpio-sck = <&chipcommon 7 0>;
+		gpio-mosi = <&chipcommon 4 0>;
+		cs-gpios = <&chipcommon 6 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hc595: gpio_spi@0 {
+			compatible = "fairchild,74hc595";
+			reg = <0>;
+			registers-number = <1>;
+			spi-max-frequency = <100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		usb {
+			label = "bcm53xx:green:usb";
+			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		power0 {
+			label = "bcm53xx:green:power";
+			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		power1 {
+			label = "bcm53xx:red:power";
+			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		router0 {
+			label = "bcm53xx:green:router";
+			gpios = <&hc595 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		router1 {
+			label = "bcm53xx:amber:router";
+			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		wan {
+			label = "bcm53xx:green:wan";
+			gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		wireless0 {
+			label = "bcm53xx:green:wireless";
+			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		wireless1 {
+			label = "bcm53xx:amber:wireless";
+			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
-- 
2.7.4
