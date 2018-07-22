Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0B720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0B720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGVRtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:49:24 -0400
Received: from mout.perfora.net ([74.208.4.197]:57725 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbeGVRrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:25 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LdWRI-1gPeuo1tBa-00ii57; Sun, 22 Jul 2018 18:50:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/28] ARM: tegra: apalis_t30: regulator clean-up
Date:   Sun, 22 Jul 2018 18:49:16 +0200
Message-Id: <20180722164936.20581-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:5txL03F3aj0aSB0RB95jxjG6r4kxM8hasjspT0Z723kLP2RZhPk
 tyON3iLGngNIHiD/a6xVt6h3uZOwe6os9WHfXGdOQz7DRy3dhVMdiFj/z97USarSygLk0EA
 7xTYOqzHB90hG8g5DWVj6JPHTgopTmEbUfuPeZqL94gk+V2HNqFR2OV9WZh4CGUfURqjygx
 +I51Fb453rwN83i3qrONA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uzfKQWF0c2Q=:9lfwi9We2z5lBD90wzD+vJ
 k/plnxo2DAlH6GenNwaUuCxoW88DuNhDEwov8AhI4oVVHJPjKIWLKeo7IeZzO0BoLQrr3dBUF
 4b6S3brTPm9eXPiFQ8SrAf5hGuQaER8N3kS7moqIfmglr1Yv9a9ZnEEDCJ2qkfdFX3zCLFpaz
 6VitXdMt4tETZJ3kPvU9y0uo0rDaXJUJrS6oDnLC+ZXZCmEVabGRHpLr5PXe/btpaOKNEdR3V
 YAkCjT1oUBUYRacPkyw+Nljg7wXt6J1g6l59MdpJO5iObQCeaJS1E9U5kiO8CFJRSpQXqyYwy
 1sPCLqgWzZjeh/lJza6RzMnHSTqi6IJTlf1OUqqWOTEB73QjOpn5hTX8hzQvkRQusj+eCn60T
 ZmtFq0e586AFn6Fm/56IHGltMqggGsqiwU+4lkdhnUs+mMOeZIYH9gs7nUfLud79xiU25PWLR
 nrihQkRudBA958G4JIBqNyc6oNfZjky0ur1FMmNsH0CHKoT01qoeDKykYAPDcw9NdAK4QrR1p
 dFK9ndrXRDA4Jn4SIwU7UAacsYd41Xt7A8DJtUeiV3rvxC6Qu5oWHsmBxWGd+MO10j3tjLpp9
 nrE2ZBu1qeO6iijaU6Rw61AjpLxh2DAapLDmOT5q0/tYWFanZaMOJJH9BPq8JX51CfxcA3kcf
 svV2ambcy9B67eRzvMahgMLbIifjPmXL1+b4GiUUAg4wVC0b3R7yT6LtMGBPSIMBbKT8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic regulator clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts |  62 ++++++-------
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 140 +++++++++++++-----------------
 2 files changed, 88 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 0dc85a20bd45..85e6adc82515 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -159,7 +159,7 @@
 	usb-phy@7d000000 {
 		status = "okay";
 		dr_mode = "otg";
-		vbus-supply = <&usbo1_vbus_reg>;
+		vbus-supply = <&reg_usbo1_vbus>;
 	};
 
 	/* EHCI instance 1: USB2_DP/N -> USBH2_DP/N */
@@ -169,7 +169,7 @@
 
 	usb-phy@7d004000 {
 		status = "okay";
-		vbus-supply = <&usbh_vbus_reg>;
+		vbus-supply = <&reg_usbh_vbus>;
 	};
 
 	/* EHCI instance 2: USB3_DP/N -> USBH3_DP/N */
@@ -179,7 +179,7 @@
 
 	usb-phy@7d008000 {
 		status = "okay";
-		vbus-supply = <&usbh_vbus_reg>;
+		vbus-supply = <&reg_usbh_vbus>;
 	};
 
 	backlight: backlight {
@@ -237,38 +237,32 @@
 		};
 	};
 
-	regulators {
-		sys_5v0_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "5v0";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_SW";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 
-		/* USBO1_EN */
-		usbo1_vbus_reg: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usbo1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio TEGRA_GPIO(T, 5) GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			vin-supply = <&sys_5v0_reg>;
-		};
+	/* USBO1_EN */
+	reg_usbo1_vbus: regulator-usbo1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USBO1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(T, 5) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_5v0>;
+	};
 
-		/* USBH_EN */
-		usbh_vbus_reg: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "usbh_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			vin-supply = <&sys_5v0_reg>;
-		};
+	/* USBH_EN */
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USBH(2A|2C|2D|3|4)";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_5v0>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d765cac7022a..45c0066984fe 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -19,8 +19,8 @@
 		avdd-pexb-supply = <&vdd2_reg>;
 		avdd-pex-pll-supply = <&vdd2_reg>;
 		avdd-plle-supply = <&ldo6_reg>;
-		hvdd-pex-supply = <&sys_3v3_reg>;
-		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		hvdd-pex-supply = <&reg_module_3v3>;
+		vddio-pex-ctl-supply = <&reg_module_3v3>;
 		vdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexb-supply = <&vdd2_reg>;
 
@@ -49,8 +49,8 @@
 			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
+			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
@@ -463,8 +463,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&sys_3v3_reg>;
-			VDDIO-supply = <&sys_3v3_reg>;
+			VDDA-supply = <&reg_module_3v3>;
+			VDDIO-supply = <&reg_module_3v3>;
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
 
