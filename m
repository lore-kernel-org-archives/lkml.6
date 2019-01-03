Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE53C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD79621871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t2Tv1PPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfACBPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:15:21 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:24115 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfACBPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:15:20 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x031F6lb024330;
        Thu, 3 Jan 2019 10:15:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x031F6lb024330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546478107;
        bh=2DVQDr+aD+0VLaeBKK6w8wSA17HEHSfgvk8NIpnsmCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t2Tv1PPN6FB8qQt+ddI6cFnWBPMm7eH2p2pELtn184+JcjronwYX+uiveuFgvgrBS
         8cv+Fw1CCzh6gCA36neeJvUhsxfvOuVkf3NxFNfXnhAYlvvGYGh4vtwdD0mEd2Afdi
         88s5yruvDIhvqfGgdTZbv2XlUA+A9pT0ccoLoBjKpybZ3Ts8lV+jAqsYVyzkiSEpCV
         ZsBt95Kuy06404qr+fclYkRBhtMOJOUNJRy7QZ/KNgJg5RJsYwbdCRZH+P3pwVR2Gd
         +WQ8moNTgAKKwDRawbwEqSq0Mdl/ElG1nKWd2K39cy/W2FewSS1KCdOi/KyDL2ShkA
         v82E1naS9wVkg==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id b18so6951010vke.2;
        Wed, 02 Jan 2019 17:15:06 -0800 (PST)
X-Gm-Message-State: AJcUukflI2HtTL0aGBIFwPuNPIbNEm1eF2WGOOGYPG4AxCdGo0eCYhu2
        9UnwC+GQvkq4ua+ZNEizV6Qp8OSpcmFGUi6a42A=
X-Google-Smtp-Source: ALg8bN42y91XwNYFmQdZirPJAneKADVm0odMeUQ1r9XPzVibehNM/6H18qhJCcMqDbUMobwZjhCaV0sykpqCfUIQdTw=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr16095908vkb.34.1546478105746;
 Wed, 02 Jan 2019 17:15:05 -0800 (PST)
MIME-Version: 1.0
References: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com> <1546244651-10447-4-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546244651-10447-4-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Jan 2019 10:14:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThpS+W_aUr3V9EN7V5A67mjvhOWAU1XZGDvS4ByBfeVg@mail.gmail.com>
Message-ID: <CAK7LNAThpS+W_aUr3V9EN7V5A67mjvhOWAU1XZGDvS4ByBfeVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: make LINUX_VERSION_CODE in <linux/version.h>
 more readable
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 5:25 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Makefile does not need to calculate LINUX_VERSION_CODE.
> Let's leave it to the preprocessor.
>
> This commit changes include/generated/uapi/linux/version.h as follows:
>
> Before:
>
>   #define LINUX_VERSION_CODE 267264
>   #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
>
> After:
>
>   #define LINUX_VERSION_CODE KERNEL_VERSION(4, 20, 0)
>   #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
>
> The latter is more human-readable in my opinion.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


I retract this patch
because it would cause a build error.




> ---
>
>  Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 437d603..1ebf5ed 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1131,8 +1131,7 @@ define filechk_utsrelease.h
>  endef
>
>  define filechk_version.h
> -       echo \#define LINUX_VERSION_CODE $(shell                         \
> -       expr $(VERSION) \* 65536 + 0$(PATCHLEVEL) \* 256 + 0$(SUBLEVEL)); \
> +       echo '#define LINUX_VERSION_CODE KERNEL_VERSION($(VERSION), $(PATCHLEVEL), $(SUBLEVEL))'; \
>         echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'
>  endef
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
