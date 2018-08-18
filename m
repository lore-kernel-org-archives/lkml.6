Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D758FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A89215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLCieMg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A89215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeHRTFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:05:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38724 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeHRTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so6112113edr.5;
        Sat, 18 Aug 2018 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xr0PWg85YE0T+Ax2Rf8OzonZmno3FCtecBrtNlrITHQ=;
        b=bLCieMg9UTOgyYx1lWeiLDWCtNoiNMFINZSXiB3EE64Zj+1TrrhKeEK8BTNuO/w2rk
         9kW8gElrRbkjZiayl4nIwKVCoJhA9rvgDAm9IBT4A60OnU/L0XBn8B9211tOr/7KNlRo
         07E++iQx3Vo09f0TSEKMK4ErgKOXyuYvEhHbcnSdgJAU0rJwjCSEW25O9/sLGLa9fE8A
         daKfzwwEBB/1HtJc56sd47Oc9K8AqCUlhdeCdplwGy4P1g668+ZxZoYUEogUVaoXEnjA
         unbD2BQLfxbSIsjzjLSzoPkVTCAEEfWZx3TIWXC952vRqOlVkvqSWKxgjVF2Iarx5uBz
         vRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xr0PWg85YE0T+Ax2Rf8OzonZmno3FCtecBrtNlrITHQ=;
        b=N/6SWCyN1yE2inFF9bF390WF0me2Wwsvdsy28JP/MtCERUSVa+YhhLB9Wavh/y2TaP
         CEqlJBGpBa3d/tUqQ2f3yP2wH/IzGIUXC3qJQYw+hwnAC6+06zdZPwpvC4Hht57+tbcm
         9eF3utxu1fq6hZItuW3ulLrQgc2OYXNJdTmcPO71iyR+SBoAqQgF94vP314Di4vJ8Gn1
         ELpiC5UH7pEro+npbjkMC0RPRB0/LFeJ4fN4qPMCtaR6DeErqRll0cxAYU6nDScw13sp
         mNsi0SWTAoXefhKSBO7pNhRaW6gBBwplmEY5K83NUYPOTB7VdGNtXIawZMycvXskZG80
         sc9Q==
X-Gm-Message-State: AOUpUlE3vXZwTttgh+Wkkl3K6c1Ncf60fHeqUNHcckFpqaQT5AYeeo3W
        ieMB04Owwd7OBM74i6MYGso=
X-Google-Smtp-Source: AA+uWPy0hhG/2+tN5XULNulmZClkbdyCZBwpRVmzljiruaO+IQ4CwNxYPEzNH+HM+wHvCJucetcg+w==
X-Received: by 2002:a50:925c:: with SMTP id j28-v6mr48739296eda.209.1534607741597;
        Sat, 18 Aug 2018 08:55:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/19] iommu: Introduce iotlb_sync_map callback
Date:   Sat, 18 Aug 2018 18:54:15 +0300
Message-Id: <20180818155430.5586-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce iotlb_sync_map() callback that is invoked in the end of
iommu_map(). This new callback allows IOMMU drivers to avoid syncing
after mapping of each contiguous chunk and sync only when the whole
mapping is completed, optimizing performance of the mapping operation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 8 ++++++--
 include/linux/iommu.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..8979b16caf61 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1545,13 +1545,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
+	const struct iommu_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 	size_t orig_size = size;
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(domain->ops->map == NULL ||
+	if (unlikely(ops->map == NULL ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
@@ -1580,7 +1581,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
 			break;
 
@@ -1589,6 +1590,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..4c488eb69752 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -202,6 +202,7 @@ struct iommu_ops {
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
-- 
2.18.0

