Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BCC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D675214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D675214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJIWnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:15 -0400
Received: from mout.perfora.net ([74.208.4.197]:43933 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeJIWnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LZwwF-1fOlxf3zzB-00lomk; Tue, 09 Oct 2018 17:25:39 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LZwwF-1fOlxf3zzB-00lomk; Tue, 09 Oct 2018 17:25:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 5/8] ARM: tegra: apalis-tk1: further regulator clean-up
Date:   Tue,  9 Oct 2018 17:25:20 +0200
Message-Id: <20181009152523.3771-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:jZUsxQOc12bYTtYzN2bvLMh1pvVqSpo/qLfcB3ABck2ktu3JPpo
 x33glYIBp4pTgfHuc/WyuiImVXiABeuvCcXmwwNm2E+OK+Nm6xHnppbidMCH1Exv9qumeuJ
 b/8IThGZlzXccb/l7N98zZYD+xV+q6G7gsYhgiG8l8eVlhsFgkwZDfWRMTouKIfdiDjWt2v
 Ta3oF+oc5f7hXKiwEWA8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:08r0L4282cU=:EKqfy9LQFTQz+COFwUDoPI
 j7U3IuSShtujB0YfbkyqvQzLcMr2mEDhOo/5755j31ds0rI13p4XPqnssW7fSf+G6T4WGwVsy
 lP+rBbcfz6sdjuo4GQXVNwfnoswRS/vQ/BnijDRw3dsKf43IYKmniT7f12xBlVKmXLog4MxBW
 aNSL25sh3CL9eQSf7YhrAgaZcLMS5fWxaxZYG3ul0bh0DHSqjIWtXwDBwytMm9bkn8mFbqPeo
 twUedZVuzv7mFnSVXeZnwgD0onexo+gTVY/G/SdKdkikKrN/8XfrIL8h8WCtR7GuZJfj/jfHv
 k/nHyBdoCc37M2IUfti2ZE+rXFDWH6Eo7ZlbXIeCgs3C0T/H4EuVXVmAknfkYsAIRG7i25919
 3O608ec8BahF+UuEnMRcpAUKYD10LjbpAyuiXTb+22dgHqElsPBoDUPpoQnJLAjwQztz4x+7f
 S8rohbAKUqk/SpTzuM4ZN4G0EMR8cDzwMfYeWJyFAiqe5w9zpT8wLvMF/xKAyf3UPRYQSH4BK
 JW3sY9QM0AObGFv1LgqDaHco2XjZfworGnstRpExB+WGeRDpQt3/731QSrWN1ue3vyzhA4dMs
 U/MHdknSiRI40fQZEj28dftBMr+a+xYJPJBJZiKI4ZukfvOB3MnZfIfMvClkRUU24WP2aBw/E
 u7o0ivpTJ0B2ktuorqrb4lsaOvgfyv2cvFQD9qdFWvAGYRNqbdfP1OjmEV1wOXJAY36g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add reg_ prefix to vddio_sdmmc1 and vddio_sdmmc3.
Reorder PMIC properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

