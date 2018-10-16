Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6FB20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6FB20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJPSiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:38:20 -0400
Received: from mout.perfora.net ([74.208.4.197]:53065 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbeJPShz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:55 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFrWa-1gP4k317fq-00EvqI; Tue, 16 Oct 2018 12:47:53 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFrWa-1gP4k317fq-00EvqI; Tue, 16 Oct 2018 12:47:53 +0200
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
Subject: [PATCH v2 4/9] ARM: tegra: apalis-tk1: further regulator clean-up
Date:   Tue, 16 Oct 2018 12:47:25 +0200
Message-Id: <20181016104730.4598-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:x5wMa9lz8945j41QvdNnVnyUXqcalrRijtDdY1dDZS7hkN1HkTJ
 bfOKEIMbQXUo3ep1AlMHzcDVvWF4yhAoIY8Z8OwDsEky6Ygc9zFoVHfYq22O76jnQ1Vcvpd
 YxfHR68lod9UTEdt/NNGKWfsy2S8hgosftcr+ulOfdBFs1+PHCCU2Vi0QySppn6XFdNfa+3
 UyrRa6gMLcC/DVYUJvfDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TSa39364F3g=:uP8hH4oD/wJJxsEfxH7y8N
 TimgKLSfViL6Oy6MxDieW6kBZPg972Lt+O02QBk4smNGBv+vrv8wT4FqsV+6CzcKywNOEkouw
 iNgixFR1D803ONwsB5U3hBr4aBZUfi79lIjQCXos0rz9a8/ZYcImJ4hIPwGb1UEiaaV5jHG0T
 Af+SS7lwWjP03L06qIJblKQm4PcgRcZsJVdmS3fYPrLzobq4p1kiv6JgOL7mI7BzFL7dtaDrf
 jW7286IOALAoJSALOqTuKhr9Oc5cK+CmrX6h5XM2PgUHpIT+DpfixiZ4RaCbLDGiEY2z5y2gX
 p9jZdIqNTuBeXUEy7/SOx+zq4G0oQf1VV5lnnJVx3S3JIqKfYv7+ZXR1/wyMBRiL8QnB49ica
 30aXBcIgvBCRqZZO2GI3xUx4e1eKaUBGY5D9fAcptuf/744akgIULGD//88XiJ495KROjgsv7
 Kr4YKldugDIKV9AW2eoXKhgeT9LyBRQfw1g1aWj9ejB7kXRMbFGVXBcCa7uqRt66EhBpnM60Y
 OPr7wLMvKwMK49JcKDH8QMpSBvqgPqQmPfRlPBlwa8Hcl4ksGtZPLjcJRr3OkI1yLewmnhnH3
 Cr/mI19Df/L7ICA3ESCvz9TV4wjjLgSBhJGXDw7Fik9QXS1go+CTk6FExSpR+SGSFeQn229Rc
 CkLkoPffJBA9RsXDL0DBIuht5iwIS6VG1cVL91qeliuFRtEbtzFj40/uCL81W0J3WsLE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add reg_ prefix to vddio_sdmmc1 and vddio_sdmmc3.
Reorder PMIC properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

