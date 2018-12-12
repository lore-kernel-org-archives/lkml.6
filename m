Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D99C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5652080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct2xjrPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5652080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeLLUyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:54:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33443 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:54:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so9461583pfb.0;
        Wed, 12 Dec 2018 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raT/d3auLRA3RnbndJJvxSiFBwRphLCGTrXGl41n2+E=;
        b=ct2xjrPcfnS8VQk3RRjKZo6YpeDN3j1JiOYElv2evs1CFs+JhLPC/xs+2V3n2+OFZm
         IG51/vLkROp8pNln9591bJJhhULKIGuQMa48e3+mvRybxzZzIrVrx7ZAvkKG/7sUZF4j
         uwKIjocs54yQhhkqWQsjQdRhtQwG+fn4pkE2hvfVBXk8CpTSjzzxV9HZzurEH6VnnSUk
         hZdDqteEY8KC/rLOqGDIJSz3NVAohqRbxTm4fIsFMb0Gutg1Ce4wSGIOoYv7n1HeNNNq
         xGk5VlHw6XEcr4aWkoPXsr2JPHvmOheYHJBhCkLtRozkidAMW4hZbCVqrGqVikQMnwXS
         DqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raT/d3auLRA3RnbndJJvxSiFBwRphLCGTrXGl41n2+E=;
        b=EwORhatMqGQkeqNjn0s2cNUwx/Fjl4JwAbJg494vQNVCbosckszqZZ630ACByuvENk
         eUAAFE9xQCbiPpgvluOXNonagN1Y5cf1euSq/qt7RT+KprZSk2S+OKdt0u13a9ZrMwV3
         okNTjQn5m877qlJiZoYoKzI7dm1z16tNZK4qgRweYOSiE8Oh2A0MH+0K9re8v/43tvoS
         e7xDFHUPjQgSaG0bKmWQp74SNR5qB1KnziqU/IqckT6Lq0QMdvu6lua3RvoKEXQisQe4
         2BqzfQB4EvdJEq959Wxx8mYguk2Lqr1YtGQqIInC71ZASTCjLueeWnYjh7gcjazga8GS
         X1mA==
X-Gm-Message-State: AA+aEWbePIgV2Vw1hxn1tfd5cHm6H1U4EnwCQyPvG3D5+GxwgtO3TTFK
        zHKTtch9oh54gAUsMxxzcIE=
X-Google-Smtp-Source: AFSGD/UfD4TBx6S1x8Xl/GBicld3Woq3GPk2MgxWEJtbQr7RfVIR6xWHMfIUwjq6WPQOax1n+2V6tQ==
X-Received: by 2002:a62:2c4d:: with SMTP id s74mr21331450pfs.6.1544648069872;
        Wed, 12 Dec 2018 12:54:29 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:54:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 24/24] iommu/tegra: gart: Perform code refactoring
Date:   Wed, 12 Dec 2018 23:39:07 +0300
Message-Id: <20181212203907.23461-25-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed redundant safety-checks in the code and some debug code that
isn't actually very useful for debugging, like enormous pagetable dump
on each fault. The majority of the changes are code reshuffling,
variables/whitespaces clean up and removal of debug messages that
duplicate messages of the IOMMU-core. Now the GART translation is kept
disabled while GART is suspended.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 253 +++++++++++++++----------------------
 1 file changed, 105 insertions(+), 148 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ad348c61d5e7..4d8057916552 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -1,5 +1,5 @@
 /*
- * IOMMU API for GART in Tegra20
+ * IOMMU API for Graphics Address Relocation Table on Tegra20
  *
  * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
  *
@@ -31,70 +31,63 @@
 
 #include <soc/tegra/mc.h>
 
-/* bitmap of the page sizes currently supported */
-#define GART_IOMMU_PGSIZES	(SZ_4K)
-
 #define GART_REG_BASE		0x24
 #define GART_CONFIG		(0x24 - GART_REG_BASE)
 #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
 #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
-#define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
+
+#define GART_ENTRY_PHYS_ADDR_VALID	BIT(31)
 
 #define GART_PAGE_SHIFT		12
 #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
