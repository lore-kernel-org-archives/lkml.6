Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B76BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60482086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nmr1zGGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405176AbfBMSa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:30:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405168AbfBMSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a/h0QpKiDchGJGYpwjpTzAR3rTKHFC5hPoy7o+oXGlU=; b=nmr1zGGr7s4Hl4zp0ZNtu6yN5I
        ulC4mihUVGYqS2+LydG2MyX3tX2s+jpusKW1vQPr/gMQwHfhA1CgIzPZO38NQpFOG42ahc6etgB3D
        li+0knsGm0GulutCCbGvsexmnLoyVAs7sFZx61JLZbnKcKmpTQe9GiO6VOlZED2ujwlj5nXpLacfk
        iiksjbK1RcMVlV4BKrvI0A4rhCz8LpJLTVGthClaAkkVRLsq4X+BBJlhPETYeLpaUqmv/iQcqILg3
        lB39zl+1hUotv1GI62RcR6jpqiqrY8aWxVTJYOSrH30/y5RfgT1BH+03fljj/X1BJpUtkyIxiDI4M
        8q19zw2w==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzIW-0001M0-Fq; Wed, 13 Feb 2019 18:30:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/21] arm64: trim includes in dma-mapping.c
Date:   Wed, 13 Feb 2019 19:29:20 +0100
Message-Id: <20190213182920.16764-22-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With most of the previous functionality now elsewhere a lot of the
headers included in this file are not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index ad46594b3799..cfa084bca3ea 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -5,20 +5,9 @@
  */
 
 #include <linux/gfp.h>
-#include <linux/acpi.h>
-#include <linux/memblock.h>
 #include <linux/cache.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/genalloc.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/dma-contiguous.h>
 #include <linux/dma-iommu.h>
-#include <linux/vmalloc.h>
-#include <linux/swiotlb.h>
-#include <linux/pci.h>
-
 #include <asm/cacheflush.h>
 
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
-- 
2.20.1

