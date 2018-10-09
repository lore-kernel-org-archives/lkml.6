Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4821479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGxUQllD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJIUqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:46:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeJIUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g770qJx2ODC0LvNyFrLPq9WG2MTi98G0QMTJr1eeeBQ=; b=JGxUQllD35wUfXqxSHIwA+orRm
        CFPVkpS9mbPtjCUVc+9xbf6+ffv6ajEaphZmcNYH+4561W/eLs6Bvr1kQ47JCpqZhsdap1G2P+QyH
        UAiMMeoEZw/rJbAErzE7+tfeY27A66dokl7X6QarLzlbjZkStu6PHxkZ9dY1bZNff2o+PHErllu0x
        fBtyCrd4JuCo3KRLAK6nNjfH503TErYCh+P77wzsu53Hz3NjnL3W/RO5N43Yk4IyxbiEGEFu5YB0Y
        IcAyZehRvryfZtzgAhDKTqakysayk/d01KqBe8rNIA7KVZYKHAGxAWuSi4qqdBTTMQ6UITGJ73s9x
        nOB1f6LQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9s0Z-0008V7-4A; Tue, 09 Oct 2018 13:25:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/33] powerpc/dma: remove the unused ARCH_HAS_DMA_MMAP_COHERENT define
Date:   Tue,  9 Oct 2018 15:24:29 +0200
Message-Id: <20181009132500.17643-3-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
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
2.19.0

