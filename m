Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB86420834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB86420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeH3TLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:11:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11650 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeH3TLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:11:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b88086f0000>; Thu, 30 Aug 2018 08:08:32 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:08:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:08:35 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:08:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:08:35 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b8808700003>; Thu, 30 Aug 2018 08:08:34 -0700
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
Subject: [PATCH v3 35/38] arm64: dts: tegra210: Add SDHCI tap and trim values
Date:   Thu, 30 Aug 2018 18:06:36 +0300
Message-ID: <20180830150639.21048-36-avienamo@nvidia.com>
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
Tegra210.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2a80f2bd80e5..0951acc69cc8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1055,6 +1055,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
+		nvidia,default-tap = <0x2>;
+		nvidia,default-trim = <0x4>;
 		status = "disabled";
 	};
 
@@ -1068,6 +1070,8 @@
 		reset-names = "sdhci";
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
+		nvidia,default-tap = <0x8>;
+		nvidia,default-trim = <0x0>;
 		status = "disabled";
 	};
 
@@ -1086,6 +1090,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
+		nvidia,default-tap = <0x3>;
+		nvidia,default-trim = <0x3>;
 		status = "disabled";
 	};
 
@@ -1099,6 +1105,8 @@
 		reset-names = "sdhci";
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
+		nvidia,default-tap = <0x8>;
+		nvidia,default-trim = <0x0>;
 		status = "disabled";
 	};
 
-- 
2.18.0

