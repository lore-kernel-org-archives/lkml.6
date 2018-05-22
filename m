Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526990712-2-14873201645869669598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990712; b=CMJA7ZyuTJd3xfjQSURJRNFnWJq1aCJgLnhmVdvAG8mfoe9erk
    f4qoIuvz6iky2/ardgZmiGMGnlBVPmErZp2EZACViTfiP+hof0YhiK7VQC3WQNJ6
    ybFajPKQV27HEuX4XjK2gbPkk6jqy2AyF04zH8eWU3lVLsmkZ2OJS0CzjLbxGuAg
    c2LrpBKWp8jsnetbcXdRk7Al2wF3m9b4SJjY+CSLiMtfmG9shYgq6TOwaCecSxHQ
    pOqnrFHEtFjb+W9trlquMHD1YWgF2BwlBet5DcREuHmfYvmfALoIz16I3ef1CXXq
    VyzRLjgHBgQpc1NOxpWstTdobB4ViHd+B0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526990712; bh=
    iBMZUynGKMTi6j/Pib9ftuwlsIaNbRBWZnZAalnU4a8=; b=H91+l9UalV/RmoH/
    V32to7XP+pdNpk4ugNbdkduyrZA2dz00etdUAbXmhGsDMUDPoQZH9K/G9EH56/hj
    XOOx8S8Jf9fLwXvf6Sc1zxFR6j0ad8YcdG6pwfaDzIVo2xcdEmZJgg5jH5Ge0jGq
    Y0ecvoa9rsvJ3QxFEhOFv7TLWykrWwhxq9tiFi+3gZYF3balLz4G7Lasfm6FiV7k
    htjD+6ttq/StvVxQSDDAcdu5dxFsLdb/afjYASdmjW0BbYCpr8Bk1982JMFW+kfh
    1kApVamzw+DKEQFb9DpxZEwsiD964+ABpzu7K8fZqxAsBf2/zUVhgPuuUnif3It2
    ixbsNQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=e5ex1EX1
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=e5ex1EX1
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
X-CM-Envelope: MS4wfG5Ibo1DTaQ5EQ920YI/248cT5PMqBD83qgsybukl3906jOzKNbHhVG2v4pBHohqtROqB7h09jB3bOKEH9toUF4U0mOR2e2zqL8ttnHcxzqfEe2+ofTu
    D5tQMA+NU+XT8Hl3hgad4TUMJtrpisAi1lIgI4mFzQGAHyhzcS/z0EWYGIUrQOWhfWV7N/WaaUA/rIsrpN4O7hp9jOpNkMFKvvYSLrJWpaQfgUBQO+zmbh4K
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LQ17Lw9wAAAA:8
    a=vX4AOHmONak64berSiwA:9 a=Gc-PDQ7bGeaEmj7w:21 a=aUrNlkghJHyWAQl3:21
    a=j77vJcMW1SzrPxEKBuqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeEVMFK (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:05:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeEVMFH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:07 -0400
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
Subject: [PATCH 05/25] microblaze: use generic dma_noncoherent_ops
Date: Tue, 22 May 2018 14:04:10 +0200
Message-Id: <20180522120430.28709-6-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Switch to the generic noncoherent direct mapping implementation.

This removes the direction-based optimizations in
sync_{single,sg}_for_{cpu,device} which were marked untestested and
do not match the usually very well tested {un,}map_{single,sg}
implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig                   |   4 +
 arch/microblaze/include/asm/Kbuild        |   1 +
 arch/microblaze/include/asm/dma-mapping.h |  28 -----
 arch/microblaze/include/asm/pgtable.h     |   2 -
 arch/microblaze/kernel/dma.c              | 144 ++--------------------
 arch/microblaze/mm/consistent.c           |   9 +-
 6 files changed, 22 insertions(+), 166 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/dma-mapping.h

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d14782100088..848e31a86ba5 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,6 +1,8 @@
 config MICROBLAZE
 	def_bool y
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -8,6 +10,8 @@ config MICROBLAZE
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
+	select DMA_NONCOHERENT_OPS
+	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 3c80a5a308ed..8d3e71f43a3e 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
deleted file mode 100644
index add50c1373bf..000000000000
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Implements the generic device dma API for microblaze and the pci
- *
- * Copyright (C) 2009-2010 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2009-2010 PetaLogix
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
- *
- * This file is base on powerpc and x86 dma-mapping.h versions
- * Copyright (C) 2004 IBM
- */
-
-#ifndef _ASM_MICROBLAZE_DMA_MAPPING_H
-#define _ASM_MICROBLAZE_DMA_MAPPING_H
-
-/*
- * Available generic sets of operations
- */
-extern const struct dma_map_ops dma_nommu_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &dma_nommu_ops;
-}
-
-#endif	/* _ASM_MICROBLAZE_DMA_MAPPING_H */
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index db8b1fa83452..8a2e654b709f 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,8 +553,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle);
-void consistent_free(size_t size, void *vaddr);
 void consistent_sync(void *vaddr, size_t size, int direction);
 void consistent_sync_page(struct page *page, unsigned long offset,
 	size_t size, int direction);
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 3145e7dc8ab1..71032cf64669 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -8,29 +8,15 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/dma-debug.h>
 #include <linux/export.h>
 #include <linux/bug.h>
 #include <asm/cacheflush.h>
 
