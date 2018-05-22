Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526991522-2-62417659833926293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526991522; b=mDeTTPUrz/HlCBgH6kvt4UPFfbWyKN7IM13PscN0nv0q+9spZt
    lLJGZgT8I1TPffhSI5LjAZVINqot10J7Bm83RtRB2nrZAX+SVl4ixeIbiBShXFYc
    qG295pXddwppJLDdzIvji+c55Bzc79/N3dnevsf0bsoEU73XnIJRUZm3wDFcSMqd
    ml0+smkbLOaoO99AjIzWCjbN0eg5mpeEPdO6ubCXtUdjttTt3rpdCyyrfr2qfZ9G
    5mkj6SPtrtbHRiie5X5a96bwdIry2S89UCNUZyi6bHsvsID/OhuDkxJGibCbkRm0
    s1Mv683WaoG68e9kj3VhofOJ2GRP99g2hKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526991522; bh=
    S2vNJMVQYUxGLIC94RRhfKqiKMtegCnQW0tFrc72hC4=; b=aZxv245nmWlaQfL9
    RvDJ/dmKLzX4zw7gQKTOvCZA7BtfMix+if/3PpozP+1ItYzQOks972XeXTeLFmI6
    gVmemM0Gkaq+dmMLInxsPXN8w/ITgJ37O1NKN9BuIVCyuF0Y9YfdJt5uaNIjD2rJ
    gXjf1EFbEJ1IWMabcXOpySjyUiBJXbO2QZrd8oT7gxJrUzimVHArwU51HaWbvCmV
    /RW961cn0vh2Cep/B2t3gkmpe6db+fwr6CXt/wqBpJQPEXjEkgnO9vbID9dc2SoS
    pTKI/r6Flv46Ee6zszTlAzbimK2bSbIslQZidazvaeQHFvDKMLJbibZ5PYcR0fmh
    TEb1jA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=FMQm5gJr
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=FMQm5gJr
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
X-CM-Envelope: MS4wfLgqsc17E6VI89pLgIh5rcGr/ebmQS0ZVEUfAr9uMAN1yfjnhU79Q9/n7GJbWSR7oanu7FePrEBLewc1ddN6LWJBITZdpk1Kf09D+170df3PpxP807el
    3hbS3ZhYSKpvmNJ/7Rh79tXa4qlYQKejLvelRdL/4k6ajxZoJOLW81MkTpEiCptIw44p4pbdAmubEnSSFfjhfwFc2m97Vpi2kJFfKTMyc5p6E8PGbfyHhCo3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=9pdmIOk1TWzA6KblF3QA:9
    a=VXHL59kRENdvPArT:21 a=pWL1bwMSAXk9ghED:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeEVMSh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:18:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51900 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeEVME6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:04:58 -0400
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
Subject: [PATCH 03/25] hexagon: use generic dma_noncoherent_ops
Date: Tue, 22 May 2018 14:04:08 +0200
Message-Id: <20180522120430.28709-4-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/Kconfig                   |   2 +
 arch/hexagon/include/asm/Kbuild        |   1 +
 arch/hexagon/include/asm/dma-mapping.h |  40 -------
 arch/hexagon/kernel/dma.c              | 148 ++-----------------------
 4 files changed, 11 insertions(+), 180 deletions(-)
 delete mode 100644 arch/hexagon/include/asm/dma-mapping.h

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 37adb2003033..bcbdcb32935c 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -4,6 +4,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
@@ -28,6 +29,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select DMA_NONCOHERENT_OPS
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index e9743f689fb8..843a8086e980 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += bugs.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
 generic-y += fb.h
diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
deleted file mode 100644
index 263f6acbfb0f..000000000000
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * DMA operations for the Hexagon architecture
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef _ASM_DMA_MAPPING_H
-#define _ASM_DMA_MAPPING_H
-
-#include <linux/types.h>
-#include <linux/cache.h>
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <asm/io.h>
-
-struct device;
-
-extern const struct dma_map_ops *dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return dma_ops;
-}
-
-#endif
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 9e46556a227d..ffc4ae8e126f 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -18,32 +18,19 @@
  * 02110-1301, USA.
  */
 
-#include <linux/dma-mapping.h>
-#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/bootmem.h>
 #include <linux/genalloc.h>
