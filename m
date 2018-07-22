Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EBEECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E51520858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E51520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeGVKWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 06:22:15 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35711 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbeGVKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 06:22:15 -0400
Received: by mail-vk0-f67.google.com with SMTP id p12-v6so7945267vkf.2;
        Sun, 22 Jul 2018 02:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFTb19kZR4E3t+QGqDRIhZKMW1Hv0QDgz1JujwutnXc=;
        b=qTR6fqUDeuZcekfRDhYfUxbLqrsgYWfN8VvUvYX8fIL1kKKQPp5MFQ+yFmG9KgbcFe
         1bqEtCWhdYWzDj9gpHcUrS/3p7qrenhdtD3Gq3xSd9xZuB1MD4W9TOIAo9oyty0Lags+
         PluHk9wXuzmLY0S1sSF5DFjwymTSdijX1pyEFXFtQPYYeTR64zkyOUm29ic4hRh3db3P
         nKjkTAIqBvt9oToMFdtaQBQjChEZhzqZALujQ9DF6YYM+TG6nuSPJIa7jyhB5pCmfhlU
         9qXp0n7G4yusw56G6UNwhSDGnvGSQxwEOhaTC0iywOMG+8ji3QPyLAFfOSuVsmJRTnj3
         hYbA==
X-Gm-Message-State: AOUpUlE/AArh1r5d4qzEhZGBUWN7E3h6lAkAweaw4R0jAM1UwYZJJTLv
        XW9c05y9bX897nrcfm1a6UGrNUlG3tXC8dZ0VzI=
X-Google-Smtp-Source: AAOMgpfVozN1RLKEy7HdT3yyIRpIscXCycusGtA2afcQQ0xQfpWVYapoeQuAOUtmHGO34kHAJiypusADjw8W/7Rw8Zw=
X-Received: by 2002:a1f:9cc4:: with SMTP id f187-v6mr5041326vke.87.1532251570847;
 Sun, 22 Jul 2018 02:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
In-Reply-To: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 Jul 2018 11:25:59 +0200
Message-ID: <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC hexagon

hexagon != H8/300 != SuperH

On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
> to unsigned long to match the function parameter type.
>
> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/hexagon/kernel/dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20180717.orig/arch/hexagon/kernel/dma.c
> +++ linux-next-20180717/arch/hexagon/kernel/dma.c
> @@ -47,7 +47,7 @@ void *arch_dma_alloc(struct device *dev,
>                         panic("Can't create %s() memory pool!", __func__);
>                 else
>                         gen_pool_add(coherent_pool,
> -                               pfn_to_virt(max_low_pfn),
> +                               (unsigned long)pfn_to_virt(max_low_pfn),
>                                 hexagon_coherent_pool_size, -1);
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
