Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F187BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83FB2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83FB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJIWnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:11 -0400
Received: from mout.perfora.net ([74.208.4.196]:38311 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:10 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lalt0-1fPali2TY8-00kRL9; Tue, 09 Oct 2018 17:25:35 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lalt0-1fPali2TY8-00kRL9; Tue, 09 Oct 2018 17:25:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 3/8] ARM: tegra: apalis/colibri_t30: fix hdmi regulator
Date:   Tue,  9 Oct 2018 17:25:18 +0200
Message-Id: <20181009152523.3771-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:TxlHnchDp7zNsrdszeUJvfdigjN5JzPkzgZHCOia+qtABLTsRkE
 qBJO+seO6vWA3AnHZ1ciIJZU5ePXAD4mNGRCP7/m2IOrNOzK/Uef+Sy3lxXQfPexcM4Uu1t
 ciF8Lat8X8ggjoqytSeTIGItCNK191eC9W4eYqKEICB5E5gGk8eZoMj85pHCxaGOMvvOskp
 6+U/8nqzOrnDwUoXCjapQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:apWq/wa1Hww=:ybOmJAzmlP98HLLZT5VmYV
 JEb1gXzx09/eLvDKNV1iJHMiUnRR0X5DylWJ6xg3MPDn+e8uWc5JjibCtxIF4yV4wxfnVElOM
 shSJTKIiWfFx702LQ0uXPqNXhZk+TAtH9Ip+mPnoYCupmpZNiI8iuuFI7vqbraw2ptquO8D+i
 z+Ja0hL/i/VvPYVqnpCVi0y5xm50NKwDtfFf62RRb6krVLcWv5vTM/dpeFpU30i95uk5yB+/W
 7o+/bnCSSth4B8G91iOJHPX4ov9W8JAcXT8vKYm7wa7Pm73Fm3bqfLmshi5CAKHAVnsZHYFMy
 3PelVmiD1ybJ0ESERS5qh6oUUifx802uHJhkilvV0uuVgrSZf6wMuOb/aLioGn0kHDaZSRwvo
 IdxUrE6QB/iql1Nt13knRkBaj73uQJJRp7iIW7rz3EPhGZnJpBfpLz3Bqo8Rmh04E67gjrkwy
 icvAxYds/TtY4DQwB61BAb7sph9LgqA3rH04ehzzJdDwpS6vVNiVvabWaXY4Q2fOybc2R2OhB
 2+owFvzSKkp9sU8rHFyFrKqC+votv64SqSeNYb16Rm4LsF+0C4RuJCysA32/n5S+At/+MSs9e
 RL6W4qh5tp8E5xZGp4OvrZ61XH8YtA+VABvU1sPsNTkiOYxzmo290zPr4WuYBLgV/Nq9O+Fjo
 yv1DQ6uJ/qmhYmmaT1c14i1v8zfjYPD4AxPIiuhNCSURAvYs++8EmsuCufcbjU45lNSo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix HDMI requiring two regulators being enabled by a single GPIO. Model
this using an intermediate reg_en_vdd_hdmi regulator being the
vin-supply of them other two. This fixes the display subsystem and gets
rid of the following error during boot:

 reg-fixed-voltage: probe of regulator-3v3-avdd-hdmi failed with error -16
 tegra-hdmi 54280000.hdmi: failed to get VDD regulator

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v1: None

 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 16 ++++++++++++----
 arch/arm/boot/dts/tegra30-apalis.dtsi      | 16 ++++++++++++----
 arch/arm/boot/dts/tegra30-colibri.dtsi     | 16 ++++++++++++----
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 02f8126481a2..065a24ac1052 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -1133,8 +1133,7 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		enable-active-high;
-		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&reg_1v8_vio>;
+		vin-supply = <&reg_en_vdd_hdmi>;
 	};
 
 	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
@@ -1143,8 +1142,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&reg_module_3v3>;
+		vin-supply = <&reg_en_vdd_hdmi>;
 	};
 
 	reg_5v0_charge_pump: regulator-5v0-charge-pump {
@@ -1171,6 +1169,16 @@
 		regulator-always-on;
 	};
 
+	reg_en_vdd_hdmi: regulator-en-vdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "EN_VDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_module_3v3>;
+	};
+
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
 			     "nvidia,tegra-audio-sgtl5000";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7f112f192fe9..6727c5868425 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1115,8 +1115,7 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		enable-active-high;
-		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&reg_1v8_vio>;
+		vin-supply = <&reg_en_vdd_hdmi>;
 	};
 
 	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
@@ -1125,8 +1124,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&reg_module_3v3>;
+		vin-supply = <&reg_en_vdd_hdmi>;
 	};
 
 	reg_5v0_charge_pump: regulator-5v0-charge-pump {
@@ -1153,6 +1151,16 @@
 		regulator-always-on;
 	};
 
+	reg_en_vdd_hdmi: regulator-en-vdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "EN_VDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_module_3v3>;
+	};
+
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
 			     "nvidia,tegra-audio-sgtl5000";
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 35af03ca9e90..963f26071415 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -965,8 +965,7 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		enable-active-high;
-		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&reg_1v8_vio>;
+		vin-supply = <&reg_en_vdd_hdmi>;
 	};
 
 	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
@@ -975,8 +974,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&reg_module_3v3>;
+		vin-supply = <&reg_en_vdd_hdmi>;
 	};
 
 	reg_5v0_charge_pump: regulator-5v0-charge-pump {
@@ -1012,6 +1010,16 @@
 		regulator-always-on;
 	};
 
+	reg_en_vdd_hdmi: regulator-en-vdd-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "EN_VDD_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_module_3v3>;
+	};
+
 	sound {
 		compatible = "toradex,tegra-audio-sgtl5000-colibri_t30",
 			     "nvidia,tegra-audio-sgtl5000";
-- 
2.14.4

