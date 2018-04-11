Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeDKIy1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:54:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752174AbeDKIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:54:19 -0400
X-UUID: ec8322660a5441eb8570b39a0069ad19-20180411
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 09/12] arm: dts: mt7623: extend common file reused by all boards with MT7623 SoCs
Date: Wed, 11 Apr 2018 16:54:02 +0800
Message-ID: <2452c5479c3687b909829dcfd090954f2c80efc2.1523434758.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Move all possible setups for pio into SoC level DTSI file mt7623.dtsi in
order to introduce more boards such as official MT7623A reference boards
without copy-n-pasting almost the same content of nodes in pio into every
new file.

So, it should be better to reuse those nodes by consolidating them into
the common file mt7623.dtsi from the current existent DTS and allow new
DTS files to refer to them.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 246 ++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 217 -----------------------
 arch/arm/boot/dts/mt7623n-rfb-nand.dts        |  31 ----
 3 files changed, 246 insertions(+), 248 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index eef81d2..01893858 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -935,3 +935,249 @@
 		status = "disabled";
 	};
 };
+
+&pio {
+	cir_pins_a:cir-default {
+		pins-cir {
+			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
+			bias-disable;
+		};
+	};
+
+	i2c0_pins_a: i2c0-default {
+		pins-i2c0 {
+			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
+				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins_a: i2c1-default {
+		pin-i2c1 {
+			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
+				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
+			bias-disable;
+		};
+	};
+
+	i2s0_pins_a: i2s0-default {
+		pin-i2s0 {
+			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
+				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
+				 <MT7623_PIN_73_I2S0_LRCK_FUNC_I2S0_LRCK>,
+				 <MT7623_PIN_74_I2S0_BCK_FUNC_I2S0_BCK>,
+				 <MT7623_PIN_126_I2S0_MCLK_FUNC_I2S0_MCLK>;
+			drive-strength = <MTK_DRIVE_12mA>;
+			bias-pull-down;
+		};
+	};
+
+	i2s1_pins_a: i2s1-default {
+		pin-i2s1 {
+			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
+				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
+				 <MT7623_PIN_35_I2S1_BCK_FUNC_I2S1_BCK>,
+				 <MT7623_PIN_36_I2S1_LRCK_FUNC_I2S1_LRCK>,
+				 <MT7623_PIN_37_I2S1_MCLK_FUNC_I2S1_MCLK>;
+			drive-strength = <MTK_DRIVE_12mA>;
+			bias-pull-down;
+		};
+	};
+
+	key_pins_a: keys-alt {
+		pins-keys {
+			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
+				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
+			input-enable;
+		};
+	};
+
+	led_pins_a: leds-alt {
+		pins-leds {
+			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
+				 <MT7623_PIN_240_EXT_XCS_FUNC_GPIO240>,
+				 <MT7623_PIN_241_EXT_SCK_FUNC_GPIO241>;
+		};
+	};
+
+	mmc0_pins_default: mmc0default {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins-rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0 {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
+				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
+				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
+				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
+				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+
+		pins-wp {
+			pinmux = <MT7623_PIN_29_EINT7_FUNC_MSDC1_WP>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-insert {
+			pinmux = <MT7623_PIN_261_MSDC1_INS_FUNC_GPIO261>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1 {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
+				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
+				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
+				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
+				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	nand_pins_default: nanddefault {
+		pins-ale {
+			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_NLD3>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_NLD0>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_NLD1>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_NLD5>,
+				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins-we {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	pcie_default: pcie_pin_default {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
+				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
+			bias-disable;
+		};
+	};
+
+	pwm_pins_a: pwm-default {
+		pins-pwm {
+			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
+				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
+				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
+				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
+				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
+		};
+	};
+
+	spi0_pins_a: spi0-default {
+		pins-spi {
+			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
+				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
+				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
+				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
+			bias-disable;
+		};
+	};
+
+	uart0_pins_a: uart0-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
+				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
+		};
+	};
+
+	uart1_pins_a: uart1-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
+				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
+		};
+	};
+
+	uart2_pins_a: uart2-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
+				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 395912e..531d905 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -281,223 +281,6 @@
 	status = "okay";
 };
 
-&pio {
-	cir_pins_a:cir-default {
-		pins-cir {
-			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
-			bias-disable;
-		};
-	};
-
-	i2c0_pins_a: i2c0-default {
-		pins-i2c0 {
-			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
-				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
-			bias-disable;
-		};
-	};
-
-	i2c1_pins_a: i2c1-default {
-		pin-i2c1 {
-			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
-				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
-			bias-disable;
-		};
-	};
-
-	i2s0_pins_a: i2s0-default {
-		pin-i2s0 {
-			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
-				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
-				 <MT7623_PIN_73_I2S0_LRCK_FUNC_I2S0_LRCK>,
-				 <MT7623_PIN_74_I2S0_BCK_FUNC_I2S0_BCK>,
-				 <MT7623_PIN_126_I2S0_MCLK_FUNC_I2S0_MCLK>;
-			drive-strength = <MTK_DRIVE_12mA>;
-			bias-pull-down;
-		};
-	};
-
-	i2s1_pins_a: i2s1-default {
-		pin-i2s1 {
-			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
-				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
-				 <MT7623_PIN_35_I2S1_BCK_FUNC_I2S1_BCK>,
-				 <MT7623_PIN_36_I2S1_LRCK_FUNC_I2S1_LRCK>,
-				 <MT7623_PIN_37_I2S1_MCLK_FUNC_I2S1_MCLK>;
-			drive-strength = <MTK_DRIVE_12mA>;
-			bias-pull-down;
-		};
-	};
-
-	key_pins_a: keys-alt {
-		pins-keys {
-			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
-				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
-			input-enable;
-		};
-	};
-
-	led_pins_a: leds-alt {
-		pins-leds {
-			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
-				 <MT7623_PIN_240_EXT_XCS_FUNC_GPIO240>,
-				 <MT7623_PIN_241_EXT_SCK_FUNC_GPIO241>;
-		};
-	};
-
-	mmc0_pins_default: mmc0default {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
-				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
-			input-enable;
-			bias-pull-up;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
-			bias-pull-down;
-		};
-
-		pins-rst {
-			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
-			bias-pull-up;
-		};
-	};
-
-	mmc0_pins_uhs: mmc0 {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
-				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_2mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_2mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
-		};
-
-		pins-rst {
-			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
-			bias-pull-up;
-		};
-	};
-
-	mmc1_pins_default: mmc1default {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
-				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
-				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
-				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
-				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
-			bias-pull-down;
-			drive-strength = <MTK_DRIVE_4mA>;
-		};
-
-		pins-wp {
-			pinmux = <MT7623_PIN_29_EINT7_FUNC_MSDC1_WP>;
-			input-enable;
-			bias-pull-up;
-		};
-
-		pins-insert {
-			pinmux = <MT7623_PIN_261_MSDC1_INS_FUNC_GPIO261>;
-			bias-pull-up;
-		};
-	};
-
-	mmc1_pins_uhs: mmc1 {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
-				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
-				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
-				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
-				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_4mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-	};
-
-	pcie_default: pcie_pin_default {
-		pins_cmd_dat {
-			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
-				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
-			bias-disable;
-		};
-	};
-
-	pwm_pins_a: pwm-default {
-		pins-pwm {
-			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
-				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
-				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
-				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
-				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
-		};
-	};
-
-	spi0_pins_a: spi0-default {
-		pins-spi {
-			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
-				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
-				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
-				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
-			bias-disable;
-		};
-	};
-
-	uart0_pins_a: uart0-default {
-		pins-dat {
-			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
-				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
-		};
-	};
-
-	uart1_pins_a: uart1-default {
-		pins-dat {
-			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
-				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
-		};
-	};
-
-	uart2_pins_a: uart2-default {
-		pins-dat {
-			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
-				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
-		};
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm_pins_a>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
index 6b0d401..96ff3c9 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
@@ -71,34 +71,3 @@
 		};
 	};
 };
-
-&pio {
-	nand_pins_default: nanddefault {
-		pins-ale {
-			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins-dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_NLD3>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_NLD0>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_NLD1>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_NLD5>,
-				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-up;
-		};
-
-		pins-we {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-	};
-};
-- 
2.7.4
