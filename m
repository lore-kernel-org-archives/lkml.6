Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACA32184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfAXHKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:10:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfAXHKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:10:42 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96945ECE9E34F177EF68;
        Thu, 24 Jan 2019 15:10:40 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 24 Jan 2019 15:10:31 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] iommu/dma: Remove unused variable
Date:   Thu, 24 Jan 2019 15:10:02 +0800
Message-ID: <1548313802-64412-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

end_pfn is never used after commit <aa3ac9469c18> ('iommu/iova: Make dma
32bit pfn implicit'), cleanup it.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/iommu/dma-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c1..77aabe637a60 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -289,7 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long order, base_pfn, end_pfn;
+	unsigned long order, base_pfn;
 	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
@@ -298,7 +298,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
-	end_pfn = (base + size - 1) >> order;
 
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
-- 
2.7.4

