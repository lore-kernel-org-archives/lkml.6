Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4053C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4053C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeH2MKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:19 -0400
Received: from mout.perfora.net ([74.208.4.196]:40959 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:18 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0McoSN-1gCjS844cT-00I0QB; Wed, 29 Aug 2018 10:14:30 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/31] ARM: tegra: colibri_t20: regulator clean-up
Date:   Wed, 29 Aug 2018 10:13:44 +0200
Message-Id: <20180829081407.11304-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:cxy75rYsgwTpz0mvxIfLyV3SUi9FlBkvtz+F19RH6mM9ChUPeu/
 6WadkxSMUGU1t2SWNe7XzQUnsE6gTddiOgUzGooBIbqONb2XOtfhW5d7461anxutbgknOzK
 uQq7BJwY1Y3JDheIuGaEHLQ1HDVdY6BDKYJVnmXYJ0GHvPwD6o5Gv8iBeFvpCnqPOeEs3Jd
 4W6nYF4O6LGEpuhHQ7V0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RYuU0N40NL0=:IJ1mqgFFRWQ2aXZMxEfojA
 TveqgNg/UfvhfwEzlCKPAEExmfsOcuaYK7lUBe5W2fJc/Sb5K/E6/EzMANhCxLbixHctKJJ6j
 dXHNm3PZZ1xAj3XUGK82BsxiKUZdDMKwt3J5xxWoBum/xtLAeGM83Zx2UQqNhdpCFNUq2X3QV
 AhchixCCa9h+ISie1+KQddIvgSX/BJ65G8Wtv03guO7OrxWd6HQMGKeWWO5CTMAsOyKIur6hM
 sH4UrtISnx4ilu1VeCccqoHcjDp9boNz4LEkAdWYmjwLEVFJP3ZCm+CEFFlGxA6oAO1P3POyq
 1cHGxEaqWX0OrK2wQVSiWevDeULomVpsCcb9054Ry6nAl+tObiEqxzHCLX+LtWUZMIH3RIFIy
 fYIvPIh8mSg68BRYEevl9U5H0t2dxt6wzktc5YKNzEwwei1aJg6RHtuzrAIDW8gyeFhmHNnQQ
 /pAr3io+FuO7U/wDhPtp1SFkIWUAwfNjJCSGlmOOD0IMGrFM/NKn5UKxk/RMcCgjFrjCo3BMF
 rY1mjMHKqDFMr2Ck92tE8Fdg8kZvZQU8SuL2SfLMDQJOs/2GPsFnnsyt4V2fYbXw8KvMjbG/c
 KySxfpC22WfmivKCpmof0eorzY1z+dkkFwm5X4j5s/j+2HyhTjCWNDo/k8XnvT3diBv4FSUuy
 Az6n1RBdQ+flSXp+/jC8Sv+lN/vPNCLfiwjamW6Oiopyj/vPwrvSM3CgGjAXSyeor2cs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Just cosmetic regulator clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts |  20 ++--
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 147 +++++++++++------------------
 2 files changed, 66 insertions(+), 101 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 3d430fa93e8c..6f89a417b0f2 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -104,16 +104,14 @@
 		no-1-8-v;
 	};
 
-	regulators {
-		regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_host_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-boot-on;
-			regulator-always-on;
-			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
-		};
+	/* USBH_PEN resp. USB_P_EN */
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USB1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index c060b58cb490..1cf64f197c08 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -19,8 +19,8 @@
 			nvidia,ddc-i2c-bus = <&i2c_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			pll-supply = <&hdmi_pll_reg>;
