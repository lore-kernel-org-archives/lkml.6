Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB03ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29E820652
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 03:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5GdVopH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29E820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeGUEIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 00:08:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46542 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeGUEIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 00:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IfrtzSekLaMORf7Bv7r+0EGDSBaP9Az0QB/7B2qghOs=; b=S5GdVopHXkIQQhpaIfV9sBU19q
        5WvjMTtTk5elUGsASXO9/KWvhmo5NTLb1GQH7j8ZpD+I7mfEixtQYd9wJDq2Lwud21jx9cQpziez+
        hm9CQp542fOMOUtkrouhaZ8WsuzEbO+H7Qqw3Ucsr3A8jS3PbaRWvW8lelrAVuVe+nhk274loyapV
        lL6B5rwaj9NyjgZ8d/x8cVMEZJQ3ohNqBVdGN4ePc6U0xP2Yc2qEvYWvV7aoZVipUQUVYjq67ATFg
        UQGH4/0RZq7OIp1W+lUoDhBx5603dFkSrKMkiLzlPehswzNRPtOBRk8iesgDKOtYgaJl7ArTuz8DP
        WDerOYgQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgiOn-0001N8-9q; Sat, 21 Jul 2018 03:17:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/h8300: fix kernel/dma.c build warning
Message-ID: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
Date:   Fri, 20 Jul 2018 20:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
to unsigned long to match the function parameter type.

../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/hexagon/kernel/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180717.orig/arch/hexagon/kernel/dma.c
+++ linux-next-20180717/arch/hexagon/kernel/dma.c
@@ -47,7 +47,7 @@ void *arch_dma_alloc(struct device *dev,
 			panic("Can't create %s() memory pool!", __func__);
 		else
 			gen_pool_add(coherent_pool,
-				pfn_to_virt(max_low_pfn),
+				(unsigned long)pfn_to_virt(max_low_pfn),
 				hexagon_coherent_pool_size, -1);
 	}
 


