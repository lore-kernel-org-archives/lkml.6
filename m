Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617F221473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617F221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJRTPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:04 -0400
Received: from mout.perfora.net ([74.208.4.196]:51043 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbeJRTPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:04 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LkQWL-1fceZh15Z5-00cQij; Thu, 18 Oct 2018 13:14:22 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LkQWL-1fceZh15Z5-00cQij; Thu, 18 Oct 2018 13:14:22 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/7] ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio enable
Date:   Thu, 18 Oct 2018 13:14:06 +0200
Message-Id: <20181018111411.26623-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111411.26623-1-marcel@ziswiler.com>
References: <20181018111411.26623-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:YjnBn+cz86dAFXn4ltS/0BckGo48Q0yJ+6U/y+LTaQQKaL+udNM
 FezbJABOWLxJahwonOxqNCoDSe8uJ19KRjzw8wdumvqmjAFcmcNYBgheztG32tFpg0K74cJ
 XsIyYnb1gfFl+IeccUQFLeOenjFRKQwsNLnRUgHh5cmoO7yxjffLlvEGtMJCT0gDWHpzeEZ
 QzgHAC6dSyTe2vUWv9HmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rDCdKtLgv0E=:qmD8zVqLmhuBaUtH3N5IS/
 1zWxR77CbF8nmpyyGBD9MJ1Vmld2sKAic/2OyGB4GDeHW82zoC0dnkivex0+SeMZl+AoUi5+D
 4TJYQCbVTCTxbttIttZt6p9/CP+Ge3NAW//TQhFUb+zZqM/BNI3ZI1P6sEY7oo6AtuNJfMNjY
 +v+lfEfcCGKKmE/DNKTv+FbhSJtP65gadPrM2B+KNUYidvNGBR5fE0QNxgM1sszaN5yMGNH4K
 1mFP1KJ+9ze3qOg932X281GcT3wcX1YfE3j2LFh0vX3TRCme8+pbLwrns7PCt2NRuDM2bnMlA
 JWM2+q1KG93H908gJeojZkt7M49en+IESg0lgXF/PRHVYdKcK1pdWvjkl8vnPlr2ThHQRbAfj
 /szZ+B040Kn+0f09Jw7rSn8QZynrIKoh2vBrOAo03DMeMvvfJPqsWe9eaTQVPP3vd2LR98L6i
 UxgQ75jF/7NFbYNjQm7EQS+MUiPBaBRgYXSZZY+PsgVX6PrlPR/4Qkc1hH0c84oin522Y3s0i
 qnleVfrwQ9gSJx6Edzg8Y3T5nJnXq0CjSWjrekgBL7s0xLACFKIK66sRqqr9tpVtjAKc/42BY
 V36hdPFaI+uHhtxxIjAOJWr5uloe2thdbbJ7xdsBQ3Wt0+nKvVamsPWF1DEObE11kHC4DpFqS
 LsAWmn1YK0HQrn7P6EVGOKDfAThQEKvtE6MqlWcOH2QK89g1HouA9/kPUL0sYsJvW/Dc=
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

Changes in v3: None
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

