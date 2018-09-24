Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F16ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA732147C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBD6tasj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA732147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIXGr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:47:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35567 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:47:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so885923pgb.2;
        Sun, 23 Sep 2018 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2SGkbZ8YT7pMwS2UGx9FqS5wN8kjnSBETrmXZxFwEQ=;
        b=lBD6tasjuBQmCufXPoHGehNbdZUhuHhbYrzp3VDMc2FbCIIYHvmqO6hI3RKnGkptEo
         9TTNDg78kxmmPxMo3H4JpnBbVgUP6V83TytvzMGzpq9OAu99LpHWJm6dJoyPy24ZGHnD
         TOyC7lA+LzNQ5lAi2B6GyPdzuVHfbTUOBlsyFNjzwA5X88z7y4GBfSqNzUdLGyVXlXU1
         g+FFA/TuA6pwRkDJxcGfTtRxI8QKgtq9LcAI9wRnqRQlFN3/dKqyXy1iy2d6AdT3PO6e
         EOOlC+lZ8RJhqGFKEe3i8rHZ8cTgoBSYNv66XPyxsUdNmfUvsMZE28ZBjBjl1W1Pb6pS
         6pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2SGkbZ8YT7pMwS2UGx9FqS5wN8kjnSBETrmXZxFwEQ=;
        b=G3n/5Ji0L9cOykSOwFGt/dVzOeCEFVPNOZMGmYoMNeOPl4zuxr3tcAofhw1YtvieIS
         KXU3C1W378+NAPx45uFdX3oXRU2kY6jKZINDOdxQntf+78u/8ZMPct2bbt3lyB3ZOClM
         qvgGF1Ri58WVfqNlqMgARvFDmdFUTwheIoJiN4T9+ZPZE5fJ1XRStI5WNDcSwrManQ8H
         pUNl84+lFl+0rAsEf5N/tUmFniTc7B4zVMAXm2KP+XCpRoHCAXm7shdI5CSx6lyAycxs
         XtXt5kQP1hb63k73r9J4yMCIf5qgCOETiA3FtxMYaMSfbxwkC+ukIN2FhWs1DcCWtk5Q
         8oxg==
X-Gm-Message-State: APzg51BKsr8NlPT5SAUefsXXeCeiNBRAhIA+xmsZrY4efGiSAFR6qn6/
        mBPgCUev1Yh5WYBVPdByc3A=
X-Google-Smtp-Source: ANB0VdbC5oSxDcekj9tyxiOWS8awGUWppXsqUz+lB/CcRjYYOv52UY9mDVo+tY7j7OotZ/m3svta4Q==
X-Received: by 2002:aa7:881a:: with SMTP id c26-v6mr8010533pfo.82.1537750070484;
        Sun, 23 Sep 2018 17:47:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/20] iommu/tegra: gart: Simplify clients-tracking code
Date:   Mon, 24 Sep 2018 03:41:52 +0300
Message-Id: <20180924004153.8232-20-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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
---
 drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
 1 file changed, 39 insertions(+), 118 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 306e9644a676..7182445c3b76 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,7 +19,6 @@
 
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -42,30 +41,20 @@
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
@@ -73,11 +62,6 @@ static bool gart_debug;
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
@@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
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
-			dev_err(gart->dev, "GART: %s is already attached\n",
-				dev_name(dev));
-			err = -EINVAL;
-			goto fail;
-		}
-	}
-	if (gart->active_domain && gart->active_domain != domain) {
-		dev_err(gart->dev,
-			"GART: Only one domain can be active at a time\n");
-		err = -EINVAL;
-		goto fail;
-	}
-	gart->active_domain = domain;
-	gart_domain->gart = gart;
-	list_add(&client->list, &gart->client);
-	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
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
-			dev_dbg(gart->dev, "GART: Detached %s\n",
-				dev_name(dev));
-			return;
-		}
+	if (gart->active_domain && gart->active_domain != domain) {
+		ret = -EBUSY;
+	} else if (dev->archdata.iommu != domain) {
+		dev->archdata.iommu = domain;
+		gart->active_domain = domain;
+		gart->active_devices++;
 	}
 
-	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
-		dev_name(dev));
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
@@ -318,8 +243,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t bytes)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
@@ -334,8 +258,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long pte;
 	phys_addr_t pa;
 	unsigned long flags;
@@ -394,8 +317,7 @@ static int gart_iommu_of_xlate(struct device *dev,
 
 static void gart_iommu_sync(struct iommu_domain *domain)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 
 	FLUSH_GART_REGS(gart);
 }
@@ -486,8 +408,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
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

