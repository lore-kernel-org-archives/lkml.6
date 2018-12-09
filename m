Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A762AC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8582082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrsgwfI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8582082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLIUbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34758 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeLIUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so6529513lfc.1;
        Sun, 09 Dec 2018 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASq2D6tW3eZzmxu1kXDh0GYheKCVARnQbJAO/oXHJwc=;
        b=OrsgwfI8xhWcuiz3tX0rs6eJNz4WTJwjHavjZBUkBc6FlbwrV4tAKTX6Bq4rFB0zWw
         Li0VMxpfub2S3xgQPjrZaKXvWQC25cejhjteLBBIZS11tLMpcw7yXau0x3ykezJv5u/f
         1HCJI7no2E+iwo0JfUWPQUIDVP76h7Cf5TeRtA/Hv18m4N8U3liKx2Qt0ouPAzGm2rPZ
         PZPuZgYotIDqI5gpeXbQk+09ttQKC1LY7/Mjc9UA4dQGkoxjrlMSSuZq1dSSWfiJ00T+
         LGrJ9BKeY1o4WZUcjOdOsIZXLFuqqY9uzIenx+Ns9IDJVuDsRg/7Lts9jkEstfIXmHnl
         drdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASq2D6tW3eZzmxu1kXDh0GYheKCVARnQbJAO/oXHJwc=;
        b=WzeIMRTlAmYuIOOXNBxx+skG9nnTcyLbk9q1xGJc7pITexMNgagEnoe9NSh1kDJufA
         uVXl8sX6WwpNNM1GUFaJQInLuyyYiJr6H/2U/XkBte7gAce1EuxaZr0phJKzVdly5TTv
         yNLot3ATVZOIzG34tBiMXVGMZpzdHVONRV3UAs37C2HryUD2xxxI0ae+A7g6djmBPkHz
         dSIPcVNCsN1f9NHDs+rBsXuWm60Ok+ZZtTraZRzkXMiNF87QUPQZdxCfS+aBjd7vSovs
         3wrLdqVPTZu84XLEYXZKgUcQCnL23Fje4XiUfu8ojkWabsAkgH/zu/R6P2h0RVFnYqli
         d1Wg==
X-Gm-Message-State: AA+aEWaZX98GVAelAgHk/5P++jOU81mS9YhytjSEzQfnPqYGkmb5l2ey
        EJ9G1hCY8SVddeJddpUIgAc=
X-Google-Smtp-Source: AFSGD/U46xyyqSO6sS/aZoLtuH+eRLad31hSnvkrjiP4hWAkLmIpM3yyz+/G1PxPF5C3s/yCIoH1Bg==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr5564410lfi.3.1544387481253;
        Sun, 09 Dec 2018 12:31:21 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 20/21] iommu/tegra: gart: Simplify clients-tracking code
Date:   Sun,  9 Dec 2018 23:29:49 +0300
Message-Id: <20181209202950.31486-21-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
index f2dc7e72be80..71de54aa845c 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -23,7 +23,6 @@
 
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/list.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -46,30 +45,20 @@
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
@@ -77,11 +66,6 @@ static bool gart_debug;
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
@@ -170,125 +154,70 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
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
@@ -319,8 +248,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t bytes)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
@@ -335,8 +263,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long pte;
 	phys_addr_t pa;
 	unsigned long flags;
@@ -395,8 +322,7 @@ static int gart_iommu_of_xlate(struct device *dev,
 
 static void gart_iommu_sync(struct iommu_domain *domain)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 
 	FLUSH_GART_REGS(gart);
 }
@@ -489,8 +415,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
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
2.19.1

