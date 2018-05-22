Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473873-1526991449-2-3399128503084752806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526991449; b=HgKbBMvWzMstTMmEgHjjb6w96dk6FLQ56L0h0P0KmiYbXiWgaE
    PoxIZSL8xC34v3cpdNULMiikPuo0lNQ4A8cRJiio3h/QRxhDPMD0tnRLuWaVeCXB
    dNwvVdmr3/qAmKl9NESu/xjavT7dc7x5Cu3HZM0aJFm3w/hlOvKznxPyD7wBkhYU
    J4neRVbyM0wUFupjCJsnYo63p/q+Dn3yGmQXFCHYld+5TujtEqpSqWh/oNqZWY4V
    /IXAdUEs6SVfRHBqGD4kyp+3RoiDTl3Xp/RRzkahOzyOsnbRZHQ4spfTrstFePxv
    cFMs+flVJXJdJpi+1ABc7wgq/ktXEmRjmh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526991449; bh=
    MCWBT5DxpAZSNH8gUehLkoPxF5zldmBPLUmaKchgtRw=; b=Xjb4gMnYlIj/j4d2
    pAdaTWwLOxIpjQ/gSPxTyauNVruUAZowadVAHg7ycVjXNDo2HhqYnC08PFtjMdo6
    k31RTTIONnMIMFEGapIWYBHaSS1kIcJXl4POslRNQTxz2gKU0EWeKFoQLOxe9u4C
    Bp+TtKPYSHj88DDj7v+OOPFxJD0kOGWiZ3+iMDEQPQxBQEcYx9cf61iXK8Gcr+fh
    gcwWMhdIKkdoIXjcheU190nJY1lY5moNyvtI8tJ0bkvtPNjYwxXkrWIGheDtkVds
    ykgA/qg2ZXIbYxlm0r/5vA//YA6Fi3BcvvPVluOYFBSG8LjxVxshU91BZP0sUs6H
    /xwy1A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=hzmLyV3l
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=hzmLyV3l
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLUW0ArUw4kAnqbcWNZtElyD1KDGrbA4NB4gA0z6hLDBtHT7POindzRf5cPxuJdaUHr+XWWdqp+ODoQArNojHIVis3W4cuJuV5I8N9vK6OF+qRVrgAzj
    vXI8BjQL1MdyB1qJuZCq+QBjFQzVvtBC/uCIoJd+VNF0iCIjwnt0YueQEad6pyVeIaIf5JKNNAAC9CfZw4HaqYwhfDLV436tt/L5LO570f0aE/2iS0G7wFcu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JlEwpaQ4eOfUt1QPGR4A:9
    a=dHb3Xlwi8hSBzBiQ:21 a=vQHWGfY5uCgtBmzf:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeEVMRW (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:17:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeEVMFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] nds32: consolidate DMA cache maintainance routines
Date: Tue, 22 May 2018 14:04:13 +0200
Message-Id: <20180522120430.28709-9-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Make sure all other DMA methods call nds32_dma_sync_single_for_{device,cpu}
to perform cache maintaince, and remove the consisteny_sync helper that
implemented both with entirely separate code based off an argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 140 +++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 79 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index e1bf7206e015..4e6fb4ffd3f7 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -22,11 +22,6 @@
 static pte_t *consistent_pte;
 static DEFINE_RAW_SPINLOCK(consistent_lock);
 
-enum master_type {
-	FOR_CPU = 0,
-	FOR_DEVICE = 1,
-};
-
 /*
  * VM region handling support.
  *
@@ -333,15 +328,53 @@ static int __init consistent_init(void)
 }
 
 core_initcall(consistent_init);
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type);
+
+static void
+nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
+				 size_t size, enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(handle);
+
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_wb_range(start, start + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void
+nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
+			      size_t size, enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(handle);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_inval_range(start, start + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
+	dma_addr_t dma_addr = page_to_phys(page) + offset;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync((void *)(page_address(page) + offset), size, dir, FOR_DEVICE);
-	return page_to_phys(page) + offset;
+		nds32_dma_sync_single_for_device(dev, handle, size, dir);
+	return dma_addr;
 }
 
 static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
@@ -349,75 +382,19 @@ static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
 				 unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync(phys_to_virt(handle), size, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, handle, size, dir);
 }
 
-/*
- * Make an area consistent for devices.
- */
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type)
-{
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end = start + size;
-
-	if (master_type == FOR_CPU) {
-		switch (direction) {
-		case DMA_TO_DEVICE:
-			break;
-		case DMA_FROM_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_inval_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	} else {
-		/* FOR_DEVICE */
-		switch (direction) {
-		case DMA_FROM_DEVICE:
-			break;
-		case DMA_TO_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_wb_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	}
-}
-
-static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction dir,
-			    unsigned long attrs)
+static void
+nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction dir)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
-	return nents;
-}
-
-static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			       int nhwentries, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-}
-
-static void
-nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-			      size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_CPU);
-}
-
-static void
-nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_DEVICE);
 }
 
 static void
@@ -427,23 +404,28 @@ nds32_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
 }
 
-static void
-nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
+static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
+			    int nents, enum dma_data_direction dir,
+			    unsigned long attrs)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_DEVICE);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
+	return nents;
+}
+
+static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nhwentries, enum dma_data_direction dir,
+			       unsigned long attrs)
+{
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0
