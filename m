Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79C1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C75821855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SbIktZBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfAWTbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:31:03 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10210 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfAWTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:30:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c48c0cf0000>; Wed, 23 Jan 2019 11:30:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 23 Jan 2019 11:30:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 23 Jan 2019 11:30:58 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 23 Jan
 2019 19:30:58 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Jan 2019 19:30:58 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c48c0f10005>; Wed, 23 Jan 2019 11:30:57 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V11 2/4] arm64: dts: tegra: Add CQE Support for SDMMC4
Date:   Wed, 23 Jan 2019 11:30:52 -0800
Message-ID: <1548271854-1765-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548271823; bh=qZlWGPm579EQ3OA/p188DFyyZ8pZYEv2hR+F4owY7Zk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SbIktZBt3UjqppFtuDBmAshrECRAr3HNavVsKEHTHJjghleTi3bYrAh2VGm2SJVP+
         pnh7VFmSa+ncOHPrfN9IqRgQryN8HWlFZFZGTVLm4pEq/K8Gmi7W/zp02DbfoveJv5
         y8xGbQKteDHLnU+Ee2Ly3k24VNGPf8w0KL76h3wbBurGYOhnobznLv5WARQmbWZ4Hr
         UhlNQdTcnsT01WTuZibYMc0nop7tU8v9gQm3cyA2b1L1g27Ktcpg03IqquBewRGGtN
         66UWP9JfGSFTmRpRilcMsRIlBhy8gsv0k/K1Vx2jK7UGkaDu0ff8258W1q+Ld61M03
         qTf7vA17Hosjw==
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

