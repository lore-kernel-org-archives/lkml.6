Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C4BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB5A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJPShv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:37:51 -0400
Received: from mout.perfora.net ([74.208.4.196]:58071 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPShu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:50 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgFn8-1fpBgr2N1g-00niQe; Tue, 16 Oct 2018 12:47:46 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgFn8-1fpBgr2N1g-00niQe; Tue, 16 Oct 2018 12:47:46 +0200
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
Subject: [PATCH v2 1/9] ARM: tegra: fix simple-panel compatibles
Date:   Tue, 16 Oct 2018 12:47:22 +0200
Message-Id: <20181016104730.4598-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lzR7XOt2nJa9uHOrfnz3DP/N07PY4ek1fRBxF1NaAYq3YyJUrT1
 Cb38/Xgxwnz03SVpSHUd4fbrcRcXlAv02gWR83gHmddka5oxJQo+R3zlSdJLPnELE9JoG4A
 K0NLabwbdKmTLIdhbBlVlryZrEzYLgBbbxixDS4KrQA9rypp4HG2EINeh0avuKzf55T2TBA
 reAhbUNnNSKtBXu3ZTiYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dqkdbmergjw=:DKOdpdzzeW+RVoMj9krVu1
 +Etn1ODGdKWxFuXA0Ah51zYqulwH99EQlXqxvPkk/yxmAXSbZs/ZPRMgfDzndURqsV01H2kOr
 jXt/+RDF0FWYP2ZjusWOCztdemLxLLeMDLr/bOgSxr5Y9EIaMqtipwerHwCCQsPvZIQcr2PeI
 ZB+oOisFnHU+edLZjKhv/W8jhmCG3W7AlDhKNjoEjC24XoasBIELDEd3blEIKlQo1tG62XMtj
 Fu6cGeKoxTkIgg4pWtP56FJlQBHiwnE9ceQ/LttRWujIk0FJdcqR4FXpCEn52h/4Pru7OMV4C
 rVl8Zz3W9P+LNU+MOwp2r+RuA8JKSS7EpgOlaVwOxXhUX+cvyOyVDc4KmtHZZesJpDSewDsno
 okLVLBBWZBmZoTG40vl4hoJu1nVF2JmfUbOlSd8YOCYNlJyori29zOASt6XUXWnXefaP2zhAu
 9UHihpnTMTCZATcesSV5kQaR0Z442KkfN9+boABO4iyOkErvh9VQwCkNq1Lm58eXfzItK05E/
 F7V+wWkK+czORvWekmRU/MsDcNE1a473wRMr9fYQ5dS7LzIrn2nGg1jmz+ExVBQ7M/qKLzZ7l
 o0jUWehdwhH+E7Vd2YSt8WSuJQRnMUapxsowGEODlqUP/5ncBolPuE8zHEXQ6NT1+us1rtOE6
 syQVYGVFznZccHzXVBR/vGva60TfeFAcXhcH1zu9UMoKvITMHKs5TO4dzQnYZiJiFZ/Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As there is no such thing as a generic simple-panel compatible remove
them.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None
Changes in v1:
- Remove simple-panel compatible as suggested by Rob.

 arch/arm/boot/dts/tegra114-dalmore.dts         | 3 +--
 arch/arm/boot/dts/tegra124-venice2.dts         | 2 +-
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts  | 2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts     | 2 +-
 arch/arm/boot/dts/tegra20-harmony.dts          | 2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts      | 2 +-
 arch/arm/boot/dts/tegra20-paz00.dts            | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts         | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts          | 2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts      | 2 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi          | 2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts  | 2 +-
 13 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 1788556b4977..2ea7236d9da6 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -46,8 +46,7 @@
 			avdd-dsi-csi-supply = <&avdd_1v2_reg>;
 
 			panel@0 {
-				compatible = "panasonic,vvx10f004b00",
-					     "simple-panel";
+				compatible = "panasonic,vvx10f004b00";
 				reg = <0>;
 
 				power-supply = <&avdd_lcd_reg>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 82d139648ef1..f54f77902774 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1079,7 +1079,7 @@
 	};
 
 	panel: panel {
-		compatible = "lg,lp129qe", "simple-panel";
+		compatible = "lg,lp129qe";
 
 		backlight = <&backlight>;
 		ddc-i2c-bus = <&dpaux>;
diff --git a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
index 3c0f2681fcde..37ad508b61d9 100644
--- a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
@@ -223,7 +223,7 @@
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
-		compatible = "edt,et057090dhu", "simple-panel";
+		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index d8004d68efa0..af4740847769 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -205,7 +205,7 @@
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
-		compatible = "edt,et057090dhu", "simple-panel";
+		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 1d96d92b72a7..02cd67ea2503 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -665,7 +665,7 @@
 	};
 
 	panel: panel {
-		compatible = "auo,b101aw03", "simple-panel";
+		compatible = "auo,b101aw03";
 
 		power-supply = <&vdd_pnl_reg>;
 		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index cda5448c2ace..c73510cd501c 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -57,7 +57,7 @@
 	};
 
 	panel: panel {
-		compatible = "innolux,n156bge-l21", "simple-panel";
+		compatible = "innolux,n156bge-l21";
 
 		power-supply =  <&vdd_1v8_reg>, <&vdd_3v3_reg>;
 		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 8861e0976e37..e75f86901dfd 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -543,7 +543,7 @@
 	};
 
 	panel: panel {
-		compatible = "samsung,ltn101nt05", "simple-panel";
+		compatible = "samsung,ltn101nt05";
 
 		ddc-i2c-bus = <&lvds_ddc>;
 		power-supply = <&vdd_pnl_reg>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index f91441683aad..376ecb6435f4 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -826,7 +826,7 @@
 	};
 
 	panel: panel {
-		compatible = "chunghwa,claa101wa01a", "simple-panel";
+		compatible = "chunghwa,claa101wa01a";
 
 		power-supply = <&vdd_pnl_reg>;
 		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index f44551e2d9d0..022649119821 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -611,7 +611,7 @@
 	};
 
 	panel: panel {
-		compatible = "chunghwa,claa101wa01a", "simple-panel";
+		compatible = "chunghwa,claa101wa01a";
 
 		power-supply = <&vdd_pnl_reg>;
 		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 749fc6d1ff70..b39c26806bf2 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -195,7 +195,7 @@
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
-		compatible = "edt,et057090dhu", "simple-panel";
+		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
index 0be50e881684..e29dca92ba0a 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
@@ -196,7 +196,7 @@
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
-		compatible = "edt,et057090dhu", "simple-panel";
+		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index fb9222b479d2..3894bf47ea8f 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -432,7 +432,7 @@
 	};
 
 	panel: panel {
-		compatible = "chunghwa,claa101wb01", "simple-panel";
+		compatible = "chunghwa,claa101wb01";
 		ddc-i2c-bus = <&panelddc>;
 
 		power-supply = <&vdd_pnl1_reg>;
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 5965150ecdd2..8e106e784dce 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -159,7 +159,7 @@
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
-		compatible = "edt,et057090dhu", "simple-panel";
+		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
-- 
2.14.4

