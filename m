Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4D1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C0225A08
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mZNY1WKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C0225A08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753759AbeGBWCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:02:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeGBWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QnHmp/XNUOrkY9QAsBCbJ8ir/k7wB9p3iU+Jp2xCJMU=; b=mZNY1WKMx31KAvN9qKYkOP5x0
        T4Q5TuZZtoYJDpchUSIxA9JrD94mXHoqOJQ44NgpOUWB/4uRsoI6kPXsnsD3OyDZEwzVtw1cCZMhj
        4yrMulSKNE789oseX4TMkKbfLRi5q1f5jx7ZEzu3p+CSrI5pIwf5lXh11RY2C5grGKWA4N9gG9gPB
        NYf3Q+xVaRa18tOe8QiiJsZGK5orHn224eOAFlF04qH6TkvjqzRdT0Sr5y2LMaaxYCaAOh/ZVpPg0
        TgBR5gCjQLtjCRks1IcieM3kHz2zvaAh6NbMdXE/jkBS4TanVxLRzyfwu0XqKjpi5mfRIoKTaKp2p
        /ETVb6FLg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa6uE-00065r-2a; Mon, 02 Jul 2018 22:02:46 +0000
Subject: [PATCH] Kconfig: menus: add PREEMPT options back
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-4-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ccf301c1-366c-4af5-54c7-36ddd4e33c52@infradead.org>
Date:   Mon, 2 Jul 2018 15:02:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702144711.22111-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Looks like the PREEMPT symbols from kernel/Kconfig.preempt were
lost, so add them back.  Otherwise some of the RCU options are
set differently than they should be.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180702.orig/init/Kconfig
+++ linux-next-20180702/init/Kconfig
@@ -332,6 +332,7 @@ config AUDIT_TREE
 
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
+source "kernel/Kconfig.preempt"
 
 menu "CPU/Task time and stats accounting"
 

