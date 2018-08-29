Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D633C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF8720846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF8720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emtrion.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeH2OFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:05:19 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:3123 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2OFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:05:19 -0400
Received: from tuelinux-v3.emtrion.local (2003:5a:a012:1:20c:29ff:fecb:7426)
 by bmk019s01.emtrion.local (2003:5a:a012:1:d9c:d045:28a7:5f84) with Microsoft
 SMTP Server (TLS) id 8.3.485.1; Wed, 29 Aug 2018 12:09:08 +0200
From:   Jan Tuerk <jan.tuerk@emtrion.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "GitAuthor: Jan Tuerk" <jan.tuerk@emtrion.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 3/4] ARM: dts: Add support for emtrion emCON-MX6 series
Date:   Wed, 29 Aug 2018 12:07:59 +0200
Message-ID: <20180829100811.55836-3-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829100811.55836-1-jan.tuerk@emtrion.com>
References: <20180824132617.43975-1-jan.tuerk@emtrion.com>
 <20180829100811.55836-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-24060.006
X-TM-AS-Result: No-0.074300-8.000000-31
X-TM-AS-MatchedID: 701762-186035-705753-704713-701433-700752-702609-700918-7
        07788-700016-701016-703529-708712-121504-188019-843086-704425-700324-121336
        -700624-704852-701482-853541-712124-704496-702311-700383-701040-700648-7016
        04-702106-702829-702898-700019-780012-700264-702890-780016-700163-701350-86
        3970-705567-186003-188198-712232-860136-139630-702747-780011-702113-700802-
        701274-139703-780058-850095-851079-148004-148133-42000-42003
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the emtrion GmbH emCON-MX6 modules.
They are available with imx.6 Solo, Dual-Lite, Dual and Quad
equipped with Memory from 512MB to 2GB (configured by U-Boot).

Our default developer-Kit ships with the Avari baseboard and the
EDT ETM0700G0BDH6 Display (imx6[q|dl]-emcon-avari).

The devicetree is split into the common part providing all module
components and the basic support for all SoC versions
(imx6qdl-emcon.dtsi) and parts which are i.mx6 S|DL and D|Q relevant.
Finally the support for the avari baseboard in the developer-kit
configuration is provided by the emcon-avari dts files.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/boot/dts/Makefile                 |   2 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts   |  14 +
 arch/arm/boot/dts/imx6q-emcon-avari.dts    |  14 +
 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi | 177 +++++
 arch/arm/boot/dts/imx6qdl-emcon.dtsi       | 832 +++++++++++++++++++++
 5 files changed, 1039 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

Changes v7:
 -Arrange aliases alphabetically
 -Sort I2C device-nodes by address 
 
All other patches unchanged

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..f7d1a2bd28ef 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -394,6 +394,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
 	imx6dl-dfi-fs700-m60.dtb \
+	imx6dl-emcon-avari.dtb \
 	imx6dl-gw51xx.dtb \
 	imx6dl-gw52xx.dtb \
 	imx6dl-gw53xx.dtb \
@@ -458,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-display5-tianma-tm070-1280x768.dtb \
 	imx6q-dmo-edmqmx6.dtb \
 	imx6q-dms-ba16.dtb \
+	imx6q-emcon-avari.dtb \
 	imx6q-evi.dtb \
 	imx6q-gk802.dtb \
 	imx6q-gw51xx.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-emcon-avari.dts b/arch/arm/boot/dts/imx6dl-emcon-avari.dts
