Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169BC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892020779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3qpYtog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5892020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeJVSKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:10:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeJVSKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o+fx/IzrVv4/MSnow+vLZxgAkW8RHCt/H6nshqKLA+o=; b=Z3qpYtogj0gTp5u2hCCEwWgsG
        vClsWhFXC04fr2cwckUenSAyT4u2ArSylgJyYhbqBJqralZYglnWMXUa2NjlVsR6VlIK/9FeGvt/B
        DG3EpaF7XhLARV03gwDBN6NTxT/rYbTHYYzH2pNcLe6Y2FWYo/znYmbtjUD6a68SnOagu2KFpAgF2
        w5rbgY78RGAK5u8J+FN8qvxAy4dCZvghpKtg4AcaDiJJYsqu35m3MuWqrmvYX/MEv0XsLTLHFB4Im
        qyIUcgz2iRXMizYDfxR+tPjIEjc+UztdfSvpc9rJcK6fWPGngHXBAf07PDuLmWOxwfeelrS5Adhrd
        ysEM1mabQ==;
Received: from [109.144.218.6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEWtJ-0006DD-LW; Mon, 22 Oct 2018 09:52:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jejb@parisc-linux.org, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: remove the dead ccio-rm-dma driver
Date:   Mon, 22 Oct 2018 10:52:51 +0100
Message-Id: <20181022095251.5699-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has never been wired up due to the life of the Linux
git tree, and has severely bitrotted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/Makefile      |   3 -
 drivers/parisc/ccio-rm-dma.c | 202 -----------------------------------
 2 files changed, 205 deletions(-)
 delete mode 100644 drivers/parisc/ccio-rm-dma.c

diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
index 3cd5e6cb8478..99fa6a89e0b9 100644
--- a/drivers/parisc/Makefile
+++ b/drivers/parisc/Makefile
@@ -8,9 +8,6 @@
 obj-$(CONFIG_IOSAPIC)		+= iosapic.o
 obj-$(CONFIG_IOMMU_SBA)		+= sba_iommu.o
 obj-$(CONFIG_PCI_LBA)		+= lba_pci.o
-
-# Only use one of them: ccio-rm-dma is for PCX-W systems *only*
-# obj-$(CONFIG_IOMMU_CCIO)	+= ccio-rm-dma.o
 obj-$(CONFIG_IOMMU_CCIO)	+= ccio-dma.o
 
 obj-$(CONFIG_GSC)		+= gsc.o
diff --git a/drivers/parisc/ccio-rm-dma.c b/drivers/parisc/ccio-rm-dma.c
deleted file mode 100644
index df7932af48b7..000000000000
--- a/drivers/parisc/ccio-rm-dma.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/*
- * ccio-rm-dma.c:
- *	DMA management routines for first generation cache-coherent machines.
- *	"Real Mode" operation refers to U2/Uturn chip operation. The chip
- *      can perform coherency checks w/o using the I/O MMU. That's all we
- *      need until support for more than 4GB phys mem is needed.
- * 
- *	This is the trivial case - basically what x86 does.
- *
- *	Drawbacks of using Real Mode are:
- *	o outbound DMA is slower since one isn't using the prefetching
- *	  U2 can do for outbound DMA.
- *	o Ability to do scatter/gather in HW is also lost.
- *      o only known to work with PCX-W processor. (eg C360)
- *        (PCX-U/U+ are not coherent with U2 in real mode.)
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- *
- * Original version/author:
- *      CVSROOT=:pserver:anonymous@198.186.203.37:/cvsroot/linux-parisc
- *      cvs -z3 co linux/arch/parisc/kernel/dma-rm.c
- *
- *	(C) Copyright 2000 Philipp Rumpf <prumpf@tux.org>
- *
- *
- * Adopted for The Puffin Group's parisc-linux port by Grant Grundler.
- *	(C) Copyright 2000 Grant Grundler <grundler@puffin.external.hp.com>
- *	
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <linux/gfp.h>
-
-#include <linux/uaccess.h>
-
-#include <asm/io.h>
-#include <asm/hardware.h>
-#include <asm/page.h>
-
-/* Only chose "ccio" since that's what HP-UX calls it....
-** Make it easier for folks to migrate from one to the other :^)
-*/
-#define MODULE_NAME "ccio"
-
-#define U2_IOA_RUNWAY 0x580
-#define U2_BC_GSC     0x501
-#define UTURN_IOA_RUNWAY 0x581
-#define UTURN_BC_GSC     0x502
-
-#define IS_U2(id) ( \
-    (((id)->hw_type == HPHW_IOA) && ((id)->hversion == U2_IOA_RUNWAY)) || \
-    (((id)->hw_type == HPHW_BCPORT) && ((id)->hversion == U2_BC_GSC))  \
-)
-
-#define IS_UTURN(id) ( \
-    (((id)->hw_type == HPHW_IOA) && ((id)->hversion == UTURN_IOA_RUNWAY)) || \
-    (((id)->hw_type == HPHW_BCPORT) && ((id)->hversion == UTURN_BC_GSC))  \
-)
-
-static int ccio_dma_supported( struct pci_dev *dev, u64 mask)
-{
-	if (dev == NULL) {
-		printk(KERN_ERR MODULE_NAME ": EISA/ISA/et al not supported\n");
-		BUG();
-		return(0);
-	}
-
-	/* only support 32-bit devices (ie PCI/GSC) */
-	return((int) (mask >= 0xffffffffUL));
-}
-
-
-static void *ccio_alloc_consistent(struct pci_dev *dev, size_t size,
-				 dma_addr_t *handle)
-{
-	void *ret;
-	
-	ret = (void *)__get_free_pages(GFP_ATOMIC, get_order(size));
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*handle = virt_to_phys(ret);
-	}
-	return ret;
-}
-	
-static void ccio_free_consistent(struct pci_dev *dev, size_t size,
-			       void *vaddr, dma_addr_t handle)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static dma_addr_t ccio_map_single(struct pci_dev *dev, void *ptr, size_t size,
-			  int direction)
-{
-	return virt_to_phys(ptr);
-}
-
-static void ccio_unmap_single(struct pci_dev *dev, dma_addr_t dma_addr,
-			    size_t size, int direction)
-{
-	/* Nothing to do */
-}
-
-
-static int ccio_map_sg(struct pci_dev *dev, struct scatterlist *sglist, int nents, int direction)
-{
-	int tmp = nents;
-
-        /* KISS: map each buffer separately. */
-	while (nents) {
-		sg_dma_address(sglist) = ccio_map_single(dev, sglist->address, sglist->length, direction);
-		sg_dma_len(sglist) = sglist->length;
-		nents--;
-		sglist++;
-	}
-
-	return tmp;
-}
-
-
-static void ccio_unmap_sg(struct pci_dev *dev, struct scatterlist *sglist, int nents, int direction)
-{
-#if 0
-	while (nents) {
-		ccio_unmap_single(dev, sg_dma_address(sglist), sg_dma_len(sglist), direction);
-		nents--;
-		sglist++;
-	}
-	return;
-#else
-	/* Do nothing (copied from current ccio_unmap_single()  :^) */
-#endif
-}
-
-
-static struct pci_dma_ops ccio_ops = {
-	ccio_dma_supported,
-	ccio_alloc_consistent,
-	ccio_free_consistent,
-	ccio_map_single,
-	ccio_unmap_single,
-	ccio_map_sg,
-	ccio_unmap_sg,
-	NULL,                   /* dma_sync_single_for_cpu : NOP for U2 */
-	NULL,                   /* dma_sync_single_for_device : NOP for U2 */
-	NULL,                   /* dma_sync_sg_for_cpu     : ditto */
-	NULL,                   /* dma_sync_sg_for_device     : ditto */
-};
-
-
-/*
-** Determine if u2 should claim this chip (return 0) or not (return 1).
-** If so, initialize the chip and tell other partners in crime they
-** have work to do.
-*/
-static int __init
-ccio_probe(struct parisc_device *dev)
-{
-	printk(KERN_INFO "%s found %s at 0x%lx\n", MODULE_NAME,
-			dev->id.hversion == U2_BC_GSC ? "U2" : "UTurn",
-			dev->hpa.start);
-
-/*
-** FIXME - should check U2 registers to verify it's really running
-** in "Real Mode".
-*/
-
-#if 0
-/* will need this for "Virtual Mode" operation */
-	ccio_hw_init(ccio_dev);
-	ccio_common_init(ccio_dev);
-#endif
-	hppa_dma_ops = &ccio_ops;
-	return 0;
-}
-
-static const struct parisc_device_id ccio_tbl[] __initconst = {
-	{ HPHW_BCPORT, HVERSION_REV_ANY_ID, U2_BC_GSC, 0xc },
-	{ HPHW_BCPORT, HVERSION_REV_ANY_ID, UTURN_BC_GSC, 0xc },
-	{ 0, }
-};
-
-static struct parisc_driver ccio_driver __refdata = {
-	.name =		"U2/Uturn",
-	.id_table =	ccio_tbl,
-	.probe =	ccio_probe,
-};
-
-void __init ccio_init(void)
-{
-	register_parisc_driver(&ccio_driver);
-}
-- 
2.19.1

