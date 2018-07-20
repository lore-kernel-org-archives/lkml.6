Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XT8iD52l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5294920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbeGTRFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:05:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbeGTRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/hCaKrGcwlM/RMUZgDXtXvLke0J6eGhaagHu7P9kYkQ=; b=XT8iD52lvoFrYuPFcNwuDHOTM
        /GvlNUUSuxU6kPM/6Eo0aN6VEl0I6SMS6uspYvvlaHBEYRGohDDpqkiCmU+v12qcRjIvHlRtOyNpG
        z6cBC1hPBrR6Xj/gFOQ40tT6hgj4Fj0s3oZu8U+hAOv4QL6nrGjgZX8+tK9wnO5R5hHvK3j3N/BAK
        Wbxy+PrB3xBqTN3quUDvnCgcNMXs5B0nXXppI4+e18YSbsCTsnE+KtTuij+Jt7J8x6uvM59i5TNxn
        Z3xLmwCbusbmBy0cQllNjyZtLfHGLr3CbHWCVS7nZzylgTW/XyWfQtDh4dfzrCxhTTBqI9WDemNJX
        zHBgMXjDg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgY4b-0000Zl-0k; Fri, 20 Jul 2018 16:16:05 +0000
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] net/dsa/realtek: add MODULE_LICENSE()
Message-ID: <3502c393-e098-241b-c361-4e5069486d71@infradead.org>
Date:   Fri, 20 Jul 2018 09:16:02 -0700
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

Add MODULE_LICENSE() to net/dsa/realtek.o to fix build warning message.

WARNING: modpost: missing MODULE_LICENSE() in drivers/net/dsa/realtek.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek-smi.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180720.orig/drivers/net/dsa/realtek-smi.c
+++ linux-next-20180720/drivers/net/dsa/realtek-smi.c
@@ -485,3 +485,5 @@ static struct platform_driver realtek_sm
 	.remove = realtek_smi_remove,
 };
 module_platform_driver(realtek_smi_driver);
+
+MODULE_LICENSE("GPL");