-#define GART_PAGE_MASK						\
-	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
+#define GART_PAGE_MASK		GENMASK(30, GART_PAGE_SHIFT)
+
+/* bitmap of the page sizes currently supported */
+#define GART_IOMMU_PGSIZES	(GART_PAGE_SIZE)
 
 struct gart_device {
 	void __iomem		*regs;
 	u32			*savedata;
-	u32			page_count;	/* total remappable size */
-	dma_addr_t		iovmm_base;	/* offset to vmm_area */
+	unsigned long		iovmm_base;	/* offset to vmm_area start */
+	unsigned long		iovmm_end;	/* offset to vmm_area end */
 	spinlock_t		pte_lock;	/* for pagetable */
 	spinlock_t		dom_lock;	/* for active domain */
 	unsigned int		active_devices;	/* number of active devices */
 	struct iommu_domain	*active_domain;	/* current active domain */
-	struct device		*dev;
-
 	struct iommu_device	iommu;		/* IOMMU Core handle */
+	struct device		*dev;
 };
 
 static struct gart_device *gart_handle; /* unique for a system */
 
 static bool gart_debug;
 
-#define GART_PTE(_pfn)						\
-	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
-
 /*
  * Any interaction between any block on PPSB and a block on APB or AHB
  * must have these read-back to ensure the APB/AHB bus transaction is
  * complete before initiating activity on the PPSB block.
  */
-#define FLUSH_GART_REGS(gart)	((void)readl((gart)->regs + GART_CONFIG))
+#define FLUSH_GART_REGS(gart)	readl_relaxed((gart)->regs + GART_CONFIG)
 
 #define for_each_gart_pte(gart, iova)					\
 	for (iova = gart->iovmm_base;					\
-	     iova < gart->iovmm_base + GART_PAGE_SIZE * gart->page_count; \
+	     iova < gart->iovmm_end;					\
 	     iova += GART_PAGE_SIZE)
 
 static inline void gart_set_pte(struct gart_device *gart,
-				unsigned long offs, u32 pte)
+				unsigned long iova, unsigned long pte)
 {
-	writel(offs, gart->regs + GART_ENTRY_ADDR);
-	writel(pte, gart->regs + GART_ENTRY_DATA);
-
-	dev_dbg(gart->dev, "%s %08lx:%08x\n",
-		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
+	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
+	writel_relaxed(pte, gart->regs + GART_ENTRY_DATA);
 }
 
 static inline unsigned long gart_read_pte(struct gart_device *gart,
-					  unsigned long offs)
+					  unsigned long iova)
 {
 	unsigned long pte;
 
-	writel(offs, gart->regs + GART_ENTRY_ADDR);
-	pte = readl(gart->regs + GART_ENTRY_DATA);
+	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
+	pte = readl_relaxed(gart->regs + GART_ENTRY_DATA);
 
 	return pte;
 }
@@ -106,49 +99,20 @@ static void do_gart_setup(struct gart_device *gart, const u32 *data)
 	for_each_gart_pte(gart, iova)
 		gart_set_pte(gart, iova, data ? *(data++) : 0);
 
-	writel(1, gart->regs + GART_CONFIG);
+	writel_relaxed(1, gart->regs + GART_CONFIG);
 	FLUSH_GART_REGS(gart);
 }
 
-#ifdef DEBUG
-static void gart_dump_table(struct gart_device *gart)
-{
-	unsigned long iova;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gart->pte_lock, flags);
-	for_each_gart_pte(gart, iova) {
-		unsigned long pte;
-
-		pte = gart_read_pte(gart, iova);
-
-		dev_dbg(gart->dev, "%s %08lx:%08lx\n",
-			(GART_ENTRY_PHYS_ADDR_VALID & pte) ? "v" : " ",
-			iova, pte & GART_PAGE_MASK);
-	}
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
-}
-#else
-static inline void gart_dump_table(struct gart_device *gart)
+static inline bool gart_iova_range_invalid(struct gart_device *gart,
+					   unsigned long iova, size_t bytes)
 {
+	return unlikely(iova < gart->iovmm_base || bytes != GART_PAGE_SIZE ||
+			iova + bytes > gart->iovmm_end);
 }
-#endif
 