new file mode 100644
index 000000000000..46eb7c2c7344
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-emcon-avari.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 or MIT)
+/*
+ * Copyright (C) 2018 emtrion GmbH
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-emcon.dtsi"
+#include "imx6qdl-emcon-avari.dtsi"
+
+/ {
+	model = "emtrion SoM emCON-MX6 Solo/Dual-Lite Avari";
+	compatible = "emtrion,emcon-mx6-avari", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-emcon-avari.dts b/arch/arm/boot/dts/imx6q-emcon-avari.dts
new file mode 100644
index 000000000000..fe719e0f8cae
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-emcon-avari.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 or MIT)
+/*
+ * Copyright (C) 2018 emtrion GmbH
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-emcon.dtsi"
+#include "imx6qdl-emcon-avari.dtsi"
+
+/ {
+	model = "emtrion SoM emCON-MX6 Dual/Quad on Avari";
+	compatible = "emtrion,emcon-mx6-avari", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi b/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
new file mode 100644
index 000000000000..e14fd38a79c6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: (GPL-2.0 or MIT)
+/*
+ * Copyright (C) 2018 emtrion GmbH
+ */
+
+/ {
+	aliases {
+		boardid = &boardid;
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc1;
+		mmc3 = &usdhc4;
+	};
+
+	reg_wall_5p0: reg-wall5p0 {
+		compatible = "regulator-fixed";
+		regulator-name = "Main-Supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_base3p3: reg-base3p3 {
+		compatible = "regulator-fixed";
+		vin-supply = <&reg_wall_5p0>;
+		regulator-name = "3V3-avari";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_base1p5: reg-base1p5 {
+		compatible = "regulator-fixed";
+		vin-supply = <&reg_base3p3>;
+		regulator-name = "1V5-avari";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_usb_otg: reg-otgvbus {
+		compatible = "regulator-fixed";
+		vin-supply = <&reg_wall_5p0>;
+		regulator-name = "OTG_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		regulator-always-on;
+	};
+
+	clk_codec: clock-codec {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency  = <12000000>;
+	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "emCON-avari-sgtl5000";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&ecspi2 {
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	sgtl5000: audio-codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clk_codec>;
+		VDDA-supply = <&reg_base3p3>;
+		VDDIO-supply = <&reg_base3p3>;
+	};
+
+	captouch: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_irq_touch2 &pinctrl_emcon_gpio4>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+		wake-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
+	};
+
+	boardid: gpio@3a {
+		compatible = "nxp,pca8574";
+		reg = <0x3a>;
+		gpio-controller;
+		#gpio-cells = <1>;
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&rgb_encoder {
+	status = "okay";
+};
+
+&rgb_panel {
+	compatible = "edt,etm0700g0bdh6";
+	status = "okay";
+};
+
+&ssi2 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+	uart-has-rtscts;
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+&usdhc1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
new file mode 100644
index 000000000000..d3fe31f411ae
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -0,0 +1,832 @@
+// SPDX-License-Identifier: (GPL-2.0 or MIT)
+/*
+ * Copyright (C) 2018 emtrion GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+
+	model = "emtrion SoM emCON-MX6";
+	compatible = "emtrion,emcon-mx6";
+
+	aliases {
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc1;
+		rtc0 = &ds1307;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@10000000 {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_emcon_wake>;
+
+		wake {
+			label = "Wake";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	som_leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_som_leds>;
+
+		green {
+			label = "som:green";
+			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+
+		red {
+			label = "som:red";
+			gpios = <&gpio3 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+		};
+
+	};
+
+	lvds_backlight: lvds-backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lvds_bl>;
+		enable-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>;
+		pwms = <&pwm1 0 50000>;
+		brightness-levels = <
+			0 4 8 16 32 64 80 96 112
+			128 144 160 176 250
+		>;
+		default-brightness-level = <13>;
+		status = "okay";
+	};
+
+	pwm_fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-min-state = <0>;
+		cooling-max-state = <4>;
+		#cooling-cells = <2>;
+		pwms = <&pwm4 0 50000>;
+		cooling-levels = <0 64 127 191 255>;
+		status = "disabled";
+	};
+
+
+	rgb_encoder: display {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rgb24_display>;
+		status = "disabled";
+
+		port@0 {
+			reg = <0>;
+
+			rgb_encoder_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			rgb_encoder_out: endpoint {
+				remote-endpoint = <&rgb_panel_in>;
+			};
+		};
+	};
+
+	rgb_panel: lcd {
+		backlight = <&rgb_backlight>;
+		power-supply = <&reg_parallel_disp>;
+
+		port {
+			rgb_panel_in: endpoint {
+				remote-endpoint = <&rgb_encoder_out>;
+			};
+		};
+	};
+
+	reg_parallel_disp: reg-parallel-display {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rgb_bl_en>;
+		regulator-name = "LCD-Supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio7 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_lvds_disp: reg-lvds-display {
+		compatible = "regulator-fixed";
+		regulator-name = "LVDS-Supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	rgb_backlight: rgb-backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rgb_bl>;
+		enable-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
+		pwms = <&pwm3 0 5000000>;
+		brightness-levels = <
+			250 176 160 144 128 112
+			96 80 64 48 32 16 8 1
+		>;
+		default-brightness-level = <13>;
+		status = "okay";
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>,
+		<&gpio2 27 GPIO_ACTIVE_HIGH>;
+};
+
+&ecspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nor_flash>;
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <50>;
+	phy-supply = <&vdd_1V8_reg>;
+	phy-handle = <&ksz9031>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ksz9031: phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+			rxdv-skew-ps = <480>;
+			txen-skew-ps = <480>;
+			rxd0-skew-ps = <480>;
+			rxd1-skew-ps = <480>;
+			rxd2-skew-ps = <480>;
+			rxd3-skew-ps = <480>;
+			txd0-skew-ps = <420>;
+			txd1-skew-ps = <420>;
+			txd2-skew-ps = <360>;
+			txd3-skew-ps = <360>;
+			txc-skew-ps = <1020>;
+			rxc-skew-ps = <960>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	da9063: pmic@58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		onkey {
+			compatible = "dlg,da9063-onkey";
+			wakeup-source;
+		};
+
+		watchdog {
+			compatible = "dlg,da9063-watchdog";
+			timeout-sec = <0>;
+		};
+
+		regulators {
+			vddcore_reg: bcore1 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1450000>;
+				regulator-ramp-delay = <2>;
+				regulator-name = "DA9063_CORE";
+				regulator-always-on;
+			};
+
+			vddsoc_reg: bcore2 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1450000>;
+				regulator-ramp-delay = <2>;
+				regulator-name = "DA9063_SOC";
+				regulator-always-on;
+			};
+
+			vdd_ddr3_reg: bpro {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-ramp-delay = <2>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_reg: bperi {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <2>;
+				regulator-always-on;
+			};
+
+			vdd_sata_reg: ldo3 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+			vdd_mipi_reg: ldo4 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			vdd_mx6_snvs_reg: ldo5 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_hdmi_reg: ldo6 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_pcie_reg: ldo7 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			vdd_1V8_reg: ldo8 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			vdd_3V3_sdc_reg: ldo9 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_1V2_reg: ldo10 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	ds1307: rtc@68 {
+		compatible = "dallas,ds1307";
+		reg = <0x68>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+};
+
+&iomuxc {
+
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD			0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC			0x1b060
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD			0x130B0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS			0x1b060
+		>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX		0x1b0b1
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX		0x1b0b1
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX		0x1b0b1
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX		0x1b0b1
+		>;
+	};
+
+	pinctrl_cpi1: csi0grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK 0xb0b1
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC	0x1b0b1
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19 0x1b0b1
+		>;
+	};
+
+	/*camera2-pinctrl is in imx6q-emcon.dtsi or imx6dl-emcon.dtsi*/
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK			0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI			0x100b1
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO			0x100b1
+			MX6QDL_PAD_EIM_LBA__GPIO2_IO27			0x100b1
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26			0x100b1
+		>;
+	};
+
+	pinctrl_emcon_gpio1: emcongpio1 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio2: emcongpio2 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio3: emcongpio3 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio4: emcongpio4 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio5: emcongpio5 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D4__GPIO2_IO04			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio6: emcongpio6 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio7: emcongpio7 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D6__GPIO2_IO06			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_gpio8: emcongpio8 {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D7__GPIO2_IO07			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_irq_a: emconirqa {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__GPIO6_IO07		0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_irq_b: emconirqb {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15		0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_irq_c: emconirqc {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16		0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_irq_pwr: emconirqpwr {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D23__GPIO3_IO23			0x0b0b1
+		>;
+	};
+
+	pinctrl_emcon_wake: emconwake {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_DA2__GPIO3_IO02			0x1b0b1
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b030
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b030
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x1b030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x1b030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x1b030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x1b030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x1b030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x4001a0b1
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x1b058
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30		0x1b0b0
+		 >;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4000b070
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b870
+		>;
+	};
+
+	pinctrl_irq_touch1: irqtouch1 {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05			0x0b0b1
+		>;
+	};
+
+	pinctrl_irq_touch2: irqtouch2 {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31			0x0b0b1
+		>;
+	};
+
+	pinctrl_lvds_bl: lvdsbacklightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__PWM1_OUT			0x0b0b1
+			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09		0x0b0b1
+		>;
+	};
+
+	pinctrl_lvds_reg: lvdsreggrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CLK__GPIO7_IO10			0x0b0b1
+		>;
+	};
+
+
+	pinctrl_nor_flash: norflashgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11		0x1b0b1
+			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK			0x100b1
+			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI			0x100b1
+			MX6QDL_PAD_EIM_D22__ECSPI4_MISO			0x100b1
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02			0x100b1
+		>;
+	};
+
+	pinctrl_pcie_ctrl: pciegrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A16__GPIO2_IO22			0x1b0b1
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x1b0b1
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08			0x0b0b1
+		>;
+	};
+
+	pinctrl_pwm_fan: pwmfan {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT2__PWM4_OUT			0x0b0b1
+		>;
+	};
+
+	pinctrl_rgb_bl: rgbbacklightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x0b0b1
+			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08		0x0b0b1
+		>;
+	};
+
+	pinctrl_rgb_bl_en: rgbenable {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__GPIO7_IO09			0x0b0b1
+		>;
+	};
+
+	pinctrl_rgb24_display: rgbgrp {
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
+	pinctrl_secure: securegrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_18__GPIO7_IO13			0x1b0b1
+		>;
+	};
+
+	pinctrl_som_leds: somledgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_DA0__GPIO3_IO00			0x0b0b1
+			MX6QDL_PAD_EIM_DA1__GPIO3_IO01			0x0b0b1
+		>;
+	};
+
+	pinctrl_spdif_in: spdifin {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_16__SPDIF_IN			0x1b0b0
+		>;
+	};
+
+	pinctrl_spdif_out: spdifout {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_19__SPDIF_OUT			0x13091
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B		0x1b0b1
+			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B		0x1b0b1
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_host1: usbhgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D31__USB_H1_PWR			0x1B058
+			MX6QDL_PAD_EIM_D30__USB_H1_OC			0x1B058
+		>;
+	};
+
+	pinctrl_usb_otg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID		0x17059
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07			0x17059
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08			0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD			0x17059
+			MX6QDL_PAD_SD1_CLK__SD1_CLK			0x10059
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x17059
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x17059
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x17059
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x17059
+			MX6QDL_PAD_GPIO_1__SD1_CD_B			0x1b0b1
+			MX6QDL_PAD_DI0_PIN4__SD1_WP			0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD			0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK			0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x17059
+			MX6QDL_PAD_GPIO_4__SD2_CD_B			0x1b0b1
+			MX6QDL_PAD_GPIO_2__SD2_WP			0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17059
+			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
+		>;
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&rgb_encoder_in>;
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie_ctrl>;
+	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	disable-gpio = <&gpio2 22 GPIO_ACTIVE_LOW>;
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
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
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_host1>;
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg>;
+	vbus-supply = <&reg_usb_otg>;
+	dr_mode = "peripheral";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	fsl,wp-controller;
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	fsl,wp-controller;
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
+/******device power Management*********/
+
+&cpu0 {
+	voltage-tolerance = <2>;
+};
+
+&reg_arm {
+	vin-supply = <&vddcore_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&vddsoc_reg>;
+};
+
+&reg_pu {
+	vin-supply = <&vddsoc_reg>;
+};
+
+/*******Disabled HW following***********/
+
+&snvs_rtc {
+	status = "disabled";
+};
-- 
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Geschäftsführer: Dieter Baur, Ramona Maurer

