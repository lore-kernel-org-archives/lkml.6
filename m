Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E249C2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdzmW2mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E249C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeGSNhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:37:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGSNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GtlAyAmQTjfpQbt89lUxbWZYhA4n69UQAlloveX4nEE=; b=QdzmW2mcCH3lzW5rXswC6BQBP
        TYWX1AF7TCBRLh2WgB6Q9XW1cnfqyc3pHkI2FANz73ONUE6G/8Vp7pRt9e2Xf5ksLgCV34aJ4wwuX
        mIpeMgqJSVOUSb+UtfO3JQOXQqyxKoGZAKpOOJZCGc+b8v+MBl8di8KmO3/F1depTiKPc5j7LbqDs
        A3shF5dj/0PHSsFjGDU5oy7n++VeAKgwkdz7wZBbYzFrXHGvF4NAkedsNqoiIFrYmoRlI73n7otGa
        sgmyRn5t/8Dz7h9r897UreoerVHQPCnbEzeffUD9BoWbtLY6o/EBRBPhv8Hy0Xl3w7dKQvlu5TU+M
        IB6XmIcqw==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8S9-0004tR-5L; Thu, 19 Jul 2018 12:54:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] microblaze: remove consistent_sync and consistent_sync_page
Date:   Thu, 19 Jul 2018 05:54:40 -0700
Message-Id: <20180719125440.424-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719125440.424-1-hch@lst.de>
References: <20180719125440.424-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/pgtable.h |  3 --
 arch/microblaze/mm/consistent.c       | 45 ---------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 8a2e654b709f..7b650ab14fa0 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,9 +553,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-void consistent_sync(void *vaddr, size_t size, int direction);
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction);
 unsigned long consistent_virt_to_pfn(void *vaddr);
 
 void setup_memory(void);
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index b9a9c8c3397b..c9a278ac795a 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -220,48 +220,3 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	flush_tlb_all();
 #endif
 }
-
-/*
- * make an area consistent.
- */
-void consistent_sync(void *vaddr, size_t size, int direction)
-{
-	unsigned long start;
-	unsigned long end;
-
-	start = (unsigned long)vaddr;
-
-	/* Convert start address back down to unshadowed memory region */
-#ifdef CONFIG_XILINX_UNCACHED_SHADOW
-	start &= ~UNCACHED_SHADOW_MASK;
-#endif
-	end = start + size;
-
-	switch (direction) {
-	case PCI_DMA_NONE:
-		BUG();
-	case PCI_DMA_FROMDEVICE:	/* invalidate only */
-		invalidate_dcache_range(start, end);
-		break;
-	case PCI_DMA_TODEVICE:		/* writeback only */
-		flush_dcache_range(start, end);
-		break;
-	case PCI_DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
-		break;
-	}
-}
-EXPORT_SYMBOL(consistent_sync);
-
-/*
- * consistent_sync_page makes memory consistent. identical
- * to consistent_sync, but takes a struct page instead of a
- * virtual address
- */
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
-{
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	consistent_sync((void *)start, size, direction);
-}
-EXPORT_SYMBOL(consistent_sync_page);
-- 
2.18.0

