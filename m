Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE4FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106652178F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4uer1i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106652178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHRTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46923 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeHRTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id o8-v6so6099463edt.13;
        Sat, 18 Aug 2018 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+cWHk0y6Zj1XeHwG0EqW/r+/kcKBaTDrZenmDA0+aSw=;
        b=j4uer1i8JSNDgdjqzp93byO5T54X8MIbPhuSk9cGl2xGwi8G3Lia0Ewb+zSPYyaXqD
         Yb1XySjnH+srKZswjgGqEAEz6aJQlcJ1WEgaNoT8YOAN7//LgAKAN5T8Eaf3ZzY7GK6d
         2LfpFHJTHipDMjTrj3mMY6irkOWZ9ZKFPnSv8OfzN3pTAlB9aAr+iLt00Vbx1Kur3unG
         p+HmXI5vQ7p1CI7rr45h2NmqLrMMZpnMJUEHcNCtrcuHprQ1VuPBLX5CdR00Kn4XZfBx
         uHxGaEAvZJ1a4pT+1rs1Af6sa9zIio+GozNRGDWigCyTiDCeawsg7dhrYDoOoxnLC5ik
         UfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cWHk0y6Zj1XeHwG0EqW/r+/kcKBaTDrZenmDA0+aSw=;
        b=hK5QGLhR29FicgZUnRYd1bKHlpg2hQBjt1LOPzRw8ESK6K8zskg5WeZSTl75NapnJx
         L6qPskzSFPalMM3ovEt8qldFzKMbVgM+tEz1b7pyYDBJf6LSa3iOi8EB4/jQq+93rAR2
         yxZXGB19Qen8JVh3FFParQKY3VwOdlYno8yqmxQNyj2Of8TwbyRI3JTUio9jWeKEhdEY
         OLMrSnyYse+NJLbcLAYHhEGUnDq0LwHZ4MDbInOqvpsiQYHod1YNek5PhuBeYlw2rhPv
         51PGPBa0KK+HTygmVo+kk3jtF/BW3k5eEZranPE+NyORKAuq/0w3pJhAl4FvfnUgksFt
         mKpg==
X-Gm-Message-State: AOUpUlGMj+8GxYIkSfTqkLNv7jIQiKbje77RMP0nQEFmOAbYSv/mFnEG
        6V9wTIGqJUMdB64Kbl0fM2M=
X-Google-Smtp-Source: AA+uWPwCVoIuuGkJHJL3kPUtVLTEo4rIIcentLnJjgi7wXMu4yWGPeuup5/SRGk8pRSYGFuKRoFUpA==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr45540864edc.229.1534607760597;
        Sat, 18 Aug 2018 08:56:00 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:56:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/19] iommu/tegra: gart: Perform code refactoring
Date:   Sat, 18 Aug 2018 18:54:30 +0300
Message-Id: <20180818155430.5586-20-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perform a major code cleanup to make it more readable and as a result
easier to maintain. I've removed some redundant safety-checks in the code
and some debug code that isn't actually very useful for debugging, like
enormous pagetable dump on each fault, the majority of the changes are
code reshuffling and variables/whitespaces clean up.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 203 +++++++++++++++----------------------
 1 file changed, 79 insertions(+), 124 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 7182445c3b76..aebbb2ccc536 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -34,63 +34,59 @@
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
+				unsigned long iova, u32 pte)
 {
-	writel(offs, gart->regs + GART_ENTRY_ADDR);
-	writel(pte, gart->regs + GART_ENTRY_DATA);
+	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
+	writel_relaxed(pte, gart->regs + GART_ENTRY_DATA);
 
-	dev_dbg(gart->dev, "GART: %s %08lx:%08x\n",
-		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
+	dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
+		pte ? "map" : "unmap", iova, pte & GART_PAGE_MASK);
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
@@ -102,49 +98,20 @@ static void do_gart_setup(struct gart_device *gart, const u32 *data)
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
-		dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
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
+	return unlikely(iova < gart->iovmm_base ||
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
@@ -187,7 +154,6 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
-	struct gart_device *gart = gart_handle;
 	struct iommu_domain *domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
@@ -195,9 +161,8 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (domain) {
-		domain->geometry.aperture_start = gart->iovmm_base;
-		domain->geometry.aperture_end = gart->iovmm_base +
-					gart->page_count * GART_PAGE_SIZE - 1;
+		domain->geometry.aperture_start = gart_handle->iovmm_base;
+		domain->geometry.aperture_end = gart_handle->iovmm_end - 1;
 		domain->geometry.force_aperture = true;
 	}
 
@@ -209,35 +174,44 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	kfree(domain);
 }
 
+static int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
+			    phys_addr_t pa)
+{
+	if (unlikely(gart_debug) && gart_pte_valid(gart, iova)) {
+		dev_WARN(gart->dev, "GART: Page entry is in-use\n");
+		return -EBUSY;
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
 	unsigned long flags;
-	unsigned long pfn;
-	unsigned long pte;
+	int ret;
 
-	if (!gart_iova_range_valid(gart, iova, bytes))
+	if (gart_iova_range_invalid(gart, iova, bytes))
 		return -EINVAL;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
-	pfn = __phys_to_pfn(pa);
-	if (!pfn_valid(pfn)) {
-		dev_err(gart->dev, "GART: Invalid page: %pa\n", &pa);
-		spin_unlock_irqrestore(&gart->pte_lock, flags);
-		return -EINVAL;
-	}
-	if (gart_debug) {
-		pte = gart_read_pte(gart, iova);
-		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
-			spin_unlock_irqrestore(&gart->pte_lock, flags);
-			dev_err(gart->dev, "GART: Page entry is in-use\n");
-			return -EBUSY;
-		}
-	}
-	gart_set_pte(gart, iova, GART_PTE(pfn));
+	ret = __gart_iommu_map(gart, iova, pa);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
-	return 0;
+
+	return ret;
+}
+
+static void __gart_iommu_unmap(struct gart_device *gart, unsigned long iova)
+{
+	if (unlikely(gart_debug) && !gart_pte_valid(gart, iova)) {
+		dev_WARN(gart->dev, "GART: Page entry is invalid\n");
+		return;
+	}
+
+	gart_set_pte(gart, iova, 0);
 }
 
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
@@ -246,12 +220,13 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 
-	if (!gart_iova_range_valid(gart, iova, bytes))
+	if (gart_iova_range_invalid(gart, iova, bytes))
 		return 0;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
