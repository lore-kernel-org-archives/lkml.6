Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F30C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0B021780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="puNjWpF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0B021780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeKNS0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbeKNS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q8shXA+ccAxgPpr+2652jWyzRdInsknrVFfhPeaPFlc=; b=puNjWpF7uPzrJ64htqV/7TvHFL
        slo3xM4iwU15fstg+Ywihl/Vc4O3GXQW9B+zDm2XKgDt0hbtIndsmtROjfbrIP8knJLOQRlVq3gQ1
        Cq541vbvybg8PekOFo8xMAzmqw9Mmn1qmUpiR4We5R1oPApfx/D2GplPJQSHZTifGn7QW/dLYMI3n
        nwhSNIFrOxT7DHlZWLe+hjTgMeTVWpBAE5cM4KjCZ5TWuwOEqjYWxBoqNcHqvMTogsznkdgLa1qcJ
        ebXc0MDkTLmYeUuPVK1VsW53aC3Yi7dXIwRUSGgmANtUdbx5D+9GiM3pSMivpDwqpaBNbiiKjC3Wq
        pOuIEC2A==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSQ-0004mj-0O; Wed, 14 Nov 2018 08:23:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/34] powerpc/dma: remove the unused dma_iommu_ops export
Date:   Wed, 14 Nov 2018 09:22:45 +0100
Message-Id: <20181114082314.8965-6-hch@lst.de>
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
---
 arch/powerpc/kernel/dma-iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index f9fe2080ceb9..2ca6cfaebf65 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -6,7 +6,6 @@
  * busses using the iommu infrastructure
  */
 
-#include <linux/export.h>
 #include <asm/iommu.h>
 
 /*
@@ -123,4 +122,3 @@ struct dma_map_ops dma_iommu_ops = {
 	.get_required_mask	= dma_iommu_get_required_mask,
 	.mapping_error		= dma_iommu_mapping_error,
 };
-EXPORT_SYMBOL(dma_iommu_ops);
-- 
2.19.1

