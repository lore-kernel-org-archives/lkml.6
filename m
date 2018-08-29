Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F5A2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F5A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeH2MK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:59 -0400
Received: from mout.perfora.net ([74.208.4.197]:54259 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:58 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M2N6o-1fcILh2Ntc-00sAWA; Wed, 29 Aug 2018 10:15:10 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 26/31] ARM: tegra: colibri_t20: annotate/move sd card detect
Date:   Wed, 29 Aug 2018 10:14:02 +0200
Message-Id: <20180829081407.11304-27-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ojZsZFW1rfQzU7HtSa3mR2+6HoIJQrb6aXTVNfEdevVWrWIT3jG
 p6TWg5E1iWP2Jx0C/BNZx2B5wuXUCynALg5hdploRwtealGMl3ztzCKG4e3CH6Thw2mAWUV
 sCOtSNEjTHTd/PXBhZgJq+lDwlbohkeC5gI0jOOHftsh3/FiXbop3VJsy59zEatqTBtQRKr
 +Plz2TPzdIMWkLB+V9fQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a5rZytriYCg=:KrX8J2dP40BloT/pvJ2ho5
 7N7uSiusjK2zafJE6ZNWBbhZ960Vd3fK7N+AiafjkBFi3AXtySIV4H/V2NQEmgR92l8vvhaKS
 QSX+J1GA2aCWM8+GG6gDxlVSX3wVRPUaU/ObAeZdQwqsk9asWR4KVSSN4jFk5v2kZSebt8O3A
 ZJFaYBPHUtmclebCMAXERLLtMMc3c/Dqiy7zdkOOzBBnXrnbFcSkT3qfk8u35e8EL3rSMqL8I
 usdIvaDy0lklqy9k02glVOoq0neNGMUM65FePQbriM6/tAqHmyApXk0eFrOguFVUG74yEJlsT
 14O2hcKmnmMnEsKPSAtn6rsEEelHfvCJ7C2RBHd4W4Gr5Ys7iP44ReOlN1gqOmv6RLjdbyAJq
 tZNjpCSLV6NW68UsG+xomNnAZZaWuER0c2qF2Uc1DRVOENwBw5Z0tOQJ8Gariidj11qH5vtvk
 XvCYN1q4lEAl/ynCg+552ZesYfFq+2TkOWuWhkvH/DGQp18p9uOLABHNewGV0hBh5RmPiuGzK
 jqA6xt6rClzRQIK19FdQVF9RNbt0XOhX9MdCyVGpmH284iU9WL+xiJTtYknLteRQZ/DOyiqx1
 iZCsFGXhI48DN5kWMUJ24zqpn3w6GzN3CLVGFu1M1qVhONOoRw6zwDgWSyQIu/Ulvj9VsvXDg
 pfdWq9S5gs+ypiB5U/D9xxQNGV7OKQjlAzywXuyH40Z4elITws15N9V8jJ8vCx5+y0H0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate the SD card, its detect pin and move the SD card detect GPIO
definition from the module to the carrier board more in-line with our
other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 91b3404e1b3d..955d1e1ad8e0 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -163,9 +163,11 @@
 		vbus-supply = <&reg_usbh_vbus>;
 	};
 
+	/* SD/MMC */
 	sdhci@c8000600 {
 		status = "okay";
 		bus-width = <4>;
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>; /* MMCD */
 		no-1-8-v;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 35eec7ade70d..057147565b1e 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -698,10 +698,6 @@
 		vbus-supply = <&reg_lan_v_bus>;
 	};
 
-	sdhci@c8000600 {
-		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
-	};
-
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.14.4