-			vdd-supply = <&hdmi_vdd_reg>;
+			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
@@ -260,49 +260,38 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 
-			sys-supply = <&vdd_3v3_reg>;
-			vin-sm0-supply = <&sys_reg>;
-			vin-sm1-supply = <&sys_reg>;
-			vin-sm2-supply = <&sys_reg>;
-			vinldo01-supply = <&sm2_reg>;
-			vinldo23-supply = <&vdd_3v3_reg>;
-			vinldo4-supply = <&vdd_3v3_reg>;
-			vinldo678-supply = <&vdd_3v3_reg>;
-			vinldo9-supply = <&vdd_3v3_reg>;
+			sys-supply = <&reg_module_3v3>;
+			vin-sm0-supply = <&reg_3v3_vsys>;
+			vin-sm1-supply = <&reg_3v3_vsys>;
+			vin-sm2-supply = <&reg_3v3_vsys>;
+			vinldo01-supply = <&reg_1v8_vdd_ddr2>;
+			vinldo23-supply = <&reg_module_3v3>;
+			vinldo4-supply = <&reg_module_3v3>;
+			vinldo678-supply = <&reg_module_3v3>;
+			vinldo9-supply = <&reg_module_3v3>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				sys_reg: regulator@0 {
-					reg = <0>;
-					regulator-compatible = "sys";
-					regulator-name = "vdd_sys";
+				reg_3v3_vsys: sys {
+					regulator-name = "VSYS_3.3V";
 					regulator-always-on;
 				};
 
-				regulator@1 {
-					reg = <1>;
-					regulator-compatible = "sm0";
-					regulator-name = "vdd_sm0,vdd_core";
+				sm0 {
+					regulator-name = "VDD_CORE_1.2V";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 				};
 
-				regulator@2 {
-					reg = <2>;
-					regulator-compatible = "sm1";
-					regulator-name = "vdd_sm1,vdd_cpu";
+				sm1 {
+					regulator-name = "VDD_CPU_1.0V";
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1000000>;
 					regulator-always-on;
 				};
 
-				sm2_reg: regulator@3 {
-					reg = <3>;
-					regulator-compatible = "sm2";
-					regulator-name = "vdd_sm2,vin_ldo*";
+				reg_1v8_vdd_ddr2: sm2 {
+					regulator-name = "VDD_DDR2_1.8V";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
@@ -310,80 +299,68 @@
 
 				/* LDO0 is not connected to anything */
 
-				regulator@5 {
-					reg = <5>;
-					regulator-compatible = "ldo1";
-					regulator-name = "vdd_ldo1,avdd_pll*";
+				/*
+				 * +3.3V_ENABLE_N switching via FET:
+				 * AVDD_AUDIO_S and +3.3V
+				 * see also +3.3V fixed supply
+				 */
+				ldo1 {
+					regulator-name = "AVDD_PLL_1.1V";
 					regulator-min-microvolt = <1100000>;
 					regulator-max-microvolt = <1100000>;
 					regulator-always-on;
 				};
 
-				regulator@6 {
-					reg = <6>;
-					regulator-compatible = "ldo2";
-					regulator-name = "vdd_ldo2,vdd_rtc";
+				ldo2 {
+					regulator-name = "VDD_RTC_1.2V";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 				};
 
 				/* LDO3 is not connected to anything */
 
-				regulator@8 {
-					reg = <8>;
-					regulator-compatible = "ldo4";
-					regulator-name = "vdd_ldo4,avdd_osc,vddio_sys";
+				ldo4 {
+					regulator-name = "VDDIO_SYS_1.8V";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
 				};
 
-				ldo5_reg: regulator@9 {
-					reg = <9>;
-					regulator-compatible = "ldo5";
-					regulator-name = "vdd_ldo5,vdd_fuse";
+				/* Switched via FET from regular +3.3V */
+				ldo5 {
+					regulator-name = "+3.3V_USB";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
 				};
 
-				regulator@10 {
-					reg = <10>;
-					regulator-compatible = "ldo6";
-					regulator-name = "vdd_ldo6,avdd_vdac,vddio_vi,vddio_cam";
+				ldo6 {
+					regulator-name = "AVDD_VDAC_2.85V";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
 				};
 
-				hdmi_vdd_reg: regulator@11 {
-					reg = <11>;
-					regulator-compatible = "ldo7";
-					regulator-name = "vdd_ldo7,avdd_hdmi";
+				reg_3v3_avdd_hdmi: ldo7 {
+					regulator-name = "AVDD_HDMI_3.3V";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 				};
 
-				hdmi_pll_reg: regulator@12 {
-					reg = <12>;
-					regulator-compatible = "ldo8";
-					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
+				reg_1v8_avdd_hdmi_pll: ldo8 {
+					regulator-name = "AVDD_HDMI_PLL_1.8V";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
 
-				regulator@13 {
-					reg = <13>;
-					regulator-compatible = "ldo9";
-					regulator-name = "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
+				ldo9 {
+					regulator-name = "VDDIO_RX_DDR_2.85V";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
 					regulator-always-on;
 				};
 
-				regulator@14 {
-					reg = <14>;
-					regulator-compatible = "ldo_rtc";
-					regulator-name = "vdd_rtc_out,vdd_cell";
+				ldo_rtc {
+					regulator-name = "VCC_BATT";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
@@ -513,31 +490,21 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd_3v3_reg: regulator@100 {
-			compatible = "regulator-fixed";
-			reg = <100>;
-			regulator-name = "vdd_3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_lan_v_bus: regulator-lan-v-bus {
+		compatible = "regulator-fixed";
+		regulator-name = "LAN_V_BUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(BB, 1) GPIO_ACTIVE_HIGH>;
+	};
 
-		regulator@101 {
-			compatible = "regulator-fixed";
-			reg = <101>;
-			regulator-name = "internal_usb";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-boot-on;
-			regulator-always-on;
-			gpio = <&gpio TEGRA_GPIO(BB, 1) GPIO_ACTIVE_HIGH>;
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

