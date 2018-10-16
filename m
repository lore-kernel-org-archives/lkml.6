Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09293C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04E02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04E02089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJPSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:37:58 -0400
Received: from mout.perfora.net ([74.208.4.196]:59421 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPSh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:56 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLgwf-1gCe0T1g9r-000xLf; Tue, 16 Oct 2018 12:47:58 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLgwf-1gCe0T1g9r-000xLf; Tue, 16 Oct 2018 12:47:58 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 6/9] ARM: tegra: colibri_t30: further regulator clean-up
Date:   Tue, 16 Oct 2018 12:47:27 +0200
Message-Id: <20181016104730.4598-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:BIyST6wbuvrOKm/VtFpml+QrTzOahly4/RB0hw/ni0b5MxEINsu
 3LHZSf1QWVnFQdKPbKpO96rZE++uDVNdmxnRdu4vwVn1vPmJaC4+8EjZDeFvjX7t9E8cK3U
 QDHjjlz6WCVfqALeaD0Go3eFUjs4KUUU15YnQeKMdmSgmxEb61QYLTroRGMqHqC0hsIZXn0
 4pqTG9JJ+BY/aQ7OmGHEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eRZq/wmYV10=:71oPY00qpPQo2mMqTnOuUq
 Dk7Pfvak6eZtA6KJ6MECBJhboQ5YnKJ/0bJp9hE7DX7vaRoEFjLc/u9WGKkouewsmwPYg87ZU
 OU/7vp9tDxtm3Nq2i95gd2jUBlSKCWDy0oKxt6c8abdg3VOmnJvvl11a5J6AmNAADPCvGzXo8
 wQerlHPd5glGKTGA4qQ8Zm2FLCKYRarXbIzlGvt8vmjwkCLeyD7mVgS0eMK3YV24+LdP6pKy+
 y9hQgTSX1VE5vIKA14icGOEqAYsP34+KC7XALDpFkl8Rc0Boy2tJJOFQcdZiX1MXLz217v+BV
 SdHZd6rOelmQuudnE+klTf/rzj0O5qhFy61iWesCdSZTJvwY5jxCASKjGZ2or2QuiHnNXVKGb
 ypO7Lu0gFvK+PFjXwDt/y9VeqzUthQ7QPpSY8tIhDTtoufPM5ebD3onFWAcCaGk7rtXwkymmg
 lV15ooX3liAU2c8Xn9x06pLkNsVSOLJNHlCjmjh1rxMhWi2nYz+jCcA9MSWCgRFXJTIKZt10k
 +iHbyhHj7OgXAON7VsiSQ8+pCYWZZlHIcg3Yt8x5OR69e52HJWSvSzF8bMvHiaCsmGJy6di2N
 yStlPjdUpJxGCJbCKdQg98wN2HsGtdKlUYPgDfquS+E+qQ8PH4Fc/q3Yixk5qCovyUhcr8Z2S
 fsv2wX97VCMERPxKBGz3sWx4qq3aglcF8qttFIfeFF0Lb3D6MI2p63vDSb5M2suzxtL0=
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

