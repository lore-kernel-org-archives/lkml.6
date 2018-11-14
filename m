Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED16C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AC821780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zd5rbN5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AC821780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeKNSZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:25:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbeKNSZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vk/qNNd2VzibZxB9SX2CyrNhZuyQw/rjQRxAbyGxTQA=; b=Zd5rbN5xX7HGsoRHS1BXzsQYTQ
        vmVTNDhnzz+fSnHCXn3BP08bSMuEJ4btcuMIdDuviqPMAM2QioBThrLnLZBusX23ZbugAvMHdNsyo
        hrwIW9J4J6j/n6ECgIJx5S9q6Ut/RRf8HAybH9C4iNUDJTvaDh68emR3QViffJDplYBNQ1+zdJVBQ
        10B5WHaZFuV8QiJFjUFh/WBThXuX38v+8eWNMrC3wTh6/ljMQSC3gFvS7FWWlJX/z5314PUu5cfPq
        bTV7pQbI5oJhoqI3W+B8lJIzhsNpQQx4xo5r//VjRdLXCzhFefOBtg0/CGlpqhe0YfB6iFoZBHEdQ
        uE5dbTcg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSK-0004hz-IN; Wed, 14 Nov 2018 08:23:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/34] powerpc/dma: remove the unused ARCH_HAS_DMA_MMAP_COHERENT define
Date:   Wed, 14 Nov 2018 09:22:43 +0100
Message-Id: <20181114082314.8965-4-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa394520af6..f2a4a7142b1e 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,5 @@ extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
 extern u64 __dma_get_required_mask(struct device *dev);
 
-#define ARCH_HAS_DMA_MMAP_COHERENT
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
-- 
2.19.1

