Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D2EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F48620854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgcZc9vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F48620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeKEVja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+yvg1Q6mtVSYriqEFYRpF4/kaMoZ8nCKYNicBxuEX/0=; b=PgcZc9vWPJD4U0FeA4HHrodBKx
        8TqTg0qYXvyureEcI24OpUtvbl14QxLg7yHzmAVBdRGDLcfwYAYUhz6y+G+ty3rOf4OIIl96UsTqA
        qQVq6JZo5zYw6oYPaCDB0nV3njeeseXLKKChp/Z+xX01Nl9/PKwyO6850VeFPmApbwkBBtJ0z2/TQ
        Xv//cTkR9gIc+aiMAG2ZvBwB64stvi7OV9+nvq0fsfrChWK8H3A9nGGXwAP694Oa45kcYd3izkO9P
        4CpYCzPfCH456/oVWm6vhhVfEyuDf80ZdQmNV9AgHMl9YThDRGBCSdzDeAs0VNDKSMdEn4l83GeJM
        dMQc5z+w==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdrH-0003iZ-7N; Mon, 05 Nov 2018 12:19:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] csky: don't select DMA_NONCOHERENT_OPS
Date:   Mon,  5 Nov 2018 13:19:29 +0100
Message-Id: <20181105121931.13481-8-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is gone past Linux 4.19.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8a30e006a845..c0cf8e948821 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,7 +8,6 @@ config CSKY
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select DMA_DIRECT_OPS
-	select DMA_NONCOHERENT_OPS
 	select DMA_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
-- 
2.19.1

