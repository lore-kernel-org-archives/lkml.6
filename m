Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427458AbeCBMTI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:19:08 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:34286 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423302AbeCBMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:18:13 -0500
X-Auth-Info: XSDPEmjJk1eOA/R2gvUAN4bYFthWeTYHqg50Ff4WWNk=
From: Lukasz Majewski <lukma@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
Date: Fri,  2 Mar 2018 13:17:50 +0100
Message-Id: <20180302121750.12865-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree description of K+P's TPC board.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx6q-kp-tpc.dts |  84 +++++++
 arch/arm/boot/dts/imx6q-kp.dtsi    | 468 +++++++++++++++++++++++++++++++++++++
 3 files changed, 553 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
 create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..c148c4cf28f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-ofcap12.dtb \
 	imx6q-icore-rqs.dtb \
+	imx6q-kp-tpc.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb \
 	imx6q-nitrogen6x.dtb \
diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/imx6q-kp-tpc.dts
new file mode 100644
index 000000000000..955462e778c9
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
@@ -0,0 +1,84 @@
+/*
+ * Copyright 2018
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is licensed under the terms of the GNU General Public
+ *     License version 2.  This program is licensed "as is" without
+ *     any warranty of any kind, whether express or implied.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "imx6q-kp.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad K+P TPC Board";
+	compatible = "fsl,imx6q-tpc", "fsl,imx6q";
+};
+
+&lcd_display {
+	display-timings {
+		800x480x60 {
+			clock-frequency = <34209000>;
+			hactive = <800>;
+			vactive = <480>;
+			hback-porch = <85>;
+			hfront-porch = <15>;
+			vback-porch = <34>;
+			vfront-porch = <10>;
+			hsync-len = <28>;
+			vsync-len = <1>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+			de-active = <1>;
+		};
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
new file mode 100644
index 000000000000..47a10fb1d46b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -0,0 +1,468 @@
+/*
+ * Copyright 2018
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is licensed under the terms of the GNU General Public
+ *     License version 2.  This program is licensed "as is" without
+ *     any warranty of any kind, whether express or implied.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
+/ {
+
+	backlight_lcd: backlight-lcd {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		status = "okay";
+	};
+
+	lcd_display: disp0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1>;
+		status = "okay";
+
+		port {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green {
+			label = "led1";
+			gpios = <&gpio3 16 0>;
+			linux,default-trigger = "gpio";
+			default-state = "off";
+		};
+
+		red {
+			label = "led0";
+			gpios = <&gpio3 23 0>;
+			linux,default-trigger = "gpio";
+			default-state = "off";
+		};
+	};
+
+	memory: memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	pwm-buzzer {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>; //2kHz
+		brightness-levels = <
+			0   7  8  9
+			10 11 12 13 14 15 16 17 18 19
+			20 21 22 23 24 25 26 27 28 29
+			30 31 32 33 34 35 36 37 38 39
+			40 41 42 43 44 45 46 47 48 49
+			50 51 52 53 54 55 56 57 58 59
+			60 61 62 63 64 65 66 67 68 69
+			70 71 72 73 74 75 76 77 78 79
+			80 81 82 83 84 85 86 87 88 89
+			90 91 92 93 94 95 96 97 98 99
+			100
+			>;
+		default-brightness-level = <0>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_h1_vbus: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+		};
+
+		reg_audio: regulator@2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "sgtl5000-supply";
+			gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-always-on;
+		};
+
+		reg_3p3v: regulator@3 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx6q-sgtl5000-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,frame-master = <&codec_dai>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+
+	ssi1 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSEL(2) |
+			IMX_AUDMUX_V2_PTCR_TCSEL(2) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(2)
+		>;
+	};
+
+	aud3 {
+		fsl,audmux-port = <2>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+		>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	fsl,magic-packet;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	goodix_ts@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ts>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 2>;
+		irq-gpios = <&gpio1 9 0>;
+		reset-gpios = <&gpio5 2 0>;
+	};
+
+	rx8025@32 {
+		compatible = "dallas,rx8025";
+		reg = <0x32>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec: sgtl5000@a {
+		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec>;
+
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&iomuxc {
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS	0x130b0
+		>;
+	};
+
+	pinctrl_codec: codecgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31   0x1b0b0
+			/* sgtl5000 sys_mclk clock routed to CLKO1 */
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000b0
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO	0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC	0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0	0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1	0x1b0b0
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2	0x1b0b0
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3	0x1b0b0
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC	0x1b0b0
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0	0x1b0b0
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1	0x1b0b0
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2	0x1b0b0
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3	0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
+		>;
+	};
+
+	pinctrl_flexcan1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX        0x1b0b0
+			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX        0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan2: can2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX        0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX        0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+		 >;
+	};
+
+	pinctrl_ipu1: ipu1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_ts: tsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x1b0b0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D26__UART2_TX_DATA       0x1b0b1
+			MX6QDL_PAD_EIM_D27__UART2_RX_DATA       0x1b0b1
+			MX6QDL_PAD_EIM_D28__UART2_CTS_B         0x1b0b1
+			MX6QDL_PAD_EIM_D29__UART2_RTS_B         0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+		>;
+	};
+
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
+		>;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&wdog1 {
+	status = "okay";
+};
-- 
2.11.0
