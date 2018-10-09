Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCCEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722952082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722952082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJIWnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:10 -0400
Received: from mout.perfora.net ([74.208.4.194]:51983 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeJIWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:10 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MUmqY-1gAyjG2XGe-00Y9mR; Tue, 09 Oct 2018 17:25:31 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MUmqY-1gAyjG2XGe-00Y9mR; Tue, 09 Oct 2018 17:25:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 1/8] ARM: tegra: fix simple-panel compatibles
Date:   Tue,  9 Oct 2018 17:25:16 +0200
Message-Id: <20181009152523.3771-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:DdWnYnhdeDeVCEnPW+iX49pwUWTPL9zRyj2SyDLWLucNb2AFecd
 GTn6qJIysnKbdV5E3EvMfjDDMBLq6iX8f9avGxUEm8BGNFQ9mjaV/0iMUuoDkbSWw/7o0ue
 RSkRUfrWX5RDQRWfieBuUttsxsjPJKpfN7AD0hTuXGZP2aEAsMb/cY/hQrKFhEbhwBZ4oxa
 K6a2MiZxhD1FRH7kgWi8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lw0XQisUmqA=:x5Htl5BrfUKOy7O+Ewc2g1
 c7G3ieoWbTEkabHZBiYx/vIUD5SLLTn6+rAfR5oEi/6K+mKbN+bF+KTwMWqHGhY7EOrOo221K
 gYWkxTE7l5jWq3tfRdTR80vvBpyi+nziYIsF3x3KKqHnjmTMnPkysCrEFMa7x3t1AN5NS5fdM
 ko3YAi2UQ02PVpl/8prOj7ulyp189sOvbYC/o+B/nFxHlPkNSf2U9zZ3LgF54rjZGNNs1z9rW
 lwtXh0xTDBcUGUUbmcxZ1GQr6mgyMhkOOnbozvpFA6sheC7wgNvnFCIA/RRTb52/Wi4JkGSNp
 Rmm14M8XArPNo3d4pH0uMXnu5jURZC1lD4nRw20U3vWyFPtc3FnWxSbim5dC9VTOCCig4WVr/
 5YSg3hdrnFy9u6JCBcMo3qYWiSSOBGMB4fV0PO/Vl+ESCOuN1WQAgaPQD9V+zV+kKKSoh7E8t
 KMX2N8OPGQtiFKmbtdZcQudpIS3kATbE5IdAksX0ahKFviFOb63iAYmQIYsFPZK6mfAx0b3eu
 T0xZVU9nQpDXwVsDYBhTr8o1swlWeKLkJM5mrlkPvclH3pl1r96KBO/cahXrK8RL5UH+2SN3b
 +Ip8IxczdsTq689nnnCLIYjFO/ETW76XSnCZYJzvP7uO+Ug6t2Q060l0bDlpweLV/SG8A7P08
 I5NTIJMoDq32PjTI+Sh40E+WXOmfZpHJAHL4UcVWTw4hqYqJshd1wkUrZVNVrzcEsuLI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As there is no such thing as a generic simple-panel compatible remove
them.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

