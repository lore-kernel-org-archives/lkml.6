Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B50C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0162920834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0162920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeH3TLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:11:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13604 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeH3TLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:11:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b88087a0000>; Thu, 30 Aug 2018 08:08:42 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:08:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:08:44 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:08:44 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:08:44 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b8808790000>; Thu, 30 Aug 2018 08:08:44 -0700
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
Subject: [PATCH v3 38/38] arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
Date:   Thu, 30 Aug 2018 18:06:39 +0300
Message-ID: <20180830150639.21048-39-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use assigned-clock properties to configure pllc4 as the parent clock
for sdmmc4 on Tegra210. pllc4 offers better jitter perfomance than
the default pllp and is required by HS200 and HS400 modes.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 0951acc69cc8..14da98ac65e8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1057,6 +1057,11 @@
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		nvidia,default-tap = <0x2>;
 		nvidia,default-trim = <0x4>;
+		assigned-clocks = <&tegra_car TEGRA210_CLK_SDMMC4>,
+				  <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>,
+				  <&tegra_car TEGRA210_CLK_PLL_C4>;
+		assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+		assigned-clock-rates = <200000000>, <1000000000>, <1000000000>;
 		status = "disabled";
 	};
 
@@ -1107,6 +1112,9 @@
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		nvidia,default-tap = <0x8>;
 		nvidia,default-trim = <0x0>;
+		assigned-clocks = <&tegra_car TEGRA210_CLK_SDMMC4>,
+				  <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+		assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
 		status = "disabled";
 	};
 
-- 
2.18.0

