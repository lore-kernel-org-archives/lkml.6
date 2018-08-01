Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E781C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A08208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A08208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbeHASVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:21:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3169 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403923AbeHASVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:21:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b61e1100003>; Wed, 01 Aug 2018 09:34:24 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Aug 2018 09:34:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Aug 2018 09:34:29 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Aug
 2018 16:34:28 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Aug
 2018 16:34:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 1 Aug 2018 16:34:28 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b61e1120003>; Wed, 01 Aug 2018 09:34:28 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "Stefan Agner" <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 35/40] arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
Date:   Wed, 1 Aug 2018 19:32:25 +0300
Message-ID: <1533141150-10511-36-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the calibration offset properties used for automatic pad drive
strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7669756..b7020dd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -240,6 +240,12 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-up-offset-sdr104 = <0x03>;
+		nvidia,pad-autocal-pull-down-offset-sdr104 = <0x05>;
 		status = "disabled";
 	};
 
@@ -254,6 +260,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc2_3v3>;
 		pinctrl-1 = <&sdmmc2_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		status = "disabled";
 	};
 
@@ -268,6 +278,12 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		status = "disabled";
 	};
 
@@ -279,6 +295,10 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
 		reset-names = "sdhci";
+		nvidia,pad-autocal-pull-up-offset-hs400 = <0x05>;
+		nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
 		status = "disabled";
 	};
 
-- 
2.7.4