-static inline bool gart_iova_range_valid(struct gart_device *gart,
-					 unsigned long iova, size_t bytes)
+static inline bool gart_pte_valid(struct gart_device *gart, unsigned long iova)
 {
-	unsigned long iova_start, iova_end, gart_start, gart_end;
-
-	iova_start = iova;
-	iova_end = iova_start + bytes - 1;
-	gart_start = gart->iovmm_base;
-	gart_end = gart_start + gart->page_count * GART_PAGE_SIZE - 1;
-
-	if (iova_start < gart_start)
-		return false;
-	if (iova_end > gart_end)
-		return false;
-	return true;
+	return !!(gart_read_pte(gart, iova) & GART_ENTRY_PHYS_ADDR_VALID);
 }
 
 static int gart_iommu_attach_dev(struct iommu_domain *domain,
@@ -191,7 +155,6 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
-	struct gart_device *gart = gart_handle;
 	struct iommu_domain *domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
@@ -199,9 +162,8 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (domain) {
-		domain->geometry.aperture_start = gart->iovmm_base;
-		domain->geometry.aperture_end = gart->iovmm_base +
-					gart->page_count * GART_PAGE_SIZE - 1;
+		domain->geometry.aperture_start = gart_handle->iovmm_base;
+		domain->geometry.aperture_end = gart_handle->iovmm_end - 1;
 		domain->geometry.force_aperture = true;
 	}
 
@@ -214,34 +176,45 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	kfree(domain);
 }
 
+static inline int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
+				   unsigned long pa)
+{
+	if (unlikely(gart_debug && gart_pte_valid(gart, iova))) {
+		dev_err(gart->dev, "Page entry is in-use\n");
+		return -EINVAL;
+	}
+
+	gart_set_pte(gart, iova, GART_ENTRY_PHYS_ADDR_VALID | pa);
+
+	return 0;
+}
+
 static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t pa, size_t bytes, int prot)
 {
 	struct gart_device *gart = gart_handle;
-	unsigned long flags;
-	unsigned long pfn;
-	unsigned long pte;
+	int ret;
 
-	if (!gart_iova_range_valid(gart, iova, bytes))
+	if (gart_iova_range_invalid(gart, iova, bytes))
 		return -EINVAL;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
-	pfn = __phys_to_pfn(pa);
-	if (!pfn_valid(pfn)) {
-		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
-		spin_unlock_irqrestore(&gart->pte_lock, flags);
+	spin_lock(&gart->pte_lock);
+	ret = __gart_iommu_map(gart, iova, (unsigned long)pa);
+	spin_unlock(&gart->pte_lock);
+
+	return ret;
+}
+
+static inline int __gart_iommu_unmap(struct gart_device *gart,
+				     unsigned long iova)
+{
+	if (unlikely(gart_debug && !gart_pte_valid(gart, iova))) {
+		dev_err(gart->dev, "Page entry is invalid\n");
 		return -EINVAL;
 	}
-	if (gart_debug) {
-		pte = gart_read_pte(gart, iova);
-		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
-			spin_unlock_irqrestore(&gart->pte_lock, flags);
-			dev_err(gart->dev, "Page entry is in-use\n");
-			return -EBUSY;
-		}
-	}
-	gart_set_pte(gart, iova, GART_PTE(pfn));
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
+
+	gart_set_pte(gart, iova, 0);
+
 	return 0;
 }
 
@@ -249,15 +222,16 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t bytes)
 {
 	struct gart_device *gart = gart_handle;
-	unsigned long flags;
+	int err;
 
-	if (!gart_iova_range_valid(gart, iova, bytes))
+	if (gart_iova_range_invalid(gart, iova, bytes))
 		return 0;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
-	gart_set_pte(gart, iova, 0);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
-	return bytes;
+	spin_lock(&gart->pte_lock);
+	err = __gart_iommu_unmap(gart, iova);
+	spin_unlock(&gart->pte_lock);
+
+	return err ? 0 : bytes;
 }
 
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -265,24 +239,15 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 {
 	struct gart_device *gart = gart_handle;
 	unsigned long pte;
-	phys_addr_t pa;
-	unsigned long flags;
 
-	if (!gart_iova_range_valid(gart, iova, 0))
+	if (gart_iova_range_invalid(gart, iova, GART_PAGE_SIZE))
 		return -EINVAL;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
+	spin_lock(&gart->pte_lock);
 	pte = gart_read_pte(gart, iova);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
+	spin_unlock(&gart->pte_lock);
 
-	pa = (pte & GART_PAGE_MASK);
-	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "No entry for %08llx:%pa\n",
-			 (unsigned long long)iova, &pa);
-		gart_dump_table(gart);
-		return -EINVAL;
-	}
-	return pa;
+	return pte & GART_PAGE_MASK;
 }
 
 static bool gart_iommu_capable(enum iommu_cap cap)
