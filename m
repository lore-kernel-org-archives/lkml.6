Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526990749-2-13866905423418316543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990749; b=LqM0D6RdjXaKWX8sPltDOQCwKjHuA9PrqyEQsizO1ilNtm4PUt
    Rz9TQZPJ1kDi8nph0uasJV1ZVTgXwOL9imLPRggMsJB+QXeTuPat/bDEoqnmG6EE
    /OoaOixU17pTYZF6oZEFQchEp8iWJyhWMS5HYuI47eYKwUaBBUxAQedkjL9SRKJ4
    J/evsDDOERj+hDrVPlUgxRZykVTe4O4pPhbum+la1PYRee9im3iu/3Q3B75tiL2u
    e8q2+5jxu+BwsUxYHvu1blrKsTuypALpjinAlx3v/ABpOf7MFrzY3NcU+Df60SBp
    5aExRPate7VdWaJ1lPdkTxsGKujDYQC+lkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526990749; bh=
    I7fdWZ5BunyQv13JTRTgi1TAo1wFA0ixDUrNCLTW878=; b=TyEnP6mEAURV2jT/
    C8zMz/2rhy9UhiD/ShkBqmmB5+KwyC9iha+EDeS4Vdq/KVaaG8njDl8PlRqzcP89
    uIu/UVo1SHthBBGTJSYRM1yIeGsV5Nm4gnMjXJNUYeR9tF572AI83Jz7NbvyzbPM
    nrLxTqlemtVthlBnwJRoac5fShLA9TvYi94EjD5l1MM7hEkRpCwi38ejzizbtRLD
    wQq7ZVC5m3QjvA0xrbEmEN0TRxVUmfSPhcs+WP4TCa5GDXfLhcom71LUxLzO2NNa
    5c3860ZwvAACOUiHvU8zyYhOEJgAUtTInzw0GTUyd8dol0oGrrrz7GpdeTa/q1t2
    V+SI7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=bG1Rr5tm
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=bG1Rr5tm
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
X-CM-Envelope: MS4wfJFd2dJ7T/C6ReXKrHBcrcS9wbb4xkR23/PPgfQaDuZut4q8U55oHAMbFK3zvmV/tu8eZNn1WALJ7T/BVCKl/lPNDevle2Ae1EKJIlYYV0Qj8fGQ725S
    Dk4oyU2ermmjwQmvh49xNVRMpmSZ4JgjZewMx3lW1HUbQ6g6DDolvh9N3sKCdHjBPurMw7D1zsNEbQNn6iA+Opj9UsP+G3l++VJxyZMRdF9c5Jgx19UcJejz
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=nFD_sOaFejjMYs_gdHAA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeEVMFq (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:05:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeEVMFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:37 -0400
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
Subject: [PATCH 14/25] openrisc: fix cache maintainance the the sync_single_for_device DMA operation
Date: Tue, 22 May 2018 14:04:19 +0200
Message-Id: <20180522120430.28709-15-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cache maintaince in the sync_single_for_device operation should be
equivalent to the map_page operation to facilitate reusing buffers.  Fix the
openrisc implementation by moving the cache maintaince performed in map_page
into the sync_single method, and calling that from map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 42 +++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 7cadff93d179..d6a0bf1fa713 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -133,19 +133,15 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-static dma_addr_t
-or1k_map_page(struct device *dev, struct page *page,
-	      unsigned long offset, size_t size,
-	      enum dma_data_direction dir,
-	      unsigned long attrs)
+static void
+or1k_sync_single_for_device(struct device *dev,
+			    dma_addr_t dma_handle, size_t size,
+			    enum dma_data_direction dir)
 {
 	unsigned long cl;
-	dma_addr_t addr = page_to_phys(page) + offset;
+	dma_addr_t addr = dma_handle;
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return addr;
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
@@ -168,6 +164,20 @@ or1k_map_page(struct device *dev, struct page *page,
 		break;
 	}
 
+}
+
+static dma_addr_t
+or1k_map_page(struct device *dev, struct page *page,
+	      unsigned long offset, size_t size,
+	      enum dma_data_direction dir,
+	      unsigned long attrs)
+{
+	unsigned long cl;
+	dma_addr_t addr = page_to_phys(page) + offset;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		or1k_sync_single_for_device(dev, addr, size, dir);
 	return addr;
 }
 
@@ -187,20 +197,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_sync_single_for_device(struct device *dev,
-			    dma_addr_t dma_handle, size_t size,
-			    enum dma_data_direction dir)
-{
-	unsigned long cl;
-	dma_addr_t addr = dma_handle;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	/* Flush the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBFR, cl);
-}
-
 const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
-- 
2.17.0
