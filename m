Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B200120836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lwCP9Lrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBUKTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:19:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17440 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfBUKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b230000>; Thu, 21 Feb 2019 02:19:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:19:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Feb 2019 02:19:08 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:19:08 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b1a0001>; Thu, 21 Feb 2019 02:19:08 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 06/12] arm64: dts: tegra210: set gpu hw throttle level
Date:   Thu, 21 Feb 2019 18:18:41 +0800
Message-ID: <1550744327-4677-7-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744355; bh=paMBpPfGmlqJ4co8bjcLGkF8Q1lwhsyfMRfIQBB0AUA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lwCP9LrsIBw9HsleOUgBPbLxy2BH03T6VBs2kviKR4QtpyFkBcWpXvipaGmaefsCH
         +RngAfti10RlJL18lF6ICu2ei3Gokf2m+aRXibW/ALSW0TWgimNL44sJmYiQVWbh+6
         9h6Qk3XO1QJYjli0pJueikPnV8QPtZIv2BRYHIyD2mKHLjZpuTxLNOvxmMBQZq/g0l
         aNMQlP5rcWU0MCe4MXtVQ36hyK6YFaiLZdMFB5Bg36ioHNhgLjFoZwng0TnbCaH1SY
         J85kbBE8WWm+04uMVML5JYhVh1MIzYB2k+AO3/TYfVGbvhUVVZuQgUt4YJ2bdhENtH
         mD3rL+FSvh6VQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set gpu hw throttle level to TEGRA_SOCTHERM_THROT_LEVEL_HIGH

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 582d56820bbb..551600513c1a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1417,6 +1417,8 @@
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
+				nvidia,gpu-throt-level =
+					<TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
 
 				#cooling-cells = <2>;
 			};
-- 
2.7.4