@@ -322,9 +287,7 @@ static int gart_iommu_of_xlate(struct device *dev,
 
 static void gart_iommu_sync(struct iommu_domain *domain)
 {
-	struct gart_device *gart = gart_handle;
-
-	FLUSH_GART_REGS(gart);
+	FLUSH_GART_REGS(gart_handle);
 }
 
 static const struct iommu_ops gart_iommu_ops = {
@@ -347,84 +310,78 @@ static const struct iommu_ops gart_iommu_ops = {
 
 int tegra_gart_suspend(struct gart_device *gart)
 {
-	unsigned long iova;
 	u32 *data = gart->savedata;
-	unsigned long flags;
+	unsigned long iova;
+
+	/*
+	 * All GART users shall be suspended at this point. Disable
+	 * address translation to trap all GART accesses as invalid
+	 * memory accesses.
+	 */
+	writel_relaxed(0, gart->regs + GART_CONFIG);
+	FLUSH_GART_REGS(gart);
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
 	for_each_gart_pte(gart, iova)
 		*(data++) = gart_read_pte(gart, iova);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
+
 	return 0;
 }
 
 int tegra_gart_resume(struct gart_device *gart)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&gart->pte_lock, flags);
 	do_gart_setup(gart, gart->savedata);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
+
 	return 0;
 }
 
 struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 {
 	struct gart_device *gart;
-	struct resource *res_remap;
-	void __iomem *gart_regs;
-	int ret;
+	struct resource *res;
+	int err;
 
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
 	/* the GART memory aperture is required */
-	res_remap = platform_get_resource(to_platform_device(dev),
-					  IORESOURCE_MEM, 1);
-	if (!res_remap) {
-		dev_err(dev, "GART memory aperture expected\n");
+	res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "Memory aperture resource unavailable\n");
 		return ERR_PTR(-ENXIO);
 	}
 
 	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
-	if (!gart) {
-		dev_err(dev, "failed to allocate gart_device\n");
+	if (!gart)
 		return ERR_PTR(-ENOMEM);
-	}
 
-	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
-	if (ret) {
-		dev_err(dev, "Failed to register IOMMU in sysfs\n");
+	gart_handle = gart;
+
+	gart->dev = dev;
+	gart->regs = mc->regs + GART_REG_BASE;
+	gart->iovmm_base = res->start;
+	gart->iovmm_end = res->end + 1;
+	spin_lock_init(&gart->pte_lock);
+	spin_lock_init(&gart->dom_lock);
+
+	do_gart_setup(gart, NULL);
+
+	err = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
+	if (err)
 		goto free_gart;
-	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
 	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
-	ret = iommu_device_register(&gart->iommu);
-	if (ret) {
-		dev_err(dev, "Failed to register IOMMU\n");
+	err = iommu_device_register(&gart->iommu);
+	if (err)
 		goto remove_sysfs;
-	}
 
-	gart->dev = dev;
-	gart_regs = mc->regs + GART_REG_BASE;
-	spin_lock_init(&gart->pte_lock);
-	spin_lock_init(&gart->dom_lock);
-	gart->regs = gart_regs;
-	gart->iovmm_base = (dma_addr_t)res_remap->start;
-	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
-
-	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
+	gart->savedata = vmalloc(resource_size(res) / GART_PAGE_SIZE *
+				 sizeof(u32));
 	if (!gart->savedata) {
-		dev_err(dev, "failed to allocate context save area\n");
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto unregister_iommu;
 	}
 
-	do_gart_setup(gart, NULL);
-
-	gart_handle = gart;
-
 	return gart;
 
 unregister_iommu:
@@ -434,7 +391,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 free_gart:
 	kfree(gart);
 
-	return ERR_PTR(ret);
+	return ERR_PTR(err);
 }
 
 module_param(gart_debug, bool, 0644);
-- 
2.20.0

