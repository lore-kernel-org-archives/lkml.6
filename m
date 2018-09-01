Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652BEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEDD20845
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEDD20845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIARRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:36 -0400
Received: from mout.perfora.net ([74.208.4.197]:39379 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:35 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Le3fW-1fYtKL00Vw-00ppli; Sat, 01 Sep 2018 15:05:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/19] ARM: tegra: apalis-tk1: add missing regulators
Date:   Sat,  1 Sep 2018 15:04:50 +0200
Message-Id: <20180901130504.14318-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:TMnsLqE/yCALvnvRgE+6kF7romzCoG2ePi5DI+PEVzq2XoRRmfv
 LcEp2YeZSHNt2uRKAk5rjL4BgARMDrX+gk0dFDutvEUIhZowHJ+qizVC54JjBNoW+2dlbao
 UdhY4B3k7+b1PeruGwITcMFWsOYpi1romdJ1SEjHv/Jb+gxmU4O8N3AT6CoYw00GrmzoWxo
 wnEGUpTjk9yrCxij1/RmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NWuPEG+Culo=:DmO/w6XOttutL6sUixqL6+
 Wo69Ly/Ab2xdN3WWyUD3NuQCIoSSYuxHwPLKpgP+J6yZ0d7WqbvrFlbizVC/+HRdR2LnEsLye
 Z5GygUrg/Wa8O5Ya4ah8bRpyZpeH0/HtqP+fRBP55H0z1PbIqy7h45patMwa6Au+CHqdBoQRD
 fw24AQqVmD+HWxDQypa2lIvIouyfTXrkyo88hiG9YkS9v14xRJAX4ypZVnBRZGbmBpVEvJCt7
 bbfY0UevVWs48KY/RN9qYSqo/uoYTkbHTbY73KauglZCckvoX0PDzTjIQQV5uL37nXji7B3dY
 rQGJ6KMvQPYb37ddLv9yMLU0zZCmT6qB2OIphP7uvX70CKKsfpfqaVrRP5w1cuM+5FUQN4g65
 CXYov4oaa3roO2YdcvkasVReMqF1FudPHh/kg0liopbgfhSpE1rKmq1LIj0UUCY4L8zO4KEIa
 IdpNktA7W9CW7YiEHZCY0uVGEwsA6TBxA2JTO9jcPJ1R86Lkso/W5EI9oNCAwF9rFrG4XfVAR
 Al2ZMA5UrHDpcAJ23O3nqqQAvsK96LaqfxLqOGy27dIPjUfdvp0B/PwnB2zj+lIYuNtQCcquW
 i1oFi6qqsh8tHLB5+BGEvECZZyg5mSw0Uzr1Vu/20FmNvgNOVOZkisyRHysXQLkLiDvQ7GA1K
 hJEOo1JMIICWfD9TS8cmuLQ6q8QQPHymAPo7Qkbf8sfeFUC3mb9cpi3tNDidbJ5lwi6I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add missing regulators:
- reg_module_3v3_audio being VDDA supply of SGTL5000
- VDDD supply of SGTL5000 actually being reg_1v8_vio
- TMP451 temperature sensor vcc supply being reg_module_3v3
- usb3-0 vbus supply being reg_usbh_vbus
- usb3-1 vbus supply being reg_usbo1_vbus
- carrier board HDMI supply being reg_5v0
- carrier board sata target 5v supply being reg_5v0
- carrier board sata target 12v supply being reg_12v0
- carrier board reg_3v3 actually being backlight power supply

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 18 ++++++++++++++++++
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 14 +++++++++++++-
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 14 +++++++++++++-
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index a6ad759dddb4..c2e918d345de 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -72,6 +72,7 @@
 	host1x@50000000 {
 		hdmi@54280000 {
 			status = "okay";
+			hdmi-supply = <&reg_5v0>;
 		};
 	};
 
