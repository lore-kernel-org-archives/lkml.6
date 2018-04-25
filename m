Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDYM4L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:56:11 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:65300 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDYMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:55:52 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-doc@vger.kernel.org>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 10/15] ARM: dts: dra7-evm: Model EVM_3V6 regulator
Date: Wed, 25 Apr 2018 18:24:44 +0530
Message-ID: <20180425125449.19755-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425125449.19755-1-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TI's DRA74x EVM, EVM_3V6 is connected is connected to the VBAT line
of the wilink card. Model it here so that it can be used while adding
wilink8 WLAN support.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index f1425b0f3a54..181289a28ca1 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -20,6 +20,16 @@
 		reg = <0x0 0x80000000 0x0 0x60000000>; /* 1536 MB */
 	};
 
+	evm_12v0: fixedregulator-evm_12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	evm_1v8_sw: fixedregulator-evm_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_1v8";
@@ -54,6 +64,38 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
+	evm_3v3: fixedregulator-evm3v3 {
+		/* Output of Cntlr A of TPS43351-Q1 on dra7-evm */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	evm_5v0: fixedregulator-evm_5v0 {
+		/* Output of Cntlr B of TPS43351-Q1 on dra7-evm */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	evm_3v6: fixedregulator-evm_3v6 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_3v6";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+		vin-supply = <&evm_5v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	extcon_usb2: extcon_usb2 {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
-- 
2.17.0
