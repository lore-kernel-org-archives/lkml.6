Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6D6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FA820880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U4GdTvNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FA820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeLMVOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:14:37 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6205 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLMVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:14:36 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c12cbb80000>; Thu, 13 Dec 2018 13:14:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Dec 2018 13:14:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Dec 2018 13:14:36 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 21:14:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 21:14:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c12cbbb0001>; Thu, 13 Dec 2018 13:14:35 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mperttunen@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] arm64: tegra: SDMMC Clock change
Date:   Thu, 13 Dec 2018 13:14:30 -0800
Message-ID: <1544735670-14246-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544735672; bh=HxzANDyOzDpZT67KEeUl3Sm6g0cfmtHogLcd0z3LO88=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=U4GdTvNnv+fcDIRWG41KX9r9xSwx9GVa7nF9XrcycqwOfGNYeAU4FNF3U/Ttk8vkm
         tTIkmGRj/6Qhg65/4VZ3ad3DMj1GUYL/ZuTJL/CfFT4PrCO6PWmNpUTKJRolo9UAte
         i/6gYbV/6SSv2p1Jc5QQ3CdUajSdTrESVkCApPw2ZdaFBTZtulTFzL/ph9FvsThOeZ
         oJNbqTDyB2MYjOhmHYYzFEar8UhZxFlwCA1+3w/E6H+u4c6XmLkbmzXfqNa0i6V6re
         xiqZ2nQIr1rtsFxZ9wIE9f0omGDwH4oNuX/7G87fD4Jv29ZLLje3Ovi7F+ueDQa22+
         MvAZd2j1SqPZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDMMC Clock source change for supporting max frequency of
200Mhz for Tegra194

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c2091bb16546..e61f86366cb1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -321,6 +321,10 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_SDMMC4>;
 			clock-names = "sdhci";
+			assigned-clocks = <&bpmp TEGRA194_CLK_SDMMC4>,
+					<&bpmp TEGRA194_CLK_PLLC4>;
+			assigned-clock-parents =
+					  <&bpmp TEGRA194_CLK_PLLC4>;
 			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names = "sdhci";
 			status = "disabled";
-- 
2.7.4