@@ -164,6 +165,8 @@
 	/* Apalis Serial ATA */
 	sata@70020000 {
 		status = "okay";
+		target-5v-supply = <&reg_5v0>;
+		target-12v-supply = <&reg_12v0>;
 	};
 
 	hda@70030000 {
@@ -230,6 +233,7 @@
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
 	};
 
 	gpio-keys {
@@ -244,6 +248,13 @@
 		};
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_5v0: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "5V_SW";
@@ -251,6 +262,13 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	reg_12v0: regulator-12v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "12V_SW";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	/* USBO1_EN */
 	reg_usbo1_vbus: regulator-usbo1-vbus {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 8a8d5fa0ecd1..eebcc013771e 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -36,6 +36,7 @@
 	host1x@50000000 {
 		hdmi@54280000 {
 			status = "okay";
+			hdmi-supply = <&reg_5v0>;
 		};
 	};
 
@@ -129,6 +130,8 @@
 	/* Apalis Serial ATA */
 	sata@70020000 {
 		status = "okay";
+		target-5v-supply = <&reg_5v0>;
+		target-12v-supply = <&reg_12v0>;
 	};
 
 	hda@70030000 {
@@ -195,6 +198,7 @@
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
 	};
 
 	gpio-keys {
@@ -209,6 +213,13 @@
 		};
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_5v0: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "5V_SW";
@@ -216,6 +227,13 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	reg_12v0: regulator-12v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "12V_SW";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	/* USBO1_EN */
 	reg_usbo1_vbus: regulator-usbo1-vbus {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 13aa8c797d42..00d5308c993f 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1565,7 +1565,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_module_3v3>;
+			VDDA-supply = <&reg_module_3v3_audio>;
+			VDDD-supply = <&reg_1v8_vddio>;
 			VDDIO-supply = <&reg_1v8_vddio>;
 			clocks = <&tegra_car TEGRA124_CLK_EXTERN1>;
 		};
@@ -1754,6 +1755,7 @@
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
 			#thermal-sensor-cells = <1>;
+			vcc-supply = <&reg_module_3v3>;
 		};
 	};
 
@@ -1902,11 +1904,13 @@
 			usb3-0 {
 				status = "okay";
 				nvidia,usb2-companion = <2>;
+				vbus-supply = <&reg_usbh_vbus>;
 			};
 
 			usb3-1 {
 				status = "okay";
 				nvidia,usb2-companion = <0>;
+				vbus-supply = <&reg_usbo1_vbus>;
 			};
 		};
 	};
@@ -1989,6 +1993,14 @@
 		vin-supply = <&reg_3v3_mxm>;
 	};
 
+	reg_module_3v3_audio: regulator-module-3v3-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AUDIO_AVDD_S";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_tk1",
 			     "nvidia,tegra-audio-sgtl5000";
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 40c6ca2d1385..65a88d314fd2 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1594,7 +1594,8 @@
 		sgtl5000: codec@a {
 			compatible = "fsl,sgtl5000";
 			reg = <0x0a>;
-			VDDA-supply = <&reg_module_3v3>;
+			VDDA-supply = <&reg_module_3v3_audio>;
+			VDDD-supply = <&reg_1v8_vddio>;
 			VDDIO-supply = <&reg_1v8_vddio>;
 			clocks = <&tegra_car TEGRA124_CLK_EXTERN1>;
 		};
@@ -1783,6 +1784,7 @@
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
 			#thermal-sensor-cells = <1>;
+			vcc-supply = <&reg_module_3v3>;
 		};
 	};
 
@@ -1931,11 +1933,13 @@
 			usb3-0 {
 				status = "okay";
 				nvidia,usb2-companion = <2>;
+				vbus-supply = <&reg_usbh_vbus>;
 			};
 
 			usb3-1 {
 				status = "okay";
 				nvidia,usb2-companion = <0>;
+				vbus-supply = <&reg_usbo1_vbus>;
 			};
 		};
 	};
@@ -2018,6 +2022,14 @@
 		vin-supply = <&reg_3v3_mxm>;
 	};
 
+	reg_module_3v3_audio: regulator-module-3v3-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_AUDIO_AVDD_S";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_tk1",
 			     "nvidia,tegra-audio-sgtl5000";
-- 
2.14.4

