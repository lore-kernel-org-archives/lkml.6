Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D71C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80422084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfAUJ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:57:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54258 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfAUJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:57:19 -0500
Received: from hades.home (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D9CF427285D;
        Mon, 21 Jan 2019 09:57:16 +0000 (GMT)
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        Christian Hemp <c.hemp@phytec.de>,
        =?UTF-8?q?Stefan=20Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD i.MX6UL Segin
Date:   Mon, 21 Jan 2019 09:57:05 +0000
Message-Id: <20190121095705.27452-2-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121095705.27452-1-martyn.welch@collabora.com>
References: <20190121095705.27452-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Phytec phyBOARD Segin is i.MX6 based SBC, available with either an
i.MX6UL or i.MX6ULL SOM and various add-on boards.

The following adds support for the "Full Featured" version of the Segin,
which is provided with the i.MX6UL SOM and the PEB-EVAL-01 evaluation
module.

Its hardware specifications are:

 * 512MB DDR3 memory
 * 512MB NAND flash
 * Dual 10/100 Ethernet
 * USB Host and USB OTG
 * RS232
 * MicroSD external storage
 * Audio, RS232, I2C, SPI, CAN headers
 * Further I/O options via A/V and Expansion headers

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

---

Changes in v3:
- Add memory device_type property
- Remove unneeded pinctrl-names property
- Keep compatible string on a single line
- Make node names generic and labels specific

Changes in v2:
- Corrected spacing, ordering and naming
- Corrected ecspi3 chip selects
- Updated deprecated node
- Removed unneeded nodes

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi   | 148 ++++++++
 .../boot/dts/imx6ul-phytec-peb-eval-01.dtsi   |  55 +++
 .../dts/imx6ul-phytec-phyboard-segin-full.dts |  89 +++++
 .../dts/imx6ul-phytec-phyboard-segin.dtsi     | 329 ++++++++++++++++++
 5 files changed, 622 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148a15b2..d35a0bf7b8f8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -561,6 +561,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-pico-pi.dtb \
+	imx6ul-phytec-phyboard-segin-full.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi b/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
new file mode 100644
index 000000000000..fc2997449b49
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "imx6ul.dtsi"
+
+/ {
+	model = "Phytec phyCORE i.MX6 UltraLite";
+	compatible = "phytec,imx6ul-pcl063", "fsl,imx6ul";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	/*
+	 * Set the minimum memory size here and
+	 * let the bootloader set the real size.
+	 */
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x8000000>;
+	};
+
+	gpio_leds_som: leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpioleds_som>;
+		compatible = "gpio-leds";
+
+		led_green {
+			label = "phycore:green";
+			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			reg = <1>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 =<&pinctrl_i2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	eeprom@52 {
+		compatible = "catalyst,24c32", "atmel,24c32";
+		reg = <0x52>;
+	};
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x17059
+		>;
+	};
+
+	pinctrl_gpioleds_som: gpioledssomgrp {
+		fsl,pins = <MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x0b0b0>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0x0b0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0x0b0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0x0b0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x0b000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0x0b0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0x0b0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0x0b0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x0b0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x0b0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0x0b0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0x0b0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0x0b0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0x0b0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0x0b0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x0b0b1
+		>;
+	};
+
+	pinctrl_i2c1: i2cgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi b/arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi
new file mode 100644
index 000000000000..e2f38f39a6ad
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 PHYTEC Messtechnik
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio_keys: gpio-keys {
+		compatible = "gpio-key";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+		status = "disabled";
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	user_leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_user_leds>;
+		status = "disabled";
+
+		led_yellow {
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		led_red {
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_gpio_keys: gpio_keysgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x79
+		>;
+	};
+
+	pinctrl_user_leds: user_ledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x79
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x79
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
new file mode 100644
index 000000000000..b6a1407a9d44
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+/dts-v1/;
+#include "imx6ul-phytec-pcl063.dtsi"
+#include "imx6ul-phytec-phyboard-segin.dtsi"
+#include "imx6ul-phytec-peb-eval-01.dtsi"
+
+/ {
+	model = "Phytec phyBOARD-Segin i.MX6 UltraLite Full Featured";
+	compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063", "fsl,imx6ul";
+};
+
+&adc1 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&tlv320 {
+	status = "okay";
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&fec2 {
+	status = "okay";
+};
+
+&i2c_rtc {
+	status = "okay";
+};
+
+&reg_can1_en {
+	status = "okay";
+};
+
+&reg_sound_1v8 {
+	status = "okay";
+};
+
+&reg_sound_3v3 {
+	status = "okay";
+};
+
+&sai2 {
+	status = "okay";
+};
+
+&sound {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbotg1 {
+	status = "okay";
+};
+
+&usbotg2 {
+	status = "okay";
+};
+
+&usdhc1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
+			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
+			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
+			MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20	0x10b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
new file mode 100644
index 000000000000..7bf439a77d2c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+/ {
+	model = "Phytec phyBOARD-Segin i.MX6 UltraLite";
+	compatible = "phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063", "fsl,imx6ul";
+
+	aliases {
+		rtc0 = &i2c_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	reg_sound_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "i2s-audio-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		status = "disabled";
+	};
+
+	reg_sound_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "i2s-audio-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		status = "disabled";
+	};
+
+	reg_can1_en: regulator-can1 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&princtrl_flexcan1_en>;
+		regulator-name = "Can";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		status = "disabled";
+	};
+
+	reg_adc1_vref_3v3: regulator-vref-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "phyBOARD-Segin-TLV320AIC3007";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Speaker", "Speaker";
+		simple-audio-card,routing =
+			"Line Out", "LLOUT",
+			"Line Out", "RLOUT",
+			"Speaker", "SPOP",
+			"Speaker", "SPOM",
+			"LINE1L", "Line In",
+			"LINE1R", "Line In";
+		status = "disabled";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&tlv320>;
+			clocks = <&clks IMX6UL_CLK_SAI2>;
+		};
+	};
+
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc1>;
+	vref-supply = <&reg_adc1_vref_3v3>;
+	/*
+	 * driver can not separate a specific channel so we request 4 channels
+	 * here - we need only the fourth channel
+	 */
+	num-channels = <4>;
+	status = "disabled";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_en>;
+	status = "disabled";
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "disabled";
+};
+
+&i2c1 {
+	tlv320: codec@18 {
+		compatible = "ti,tlv320aic3007";
+		#sound-dai-cells = <0>;
+		reg = <0x18>;
+		AVDD-supply = <&reg_sound_3v3>;
+		IOVDD-supply = <&reg_sound_3v3>;
+		DRVDD-supply = <&reg_sound_3v3>;
+		DVDD-supply = <&reg_sound_1v8>;
+		status = "disabled";
+	};
+
+	stmpe: touchscreen@44 {
+		compatible = "st,stmpe811";
+		reg = <0x44>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio5>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_stmpe>;
+		status = "disabled";
+
+		touchscreen {
+			compatible = "st,stmpe-ts";
+			st,sample-time = <4>;
+			st,mod-12b = <1>;
+			st,ref-sel = <0>;
+			st,adc-freq = <1>;
+			st,ave-ctrl = <1>;
+			st,touch-det-delay = <2>;
+			st,settling = <2>;
+			st,fraction-z = <7>;
+			st,i-drive = <1>;
+			touchscreen-inverted-x = <1>;
+			touchscreen-inverted-y = <1>;
+		};
+	};
+
+	i2c_rtc: rtc@68 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc_int>;
+		compatible = "microcrystal,rv4162";
+		reg = <0x68>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		status = "disabled";
+	};
+};
+
+&mdio {
+	ethphy1: ethernet-phy@2 {
+		reg = <2>;
+		micrel,led-mode = <1>;
+		clocks = <&clks IMX6UL_CLK_ENET2_REF>;
+		clock-names = "rmii-ref";
+	};
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "disabled";
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			<&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <19200000>;
+	fsl,sai-mclk-direction-output;
+	status = "disabled";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	dr_mode = "otg";
+	status = "disabled";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "disabled";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_adc1: adc1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1 {
+		fsl,pins = <
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x0b0b0
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x0b0b0
+		>;
+	};
+
+	princtrl_flexcan1_en: flexcan1engrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x17059
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO04__PWM3_OUT	0x0b0b0
+		>;
+	};
+
+	pinctrl_rtc_int: rtcintgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x17059
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+		>;
+	};
+
+	pinctrl_stmpe: stmpegrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x17059
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
+			MX6UL_PAD_GPIO1_IO08__UART5_DCE_RTS	0x1b0b1
+			MX6UL_PAD_GPIO1_IO09__UART5_DCE_CTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usbotg1idgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+};
-- 
2.20.1