-	gart_set_pte(gart, iova, 0);
+	__gart_iommu_unmap(gart, iova);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
+
 	return bytes;
 }
 
@@ -259,25 +234,17 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
 	struct gart_device *gart = gart_handle;
-	unsigned long pte;
-	phys_addr_t pa;
 	unsigned long flags;
+	unsigned long pte;
 
-	if (!gart_iova_range_valid(gart, iova, 0))
+	if (gart_iova_range_invalid(gart, iova, SZ_4K))
 		return -EINVAL;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	pte = gart_read_pte(gart, iova);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 
-	pa = (pte & GART_PAGE_MASK);
-	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "GART: No entry for %08llx:%pa\n",
-			 (unsigned long long)iova, &pa);
-		gart_dump_table(gart);
-		return -EINVAL;
-	}
-	return pa;
+	return pte & GART_PAGE_MASK;
 }
 
 static bool gart_iommu_capable(enum iommu_cap cap)
@@ -342,24 +309,19 @@ static const struct iommu_ops gart_iommu_ops = {
 
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
 
@@ -368,8 +330,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 				     struct tegra_mc *mc)
 {
 	struct gart_device *gart;
-	struct resource *res_remap;
-	void __iomem *gart_regs;
+	struct resource *res;
 	int ret;
 
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
@@ -379,9 +340,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return NULL;
 
 	/* the GART memory aperture is required */
-	res_remap = platform_get_resource(to_platform_device(dev),
-					  IORESOURCE_MEM, 1);
-	if (!res_remap) {
+	res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 1);
+	if (!res) {
 		dev_err(dev, "GART: Memory aperture resource unavailable\n");
 		return ERR_PTR(-ENXIO);
 	}
@@ -390,39 +350,34 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	if (!gart)
 		return ERR_PTR(-ENOMEM);
 
+	gart_handle = gart;
+
+	gart->dev = dev;
+	gart->regs = mc->regs + GART_REG_BASE;
+	gart->iovmm_base = res->start;
+	gart->iovmm_end = res->start + resource_size(res);
+	spin_lock_init(&gart->pte_lock);
+	spin_lock_init(&gart->dom_lock);
+
+	do_gart_setup(gart, NULL);
+
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
-	if (ret) {
-		dev_err(dev, "GART: Failed to register IOMMU sysfs\n");
+	if (ret)
 		goto free_gart;
-	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
 	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
-	if (ret) {
-		dev_err(dev, "GART: Failed to register IOMMU\n");
+	if (ret)
 		goto remove_sysfs;
-	}
-
-	gart->dev = dev;
-	gart_regs = mc->regs + GART_REG_BASE;
-	spin_lock_init(&gart->pte_lock);
-	spin_lock_init(&gart->dom_lock);
-	gart->regs = gart_regs;
-	gart->iovmm_base = (dma_addr_t)res_remap->start;
-	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
 
-	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
+	gart->savedata = vmalloc(resource_size(res) >> GART_PAGE_SHIFT);
 	if (!gart->savedata) {
 		ret = -ENOMEM;
 		goto unregister_iommu;
 	}
 
-	do_gart_setup(gart, NULL);
-
-	gart_handle = gart;
-
 	return gart;
 
 unregister_iommu:
-- 
2.18.0

