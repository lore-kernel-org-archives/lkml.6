Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04560C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9892088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MgGL/qTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9892088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeGYMtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:49:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbeGYMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SiNG9uk2Fm1Y8AilLDJsQ+SucfVMvTyV5FkdWQ1r70w=; b=MgGL/qTlZdO0swlXoRdoCj0Gj
        PbzoMGPEcCVpqCkT5rMBJwlHFdlNeuRcljpVuu1JhSABIJavaXbCkdKq00Z+ZoGbqnBIXGMNThgIy
        ztDN8ZZHkCP08UYmeyunT4UwTPb1xWeh5GjpzQbPO54LKwS+ImgrePDvRpTzm1rUnHXpx+pMx8PN9
        9Rra2zWck/IvwTdDhbqqIZ2gvHGyoQ+429C1beD+4IciECTBzJvApasKj9FuEPY80MpJUPLugJvhn
        kcVrNYPQ4pIQ9GIuEgHxKEQkfGCxChNONqaq8vBhi1BpunY1pyZFkEZmBxYwubVVVuSzcNalolopm
        xWMk5Bjng==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiI7U-0006om-UR; Wed, 25 Jul 2018 11:38:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] swiotlb: mark is_swiotlb_buffer static
Date:   Wed, 25 Jul 2018 13:38:00 +0200
Message-Id: <20180725113802.18943-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 1 -
 kernel/dma/swiotlb.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 965be92c33b5..7ef541ce8f34 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
 #endif
 
 extern void swiotlb_print_info(void);
-extern int is_swiotlb_buffer(phys_addr_t paddr);
 extern void swiotlb_set_max_segment(unsigned int);
 
 extern const struct dma_map_ops swiotlb_dma_ops;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 03016221fc64..5555e1fd03cf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
 	max_segment = 0;
 }
 
-int is_swiotlb_buffer(phys_addr_t paddr)
+static int is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
-- 
2.18.0

