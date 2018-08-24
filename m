Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490EB21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="U+G6fEOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490EB21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHXSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:05:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46870 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:05:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so7633486wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/74OLYCjhI4odcmhFMhHLARW+BN+P0IRpbkQzkWrzHw=;
        b=U+G6fEObBdhjn6MyIPnhGN228V+YEc6/S1R2tWfJyMFr4VBpVrm+2nExPERaEH5IoM
         NpEaAvepD848uGzce6EkrwYnnk6lzGf6hjBfRCKJkhpEYvk+1+SlTHCwL03veTe0Km5r
         rvRK4k5Q90m8U7LmmRSnvwrnvUR9lrRE0erW7UDkjk1xCus2XH/Z0fBFA0m4DMDHMjKM
         /QbZdEcQzO96eBawYqOhRZQZhDGW5Ap8SWa2TTP232hL0XGhdclRUf6gDH/byIjUordo
         VSo6//ow6t4gRrwY3B5m8LivIe3Iv6g4iBEOTcWl96cvDiLPsrL3jLJZYOgDoutSDFo7
         790w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/74OLYCjhI4odcmhFMhHLARW+BN+P0IRpbkQzkWrzHw=;
        b=IAKOrf1xAMHzVw167Y3u/9iH2a+fwxiUCJpbfkBm69CP3wkrk4SiW7+rmt72VpBiEz
         +hwK8z7OjT58HnAqJZ7swj7ZKdvYGtqiLKJd8ryUAD9LnVGa/y8B/HZP2Oia5LCKnxzp
         N1Pp0mlJnRRAz7xjIeQ2o5nsB7T2iPEvqXB5Ryp4Xc0m3/lWWyaYvPHc1rR7t3ItCe5b
         8YfZIHXGfXDxd7Wt3qAIFOIKplb/4nvbOc0JsEOO1gBvSBphXvDMW/pGDEiGVYNBMzQr
         uY/MLYbKg+Ott4MDwye/YaSOKcf0KcGNLE7NHw612Xnrd4WXmtx9iYKJnbVb1bQibw0B
         cP9g==
X-Gm-Message-State: APzg51BnvNx5ez3bcTeNluNMdi5s+WVErRD7CPMGgIbwtZ05Gup6KAu4
        z74vVlbNCTnpsUskK2FwdyqTQw==
X-Google-Smtp-Source: ANB0Vdao/8zq/TBTw6TJtRcRw0DUkn1CW5iphjuKUbYFOEwV6PojcMBJ+vrXHuILAIFyXsYPmCicIw==
X-Received: by 2002:a5d:6251:: with SMTP id m17-v6mr1387816wrv.179.1535121046346;
        Fri, 24 Aug 2018 07:30:46 -0700 (PDT)
Received: from instance-1.c.sanmarino-210610.internal (106.146.234.35.bc.googleusercontent.com. [35.234.146.106])
        by smtp.gmail.com with ESMTPSA id u4-v6sm5130791wro.47.2018.08.24.07.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 07:30:45 -0700 (PDT)
From:   murphyt7@tcd.ie
To:     leo.duran@amd.com
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Changing the AMD IOMMU API path to work in an atomic context which is necessary for any custom drivers using the IOMMU API while holding a spinlock.
Date:   Fri, 24 Aug 2018 14:28:49 +0000
Message-Id: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

---

This patch allows the IOMMU API path in the AMD driver to be called from an atomic context.
This is useful for anyone building a driver which needs to call the IOMMU API while holding a spinlock.

 drivers/iommu/amd_iommu.c       | 14 ++++++++------
 drivers/iommu/amd_iommu_types.h |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0c910a8..642afc9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2904,7 +2904,7 @@ static void protection_domain_free(struct protection_domain *domain)
 static int protection_domain_init(struct protection_domain *domain)
 {
 	spin_lock_init(&domain->lock);
-	mutex_init(&domain->api_lock);
+	spin_lock_init(&domain->api_lock);
 	domain->id = domain_id_alloc();
 	if (!domain->id)
 		return -ENOMEM;
@@ -3088,6 +3088,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 phys_addr_t paddr, size_t page_size, int iommu_prot)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
 	int prot = 0;
 	int ret;
 
@@ -3099,9 +3100,9 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	mutex_lock(&domain->api_lock);
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
-	mutex_unlock(&domain->api_lock);
+	spin_lock_irqsave(&domain->api_lock, flags);
+	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_ATOMIC);
+	spin_unlock_irqrestore(&domain->api_lock, flags);
 
 	return ret;
 }
@@ -3110,14 +3111,15 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			   size_t page_size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
 	size_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
-	mutex_lock(&domain->api_lock);
+	spin_lock_irqsave(&domain->api_lock, flags);
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
-	mutex_unlock(&domain->api_lock);
+	spin_unlock_irqrestore(&domain->api_lock, flags);
 
 	domain_flush_tlb_pde(domain);
 	domain_flush_complete(domain);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 0d91785..a9077a5 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -444,7 +444,7 @@ struct protection_domain {
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
 	spinlock_t lock;	/* mostly used to lock the page table*/
-	struct mutex api_lock;	/* protect page tables in the iommu-api path */
+	spinlock_t api_lock;	/* protect page tables in the iommu-api path */
 	u16 id;			/* the domain id written to the device table */
 	int mode;		/* paging mode (0-6 levels) */
 	u64 *pt_root;		/* page table root pointer */
-- 
2.7.4

