Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDCC2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fHfeT8iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBTPNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:13:50 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12835 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:13:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6d6eb20001>; Wed, 20 Feb 2019 07:13:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 07:13:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 07:13:48 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 15:13:48 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 15:13:47 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6d6ea90000>; Wed, 20 Feb 2019 07:13:47 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/3] arm64: tegra: custom name for hda sound card
Date:   Wed, 20 Feb 2019 20:43:23 +0530
Message-ID: <1550675604-14788-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550675604-14788-1-git-send-email-spujar@nvidia.com>
References: <1550675604-14788-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550675634; bh=B918ynsUcuKsCMWFHNIY+6tEenXQtY9gfHpVcabv3DU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=fHfeT8iPo0hHEK9gwfzTwk/FurtS4/pSVTW/+SpwBsYgddmsKlYcxtG5RwelOtHkp
         DNL0yuDUKVCEqjSft6F76aHoeamk668j6GFE0JC3WxEpzb4o3EGT+t59cFz1qoUx7T
         pJtsl/gmIcSEmdip25/HkHKOC12lexyzHrL89FdI7XZsnfpyV1sFzquCjuTyewDYUI
         AadEGyVDfkqNhHW6WEVmG3qqDs+GuzdFsXzUl/HR1SCiF/oqXb7Er8dlMwP4NM+AaZ
         iI5wbd5D8OlqgLG4zzUg2/i4gFZ9crNVJHr3sRVV1EF3C5xVVa28hqXUJLHyaM3grN
         Oemv48bpUpPtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"nvidia,model" property is added to pass custom name for hda sound card.
This is parsed in hda driver and used for card name. This aligns with the
way with which sound cards are named in general.

This patch populates above for jetson-tx1, jetson-tx2 and jetson-xavier.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 1 +
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 1 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 0f3c6ce..31457f3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -54,6 +54,7 @@
 	};
 
 	hda@3510000 {
+		nvidia,model = "jetson-tx2-hda";
 		status = "okay";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 34a7044..b62e969 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -21,6 +21,7 @@
 		};
 
 		hda@3510000 {
+			nvidia,model = "jetson-xavier-hda";
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 8780b5b..95e890d8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1323,6 +1323,7 @@
 	};
 
 	hda@70030000 {
+		nvidia,model = "jetson-tx1-hda";
 		status = "okay";
 	};
 
-- 
2.7.4

