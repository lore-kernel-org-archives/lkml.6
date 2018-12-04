Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB7C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1482146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oNpzOIiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1482146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLDBhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:37:25 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17639 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeLDBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:37:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c05da3e0002>; Mon, 03 Dec 2018 17:37:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 17:37:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 17:37:03 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:37:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Dec 2018 01:37:02 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c05da3e000a>; Mon, 03 Dec 2018 17:37:02 -0800
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v3 5/6] arm64: defconfig: Enable ARM_SMMU_TEGRA
Date:   Mon, 3 Dec 2018 17:36:53 -0800
Message-ID: <1543887414-18209-6-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543887422; bh=J/o0R9zVlmi0W2ef9WvO+7XujrgcpT7YYO5K6e/OwQs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oNpzOIiNXlC/vP6Q+zw9a5AXOVhzEgvnZN7SGU5JxKzUjNzsOv4VtARnmQ/ATyUmA
         a2UKJSehGtJDoBYRwFglGLKvV8ypv1jxNL8b7di/RnrrzuR03yKo4i5ljSpEy+H3Ii
         c6ECJ43DCUAf1MA/TvFOPh3kiYap3iTIIA+6pyNWW+gaBB9Xqu/VUgxq4lB1+3y/XK
         xAEDSoLAc19GSJTx7p+uwMuvjgnOtDwIBlgZLIVib5XaoQgjkdsHHUKLbdzb0AH6VV
         Zuwro4Y6Xje8hOGhqhe9Cvqt8vd+QM9FO9vooGQ1Vv9A2+rLWjV+plOkBeSoyhOtZz
         TopWd31hLrDOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_ARM_SMMU_TEGRA that is used
by Tegra194 SOC.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5c2b1f6..e5ea13b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -625,6 +625,7 @@ CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
+CONFIG_ARM_SMMU_TEGRA=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=m
-- 
2.1.4

