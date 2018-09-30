Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF2C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D52089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXWzuHq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3D52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeJAFYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45005 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJAFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:24:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so1803545lfl.11;
        Sun, 30 Sep 2018 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPWBiM2j3TnRVHvKthyY+EnE0spKkoguthVCpf1cp7o=;
        b=WXWzuHq2MnS73OD+Hfq0h764gcenDfJ9h+OAGB3uS+zrNIe8tj+ElK1ww4JPepT2Kv
         P425115E2EecZpvJ6czHgTMwiqkvNIZiGu0MJ9ZQPUMWh8i1YYHYz0Rpze1CjoJQBilS
         gRmK1VfUba+wv21ExkzvQPirQbuk8ET6VWacvP34z1g4tpXwgWjforGjSPi0ZJfBqYm5
         mPh6KbQ6Y2fXmYXALgEWX9WdvcPfXN3P2KL8wtsdRdM01bPS9V1BwU2Oc34QeqVfUX0s
         tq/withHr2kM0b1T03OKbLbHio5IQni5YoqH7teBIINIWA/6gKrBdG6nCNBiS2Ca/XxS
         K3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPWBiM2j3TnRVHvKthyY+EnE0spKkoguthVCpf1cp7o=;
        b=G2x9sh0DySdCThkcZfDoZBAGp7BWCtJHr59dqTjXHN3JrXVtfSclIad18BYKoh0cPA
         srRVJpZV+hQ7w+Ad+PQXKsC46HsGVL2X1sziMBuD02yyBAEG7MCENTnQG/gYkS0MFJ0W
         soAhiOTYCIFIEit69+zmySkhKOiMYnF9qcRaW1YbasqSMl1owv4hS8BG5DUm8dLnE3CV
         /4Oxdzl7K6zFXItdE+zC0xsNH/FyNX+Dmo7T8pa2BzMC+mGvzCSLAWS3WBkmn2dvJgM7
         ERaLiMOB8svZVUWMfLOkznfKrOq1zPUgcAThIGBITaDFRGGrkByNw3xwmtQai1F02fhs
         kITQ==
X-Gm-Message-State: ABuFfoieLM+40ddDoJZnohthWjM7SVWokUqZN9tkLXi+IuuBitsOIm5n
        6x3V9a2DLYdBT744lgnfpdA=
X-Google-Smtp-Source: ACcGV60ouH2Ak3YGG+voCbDdxXbRR/uXeDagFIF8EednKXpSZBooOauKt+8qOgNRE6+bimOaDk738g==
X-Received: by 2002:a19:7510:: with SMTP id y16-v6mr3862177lfe.100.1538347754654;
        Sun, 30 Sep 2018 15:49:14 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/21] iommu/tegra: gart: Perform code refactoring
Date:   Mon,  1 Oct 2018 01:48:33 +0300
Message-Id: <20180930224833.28809-22-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
duplicate messages of the IOMMU-core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 246 +++++++++++++++----------------------
 1 file changed, 97 insertions(+), 149 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f7358b5547dc..97b1917d9511 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -1,5 +1,5 @@
 /*
- * IOMMU API for GART in Tegra20
+ * IOMMU API for Graphics Address Relocation Table on Tegra20
  *
  * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
  *
@@ -29,70 +29,63 @@
 
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
@@ -104,49 +97,20 @@ static void do_gart_setup(struct gart_device *gart, const u32 *data)
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
@@ -189,7 +153,6 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
-	struct gart_device *gart = gart_handle;
 	struct iommu_domain *domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
@@ -197,9 +160,8 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (domain) {
-		domain->geometry.aperture_start = gart->iovmm_base;
-		domain->geometry.aperture_end = gart->iovmm_base +
-					gart->page_count * GART_PAGE_SIZE - 1;
+		domain->geometry.aperture_start = gart_handle->iovmm_base;
+		domain->geometry.aperture_end = gart_handle->iovmm_end - 1;
 		domain->geometry.force_aperture = true;
 	}
 
@@ -212,34 +174,44 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	kfree(domain);
 }
 
+static int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
+			    unsigned long pa)
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
+	ret = __gart_iommu_map(gart, iova, (unsigned long) pa);
+	spin_unlock(&gart->pte_lock);
+
+	return ret;
+}
+
+static int __gart_iommu_unmap(struct gart_device *gart, unsigned long iova)
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
 
@@ -247,15 +219,16 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
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
@@ -263,24 +236,15 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
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
@@ -320,9 +284,7 @@ static int gart_iommu_of_xlate(struct device *dev,
 
 static void gart_iommu_sync(struct iommu_domain *domain)
 {
-	struct gart_device *gart = gart_handle;
-
-	FLUSH_GART_REGS(gart);
+	FLUSH_GART_REGS(gart_handle);
 }
 
 static const struct iommu_ops gart_iommu_ops = {
@@ -345,24 +307,19 @@ static const struct iommu_ops gart_iommu_ops = {
 
 int tegra_gart_suspend(struct gart_device *gart)
 {
-	unsigned long iova;
 	u32 *data = gart->savedata;
-	unsigned long flags;
+	unsigned long iova;
 
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
 
@@ -371,9 +328,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 				     struct tegra_mc *mc)
 {
 	struct gart_device *gart;
-	struct resource *res_remap;
-	void __iomem *gart_regs;
-	int ret;
+	struct resource *res;
+	int err;
 
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
@@ -382,53 +338,45 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return NULL;
 
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
@@ -438,12 +386,12 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 free_gart:
 	kfree(gart);
 
-	return ERR_PTR(ret);
+	return ERR_PTR(err);
 }
 
 module_param(gart_debug, bool, 0644);
 
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
-MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
+MODULE_DESCRIPTION("IOMMU API for GART on Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.19.0

