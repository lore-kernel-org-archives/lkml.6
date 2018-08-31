Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E30FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0993620658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0993620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeHaUuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:50:13 -0400
Received: from mout.perfora.net ([74.208.4.197]:59109 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbeHaUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:07 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MSt2R-1gMta73hif-00RrsW; Fri, 31 Aug 2018 18:38:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 07/34] ARM: tegra: apalis_t30: regulator clean-up
Date:   Fri, 31 Aug 2018 18:37:49 +0200
Message-Id: <20180831163817.23970-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Rd6orDjTBjN3ppqO7kCCGk4KN+mRg3891lqdE4gjxZG4/txkh0c
 BcqOuQZcMhg6aYNWfmBDOjkkFkZlbJHqLiNYE1I5zM1ReZKxWN4aHSuCgS8FBqmorbvPTtq
 WwIf1Z2DIS96Ka9MpeW0Fb5c6rUT1UIZZeerOByVv5Y59LnsIb2CttZ4Hbys7n9RTdraQn8
 ShfNKZAQo8tnu9azKmO4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w+ki3wyXEqk=:4hjuRj7pXTD1Is+G2ZR2BW
 oMvrj6EADdKwDRbpSsvhjUcuJS2IKSBzMRM7BouRN+lbP8HOeQwMVzxpiCCyeX+hp0odqkFYF
 +irKa+cal9ep20noKfmhtmH+A5MHQ7fP2MuZN5W5I1KnStrOc7JmS/SPXuTTIvK5pU3FgmXzL
 71fJHH3yUMIvfXBsFI6llCPOqhcWfUQoL/gDuDB55q+4HUfxizDDZ+fRB5eCPqngvh4UbNVbo
 bLyEY0RQXOYhIPCcvmw+S4dEJ7GRo4qXCbqeMOBiSdF/QUSb40/npZt5L7/bKOUTddj2TEJl6
 37FjFeDCt27zZYnw1FCCPyQ2MC1kZmHr51SXnjv/YjWzNhfrSpfrqFjTQ9YFzGb2y5wvlxWtZ
 H+ImuT8l46/O2ph/D5EMJAXEhVpoMiLBzHFKatTI0Q9blxoduCHNO5DciOCxbYW3x+LmbE64t
 0Ycknjrz2t4+xdi1W5DDFTI1ZrxishwBEuomT+g8PHIdAJ+xyut+w8D0V+S47ZDJ11hl1aCAM
 2gJus8SvmeKBBvlpqBgvPeV+F2ssh8ie55ooI0bAqQ/T7kVIMFRB2U76qEGr+g7Ev9fRoxldA
 6eMyuh3gm5poSSJ+gQquBdg1FwwrrBbXpzw57BMfuWklTevv1mXcFnR8itlk26JzcOV/1c0AR
 9skABKtr0N4BteuVHUE1dkJleFCPnTv5zS8mJi7GvaB0F3bj3WpTaFgOXfLHcRb5KkS0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic regulator clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts |  62 ++++++-------
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 140 +++++++++++++-----------------
 2 files changed, 88 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index e3c70e7d8d37..07da481bc441 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -153,7 +153,7 @@
 	usb-phy@7d000000 {
 		status = "okay";
 		dr_mode = "otg";
-		vbus-supply = <&usbo1_vbus_reg>;
+		vbus-supply = <&reg_usbo1_vbus>;
 	};
 
 	/* EHCI instance 1: USB2_DP/N -> USBH2_DP/N */
@@ -163,7 +163,7 @@
 
 	usb-phy@7d004000 {
 		status = "okay";
-		vbus-supply = <&usbh_vbus_reg>;
+		vbus-supply = <&reg_usbh_vbus>;
 	};
 
 	/* EHCI instance 2: USB3_DP/N -> USBH3_DP/N */
@@ -173,7 +173,7 @@
 
 	usb-phy@7d008000 {
 		status = "okay";
-		vbus-supply = <&usbh_vbus_reg>;
+		vbus-supply = <&reg_usbh_vbus>;
 	};
 
 	backlight: backlight {
@@ -231,38 +231,32 @@
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
index 648db524abae..214a23722ab4 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -20,8 +20,8 @@
 		avdd-pexb-supply = <&vdd2_reg>;
 		avdd-pex-pll-supply = <&vdd2_reg>;
 		avdd-plle-supply = <&ldo6_reg>;
-		hvdd-pex-supply = <&sys_3v3_reg>;
-		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		hvdd-pex-supply = <&reg_module_3v3>;
+		vddio-pex-ctl-supply = <&reg_module_3v3>;
 		vdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexb-supply = <&vdd2_reg>;
 
@@ -51,8 +51,8 @@
 			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
+			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
@@ -465,8 +465,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&sys_3v3_reg>;
-			VDDIO-supply = <&sys_3v3_reg>;
+			VDDA-supply = <&reg_module_3v3>;
+			VDDIO-supply = <&reg_module_3v3>;
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
 
@@ -483,43 +483,38 @@
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
@@ -529,27 +524,24 @@
 
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
@@ -557,10 +549,10 @@
 
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
@@ -572,22 +564,20 @@
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
@@ -732,50 +722,40 @@
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

