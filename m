Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AE9C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BDC206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BDC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeLDQaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:30:11 -0500
Received: from 8bytes.org ([81.169.241.247]:51522 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbeLDQaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:30:09 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 64915490; Tue,  4 Dec 2018 17:30:05 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 9/9] iommu/tegra: Use helper functions to access dev->iommu_fwspec
Date:   Tue,  4 Dec 2018 17:30:02 +0100
Message-Id: <20181204163002.15800-10-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0d03341317c4..0d026cb2dfff 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -846,7 +846,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 
 static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev->archdata.iommu;
 	struct iommu_group *group;
 
-- 
2.17.1

