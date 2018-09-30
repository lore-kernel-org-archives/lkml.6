Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED060C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4A208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z59gE8Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE4A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeJAFYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37590 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeJAFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:24:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so8481946lfa.4;
        Sun, 30 Sep 2018 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dr92P6HFKlC5v8bNbScjv9Qh86HQ4kQ2KUMPEXvd3MI=;
        b=Z59gE8WxRBDsaQNjkOwZzLvAIA2BTXag51K3UwBKXqfxjX/r1q6siUj9ODz5Dfm26u
         NV38DQGSbDMeoFJYMdqOibrKhihwH7Z+vnow2ZexhvSXNce+Jh+Dshdv53PYmUq5PcYs
         wZC8otBK2Ub8cXtu2sJ0k+Gxtr9MmIk6Ivm7fywACB2VfByYwK6FaQNJWV20URdXQE7K
         3d462ZK3P45lvZ0kwF3MwuoLP4aJYx0Po6IKZO+BPWVDxwhPqVf14mqj9KIeBleFXvvO
         GQUHrzJMmFDtRW+Ahp1PSHX4IJzp6eczomKwLbhUqHGiEjcHMU4EyEYUQBAn624oNkcg
         Dz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dr92P6HFKlC5v8bNbScjv9Qh86HQ4kQ2KUMPEXvd3MI=;
        b=DdK9baWcEMqU6VNLSBr3JtpRMEYr9KLij+GhiOeDDH6S0T/mt5cDWDoSA+UoxH7l7e
         qYFbX8mBrrRSAo5q1XS1cv1kfPOJKg7l1H9Hgjpd0l5svyFcBV62YBarIb2lh1P43GAB
         te44yn398v2OJy/yuVlkm6cWM6AN7dAnCyMQmPsF17BV8aZZAGkby8BI+1VnsbIDv6lP
         Jsbkxb03TDOAuX3tkxLJOVzK+KgqRuRhxWc5ptHImE956chXyvSRnFhEvaPQXFY8tvdh
         415wdn7vvChHFcohVSdbXxYWxApSKhZ3vGaNfCVPwqHQDVxz8KCF/nYOfCRBWOMu4pbh
         /ePQ==
X-Gm-Message-State: ABuFfoiMn3PcLrhj6JlzLvb1k0ujF2H8eWn8L3u895djXPJl9Q03uRBL
        BaIkvlnHa+V9QyDm2LiuJbE=
X-Google-Smtp-Source: ACcGV63SBO2/wJA6Takc4ATWW69Sjb9LdGjMkXunbHu2YBInWFVB9F1oyEateEA652Alcw4Q1Vgg8w==
X-Received: by 2002:a19:dd8a:: with SMTP id w10-v6mr4110913lfi.97.1538347753702;
        Sun, 30 Sep 2018 15:49:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/21] iommu/tegra: gart: Simplify clients-tracking code
Date:   Mon,  1 Oct 2018 01:48:32 +0300
Message-Id: <20180930224833.28809-21-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART is a simple IOMMU provider that has single address space. There is
no need to setup global clients list and manage it for tracking of the
active domain, hence lot's of code could be safely removed and replaced
with a simpler alternative.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 155 ++++++++++---------------------------
 1 file changed, 40 insertions(+), 115 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 101ab3b40c2d..f7358b5547dc 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -21,7 +21,6 @@
 
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -44,30 +43,20 @@
 #define GART_PAGE_MASK						\
 	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
 
-struct gart_client {
-	struct device		*dev;
-	struct list_head	list;
-};
-
 struct gart_device {
 	void __iomem		*regs;
 	u32			*savedata;
 	u32			page_count;	/* total remappable size */
 	dma_addr_t		iovmm_base;	/* offset to vmm_area */
 	spinlock_t		pte_lock;	/* for pagetable */
-	struct list_head	client;
-	spinlock_t		client_lock;	/* for client list */
+	spinlock_t		dom_lock;	/* for active domain */
+	unsigned int		active_devices;	/* number of active devices */
 	struct iommu_domain	*active_domain;	/* current active domain */
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
 };
 
-struct gart_domain {
-	struct iommu_domain domain;		/* generic domain handle */
-	struct gart_device *gart;		/* link to gart device   */
-};
-
 static struct gart_device *gart_handle; /* unique for a system */
 
 static bool gart_debug;
@@ -75,11 +64,6 @@ static bool gart_debug;
 #define GART_PTE(_pfn)						\
 	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
 
