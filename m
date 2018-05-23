Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeEWGDc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:03:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753826AbeEWGDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:03:31 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] iommu/dma: fix trival coding style mistake
Date: Wed, 23 May 2018 14:02:49 +0800
Message-ID: <1527055369-13192-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/dma-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb..4e885f7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -231,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;

+	if (!dev)
+		return 0;
+
 	if (dev_is_pci(dev))
 		iova_reserve_pci_windows(to_pci_dev(dev), iovad);

@@ -246,11 +249,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
 		hi = iova_pfn(iovad, region->start + region->length - 1);
 		reserve_iova(iovad, lo, hi);

-		if (region->type == IOMMU_RESV_MSI)
+		if (region->type == IOMMU_RESV_MSI) {
 			ret = cookie_init_hw_msi_region(cookie, region->start,
 					region->start + region->length);
-		if (ret)
-			break;
+			if (ret)
+				break;
+		}
 	}
 	iommu_put_resv_regions(dev, &resv_regions);

@@ -308,8 +312,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}

 	init_iova_domain(iovad, 1UL << order, base_pfn);
-	if (!dev)
-		return 0;

 	return iova_reserve_iommu_regions(dev, domain);
 }
--
1.8.3
