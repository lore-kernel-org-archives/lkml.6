Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DBC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C012214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C012214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJIWnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:11 -0400
Received: from mout.perfora.net ([74.208.4.197]:57581 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeJIWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:10 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MVbnF-1gBo4h2TTL-00Yyj6; Tue, 09 Oct 2018 17:25:33 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MVbnF-1gBo4h2TTL-00Yyj6; Tue, 09 Oct 2018 17:25:33 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 2/8] ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio enable
Date:   Tue,  9 Oct 2018 17:25:17 +0200
Message-Id: <20181009152523.3771-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:csVlod9DLphVaeaTIyMylXuAX6z/AIAbCOZ4VMbm5Th56MpGDj4
 OfOBmFsQHL5kmwCuqOfzSaAsj6ERj34Ulx+qcXyUSNt4HMFq9tbPu1fptxhsnuRmN8MVn5W
 75OIHqDkiJpAIVEUvtRpRQYXrUn8mFpPLXFE5jMy2dZ8Rb8oBtsmHu1i14Ds/BLH+yAD7iY
 DEDv5GFDKDE9t1gjN3cZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dGZ4Na06ak0=:fDN1vz9W2DG4vv506PKn3J
 kf1Nl8bMcgxR2OlEN/IACNCvtkkaGZx1GQehMiZ5uK+vrGzx9ih3uWOjvk8OBEa/QH+QKxP90
 iywxftb1F3vh8xZAjWaujoGd2WScoq8vWnWZMqcTI66TX7LDNcWAS7iyhCzG/HZmtY4NNL9et
 hIia5llVt0CA/mKFgbVQbp55K5R5XNVutqniHex3RUuQaa91U5jk3uo+e9sp8ONhy70OkDxpq
 Y2E+jSR8wkislDJxjnemoCa4kZkYvHdPnY4dw7HWuFIVbIIQthXg2YXanQlqbffw3NrnwinHb
 6ZqND3epYHcA0Mk8tRdLTU4F2sMyD05LfOJx7awiPbTtTxbD72auA9STcc9Opr6loZEgzwWNi
 7L53xYmSJDBveauEIAZo2kRaGDbpUVWLTCzd79ZTvgodeQ8D3uQqukh9uaZh9qTTVn1eBuYS9
 0pFZUw4TpFjPvvTSa3DksFILWx/nIgrkFeqsNGD/jQs2pEOeTo09qhCUDEmtNj5p//pFjqAJH
 H50ZbMo+alYQezU9ETSEW+b+FnCjUGDl+1BEG/1lO3m48BPdoUj3iVXoz/Oy3bM0Q8oMUKL1J
 zdIYhQ45iDYnZcDvKLNMzYJiEwHuEux8R4KvmwEISWG/WXPhGPlfRXe/GEj714Ed+aO3FjGvp
 olHlg2EzOwvblhvHpqVOPNuhch4M81QA7BTftGxR7AWE/4wHJ0ThAvwOzzpYBBDd4rdU=
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

