Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeEDFRx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:17:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:30967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDFRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:17:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="48196457"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Clean up unused variable in find_or_alloc_domain
Date: Fri,  4 May 2018 13:08:17 +0800
Message-Id: <1525410499-18632-3-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove it to make the code more concise.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f2..9064607 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2533,7 +2533,7 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 	struct device_domain_info *info = NULL;
 	struct dmar_domain *domain = NULL;
 	struct intel_iommu *iommu;
-	u16 req_id, dma_alias;
+	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
 
@@ -2541,8 +2541,6 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 	if (!iommu)
 		return NULL;
 
-	req_id = ((u16)bus << 8) | devfn;
-
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-- 
2.7.4
