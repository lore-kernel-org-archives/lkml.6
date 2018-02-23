Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeBWKTy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:19:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:23098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbeBWKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:55 -0500
X-UUID: b8c44d5fd1574ac182848b7663dcc5fb-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 12/19] arm: dts: mt7623: fix all Warnings (unit_address_vs_reg)
Date: Fri, 23 Feb 2018 18:16:32 +0800
Message-ID: <5cf5b140e45b8484eca780b53cc223ba8d1d768b.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix below a lot of warnings that dtc complains so much

Warning (unit_address_vs_reg): Node /oscillator@1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /oscillator@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/cir@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/i2c@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/i2c@1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/i2s@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/i2s@1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/keys@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/leds@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/pwm@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/spi@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/uart@0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/uart@1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /pinctrl@10005000/uart@2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /ethernet@1b100000/mdio-bus/switch@0/ports has a reg or ranges property, but no unit name

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/mt7623.dtsi                 |  4 ++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 29 +++++++++++++--------------
 arch/arm/boot/dts/mt7623n-rfb.dtsi            |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 4b68448..bf9db44 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -130,14 +130,14 @@
 		#clock-cells = <0>;
 	};
 
-	rtc32k: oscillator@1 {
+	rtc32k: oscillator-1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32000>;
 		clock-output-names = "rtc32k";
 	};
 
-	clk26m: oscillator@0 {
+	clk26m: oscillator-0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index a6295ef..75e61c4 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -158,7 +158,6 @@
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <0>;
 
 				port@0 {
 					reg = <0>;
@@ -262,14 +261,14 @@
 };
 
 &pio {
-	cir_pins_a:cir@0 {
+	cir_pins_a:cir-default {
 		pins-cir {
 			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
 			bias-disable;
 		};
 	};
 
-	i2c0_pins_a: i2c@0 {
+	i2c0_pins_a: i2c0-default {
 		pins-i2c0 {
 			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
 				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
@@ -277,7 +276,7 @@
 		};
 	};
 
-	i2c1_pins_a: i2c@1 {
+	i2c1_pins_a: i2c1-default {
 		pin-i2c1 {
 			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
 				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
@@ -285,7 +284,7 @@
 		};
 	};
 
-	i2s0_pins_a: i2s@0 {
+	i2s0_pins_a: i2s0-default {
 		pin-i2s0 {
 			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
 				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
@@ -297,7 +296,7 @@
 		};
 	};
 
-	i2s1_pins_a: i2s@1 {
+	i2s1_pins_b: i2s1-default {
 		pin-i2s1 {
 			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
 				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
@@ -309,7 +308,7 @@
 		};
 	};
 
-	key_pins_a: keys@0 {
+	key_pins_a: keys-alt {
 		pins-keys {
 			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
 				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
@@ -317,7 +316,7 @@
 		};
 	};
 
-	led_pins_a: leds@0 {
+	led_pins_a: leds-alt {
 		pins-leds {
 			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
 				 <MT7623_PIN_240_EXT_XCS_FUNC_GPIO240>,
@@ -428,15 +427,15 @@
 		};
 	};
 
-	pcie_default: pcie_pin_default {
-		pins_cmd_dat {
+	pcie_default: pcie-pin-default {
+		pins-cmd-dat {
 			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
 				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
 			bias-disable;
 		};
 	};
 
-	pwm_pins_a: pwm@0 {
+	pwm_pins_a: pwm-default {
 		pins-pwm {
 			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
 				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
@@ -446,7 +445,7 @@
 		};
 	};
 
-	spi0_pins_a: spi@0 {
+	spi0_pins_a: spi0-default {
 		pins-spi {
 			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
 				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
@@ -456,21 +455,21 @@
 		};
 	};
 
-	uart0_pins_a: uart@0 {
+	uart0_pins_a: uart0-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
 				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
 		};
 	};
 
-	uart1_pins_a: uart@1 {
+	uart1_pins_a: uart1-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
 				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
 		};
 	};
 
-	uart2_pins_a: uart@2 {
+	uart2_pins_a: uart2-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
 				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 256c5fd..128586d 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -50,7 +50,7 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
-	usb_p1_vbus: regulator@0 {
+	usb_p1_vbus: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.7.4
