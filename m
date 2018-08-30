Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFAFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A046A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A046A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeH3TLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:11:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2785 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbeH3TLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:11:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b8808760000>; Thu, 30 Aug 2018 08:08:38 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:08:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:08:38 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:08:38 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:08:38 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b8808730000>; Thu, 30 Aug 2018 08:08:38 -0700
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
Subject: [PATCH v3 36/38] arm64: dts: tegra186: Add SDHCI tap and trim values
Date:   Thu, 30 Aug 2018 18:06:37 +0300
Message-ID: <20180830150639.21048-37-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDHCI inbound and outbound SDHCI sampling trimmer values for
Tegra186.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b7020dd2be44..3b2fe0d99aaf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -246,6 +246,8 @@
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		nvidia,pad-autocal-pull-up-offset-sdr104 = <0x03>;
 		nvidia,pad-autocal-pull-down-offset-sdr104 = <0x05>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0xb>;
 		status = "disabled";
 	};
 
@@ -264,6 +266,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0xb>;
 		status = "disabled";
 	};
 
@@ -284,6 +288,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0xb>;
 		status = "disabled";
 	};
 
@@ -299,6 +305,8 @@
 		nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0x9>;
 		status = "disabled";
 	};
 
-- 
2.18.0

