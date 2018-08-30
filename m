Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8740820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8740820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeH3TLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:11:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13594 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeH3TLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:11:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b88086e0000>; Thu, 30 Aug 2018 08:08:30 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:08:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:08:32 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:08:32 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:08:32 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b88086d0000>; Thu, 30 Aug 2018 08:08:31 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 34/38] arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
Date:   Thu, 30 Aug 2018 18:06:35 +0300
Message-ID: <20180830150639.21048-35-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the calibration offset properties used for automatic pad drive
strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index bc1918e07cc3..2a80f2bd80e5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1051,6 +1051,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
+		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		status = "disabled";
 	};
 
@@ -1062,6 +1066,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
@@ -1076,6 +1082,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
+		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		status = "disabled";
 	};
 
@@ -1087,6 +1097,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
-- 
2.18.0

