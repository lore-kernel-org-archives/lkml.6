Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473873-1526991275-2-14349065683534602058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526991275; b=O0xN1k2leKOz5RdeQoJ1mnqh2G2OqSbVmciesXG55toz7kivy6
    DBIoHNQhJUWkWv5nA5VuHGBrlpUPVW3Lo4mao+Vw8jrPOWQ6Sy/P76D10ne2vb3f
    sYQPfIUgGXo926adpl2K+w/fjU77V68rnywDZAz+8c7AYpOHpBf1LRa+v//NoAI9
    xSE/wvwDWP6wh4kbiuAHLPyHg0I00P0l5+ePt2Ywqh7wOtYrFg2le5Hi1yLHlhwX
    2Eha0RGIpNlZMiI32j2ioXn8kVJ4u3POzPxSEQgDGvJbJk7sgoohZiOm+AeGDics
    jxkZ2jQ10vyE/YMAgQrRLiN8ddfXUQAZyaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526991275; bh=
    QFea48ZvlA06Tepz098VbrGCogp//lKYPIEzbhGFTS0=; b=HHNVOiMZhANlyMNy
    fzC2Zvzy8gUiQ7NlJyBI1pGrkFdHuZ7Rq3fyObk94Glovtn+D0RIoUb9zK5X6W18
    gF4vFCcim1VLMm+Zfvgj5x+m1NNFY8oC8cLcTM2HlgztDKHTXb1dZeB4aj9AZ35o
    FFZpt2p7J/S8A0ETZAg530KaFI65jmwuH+fw32GR3WPrqdOVpVzdOA+cgcgDmdnC
    P3Cixjlat3DBtt34BFsO/uCy9X2tFdy8C4hIvhl1jU2elkyakr4J964I0rDTxDjp
    Ga2ZCRVHHDpNuOcaGRvYR1ZxrMzykFmi1+XSYLDtOs08h90jIZkwcxpLyRfKP7xX
    chLmUA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=nISrH7T2
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
      header.d=infradead.org header.i=@infradead.org header.b=nISrH7T2
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
X-CM-Envelope: MS4wfOuOx02FOnU80iVE6L76w/jbcRXtIEC+59xrjGumF2Ro04Uk9wCaTJYV8RSjug5mEQ95qXaFB8SMT8Zw+R9cZOZ+2EJRHoB/DTFLEbEmGrD0jRIyDGha
    DCMLRH0GQ0CE75T7cgH2yPd1pPB+zNC/8R1Uv2oPR4KHVinzRiGxy5bIyjd9d/1GBzICP2RTiVi0DVcxbTF8gAAzM6GeCdywjHYJucLeLbUr7bnMmItffI5A
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=kPNvON0MrPcPl8848voA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEVMOc (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:14:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeEVMFm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:42 -0400
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
Subject: [PATCH 16/25] sh: simplify get_arch_dma_ops
Date: Tue, 22 May 2018 14:04:21 +0200
Message-Id: <20180522120430.28709-17-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove the indirection through the dma_ops variable, and just return
nommu_dma_ops directly from get_arch_dma_ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/dma-mapping.h |  5 ++---
 arch/sh/kernel/dma-nommu.c        |  8 +-------
 arch/sh/mm/consistent.c           |  3 ---
 arch/sh/mm/init.c                 | 10 ----------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 41167931e5d9..149e71f95be7 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -2,12 +2,11 @@
 #ifndef __ASM_SH_DMA_MAPPING_H
 #define __ASM_SH_DMA_MAPPING_H
 
-extern const struct dma_map_ops *dma_ops;
-extern void no_iommu_init(void);
+extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return dma_ops;
+	return &nommu_dma_ops;
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 3e3a32fc676e..79a9edafa5b0 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -79,10 +79,4 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 #endif
 };
-
-void __init no_iommu_init(void)
-{
-	if (dma_ops)
-		return;
-	dma_ops = &nommu_dma_ops;
-}
+EXPORT_SYMBOL(nommu_dma_ops);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 35ea3099a3b6..221832eec33b 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -20,9 +20,6 @@
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
 				 unsigned long attrs)
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..32e09f03e6bf 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -395,22 +395,12 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-/*
- * Early initialization for any I/O MMUs we might have.
- */
-static void __init iommu_init(void)
-{
-	no_iommu_init();
-}
-
 unsigned int mem_init_done = 0;
 
 void __init mem_init(void)
 {
 	pg_data_t *pgdat;
 
-	iommu_init();
-
 	high_memory = NULL;
 	for_each_online_pgdat(pgdat)
 		high_memory = max_t(void *, high_memory,
-- 
2.17.0
