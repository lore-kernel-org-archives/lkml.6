Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526990829-2-1552050587648712230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990828; b=G0v7EpUgnEpDUSAmEcw9CfPquNUxdG7yVUQShI1XUJhIw1kF+9
    JI7Davoz7hgRnLsTcAKZ8S40TrGODvygsQchFw/wTgWA3nze30R919xOIAolVZK9
    kxngFY7zmSnm7K413ZD+8WPbIua8WS4RJurAB86z2JfjwW5XBI2QEjhqUSyY5z/4
    PpPMPkySJfDYNLE2vsrZGky+2sQ8qUmfSVdE6qx0FrcCYs9EIYSw2wGYAYAyXzT/
    Wg+t62+9sUfjs8rPKt+7ZnkUmBZWJEh+brV7dSwB6eI+rfEqE4xq17D90WC0+m/x
    euABMEpU13hxl62xrot8ZoJ52YV/iHu3S9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526990828; bh=
    pgoTNyGPaQn4ahamtCBnigcXY+CB925hO659TYFYURY=; b=Fi6K3t+mXv7Th1J5
    v6V+n167rpxz1D2Cm1S0x4H3pk7BogeJ8wZjmdx7Mc40KkqrFfqnHpMhBTAA1zxd
    zRuSyuDfYpWqyKviGrcCOaIpYCzWEkLzJ47Z43kZVR26Ifp2tNFTbXFnu5tDPMjW
    N2Xm3Xq5zG9X3p+NK2aBjtLhL9mH1I+SBvKpYi19pyiN1ALkKCviEcnD1+1mUFSP
    Pd79Y5/U7aM/GXDnPp41/Yg2SfOqVSucnZrZdaThKN7Ju3HSNw5GB+0Ey/UjvHKM
    YPxDpzR8e/ZTZRHg2S5hoB7vL4zMcIK4juT49gnhyGri2xy4mPBGA0ZC47ppSdlg
    4Oh8LQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=runVb4aB
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
      header.d=infradead.org header.i=@infradead.org header.b=runVb4aB
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
X-CM-Envelope: MS4wfDVivBiUHAAOrEkRv74fyaMq/851aVX2UtkCJB2igx0bLcgFeBjuadF+yz0xQ0LlwCwbcEsHI95Xv2yWo48VNbYJS6d6H8r+7lSpbeiTnvIv7cUou5Ya
    5ZWJ0/ZBVos06md18SR8/y0U7KtvDsnlHbxOKWYI3q5ft+Y+fLzzcM5G1+hQ07OpHXA3D3bYsDZjT0e+cLQuzyQTW/tHTYmMgiIOeMjUbEidkElkpoefYglI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JI-gzSgfEtX4ME16QlEA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEVMHE (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:07:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeEVMGN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:06:13 -0400
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
Subject: [PATCH 23/25] parisc: merge pcx_dma_ops and pcxl_dma_ops
Date: Tue, 22 May 2018 14:04:28 +0200
Message-Id: <20180522120430.28709-24-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The only difference is that pcxl supports dma coherent allocations, while
pcx only supports non-consistent allocations and otherwise fails.

But dma_alloc* is not in the fast path, and merging these two allows an
easy migration path to the generic dma-noncoherent implementation, so
do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/dma-mapping.h |  3 +-
 arch/parisc/kernel/pci-dma.c          | 80 ++++++++++++---------------
 arch/parisc/kernel/setup.c            |  8 +--
 arch/parisc/mm/init.c                 | 11 +---
 4 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index 01e1fc057c83..eeec8dd18e74 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -22,8 +22,7 @@
 */
 
 #ifdef CONFIG_PA11
-extern const struct dma_map_ops pcxl_dma_ops;
-extern const struct dma_map_ops pcx_dma_ops;
+extern const struct dma_map_ops pa11_dma_ops;
 #endif
 
 extern const struct dma_map_ops *hppa_dma_ops;
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 91bc0cac03a1..52304cb290f9 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -408,7 +408,7 @@ pcxl_dma_init(void)
 
 __initcall(pcxl_dma_init);
 
-static void *pa11_dma_alloc(struct device *dev, size_t size,
+static void *pcxl_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
 {
 	unsigned long vaddr;
@@ -435,16 +435,44 @@ static void *pa11_dma_alloc(struct device *dev, size_t size,
 	return (void *)vaddr;
 }
 
+static void *pcx_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
+{
+	void *addr;
+
+	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0)
+		return NULL;
+
+	addr = (void *)__get_free_pages(flag, get_order(size));
+	if (addr)
+		*dma_handle = (dma_addr_t)virt_to_phys(addr);
+
+	return addr;
+}
+
+static void *pa11_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+
+	if (boot_cpu_data.cpu_type == pcxl2 || boot_cpu_data.cpu_type == pcxl)
+		return pcxl_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	else
+		return pcx_dma_alloc(dev, size, dma_handle, gfp, attrs);
+}
+
 static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	int order;
+	int order = get_order(size);
 
-	order = get_order(size);
-	size = 1 << (order + PAGE_SHIFT);
-	unmap_uncached_pages((unsigned long)vaddr, size);
-	pcxl_free_range((unsigned long)vaddr, size);
-	free_pages((unsigned long)__va(dma_handle), order);
+	if (boot_cpu_data.cpu_type == pcxl2 || boot_cpu_data.cpu_type == pcxl) {
+		size = 1 << (order + PAGE_SHIFT);
+		unmap_uncached_pages((unsigned long)vaddr, size);
+		pcxl_free_range((unsigned long)vaddr, size);
+
+		vaddr = __va(dma_handle);
+	}
+	free_pages((unsigned long)vaddr, get_order(size));
 }
 
 static dma_addr_t pa11_dma_map_page(struct device *dev, struct page *page,
@@ -573,7 +601,7 @@ static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	flush_kernel_dcache_range((unsigned long)vaddr, size);
 }
 
