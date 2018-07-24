Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB240C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8321120844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPsa83ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8321120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeGXEpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:45:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388142AbeGXEps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3B/WbQ8hBZP3+9iX7EqmZhhuR4kBHCIaCgHIL3q9U/Y=; b=gPsa83agw7NvRePjiLXfPWMHL
        Wsf0nkAKWoGgru9nl+iFezsEssO28LBTiqHmzNI4znZBvSiQCV637rjt+IDD0xb9ZEfbjF7XydGze
        /r+UzUmyTtxutlg7xVUJa8TMlJjWmmGx5Li6oxDnpJ87Kokq38of+LqEGjo0ZgjlVjPo7/01gFqCx
        aOoq/bBsZS4u3NzFE+4BLMn2dqNUOfNL6yGJMic38wH9CViKvFuTXZPFfGxZhDnkuwzdr/GbvhMvi
        RQ2lNc/ysxfuK3IoqRXs196gwF99zRRsV2JMJMa3mfJxnF2oepty0TFGnGW4DtzIsT8w6x/tpRcUm
        grp05LgQQ==;
Received: from 177.41.135.13.dynamic.adsl.gvt.net.br ([177.41.135.13] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhoCP-0003y2-60; Tue, 24 Jul 2018 03:41:21 +0000
Date:   Tue, 24 Jul 2018 00:41:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] media: staging: omap4iss: Include asm/cacheflush.h
 after generic includes
Message-ID: <20180724004110.37d0e5dc@coco.lan>
In-Reply-To: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
References: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 23 Jul 2018 14:39:33 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> Including asm/cacheflush.h first results in the following build error when
> trying to build sparc32:allmodconfig.
> 
> In file included from arch/sparc/include/asm/page.h:10:0,
>                  from arch/sparc/include/asm/string_32.h:13,
>                  from arch/sparc/include/asm/string.h:7,
>                  from include/linux/string.h:20,
>                  from include/linux/bitmap.h:9,
>                  from include/linux/cpumask.h:12,
>                  from arch/sparc/include/asm/smp_32.h:15,
>                  from arch/sparc/include/asm/smp.h:7,
>                  from arch/sparc/include/asm/switch_to_32.h:5,
>                  from arch/sparc/include/asm/switch_to.h:7,
>                  from arch/sparc/include/asm/ptrace.h:120,
>                  from arch/sparc/include/asm/thread_info_32.h:19,
>                  from arch/sparc/include/asm/thread_info.h:7,
>                  from include/linux/thread_info.h:38,
>                  from arch/sparc/include/asm/current.h:15,
>                  from include/linux/mutex.h:14,
>                  from include/linux/notifier.h:14,
>                  from include/linux/clk.h:17,
>                  from drivers/staging/media/omap4iss/iss_video.c:15:
> include/linux/highmem.h: In function 'clear_user_highpage':
> include/linux/highmem.h:137:31: error:
> 	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible
> 	pointer type
> 
> Include generic includes files first to fix the problem.
> 
> Fixes: fc96d58c10162 ("[media] v4l: omap4iss: Add support for OMAP4 camera interface - Video devices")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/staging/media/omap4iss/iss_video.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
> index a3a83424a926..16478fe9e3f8 100644
> --- a/drivers/staging/media/omap4iss/iss_video.c
> +++ b/drivers/staging/media/omap4iss/iss_video.c
> @@ -11,7 +11,6 @@
>   * (at your option) any later version.
>   */
>  
> -#include <asm/cacheflush.h>
>  #include <linux/clk.h>
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
> @@ -24,6 +23,8 @@
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-mc.h>
>  
> +#include <asm/cacheflush.h>
> +
>  #include "iss_video.h"
>  #include "iss.h"

While I won't be against merging it, IMHO a better fix would be to
add the includes asm/cacheflush.h needs inside it, e. g. something
like adding:

	#include <linux/highmem.h>

at the sparc32 variant of it. Btw, ./arch/sparc/include/asm/cacheflush_64.h
seems to include linux/mm.h... So, I guess the right fix would
be something like:

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index fb66094a2c30..daeccbdc371a 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_CACHEFLUSH_H
 #define _SPARC_CACHEFLUSH_H
 
+#include <linux/mm.h>
+
 #include <asm/cachetlb_32.h>
 
 #define flush_cache_all() \



Thanks,
Mauro
