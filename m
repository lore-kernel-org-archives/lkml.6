Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A5C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715DC20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715DC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIAM1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:27:17 -0400
Received: from mout.perfora.net ([74.208.4.197]:46907 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbeIAMYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:25 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M6Cey-1fg8tv2L2Q-00yBhK; Sat, 01 Sep 2018 10:13:06 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 03/34] ARM: tegra: colibri_t30: regulator clean-up
Date:   Sat,  1 Sep 2018 10:12:17 +0200
Message-Id: <20180901081248.22639-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:/rup172jsrCVVZWetbtT7FgVPgwJGrjzqVGRxv/Zoi17oKsP5eI
 yOx/EVEZ3SqmIIsVEAMbOgnkZOmyZbkjWahq9zk+voae5oqvf35M+eHp2gzxM0oPO95AbjK
 iycorVW/m9VZzBLrKMbbRbIsel0TN/8W7owOFRNqTN3S95Fbg4N7nRVjU7x8uKTtVwgzJDl
 s/xgBF8zS+f1Fe2+oxhrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BGzpcpozkGY=:R7yJp4xD7cpVFk7vi6OMSS
 ssJMEOAs71LWEKVbjiGX0eUyLBDM+Rc0W3vykZwf2z/7wUwwhZcr4uFdviy7wyIswvc/jGnKg
 eP0/tqQemyDCQeXiD61Nv8ob6/5QmTv6eDTdoH9oBGE6DlKriNmsvJfr+3hltga6sUymePBuK
 9Zc677dBbxZhCeuqARW0gheizPaVnT4BA0P8T4qOuPmGkryIOEWtXbV+xsJB4zypjLEmFdm5N
 GmmDITLGgu/h+cBYBCNcyiHSVwnISRriRBDHUbeg35YLceyqfkW2YKJ0GCeQ4IDVy8sBCPcYa
 VwntC/oOupnnKp1giKNZvXhUGHKs4V0OqyPI12hVgmlnSKG1WCoVCCob1rT2Vpv64oLMqtMh9
 O6JYQuSVSpG97tHEHkgBtFixAX3Bh3Qf0/DGd7HTr/6tVvwKdyn5bN+2KIHoVCMQwUQpRS2VO
 7wARtHAAODxqxC0DzTbDd4de45pLhYnesmITiPh3xDxD++eOJ+uvTaXB+wDi25nRKuKzssart
 jCYn3XgXaJptvhN9jpDMd5Hq+BP7/+BvpmYPUt63TMKm5TR918NJ67lETfLfB9+5LFI4gJhzs
 F95fcECVzSF9Twa1BfXPGQMCp9eMEt3bPLDH5kesql6ympbuwYCsnMIydQ+4MVOXvg7vQqjKO
 96zKoQSe7yUN9DEak7djtLlPkrlrC9EphuahUPrSx4+2PbWaCe0S/QEEcPpNcg7eAt+o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic regulator clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  52 +++++------
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 126 +++++++++++---------------
 2 files changed, 78 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 16e1f387aa6d..5eb665d89435 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -105,7 +105,7 @@
 	usb-phy@7d000000 {
 		status = "okay";
 		dr_mode = "otg";
-		vbus-supply = <&usbc_vbus_reg>;
+		vbus-supply = <&reg_usbc_vbus>;
 	};
 
 	/* EHCI instance 2: USB3_DP/N -> USBH_P/N */
@@ -115,7 +115,7 @@
 
 	usb-phy@7d008000 {
 		status = "okay";
-		vbus-supply = <&usbh_vbus_reg>;
+		vbus-supply = <&reg_usbh_vbus>;
 	};
 
 	backlight: backlight {
@@ -181,34 +181,28 @@
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
 
-		usbc_vbus_reg: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usbc_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			vin-supply = <&sys_5v0_reg>;
-		};
+	reg_usbc_vbus: regulator-usbc-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USB5";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_5v0>;
+	};
 
-		/* USBH_PEN */
-		usbh_vbus_reg: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "usbh_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
-			vin-supply = <&sys_5v0_reg>;
-		};
+	/* USBH_PEN resp. USB_P_EN */
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USB[1-4]";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_5v0>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 48c41a36b4dc..4d7ed25bd594 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -19,8 +19,8 @@
 			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
+			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
@@ -229,8 +229,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&sys_3v3_reg>;
-			VDDIO-supply = <&sys_3v3_reg>;
+			VDDA-supply = <&reg_module_3v3>;
+			VDDIO-supply = <&reg_module_3v3>;
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
 
@@ -247,19 +247,18 @@
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
@@ -267,17 +266,15 @@
 
 				/* SW2: unused */
 
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
@@ -288,10 +285,10 @@
 				/*
 				 * EN_+V3.3 switching via FET:
 				 * +V3.3_AUDIO_AVDD_S, +V3.3 and +V1.8_VDD_LAN
-				 * see also 3v3 fixed supply
+				 * see also +V3.3 fixed supply
 				 */
 				ldo2_reg: ldo2 {
-					regulator-name = "en_3v3";
+					regulator-name = "EN_+V3.3";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
@@ -299,9 +296,8 @@
 
 				/* LDO3: unused */
 
-				/* +V1.2_VDD_RTC */
 				ldo4_reg: ldo4 {
-					regulator-name = "vdd_rtc";
+					regulator-name = "+V1.2_VDD_RTC";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
@@ -309,10 +305,10 @@
 
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
@@ -324,22 +320,20 @@
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
@@ -463,50 +457,40 @@
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