-static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag,
-				       unsigned long attrs)
-{
-	return consistent_alloc(flag, size, dma_handle);
-}
-
-static void dma_nommu_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle,
-				     unsigned long attrs)
-{
-	consistent_free(size, vaddr);
-}
-
-static inline void __dma_sync(unsigned long paddr,
-			      size_t size, enum dma_data_direction direction)
+static void __dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
+		enum dma_data_direction direction)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
@@ -45,113 +31,21 @@ static inline void __dma_sync(unsigned long paddr,
 	}
 }
 
-static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
-			     int nents, enum dma_data_direction direction,
-			     unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *sg;
-	int i;
-
-	/* FIXME this part of code is untested */
-	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg);
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		__dma_sync(sg_phys(sg), sg->length, direction);
-	}
-
-	return nents;
-}
-
-static inline dma_addr_t dma_nommu_map_page(struct device *dev,
-					     struct page *page,
-					     unsigned long offset,
-					     size_t size,
-					     enum dma_data_direction direction,
-					     unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(page_to_phys(page) + offset, size, direction);
-	return page_to_phys(page) + offset;
+	__dma_sync(dev, paddr, size, dir);
 }
 
-static inline void dma_nommu_unmap_page(struct device *dev,
-					 dma_addr_t dma_address,
-					 size_t size,
-					 enum dma_data_direction direction,
-					 unsigned long attrs)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-/* There is not necessary to do cache cleanup
- *
- * phys_to_virt is here because in __dma_sync_page is __virt_to_phys and
- * dma_address is physical address
- */
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(dma_address, size, direction);
+	__dma_sync(dev, paddr, size, dir);
 }
 
-static inline void
-dma_nommu_sync_single_for_cpu(struct device *dev,
-			       dma_addr_t dma_handle, size_t size,
-			       enum dma_data_direction direction)
-{
-	/*
-	 * It's pointless to flush the cache as the memory segment
-	 * is given to the CPU
-	 */
-
-	if (direction == DMA_FROM_DEVICE)
-		__dma_sync(dma_handle, size, direction);
-}
-
-static inline void
-dma_nommu_sync_single_for_device(struct device *dev,
-				  dma_addr_t dma_handle, size_t size,
-				  enum dma_data_direction direction)
-{
-	/*
-	 * It's pointless to invalidate the cache if the device isn't
-	 * supposed to write to the relevant region
-	 */
-
-	if (direction == DMA_TO_DEVICE)
-		__dma_sync(dma_handle, size, direction);
-}
-
-static inline void
-dma_nommu_sync_sg_for_cpu(struct device *dev,
-			   struct scatterlist *sgl, int nents,
-			   enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	/* FIXME this part of code is untested */
-	if (direction == DMA_FROM_DEVICE)
-		for_each_sg(sgl, sg, nents, i)
-			__dma_sync(sg->dma_address, sg->length, direction);
-}
-
-static inline void
-dma_nommu_sync_sg_for_device(struct device *dev,
-			      struct scatterlist *sgl, int nents,
-			      enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	/* FIXME this part of code is untested */
-	if (direction == DMA_TO_DEVICE)
-		for_each_sg(sgl, sg, nents, i)
-			__dma_sync(sg->dma_address, sg->length, direction);
-}
-
-static
-int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
-			     void *cpu_addr, dma_addr_t handle, size_t size,
-			     unsigned long attrs)
+int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t handle, size_t size,
+		unsigned long attrs)
 {
 #ifdef CONFIG_MMU
 	unsigned long user_count = vma_pages(vma);
@@ -170,17 +64,3 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 	return -ENXIO;
 #endif
 }
-
-const struct dma_map_ops dma_nommu_ops = {
-	.alloc			= dma_nommu_alloc_coherent,
-	.free			= dma_nommu_free_coherent,
-	.mmap			= dma_nommu_mmap_coherent,
-	.map_sg			= dma_nommu_map_sg,
-	.map_page		= dma_nommu_map_page,
-	.unmap_page		= dma_nommu_unmap_page,
-	.sync_single_for_cpu	= dma_nommu_sync_single_for_cpu,
-	.sync_single_for_device	= dma_nommu_sync_single_for_device,
-	.sync_sg_for_cpu	= dma_nommu_sync_sg_for_cpu,
-	.sync_sg_for_device	= dma_nommu_sync_sg_for_device,
-};
-EXPORT_SYMBOL(dma_nommu_ops);
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index b06c3a7faf20..b9a9c8c3397b 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/gfp.h>
+#include <linux/dma-noncoherent.h>
 
 #include <asm/pgalloc.h>
 #include <linux/io.h>
@@ -59,7 +60,8 @@
  * uncached region.  This will no doubt cause big problems if memory allocated
  * here is not also freed properly. -- JW
  */
-void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned long order, vaddr;
 	void *ret;
@@ -154,7 +156,6 @@ void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle)
 
 	return ret;
 }
-EXPORT_SYMBOL(consistent_alloc);
 
 #ifdef CONFIG_MMU
 static pte_t *consistent_virt_to_pte(void *vaddr)
@@ -178,7 +179,8 @@ unsigned long consistent_virt_to_pfn(void *vaddr)
 /*
  * free page(s) as defined by the above mapping.
  */
-void consistent_free(size_t size, void *vaddr)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct page *page;
 
@@ -218,7 +220,6 @@ void consistent_free(size_t size, void *vaddr)
 	flush_tlb_all();
 #endif
 }
-EXPORT_SYMBOL(consistent_free);
 
 /*
  * make an area consistent.
-- 
2.17.0
