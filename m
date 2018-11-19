Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC3420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD1VVJKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC3420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeKSVxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:53:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeKSVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:53:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so6544412pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yu2CDws+nRMfSkSWbR7YP0+sDbSGiaSe/QV36BlkMmM=;
        b=aD1VVJKhSU13hqjCvOySUKPoQ6kD4UIYIN433Kz7s3BU/YTrFHFNVNrG+mQfxIntnl
         Z/q3lucaCXCKml5R6TufJeQgJttHrFtbjCUJbzCm/AoZyKKXCyGclbLnbc78rrnEcYk3
         3yPV8ZfB3wyuMUV7kB8vJ4Oc2eqrzyeb/JaV96cD5wzbqW3hV7mwjr/kgFYDIo6uXrJU
         Y2p8bZgkOOeVhy4RKO+2dMJ0EePp7tgGOu5iVTKaUn5A5tzfq9TkgRFCtWUeYVvP4NMc
         hw6Ao/Lhk4KmCPN5dsbZqHGZQHJJTIzVHZ1/NvDXf0rhwLCgY0g7pyXDZjlDKgwXH+Li
         aWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yu2CDws+nRMfSkSWbR7YP0+sDbSGiaSe/QV36BlkMmM=;
        b=DJiz2Qh7x27Okh2YvWcTWHTDEF7Pk/udRLrQWNLNZLRBV9jn8kJzAeisnIxKyIMx1j
         MTDaWXwx3rF18ldparFGmCWdqoU/eElLR9oXOR2zAnGflUNoZsqavmfkdjRmblenKqSS
         52FX9EUf0PxWishQwq7TVU8+yrKEsb4/uP+zJovhM/CeUSSEw7w4OXQVn9oy+b4YRr8U
         tonNZTJjbaAVLUVsYTIFszZOOYYTjLYwWKzduCQ0qwZ1r0jvODGjA5Nr8XKrXB9bQSR/
         xZAaq5mW1MdS6DdCsrfusCswCYnFY6Vx4J2ZYVLR+l7UMn5aHVIUJYmjIQw1qS3N+rK1
         AFvg==
X-Gm-Message-State: AA+aEWb/6dLqE3Ss+PSCSvIHGyykQ2nogNrznV+nMb+7bkO1uTdDA/tq
        omvnTHys7NpUAUNoZZa78Hk=
X-Google-Smtp-Source: AFSGD/VbHP+fdDXFSyX/XU/nTOmEZmmF5g28CBg7juhDQ3oRs8sZJ9H5qCPwJdU3y8VtbXKfBGL+4w==
X-Received: by 2002:a63:d818:: with SMTP id b24mr9999596pgh.174.1542626981952;
        Mon, 19 Nov 2018 03:29:41 -0800 (PST)
Received: from mail.google.com ([207.246.110.149])
        by smtp.gmail.com with ESMTPSA id f13sm19666640pfa.132.2018.11.19.03.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 03:29:41 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:29:36 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     yamada.masahiro@socionext.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openrisc: make function cache_loop() inline
Message-ID: <20181119112935.txuwqdaitsmnowaj@mail.google.com>
References: <20181114230856.30143-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114230856.30143-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yamada,
Could you add this patch to your kbuild tree? Horne already acked it.

On Thu, Nov 15, 2018 at 07:08:56AM +0800, Changbin Du wrote:
> The third operand of mtspr instruction must be a constant. To guarantee
> this condition, function cache_loop() which uses macro mtspr() must be
> inlined. So let's force it as 'inline'. This is to fix compiling error with
> new option CONFIG_NO_AUTO_INLINE.
> 
> In file included from arch/openrisc/mm/cache.c:17:0:
> arch/openrisc/mm/cache.c: In function 'cache_loop':
> arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
>                               ^
> arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
>       mtspr(reg, line);
>       ^~~~~
> arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/mm/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> index b747bf1fc1b6..4a4b2b6e006b 100644
> --- a/arch/openrisc/mm/cache.c
> +++ b/arch/openrisc/mm/cache.c
> @@ -20,7 +20,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  
> -static void cache_loop(struct page *page, const unsigned int reg)
> +static inline void cache_loop(struct page *page, const unsigned int reg)
>  {
>  	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>  	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> -- 
> 2.17.1
> 

-- 
Cheers,
Changbin Du
