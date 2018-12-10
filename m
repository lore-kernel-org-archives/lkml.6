Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA684C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95FD20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/ujtq7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95FD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeLJVPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:15:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39358 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeLJVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:15:10 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so213165itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3TVMDzvf7NesvUIZPej8IInDcQsHDhk2sIidxJ8T1s=;
        b=i/ujtq7eIS1ndLedPAZHD3aCPFZ9KsUwfwoCESJ6xRSQEWzigU2IDhSqz/Zrv5dFWi
         WokAjcZPEyl8W7PI9vPogX1tSu74ssT1L/xJV4tLoeKnrx6X4CErXYi7aSWsLzD0AbPz
         YJAafOqtb8qnrvIzlvtveRNShVR7jq7kQSYOLA3l0rKdUbqE/hux9wkOYwAlHXaGXaOC
         h9gjPeOIRuLb1oV7Uj2kX6wpaiP6uoQ1GrzVp0vj/75741nLHY6RplZuSrLR9Q9dKnjN
         d97ZHPkrwwkSO7QDDQs3axwLgodo3zsxcxubG1aQlKcHrAd0ZlAe6RFiDW2mCiUqLs8M
         FH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3TVMDzvf7NesvUIZPej8IInDcQsHDhk2sIidxJ8T1s=;
        b=XgPBMrCqJGG/AzHGnuPLKCU4w80FMc32cJNC/AZhrR4v4cmZyz01HEoOu7elRKuQnB
         NF4JKWHtb3mRutnlRJlJXnzme2zoProW8nhWZMIkSuxOMkTc/GhKOQ+sGLFqfe73HphY
         WNGUZrMcX9sCg/vOXG19paE6YUjY0VjrETFRZGfkW/5f+2GbFu6aatTWEK8/BaRwQLJP
         F+WUEXyEKjweIFGpkt4P6dQFa1sw1RMngSqFXy5IfloLs6PnlZsRbKbTiAjOr1tkkasO
         xEqLF4fuA1wcSTKQVbFJ38DDzNyaS/oUo/pTus5EGGRFfRXM7XFcCLHt3/4pfZ+4bt3o
         /JqQ==
X-Gm-Message-State: AA+aEWaP5kf7x2CxZoTS5NPrkCXIel0UZupxekovFT49/BJdtngraquN
        Lshv316uo3x9VEOWOW5jqy5Qo3D96VycUNAQsQSMOg==
X-Google-Smtp-Source: AFSGD/Wh6fCK68+oEV74ecI17bJ+S0Y/SMykGYC4cf4Ah0gflIpdIqX6/4NFjEj8vEIExGOLAppQF6+v7WXx7LEqE7Y=
X-Received: by 2002:a02:93c2:: with SMTP id z60mr12367208jah.51.1544476508673;
 Mon, 10 Dec 2018 13:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20181210205929.3213516-1-arnd@arndb.de>
In-Reply-To: <20181210205929.3213516-1-arnd@arndb.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 10 Dec 2018 22:14:57 +0100
Message-ID: <CAAeHK+y_ySWM7NLsAvX7UzeBjYdofQHGgG_xbOMwX_pVsQJJKA@mail.gmail.com>
Subject: Re: [PATCH] kasan: add missing Kconfig dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, gor@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 9:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building with CONFIG_KASAN=y when neither KASAN_GENERIC nor KASAN_SW_TAGS
> can be selected leads to a build error:
>
> arch/arm64/mm/kasan_init.c: In function 'kasan_pte_populate':
> arch/arm64/mm/kasan_init.c:106:28: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function); did you mean 'KASAN_SHADOW_END'?
>
> We should really only allow enabling KASAN when all its dependencies
> are met as it was before the introduction of CONFIG_KASAN_SW_TAGS.
>
> Fixes: b8440cc16515 ("kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

Is this a patch against linux-next? The issue has been addressed by
v13 of the patchset, which is now in the mm tree and should end up in
the linux-next soon AFAIU.

Thanks!

> ---
>  lib/Kconfig.kasan | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index b5d0cbfce4a1..83286bca2f70 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -15,6 +15,8 @@ if HAVE_ARCH_KASAN
>
>  config KASAN
>         bool "KASAN: runtime memory debugger"
> +       depends on CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS
> +       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>         help
>           Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
>           designed to find out-of-bounds accesses and use-after-free bugs.
> --
> 2.20.0
>
