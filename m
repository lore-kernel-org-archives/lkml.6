Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DA9ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4860421473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4860421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeJRTPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:07 -0400
Received: from mout.perfora.net ([74.208.4.196]:41937 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeJRTPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:07 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LvTAD-1fVxZJ2b9n-010bRt; Thu, 18 Oct 2018 13:14:27 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LvTAD-1fVxZJ2b9n-010bRt; Thu, 18 Oct 2018 13:14:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 4/7] ARM: tegra: apalis-tk1: further regulator clean-up
Date:   Thu, 18 Oct 2018 13:14:08 +0200
Message-Id: <20181018111411.26623-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111411.26623-1-marcel@ziswiler.com>
References: <20181018111411.26623-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:kTzT6JAdsm3zHPKM6L3/1IJ5wfY7DjoX6qFTriSXjKRMFrhSOl0
 f4QEXRuCbWQN3wIgkdmGkYwDgfNBNlLLQs9reL07I8NNNYjjRr6ZuGWfGXen3Yx9r/7rutV
 FVU3X6PKE0dcxOmuVGEeDawTlqqNB4dYKfVwYXf/k8G8prJ1trGiLg/P4hcV/QU8x0GeuG5
 X3HLiTAx/C6XFCuuvFAUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nd1EXAOAMis=:9vD6zT04Z7PoVNAf3qudmp
 N2HgWvZJkOOB2OWTAwb0RkHYopxePGkOpGWe4WoWWkwOSQxC/Frp1JjSWE/leUSob1QkWwdPG
 9wgpwfmM182A8RTKH762PbEQ7lMSC7NMCsIrHQzhSfEt+I8tUphjmYzJaXXB7QDBBikzz7ZjO
 JVpCeGdFvG5gtFbxkpHcQXAxv938ue3BLEfUadU7V9ijP/USAjnliD3YUq0jhXU+2TykSw1WN
 OVlId1hNVGkm3TlbG+graOqBO7jIGbpb7iAtFNM3kIUY+9H0Y4ArE+a0QD1IeGrCNeqLO+qUH
 yCDtzx+69GbIX/BYW0o6f9GM5/1NO4Sw4gZ7oNPTOwmKOYm5HlGRUxCwP9L+6zCN7M1YrqcIz
 UzejEhcQfJblItorYlYYeHzxdbY2VnfpfoxB6+d0PSh4otx6iVIqKhGY9FGp+8UeTDjIe0cIw
 wFzg1L6kG0j1aGYkf4JSt+jLMMkv9/VZF12Jyn5OmK0Wf6s0Pe0CGq6+3EBckeUzIJ92/rC81
 HywAoDxYydEOIKqjt+W0/LmI6ICy7NawVfQ7svRDzAlJk/9hi9+xOKjm9ZVJ51r2dzYutcTBw
 FG0lBkveoWWe3jRu7AL4h1h3hbEzqfuV7BIwzl/6QzgG03iBdutccFvliSY3NQtiI3ctthY8/
 bM5ddPqRrvb4UUEwyv/pQXDyvTrwCKL77f7v/y6mvcGh5ELDqO1wKN7MiW/+Zf4I5KY4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add reg_ prefix to vddio_sdmmc1 and vddio_sdmmc3.
Reorder PMIC properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/tegra124-apalis-eval.dts      |  4 ++--
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  4 ++--
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 10 +++++-----
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index eaee10ef6512..e553eff50499 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -171,7 +171,7 @@
 		bus-width = <4>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
-		vqmmc-supply = <&vddio_sdmmc1>;
+		vqmmc-supply = <&reg_vddio_sdmmc1>;
 	};
 
 	/* Apalis SD1 */
@@ -180,7 +180,7 @@
 		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-		vqmmc-supply = <&vddio_sdmmc3>;
+		vqmmc-supply = <&reg_vddio_sdmmc3>;
 	};
 
 	/* EHCI instance 0: USB1_DP/N -> USBO1_DP/N */
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 7961eb4bd803..e2f94dc7ff91 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -137,7 +137,7 @@
 		bus-width = <4>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
-		vqmmc-supply = <&vddio_sdmmc1>;
+		vqmmc-supply = <&reg_vddio_sdmmc1>;
 	};
 
 	/* Apalis SD1 */
@@ -146,7 +146,7 @@
 		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-		vqmmc-supply = <&vddio_sdmmc3>;
+		vqmmc-supply = <&reg_vddio_sdmmc3>;
 	};
 
 	/* EHCI instance 0: USB1_DP/N -> USBO1_DP/N */
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 73a8e117a9b9..e532b564e4c9 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1570,12 +1570,12 @@
 		pmic: pmic@40 {
 			compatible = "ams,as3722";
 			reg = <0x40>;
-			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			ams,system-power-controller;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			gpio-controller;
-			#gpio-cells = <2>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&as3722_default>;
 
@@ -1679,7 +1679,7 @@
 					ams,ext-control = <1>;
 				};
 
-				vddio_sdmmc1: ldo1 {
+				reg_vddio_sdmmc1: ldo1 {
 					regulator-name = "VDDIO_SDMMC1";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
@@ -1711,7 +1711,7 @@
 
 				/* LDO5 not used */
 
-				vddio_sdmmc3: ldo6 {
+				reg_vddio_sdmmc3: ldo6 {
 					regulator-name = "VDDIO_SDMMC3";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 3e3b347afe56..3cab9bda918f 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1600,12 +1600,12 @@
 		pmic: pmic@40 {
 			compatible = "ams,as3722";
 			reg = <0x40>;
-			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			ams,system-power-controller;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			gpio-controller;
-			#gpio-cells = <2>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&as3722_default>;
 
@@ -1709,7 +1709,7 @@
 					ams,ext-control = <1>;
 				};
 
-				vddio_sdmmc1: ldo1 {
+				reg_vddio_sdmmc1: ldo1 {
 					regulator-name = "VDDIO_SDMMC1";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
@@ -1741,7 +1741,7 @@
 
 				/* LDO5 not used */
 
-				vddio_sdmmc3: ldo6 {
+				reg_vddio_sdmmc3: ldo6 {
 					regulator-name = "VDDIO_SDMMC3";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
-- 
2.14.4

