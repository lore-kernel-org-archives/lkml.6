Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4C6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69711208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69711208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJPShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:37:50 -0400
Received: from mout.perfora.net ([74.208.4.197]:37009 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJPSht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:49 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8gIX-1fQ3cd0gHD-00wClv; Tue, 16 Oct 2018 12:47:48 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8gIX-1fQ3cd0gHD-00wClv; Tue, 16 Oct 2018 12:47:48 +0200
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
Subject: [PATCH v2 2/9] ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio enable
Date:   Tue, 16 Oct 2018 12:47:23 +0200
Message-Id: <20181016104730.4598-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:XqocmbGRYW/uclVoJwDyJYVy/cNnWETyGtI9UzOc16hqj0NaMXC
 qFO88r4HdrlWIFalb5nhPtdN6BozjFvoLp0yrDQliz1tGxD1628zj86oiqv4FVYSNUdXRF/
 8UBAktMpMtHnhWYbwjQeFGqkazr2uRlE2+e9hDWYGAz+FDe/d1P+Ykm4t4FvpUZx4xqqfLB
 bw8yAhHoxcBgbnpLPiteQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aP5xIFbs9xA=:J77xsiNhTcJqscWXv/+Vdo
 s6RAV9iMXtGBDw3yOM3Nt94wQVgooAvYWpynnGcQcbI1G0kA/LRdF5nu5NVYl7gyYAGKKb3fA
 ZP2+aM9EzPpl1ahkiATYWKoiMVnKTRWx56tFLGIducwoQI9EgcMiUpwlEeU2dY/PqUTTjtIR5
 qwwnq+S9FSbHJm4iRJYKPJKCoxr0Qh2d9aaQMWsAdXQVWhjJ4fr8BOAlkiM6Sde0xTUl617hw
 D+5nGRBePDNhvJHHZocjf2M16SbgGV0oh82JOyAMf0jpxGEDXSnsQFoqmjPQC3vPK0Fx8gKc7
 +nLyw2+7rH3hO+70NcU0VhZIrzwoUZEe79GtiIvWxt9Un7db8Lalfywm7jWDH0obzvEAY5HCM
 X/tey5/q//+pJsY3PlkOiIFv8wW5kTUWvEZptNmz5sxv8X6PtMnWNkmq2uNMKVNPB810IUMiA
 cYeRTIbx+FMwglVaBUJoRL+aV1B3SqMooDbM9OdsI8bWJZnYYiIPUZtbRCzdLml05zYNSL4yu
 kNsNJanKBajdsvb7Xf5/zGucYi7M5E9DYz70x3dQLmMBOJP3da4EgutmQEitBoRzq9rIQ2saM
 5QaSCU1HW+upalioH2A/PUmObsCJc4Qkn6scvLhl0VPDdqrQ8xH7sFMODzKG9K5SPcclroMvT
 Sy7wEoK7G+n9z8ksFEI8aZo8mCEtmblLB3ZIGtSjX9vrM9eSo0USv/cYoaNWTBwi1vgQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Anything other than the default active-low would require the separate
property enable-active-high to be set. This gets rid of the following
warning during boot:

 regulator-usbh-vbus GPIO handle specifies active low - ignored

resp.:

 regulator-1v05-avdd-hdmi-pll GPIO handle specifies active low - ignored

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi   | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi        | 2 +-
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts | 2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts    | 2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 367eb8c86098..73a8e117a9b9 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1948,7 +1948,7 @@
 		regulator-name = "+V1.05_AVDD_HDMI_PLL";
 		regulator-min-microvolt = <1050000>;
 		regulator-max-microvolt = <1050000>;
-		gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
+		gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		vin-supply = <&reg_1v05_vdd>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 13c93cd507d8..3e3b347afe56 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1978,7 +1978,7 @@
 		regulator-name = "+V1.05_AVDD_HDMI_PLL";
 		regulator-min-microvolt = <1050000>;
 		regulator-max-microvolt = <1050000>;
-		gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_LOW>;
+		gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		vin-supply = <&reg_1v05_vdd>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
index 37ad508b61d9..f1a85d930e61 100644
--- a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
@@ -256,7 +256,7 @@
 		regulator-name = "VCC_USB[1-4]";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 		vin-supply = <&reg_5v0>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index af4740847769..e1e5ec5253fd 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -238,7 +238,7 @@
 		regulator-name = "VCC_USB1";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 		vin-supply = <&reg_5v0>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 8e106e784dce..7e6bf4cdf322 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -192,7 +192,7 @@
 		regulator-name = "VCC_USB[1-4]";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 		vin-supply = <&reg_5v0>;
 	};
 };
-- 
2.14.4

