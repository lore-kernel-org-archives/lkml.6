Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B96C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174320820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iX8LCu/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6174320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeKBD6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:58:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35763 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKBD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:57:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so8804411plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uTpWpNZGhoVK3YWg4IywStWPJDkNPjsQamkC499X1uM=;
        b=iX8LCu/Guh6pwDFuWrVoOZFNlWKDTpqQbSJo/uYVh9++VyPldRsUVcEgJiFw5myTYS
         TVtmZQ89g4XlZkyJziloQV2LPQodCB3EMup6hdaBHyhy0xkMR23qoNImPx3vNkEIqpC6
         8Cypjp1eDnX+nzXe/UIMNQdkorrJVYW+8xcc12GLQW/cwYyKGOLD9K2wqwLFx1K/srJe
         7g5l90pEk60+8smTBJkwPvtLvNHRcCxKh3xzeuZLQX2R+61+F7f3tNc/Jq/Y30OG8bvH
         aih6UmOYIzaViJQg79EyoToN5JTOT6jEXJcUN5ze//WZsPpNb27o6hthhJadbD4wvhIT
         SruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uTpWpNZGhoVK3YWg4IywStWPJDkNPjsQamkC499X1uM=;
        b=aidylPio8iROVq3w34ER1YpMN6gDJKrroAV1SlkfiQTIwSm6Fr/5PPIbfkqMfqqcvN
         5Bkwq/L7EVtXCUc0G6owmVN+QGTC9KGaNyZZPPlLtLotzKewYufbwHQH+ab1z+CkUmz/
         mk6ua5wkZi2qnKZDgiFqdM4Yu6ug364yXtgj4jgGIz5Gev5DEhfWBEMvjxgr4D5BkvHr
         K2OY27VS0eHlqbNol9ySgbKFoW6sTdoBXY3Jy7M0X5ofWYK00/SzQZtl37Hp5xSwFAgp
         4XhrLz63oRPkHj+z3HJGv1gwDRUlXtlaYw4gn0sszAcncTht7dwnmj+dC2+a7n1xp+rJ
         2vwQ==
X-Gm-Message-State: AGRZ1gK472HNm1rSg+ynRKcOJMzr7oAViVmdP6DFhckr+cwYhZVMXBrR
        2+N209pOnCl+DJgdqKBqdnhFEw==
X-Google-Smtp-Source: AJdET5eZ8IYS6rH9uSRonPJPbqUrCWJcKFW2Hfor1iCEqsinGdb7OpCDZGID8T99P3XN0yv9DbeQYg==
X-Received: by 2002:a17:902:4e25:: with SMTP id f34-v6mr8543351ple.43.1541098427750;
        Thu, 01 Nov 2018 11:53:47 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u69-v6sm46298545pfk.68.2018.11.01.11.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 11:53:46 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] ARM64: dma: move swiotlb helpers under CONFIG_IOMMU_DMA
Date:   Thu,  1 Nov 2018 11:53:40 -0700
Message-Id: <20181101185340.32664-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following tinyconfig warnings:
arch/arm64/mm/dma-mapping.c:174:12: warning: '__swiotlb_mmap_pfn' defined but not used [-Wunused-function]
arch/arm64/mm/dma-mapping.c:163:12: warning: '__swiotlb_get_sgtable_page' defined but not used [-Wunused-function]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/mm/dma-mapping.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3a703e5d4e32..62356c64e180 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -160,35 +160,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	__dma_unmap_area(phys_to_virt(paddr), size, dir);
 }
 
-static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
-				      struct page *page, size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-
-	return ret;
-}
-
-static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-
 static int __init atomic_pool_init(void)
 {
 	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
@@ -358,6 +329,35 @@ arch_initcall(arm64_dma_init);
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
+static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
+				      struct page *page, size_t size)
+{
+	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+
+	return ret;
+}
+
+static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
+			      unsigned long pfn, size_t size)
+{
+	int ret = -ENXIO;
+	unsigned long nr_vma_pages = vma_pages(vma);
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+
+	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      vma->vm_end - vma->vm_start,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
 /* Thankfully, all cache ops are by VA so we can ignore phys here */
 static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 {
-- 
2.11.0