-static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct gart_domain, domain);
-}
-
 /*
  * Any interaction between any block on PPSB and a block on APB or AHB
  * must have these read-back to ensure the APB/AHB bus transaction is
@@ -168,125 +152,70 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
 static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_handle;
-	struct gart_client *client, *c;
-	int err = 0;
-
-	client = kzalloc(sizeof(*c), GFP_KERNEL);
-	if (!client)
-		return -ENOMEM;
-	client->dev = dev;
-
-	spin_lock(&gart->client_lock);
-	list_for_each_entry(c, &gart->client, list) {
-		if (c->dev == dev) {
-			dev_err(gart->dev,
-				"%s is already attached\n", dev_name(dev));
-			err = -EINVAL;
-			goto fail;
-		}
-	}
-	if (gart->active_domain && gart->active_domain != domain) {
-		dev_err(gart->dev, "Only one domain can be active at a time\n");
-		err = -EINVAL;
-		goto fail;
-	}
-	gart->active_domain = domain;
-	gart_domain->gart = gart;
-	list_add(&client->list, &gart->client);
-	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
-	return 0;
+	int ret = 0;
 
-fail:
-	kfree(client);
-	spin_unlock(&gart->client_lock);
-	return err;
-}
+	spin_lock(&gart->dom_lock);
 
-static void __gart_iommu_detach_dev(struct iommu_domain *domain,
-				    struct device *dev)
-{
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
-	struct gart_client *c;
-
-	list_for_each_entry(c, &gart->client, list) {
-		if (c->dev == dev) {
-			list_del(&c->list);
-			kfree(c);
-			if (list_empty(&gart->client)) {
-				gart->active_domain = NULL;
-				gart_domain->gart = NULL;
-			}
-			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
-			return;
-		}
+	if (gart->active_domain && gart->active_domain != domain) {
+		ret = -EBUSY;
+	} else if (dev->archdata.iommu != domain) {
+		dev->archdata.iommu = domain;
+		gart->active_domain = domain;
+		gart->active_devices++;
 	}
 
-	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+	spin_unlock(&gart->dom_lock);
+
+	return ret;
 }
 
 static void gart_iommu_detach_dev(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
+
+	spin_lock(&gart->dom_lock);
 
-	spin_lock(&gart->client_lock);
-	__gart_iommu_detach_dev(domain, dev);
-	spin_unlock(&gart->client_lock);
+	if (dev->archdata.iommu == domain) {
+		dev->archdata.iommu = NULL;
+
+		if (--gart->active_devices == 0)
+			gart->active_domain = NULL;
+	}
+
+	spin_unlock(&gart->dom_lock);
 }
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
-	struct gart_domain *gart_domain;
-	struct gart_device *gart;
+	struct gart_device *gart = gart_handle;
+	struct iommu_domain *domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
-	gart = gart_handle;
-	if (!gart)
-		return NULL;
-
-	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
-	if (!gart_domain)
-		return NULL;
-
-	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
-	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (domain) {
+		domain->geometry.aperture_start = gart->iovmm_base;
+		domain->geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-	gart_domain->domain.geometry.force_aperture = true;
+		domain->geometry.force_aperture = true;
+	}
 
-	return &gart_domain->domain;
+	return domain;
 }
 
 static void gart_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
-
-	if (gart) {
-		spin_lock(&gart->client_lock);
-		if (!list_empty(&gart->client)) {
-			struct gart_client *c, *tmp;
-
-			list_for_each_entry_safe(c, tmp, &gart->client, list)
-				__gart_iommu_detach_dev(domain, c->dev);
-		}
-		spin_unlock(&gart->client_lock);
-	}
-
-	kfree(gart_domain);
+	WARN_ON(gart_handle->active_domain == domain);
+	kfree(domain);
 }
 
 static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t pa, size_t bytes, int prot)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 	unsigned long pfn;
 	unsigned long pte;
@@ -317,8 +246,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t bytes)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
@@ -333,8 +261,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long pte;
 	phys_addr_t pa;
 	unsigned long flags;
@@ -393,8 +320,7 @@ static int gart_iommu_of_xlate(struct device *dev,
 
 static void gart_iommu_sync(struct iommu_domain *domain)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 
 	FLUSH_GART_REGS(gart);
 }
@@ -487,8 +413,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	gart->dev = dev;
 	gart_regs = mc->regs + GART_REG_BASE;
 	spin_lock_init(&gart->pte_lock);
-	spin_lock_init(&gart->client_lock);
-	INIT_LIST_HEAD(&gart->client);
+	spin_lock_init(&gart->dom_lock);
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
-- 
2.19.0

