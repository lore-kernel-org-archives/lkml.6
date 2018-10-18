Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B177C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320D52087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320D52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeJRTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:12 -0400
Received: from mout.perfora.net ([74.208.4.196]:57843 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeJRTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:11 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M3TuA-1fMNBG41aa-00qwX0; Thu, 18 Oct 2018 13:14:31 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M3TuA-1fMNBG41aa-00qwX0; Thu, 18 Oct 2018 13:14:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 6/7] ARM: tegra: colibri_t30: further regulator clean-up
Date:   Thu, 18 Oct 2018 13:14:10 +0200
Message-Id: <20181018111411.26623-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111411.26623-1-marcel@ziswiler.com>
References: <20181018111411.26623-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:HUt2/WPy40WPqBOIwuorF8NCF4hlulqpk+m7QaAEpF9pIP+4EKq
 gLAVuOBywyGZYRPqxsCs7TruBHRN417HNe4e2WmLD9eyda2Yj7WbwttqdqRXOjV2YltEcgQ
 Tavr9RlRN9ynHCRubsHeBQdZTajxRBLSbEptE1gNVyGZKZc/Gv4DEPcdZCxegiiSsbrq2y7
 p5R6YuDX8QbRijiH9CF/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WkSvQmd3ZHQ=:Ru+Sa1/EpmYS1AoOqBQE+S
 e9e1qe2OnUiPH2ef3CQHAVWrjs/psxZW8ugtwA2HoThThdp19BhVpS2yqZ7nj4I5KLtJIBenX
 ciTuavqztsR6jq0gfsm7yyID63a4HgWTIfInfpavn4qZQ/3gKu6F5wYQrGlHi1ESgCgieZ32u
 +ki78k55HPy7QnNSW+XkxJUwQtKJEVyMrQQX0/kEbLEQIjOYkflkPN7bSuxyI9ZpEX20Cpuv2
 2yxQ3zhhEoSFr/jpYYbb1fTPMENWdwSZKbf3ypxOCjTyxohaiXfQT3VkvU6zLUTzXIDSlh/VA
 2U00TqGkZNBq3cdOYbepj+9bLJ1gBzuUq62G60Bx4ttfn+9IZ67bwv7ffxsNfIMJY0b2bckdH
 1rl0mWLGJRur+igE2fsqZhZ5pZJqcEFbfKT2FxO/XTW0/Mkni+QPjEydAdoIM/rjD/8bZCG+B
 LZjjIaAm6u9IwIZmdriJ5FWYDUnP6OEJK4E6rE7g/9+FO8M4bnYZEqApYWRe+2ameyrt9428q
 3kUvoTuvC/aT9SgaPmUhl/M6BuxFQ4yK3YTbcqm0ueygj3PHjDBenqfEQDrqAJfk9BsBzj6HK
 EmQwckjL/AI489/ryhJQFreO4a5LFEPjGTCTJhinWbcmznFcA6KxoEE46lxCwu+0ENmy5SE5n
 PSc8aSFVh73hWW2MIjlU1xmnYBDpNBzYLbySyRkarJIwUaE7tzcJwxpXtqgUgD8cFtBM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused labels.
Rename regulator tps62362-vout to +V1.2_VDD_CORE.
Reorder TPS65911 properties.
Rename +V1.05 to +V1.05_AVDD_PLLE.
Add ti,en-ck32k-xtal.
Specify TPS62362 vin-supply.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 45 ++++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 35af03ca9e90..f3c2dcd3879d 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -732,16 +732,13 @@
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
@@ -752,29 +749,29 @@
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
 
-				/* SW2: unused */
+				/* SW2 aka vdd2: unused */
 
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
@@ -782,7 +779,7 @@
 				 * +V3.3_AUDIO_AVDD_S, +V3.3 and +V1.8_VDD_LAN
 				 * see also +V3.3 fixed supply
 				 */
-				ldo2_reg: ldo2 {
+				ldo2 {
 					regulator-name = "EN_+V3.3";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -791,7 +788,7 @@
 
 				/* LDO3: unused */
 
-				ldo4_reg: ldo4 {
+				ldo4 {
 					regulator-name = "+V1.2_VDD_RTC";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
@@ -802,7 +799,7 @@
 				 * +V2.8_AVDD_VDAC:
 				 * only required for (unsupported) analog RGB
 				 */
-				ldo5_reg: ldo5 {
+				ldo5 {
 					regulator-name = "+V2.8_AVDD_VDAC";
 					regulator-min-microvolt = <2800000>;
 					regulator-max-microvolt = <2800000>;
@@ -814,20 +811,20 @@
 				 * but LDO6 can't set voltage in 50mV
 				 * granularity
 				 */
-				ldo6_reg: ldo6 {
+				ldo6 {
 					regulator-name = "+V1.05_AVDD_PLLE";
 					regulator-min-microvolt = <1100000>;
 					regulator-max-microvolt = <1100000>;
 				};
 
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
@@ -885,8 +882,7 @@
 		regulator@60 {
 			compatible = "ti,tps62362";
 			reg = <0x60>;
-
-			regulator-name = "tps62362-vout";
+			regulator-name = "+V1.2_VDD_CORE";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1400000>;
 			regulator-boot-on;
@@ -894,6 +890,7 @@
 			ti,vsel0-state-low;
 			/* VSEL1: EN_CORE_DVFS_N low for DVFS */
 			ti,vsel1-state-low;
+			vin-supply =<&reg_module_3v3>;
 		};
 	};
 
-- 
2.14.4