-#include <asm/dma-mapping.h>
 #include <linux/module.h>
 #include <asm/page.h>
 
-#define HEXAGON_MAPPING_ERROR	0
-
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
-static inline void *dma_addr_to_virt(dma_addr_t dma_addr)
-{
-	return phys_to_virt((unsigned long) dma_addr);
-}
-
 static struct gen_pool *coherent_pool;
 
 
 /* Allocates from a pool of uncached memory that was reserved at boot time */
 
-static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_addr, gfp_t flag,
-				 unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_addr,
+		gfp_t flag, unsigned long attrs)
 {
 	void *ret;
 
@@ -75,58 +62,17 @@ static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-static void hexagon_free_coherent(struct device *dev, size_t size, void *vaddr,
-				  dma_addr_t dma_addr, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	gen_pool_free(coherent_pool, (unsigned long) vaddr, size);
 }
 
-static int check_addr(const char *name, struct device *hwdev,
-		      dma_addr_t bus, size_t size)
-{
-	if (hwdev && hwdev->dma_mask && !dma_capable(hwdev, bus, size)) {
-		if (*hwdev->dma_mask >= DMA_BIT_MASK(32))
-			printk(KERN_ERR
-				"%s: overflow %Lx+%zu of device mask %Lx\n",
-				name, (long long)bus, size,
-				(long long)*hwdev->dma_mask);
-		return 0;
-	}
-	return 1;
-}
-
-static int hexagon_map_sg(struct device *hwdev, struct scatterlist *sg,
-			  int nents, enum dma_data_direction dir,
-			  unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *s;
-	int i;
-
-	WARN_ON(nents == 0 || sg[0].length == 0);
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = sg_phys(s);
-		if (!check_addr("map_sg", hwdev, s->dma_address, s->length))
-			return 0;
-
-		s->dma_length = s->length;
+	void *addr = phys_to_virt(paddr);
 
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		flush_dcache_range(dma_addr_to_virt(s->dma_address),
-				   dma_addr_to_virt(s->dma_address + s->length));
-	}
-
-	return nents;
-}
-
-/*
- * address is virtual
- */
-static inline void dma_sync(void *addr, size_t size,
-			    enum dma_data_direction dir)
-{
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		hexagon_clean_dcache_range((unsigned long) addr,
@@ -144,81 +90,3 @@ static inline void dma_sync(void *addr, size_t size,
 		BUG();
 	}
 }
-
-/**
- * hexagon_map_page() - maps an address for device DMA
- * @dev:	pointer to DMA device
- * @page:	pointer to page struct of DMA memory
- * @offset:	offset within page
- * @size:	size of memory to map
- * @dir:	transfer direction
- * @attrs:	pointer to DMA attrs (not used)
- *
- * Called to map a memory address to a DMA address prior
- * to accesses to/from device.
- *
- * We don't particularly have many hoops to jump through
- * so far.  Straight translation between phys and virtual.
- *
- * DMA is not cache coherent so sync is necessary; this
- * seems to be a convenient place to do it.
- *
- */
-static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	dma_addr_t bus = page_to_phys(page) + offset;
-	WARN_ON(size == 0);
-
-	if (!check_addr("map_single", dev, bus, size))
-		return HEXAGON_MAPPING_ERROR;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_sync(dma_addr_to_virt(bus), size, dir);
-
-	return bus;
-}
-
-static void hexagon_sync_single_for_device(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
-static void hexagon_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
-				sg->length, dir);
-}
-
-
-static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == HEXAGON_MAPPING_ERROR;
-}
-
-const struct dma_map_ops hexagon_dma_ops = {
-	.alloc		= hexagon_dma_alloc_coherent,
-	.free		= hexagon_free_coherent,
-	.map_sg		= hexagon_map_sg,
-	.map_page	= hexagon_map_page,
-	.sync_single_for_device = hexagon_sync_single_for_device,
-	.sync_sg_for_device = hexagon_sync_sg_for_device,
-	.mapping_error	= hexagon_mapping_error,
-};
-
-void __init hexagon_dma_init(void)
-{
-	if (dma_ops)
-		return;
-
-	dma_ops = &hexagon_dma_ops;
-}
-- 
2.17.0