@@ -481,43 +481,38 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 
-			vcc1-supply = <&sys_3v3_reg>;
-			vcc2-supply = <&sys_3v3_reg>;
-			vcc3-supply = <&vio_reg>;
-			vcc4-supply = <&sys_3v3_reg>;
-			vcc5-supply = <&sys_3v3_reg>;
-			vcc6-supply = <&vio_reg>;
-			vcc7-supply = <&charge_pump_5v0_reg>;
-			vccio-supply = <&sys_3v3_reg>;
+			vcc1-supply = <&reg_module_3v3>;
+			vcc2-supply = <&reg_module_3v3>;
+			vcc3-supply = <&reg_1v8_vio>;
+			vcc4-supply = <&reg_module_3v3>;
+			vcc5-supply = <&reg_module_3v3>;
+			vcc6-supply = <&reg_1v8_vio>;
+			vcc7-supply = <&reg_5v0_charge_pump>;
+			vccio-supply = <&reg_module_3v3>;
 
 			regulators {
-				/* SW1: +V1.35_VDDIO_DDR */
 				vdd1_reg: vdd1 {
-					regulator-name = "vddio_ddr_1v35";
+					regulator-name = "+V1.35_VDDIO_DDR";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
 					regulator-always-on;
 				};
 
-				/* SW2: +V1.05 */
 				vdd2_reg: vdd2 {
-					regulator-name =
-						"vdd_pexa,vdd_pexb,vdd_sata";
+					regulator-name = "+V1.05";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 				};
 
-				/* SW CTRL: +V1.0_VDD_CPU */
 				vddctrl_reg: vddctrl {
-					regulator-name = "vdd_cpu,vdd_sys";
+					regulator-name = "+V1.0_VDD_CPU";
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					regulator-always-on;
 				};
 
-				/* SWIO: +V1.8 */
-				vio_reg: vio {
-					regulator-name = "vdd_1v8_gen";
+				reg_1v8_vio: vio {
+					regulator-name = "+V1.8";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
@@ -527,27 +522,24 @@
 
 				/*
 				 * EN_+V3.3 switching via FET:
-				 * +V3.3_AUDIO_AVDD_S, +V3.3 and +V1.8_VDD_LAN
-				 * see also v3_3 fixed supply
+				 * +V3.3_AUDIO_AVDD_S, +V3.3
+				 * see also +V3.3 fixed supply
 				 */
 				ldo2_reg: ldo2 {
-					regulator-name = "en_3v3";
+					regulator-name = "EN_+V3.3";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
 				};
 
-				/* +V1.2_CSI */
 				ldo3_reg: ldo3 {
-					regulator-name =
-						"avdd_dsi_csi,pwrdet_mipi";
+					regulator-name = "+V1.2_CSI";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 				};
 
-				/* +V1.2_VDD_RTC */
 				ldo4_reg: ldo4 {
-					regulator-name = "vdd_rtc";
+					regulator-name = "+V1.2_VDD_RTC";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
@@ -555,10 +547,10 @@
 
 				/*
 				 * +V2.8_AVDD_VDAC:
-				 * only required for analog RGB
+				 * only required for (unsupported) analog RGB
 				 */
 				ldo5_reg: ldo5 {
-					regulator-name = "avdd_vdac";
+					regulator-name = "+V2.8_AVDD_VDAC";
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
 					regulator-always-on;
@@ -570,22 +562,20 @@
 				 * granularity
 				 */
 				ldo6_reg: ldo6 {
-					regulator-name = "avdd_plle";
+					regulator-name = "+V1.05_AVDD_PLLE";
 					regulator-min-microvolt = <1100000>;
 					regulator-max-microvolt = <1100000>;
 				};
 
-				/* +V1.2_AVDD_PLL */
 				ldo7_reg: ldo7 {
-					regulator-name = "avdd_pll";
+					regulator-name = "+V1.2_AVDD_PLL";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 				};
 
-				/* +V1.0_VDD_DDR_HS */
 				ldo8_reg: ldo8 {
-					regulator-name = "vdd_ddr_hs";
+					regulator-name = "+V1.0_VDD_DDR_HS";
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1000000>;
 					regulator-always-on;
@@ -738,50 +728,40 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		avdd_hdmi_pll_1v8_reg: regulator@100 {
-			compatible = "regulator-fixed";
-			reg = <100>;
-			regulator-name = "+V1.8_AVDD_HDMI_PLL";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			enable-active-high;
-			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-			vin-supply = <&vio_reg>;
-		};
+	reg_1v8_avdd_hdmi_pll: regulator-1v8-avdd-hdmi-pll {
+		compatible = "regulator-fixed";
+		regulator-name = "+V1.8_AVDD_HDMI_PLL";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_1v8_vio>;
+	};
 
-		sys_3v3_reg: regulator@101 {
-			compatible = "regulator-fixed";
-			reg = <101>;
-			regulator-name = "3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AVDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_module_3v3>;
+	};
 
-		avdd_hdmi_3v3_reg: regulator@102 {
-			compatible = "regulator-fixed";
-			reg = <102>;
-			regulator-name = "+V3.3_AVDD_HDMI";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			enable-active-high;
-			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-			vin-supply = <&sys_3v3_reg>;
-		};
+	reg_5v0_charge_pump: regulator-5v0-charge-pump {
+		compatible = "regulator-fixed";
+		regulator-name = "+V5.0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 
-		charge_pump_5v0_reg: regulator@103 {
-			compatible = "regulator-fixed";
-			reg = <103>;
-			regulator-name = "5v0";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_module_3v3: regulator-module-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	sound {
-- 
2.14.4

