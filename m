Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DF9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48324214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48324214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJIWnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:21 -0400
Received: from mout.perfora.net ([74.208.4.196]:53441 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJIWnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:20 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lx5zT-1fd1163hE1-016f3C; Tue, 09 Oct 2018 17:25:46 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lx5zT-1fd1163hE1-016f3C; Tue, 09 Oct 2018 17:25:46 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 8/8] ARM: tegra: apalis_t30: further regulator clean-up
Date:   Tue,  9 Oct 2018 17:25:23 +0200
Message-Id: <20181009152523.3771-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:MQHTjvo8+c2GScTnqI8sAZhpZyyM5ZKewko7K69Vm9vZXjw9dQq
 di9XGnLjR/VN1umbbx5QRqU2JcxjClK7/vszmolhO8KBj4p2GOM3Acn3aWBsaL6TUiWkC0s
 hq+9H8JjMkB2NlIYlyNtdSTR+lddJjZl48192vJDZqVeBqSvXUG/ugTWAfG96Xe9KbHB+I4
 6JWP9leqwFe9oqn7TfPTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j/JfLY4iEsQ=:4DFtgAaNlxCisZwTrSuLp5
 POp2CdrKOFVX7bInQZrw1XDYVg8Zobory843QKHJeGyW6z7BWZ+zF48fKBNPcDwzxCt2yRQUx
 cQDgMqVg1IWBjcV2VtS8Q/2hmVZ1f77VO2yjPbAvjb3C5C6wQB2QgnT/Jmq7x6evKpAX25ehM
 q5lcsWjix0CYWMeT9ZCucYYARv5GIoYUC0iSsWMO/jDSXmqhNP6u/v5/lJyAftw6LTuMk+FY7
 vWOb2lmxK4vcNqX32R5T6y19lklNohz6UWZ6XO6edaWVvybOwwshGhkHM7hkOVC9rvnxp57oW
 Jtum3DiQt1CB/8sG32IrPg3WvjDfZwwLYW8trafk770zeyfpzD585c/rkK9urptO4hnBfCwoj
 DTBmBi0wyFn7BKd6wJk4lBu06kBRQdT/l0Q/zMHWq8ypKH8p2ab+nNrrHL0yGzYzglgKFzA1m
 VISWy6lWP19i3nUrdQm7bu7/9XJStNubEouwdXcMKV8nMOkJD1Qpkijo9WDjPVKHBhMgGbDiU
 TaHNBGFVpvxdd339ViGXFGAtKJ7U/59XforM9NNRP2hZGZhFowHIjeG4Eg97R8TflqAMPsCAh
 9yc8egry51TJGY+cOjbBSeIVj1WgY9yAaT8gx9rZpkFcgDQG3zSN+gVTIN4ZfR/LhkA7zhVAQ
 agjG66clvE9xG5z+Fv/V0aQPDk4NWQVbtFK0SIDLvoEEvGYv3mHHoWa3Y4vPPRKYWobk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename label vdd2_reg to reg_1v05.
Rename label ldo6_reg to reg_1v05_avdd_plle.
Drop unused labels.
Rename regulator tps62362-vout to +V1.2_VDD_CORE.
Reorder TPS65911 properties.
Rename +V1.05 to +V1.05_AVDD_PLLE.
Add ti,en-ck32k-xtal.
Specify TPS62362 vin-supply.
Drop spurious newline in TPS62362 properties.
Rename vddio_sdmmc_1v8_reg to reg_1v8_vddio_sdmmc3.
Rename +V1.05 to +V1.05_AVDD_PLLE.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v1: None

 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts |  2 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi     | 70 +++++++++++---------------
 arch/arm/boot/dts/tegra30-apalis.dtsi          | 68 +++++++++++--------------
 3 files changed, 58 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
index e29dca92ba0a..34c9fcd9198f 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
@@ -251,7 +251,7 @@
 		states = <1800000 0x0
 			  3300000 0x1>;
 		startup-delay-us = <100000>;