-const struct dma_map_ops pcxl_dma_ops = {
+const struct dma_map_ops pa11_dma_ops = {
 	.alloc =		pa11_dma_alloc,
 	.free =			pa11_dma_free,
 	.map_page =		pa11_dma_map_page,
@@ -586,39 +614,3 @@ const struct dma_map_ops pcxl_dma_ops = {
 	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
 	.cache_sync =		pa11_dma_cache_sync,
 };
-
-static void *pcx_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
-{
-	void *addr;
-
-	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0)
-		return NULL;
-
-	addr = (void *)__get_free_pages(flag, get_order(size));
-	if (addr)
-		*dma_handle = (dma_addr_t)virt_to_phys(addr);
-
-	return addr;
-}
-
-static void pcx_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t iova, unsigned long attrs)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-	return;
-}
-
-const struct dma_map_ops pcx_dma_ops = {
-	.alloc =		pcx_dma_alloc,
-	.free =			pcx_dma_free,
-	.map_page =		pa11_dma_map_page,
-	.unmap_page =		pa11_dma_unmap_page,
-	.map_sg =		pa11_dma_map_sg,
-	.unmap_sg =		pa11_dma_unmap_sg,
-	.sync_single_for_cpu =	pa11_dma_sync_single_for_cpu,
-	.sync_single_for_device = pa11_dma_sync_single_for_device,
-	.sync_sg_for_cpu =	pa11_dma_sync_sg_for_cpu,
-	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
-	.cache_sync =		pa11_dma_cache_sync,
-};
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 8d3a7b80ac42..5c8450a22255 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -97,14 +97,12 @@ void __init dma_ops_init(void)
 		panic(	"PA-RISC Linux currently only supports machines that conform to\n"
 			"the PA-RISC 1.1 or 2.0 architecture specification.\n");
 
-	case pcxs:
-	case pcxt:
-		hppa_dma_ops = &pcx_dma_ops;
-		break;
 	case pcxl2:
 		pa7300lc_init();
 	case pcxl: /* falls through */
-		hppa_dma_ops = &pcxl_dma_ops;
+	case pcxs:
+	case pcxt:
+		hppa_dma_ops = &pa11_dma_ops;
 		break;
 	default:
 		break;
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index cab32ee824d2..4ad91c28ecbe 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -19,7 +19,6 @@
 #include <linux/gfp.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/pci.h>		/* for hppa_dma_ops and pcxl_dma_ops */
 #include <linux/initrd.h>
 #include <linux/swap.h>
 #include <linux/unistd.h>
@@ -616,17 +615,13 @@ void __init mem_init(void)
 	free_all_bootmem();
 
 #ifdef CONFIG_PA11
-	if (hppa_dma_ops == &pcxl_dma_ops) {
+	if (boot_cpu_data.cpu_type == pcxl2 || boot_cpu_data.cpu_type == pcxl) {
 		pcxl_dma_start = (unsigned long)SET_MAP_OFFSET(MAP_START);
 		parisc_vmalloc_start = SET_MAP_OFFSET(pcxl_dma_start
 						+ PCXL_DMA_MAP_SIZE);
-	} else {
-		pcxl_dma_start = 0;
-		parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
-	}
-#else
-	parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
+	} else
 #endif
+		parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
 
 	mem_init_print_info(NULL);
 
-- 
2.17.0
