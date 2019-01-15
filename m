Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD81120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QT+usV8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfAOTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:03:57 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12274 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfAOTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:03:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3e2e8c0000>; Tue, 15 Jan 2019 11:03:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 11:03:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 11:03:55 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 19:03:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 19:03:54 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c3e2e9a0002>; Tue, 15 Jan 2019 11:03:55 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V9 2/3] arm64: dts: tegra: Add CQE Support for SDMMC4
Date:   Tue, 15 Jan 2019 11:03:51 -0800
Message-ID: <1547579032-18314-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547579020; bh=qZlWGPm579EQ3OA/p188DFyyZ8pZYEv2hR+F4owY7Zk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QT+usV8NU6LrvhoyP1S1hFqnGe39CwftcI8Rhkuctznv3B1h8dv9SuES2RWFBifs/
         5qBRNDSFtQQvBpE3oQGq3wuMVJjkBQ+l6SgNKwh8PIghwLAR8e0zGnWuSLzvnLnQnM
         qUEdNMADuT+/FZz+GBWW+AXYKIjBq3hUd/qd3OwmfBlvX9q8tjqp9662Q+D3FiLrml
         NH+F0EtJiDSaj4ht2+xUy81OEtPqOGK2Zoahg0VNuvOt3Qf+YpzK0D7780sUDr/TVb
         y2iZmxJWx6rUXfbqygU4Sm4sIaYdWSB3562YzP3kHjeXyUdY/GW52YDTB9bvXwl4kc
         aXHQuS4phTP0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CQE Support for Tegra186 and Tegra194 SDMMC4 controller

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 22815db4a3ed..3dfdc4701934 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -319,6 +319,7 @@
 		nvidia,default-trim = <0x9>;
 		nvidia,dqs-trim = <63>;
 		mmc-hs400-1_8v;
+		supports-cqe;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6dfa1ca0b851..9ce1c91d4596 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -325,6 +325,7 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names = "sdhci";
+			supports-cqe;
 			status = "disabled";
 		};
 
-- 
2.7.4