-		vin-supply = <&vddio_sdmmc_1v8_reg>;
+		vin-supply = <&reg_1v8_vddio_sdmmc3>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 05e412a7ea17..600680b5ae6c 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -13,14 +13,14 @@
 
 	pcie@3000 {
 		status = "okay";
-		avdd-pexa-supply = <&vdd2_reg>;
-		avdd-pexb-supply = <&vdd2_reg>;
-		avdd-pex-pll-supply = <&vdd2_reg>;
-		avdd-plle-supply = <&ldo6_reg>;
+		avdd-pexa-supply = <&reg_1v05>;
+		avdd-pexb-supply = <&reg_1v05>;
+		avdd-pex-pll-supply = <&reg_1v05>;
+		avdd-plle-supply = <&reg_1v05>;
 		hvdd-pex-supply = <&reg_module_3v3>;
 		vddio-pex-ctl-supply = <&reg_module_3v3>;
-		vdd-pexa-supply = <&vdd2_reg>;
-		vdd-pexb-supply = <&vdd2_reg>;
+		vdd-pexa-supply = <&reg_1v05>;
+		vdd-pexb-supply = <&reg_1v05>;
 
 		/* Apalis type specific */
 		pci@1,0 {
@@ -864,16 +864,13 @@
 		pmic: pmic@2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
-
+			#gpio-cells = <2>;
+			gpio-controller;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
+			ti,en-ck32k-xtal;
 			ti,system-power-controller;
-
-			#gpio-cells = <2>;
-			gpio-controller;
-
 			vcc1-supply = <&reg_module_3v3>;
 			vcc2-supply = <&reg_module_3v3>;
 			vcc3-supply = <&reg_1v8_vio>;
@@ -884,38 +881,38 @@
 			vccio-supply = <&reg_module_3v3>;
 
 			regulators {
-				vdd1_reg: vdd1 {
+				reg_1v8_vio: vio {
+					regulator-name = "+V1.8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				vdd1 {
 					regulator-name = "+V1.35_VDDIO_DDR";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
 					regulator-always-on;
 				};
 
-				vdd2_reg: vdd2 {
+				reg_1v05: vdd2 {
 					regulator-name = "+V1.05";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 				};
 
-				vddctrl_reg: vddctrl {
+				vddctrl {
 					regulator-name = "+V1.0_VDD_CPU";
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					regulator-always-on;
 				};
 
-				reg_1v8_vio: vio {
-					regulator-name = "+V1.8";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
 				/*
 				 * 1.8 volt +VDDIO_SDMMC3 in case EN_+3.3_SDMMC3
 				 * is off
 				 */
-				vddio_sdmmc_1v8_reg: ldo1 {
+				reg_1v8_vddio_sdmmc3: ldo1 {
 					regulator-name = "+VDDIO_SDMMC3_1V8";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -927,20 +924,20 @@
 				 * +V3.3_AUDIO_AVDD_S, +V3.3
 				 * see also +V3.3 fixed supply
 				 */
-				ldo2_reg: ldo2 {
+				ldo2 {
 					regulator-name = "EN_+V3.3";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
 				};
 
-				ldo3_reg: ldo3 {
+				ldo3 {
 					regulator-name = "+V1.2_CSI";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 				};
 
-				ldo4_reg: ldo4 {
+				ldo4 {
 					regulator-name = "+V1.2_VDD_RTC";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
@@ -951,32 +948,23 @@
 				 * +V2.8_AVDD_VDAC:
 				 * only required for (unsupported) analog RGB
 				 */
-				ldo5_reg: ldo5 {
+				ldo5 {
 					regulator-name = "+V2.8_AVDD_VDAC";
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
 					regulator-always-on;
 				};
 
-				/*
-				 * +V1.05_AVDD_PLLE: avdd_plle should be 1.05V
-				 * but LDO6 can't set voltage in 50mV
-				 * granularity
-				 */
-				ldo6_reg: ldo6 {
-					regulator-name = "+V1.05_AVDD_PLLE";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-				};
+				/* LDO6: unused */
 
-				ldo7_reg: ldo7 {
+				ldo7 {
 					regulator-name = "+V1.2_AVDD_PLL";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 				};
 
-				ldo8_reg: ldo8 {
+				ldo8 {
 					regulator-name = "+V1.0_VDD_DDR_HS";
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1000000>;
@@ -1034,8 +1022,7 @@
 		regulator@60 {
 			compatible = "ti,tps62362";
 			reg = <0x60>;
-
-			regulator-name = "tps62362-vout";
+			regulator-name = "+V1.2_VDD_CORE";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1400000>;
 			regulator-boot-on;
@@ -1043,6 +1030,7 @@
 			ti,vsel0-state-low;
 			/* VSEL1: EN_CORE_DVFS_N low for DVFS */
 			ti,vsel1-state-low;
+			vin-supply =<&reg_module_3v3>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 0f0d0ae93075..85f4b70ed73d 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -12,14 +12,14 @@
 
 	pcie@3000 {
 		status = "okay";
-		avdd-pexa-supply = <&vdd2_reg>;
-		avdd-pexb-supply = <&vdd2_reg>;
-		avdd-pex-pll-supply = <&vdd2_reg>;
-		avdd-plle-supply = <&ldo6_reg>;
+		avdd-pexa-supply = <&reg_1v05>;
+		avdd-pexb-supply = <&reg_1v05>;
+		avdd-pex-pll-supply = <&reg_1v05>;
+		avdd-plle-supply = <&reg_1v05>;
 		hvdd-pex-supply = <&reg_module_3v3>;
 		vddio-pex-ctl-supply = <&reg_module_3v3>;
-		vdd-pexa-supply = <&vdd2_reg>;
-		vdd-pexb-supply = <&vdd2_reg>;
+		vdd-pexa-supply = <&reg_1v05>;
+		vdd-pexb-supply = <&reg_1v05>;
 
 		/* Apalis type specific */
 		pci@1,0 {
@@ -855,16 +855,13 @@
 		pmic: pmic@2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
-
+			#gpio-cells = <2>;
+			gpio-controller;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
+			ti,en-ck32k-xtal;
 			ti,system-power-controller;
-
-			#gpio-cells = <2>;
-			gpio-controller;
-
 			vcc1-supply = <&reg_module_3v3>;
 			vcc2-supply = <&reg_module_3v3>;
 			vcc3-supply = <&reg_1v8_vio>;
@@ -875,33 +872,33 @@
 			vccio-supply = <&reg_module_3v3>;
 
 			regulators {
-				vdd1_reg: vdd1 {
+				reg_1v8_vio: vio {
+					regulator-name = "+V1.8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				vdd1 {
 					regulator-name = "+V1.35_VDDIO_DDR";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
 					regulator-always-on;
 				};
 
-				vdd2_reg: vdd2 {
+				reg_1v05: vdd2 {
 					regulator-name = "+V1.05";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1050000>;
 				};
 
-				vddctrl_reg: vddctrl {
+				vddctrl {
 					regulator-name = "+V1.0_VDD_CPU";
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					regulator-always-on;
 				};
 
-				reg_1v8_vio: vio {
-					regulator-name = "+V1.8";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
 				/* LDO1: unused */
 
 				/*
@@ -909,20 +906,20 @@
 				 * +V3.3_AUDIO_AVDD_S, +V3.3
 				 * see also +V3.3 fixed supply
 				 */
-				ldo2_reg: ldo2 {
+				ldo2 {
 					regulator-name = "EN_+V3.3";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
 				};
 
-				ldo3_reg: ldo3 {
+				ldo3 {
 					regulator-name = "+V1.2_CSI";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 				};
 
-				ldo4_reg: ldo4 {
+				ldo4 {
 					regulator-name = "+V1.2_VDD_RTC";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
@@ -933,32 +930,23 @@
 				 * +V2.8_AVDD_VDAC:
 				 * only required for (unsupported) analog RGB
 				 */
-				ldo5_reg: ldo5 {
+				ldo5 {
 					regulator-name = "+V2.8_AVDD_VDAC";
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
 					regulator-always-on;
 				};
 
-				/*
-				 * +V1.05_AVDD_PLLE: avdd_plle should be 1.05V
-				 * but LDO6 can't set voltage in 50mV
-				 * granularity
-				 */
-				ldo6_reg: ldo6 {
-					regulator-name = "+V1.05_AVDD_PLLE";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-				};
+				/* LDO6: unused */
 
-				ldo7_reg: ldo7 {
+				ldo7 {
 					regulator-name = "+V1.2_AVDD_PLL";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 				};
 
-				ldo8_reg: ldo8 {
+				ldo8 {
 					regulator-name = "+V1.0_VDD_DDR_HS";
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1000000>;
@@ -1016,8 +1004,7 @@
 		regulator@60 {
 			compatible = "ti,tps62362";
 			reg = <0x60>;
-
-			regulator-name = "tps62362-vout";
+			regulator-name = "+V1.2_VDD_CORE";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1400000>;
 			regulator-boot-on;
@@ -1025,6 +1012,7 @@
 			ti,vsel0-state-low;
 			/* VSEL1: EN_CORE_DVFS_N low for DVFS */
 			ti,vsel1-state-low;
+			vin-supply =<&reg_module_3v3>;
 		};
 	};
 
-- 
2.14.4

