Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E2FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3459620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l4TwRe8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfANLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfANLYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q5jcPUycwd0PXCcz2/cgqKIdp9jkY+nLz8sObNmDVnE=; b=l4TwRe8mhPu2NMzvmn3AZgmtKR
        shruT8GqkIK+kR/4KVpRXNwL4AHD5lqkV+zOcIXmriPEXooUXZevTdWuc/6MJHhncrGhLL5E90D9Q
        CggxlXTQu2pDQmOqoyJmbqM85W47M24I6hJd38Bptmx9QAzQ2SzX+ysB5FS/VTYqCyiihCo/ZbOqx
        Y9Ddhy1+TPo0cmAD/eADo+2u/ASkGdJn3ef0CWSHDEtmv/a/Nj5+Zl09lSDYuq2a7YSb6niFWyf2Z
        +oA2+aM8EnBGKswBL3XD5Hk6vr4ixiuE8hzDQQLW9WhQCB/2QjJP7rgRTKkq75ODeL8jGU3M9pIeA
        kK6m/Wbg==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0LW-0006oT-LT; Mon, 14 Jan 2019 11:23:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] parisc: don't include <asm/cacheflush.h> in <asm/dma-mapping.h>
Date:   Mon, 14 Jan 2019 12:23:46 +0100
Message-Id: <20190114112353.30616-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114112353.30616-1-hch@lst.de>
References: <20190114112353.30616-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for any of the definitions here, all there real work now
happens out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/dma-mapping.h | 2 --
 arch/parisc/kernel/setup.c            | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index 44a9f97194aa..f1bf5e297f1c 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -2,8 +2,6 @@
 #ifndef _PARISC_DMA_MAPPING_H
 #define _PARISC_DMA_MAPPING_H
 
-#include <asm/cacheflush.h>
-
 /*
 ** We need to support 4 different coherent dma models with one binary:
 **
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index f2cf86ac279b..15dd9e21be7e 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/sched/clock.h>
 #include <linux/start_kernel.h>
 
+#include <asm/cacheflush.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/pdc.h>
-- 
2.20.1

