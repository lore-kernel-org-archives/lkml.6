Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeCVKSr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:18:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59957 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752642AbeCVKSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:18:43 -0400
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC: Shaokun Zhang <zhangshaokun@hisilicon.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/vt-d, trivial: Remove unused variable
Date: Thu, 22 Mar 2018 18:18:06 +0800
Message-ID: <1521713886-87177-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused after commit <42e8c186b595> ("iommu/vt-d: Simplify io/tlb flushing
in intel_iommu_unmap"), cleanup it.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/iommu/intel-iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01..d49e0d3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5072,7 +5072,6 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct page *freelist = NULL;
-	struct intel_iommu *iommu;
 	unsigned long start_pfn, last_pfn;
 	unsigned int npages;
 	int iommu_id, level = 0;
@@ -5091,12 +5090,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
 	npages = last_pfn - start_pfn + 1;
 
-	for_each_domain_iommu(iommu_id, dmar_domain) {
-		iommu = g_iommus[iommu_id];
-
+	for_each_domain_iommu(iommu_id, dmar_domain)
 		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
 				      start_pfn, npages, !freelist, 0);
-	}
 
 	dma_free_pagelist(freelist);
 
-- 
1.9.1
