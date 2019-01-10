Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8153DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ECD21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bF1Z7Je2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAJCBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:01:49 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:41254 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfAJCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:01:48 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x0A21Qco025112;
        Thu, 10 Jan 2019 11:01:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0A21Qco025112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547085687;
        bh=DKoDKvyK76QTjdnpbM9U16qtvJDLW6WtXVdR6h9x+Zk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bF1Z7Je2DXVZLDH76bNDxKmpcT7MDtiuZf9If13f9/q+2+HvV7hAmC41pMkRNHm9E
         GFZqxuPhKSLTbz5UUY8m91RQd+oj6uzaH83QQcziC+nT95LOBeZf8eDTibUsWo3UyF
         iZ6fWChmikR3hjL+S3sF+YRvVSYyCavVoO06fR9XySjOxy9Lw5N1UNjDaSfH6OPKOW
         uJgJRC8mARNBTWdbFi9uJ2vt55e8/rU7B82waUp1wyWryjD5PXswO49L3f8nPxiR16
         MM5u4TgEtf66qMAXfrwrvSbx5WhzRUV90s52iegOlYRLIyQIx3n8JGEBgKfZ/ntVGP
         a3POe3yfW0mVw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id x64so6062548vsa.5;
        Wed, 09 Jan 2019 18:01:26 -0800 (PST)
X-Gm-Message-State: AJcUukfjXbl3opNcQuCcAzJ9HOSQq/FyIM61Do4cfRUu1zkDbyqeVxzx
        rCq0VXLYDN82g0/0RyrKBDAiE4+XlqQWglFy9tI=
X-Google-Smtp-Source: ALg8bN4zxupc8ctlYFUcX68oMDNxCkAOZB5zYB16VdfHYnExVzVFTfeTWK7jOq9PXtCqMadn8yK0jIFuY+CCl8w43pE=
X-Received: by 2002:a67:a858:: with SMTP id r85mr3391514vse.215.1547085685569;
 Wed, 09 Jan 2019 18:01:25 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdUw9LMVb-8RSNVBEcDMVB9SFOdfF+kb20=gxJiWF1x8sQ@mail.gmail.com>
 <20190109231539.24613-1-paul.burton@mips.com>
In-Reply-To: <20190109231539.24613-1-paul.burton@mips.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 10 Jan 2019 11:00:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReiEzF1nS8WR_yUmi-boJnfLWw5bjUvL2rDEAYnxwCzw@mail.gmail.com>
Message-ID: <CAK7LNAReiEzF1nS8WR_yUmi-boJnfLWw5bjUvL2rDEAYnxwCzw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace
 & GCC <= 4.7
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 8:16 AM Paul Burton <paul.burton@mips.com> wrote:
>
> When building using GCC 4.7 or older, -ffunction-sections & the -pg flag
> used by ftrace are incompatible. This causes warnings or build failures
> (where -Werror applies) such as the following:
>
>   arch/mips/generic/init.c:
>     error: -ffunction-sections disabled; it makes profiling impossible
>
> This used to be taken into account by the ordering of calls to cc-option
> from within the top-level Makefile, which was introduced by commit
> 90ad4052e85c ("kbuild: avoid conflict between -ffunction-sections and
> -pg on gcc-4.7"). Unfortunately this was broken when the
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION cc-option check was moved to
> Kconfig in commit e85d1d65cd8a ("kbuild: test dead code/data elimination
> support in Kconfig"), because the flags used by this check no longer
> include -pg.
>
> Fix this by not allowing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION to be
> enabled at the same time as ftrace/CONFIG_FUNCTION_TRACER when building
> using GCC 4.7 or older.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: e85d1d65cd8a ("kbuild: test dead code/data elimination support in Kconfig")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: stable@vger.kernel.org # v4.19+
> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index d47cb77a220e..c787f782148d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1124,6 +1124,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
>         bool "Dead code and data elimination (EXPERIMENTAL)"
>         depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>         depends on EXPERT
> +       depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >= 40800
>         depends on $(cc-option,-ffunction-sections -fdata-sections)
>         depends on $(ld-option,--gc-sections)
>         help


Thanks for the fix.

I prefer this explicit 'depends on'.

Relying on the order of $(call cc-option, ...) in Makefile is fragile.

We raise the compiler minimum version from time to time.
So, this 'depends on' will eventually go away in the future.


BTW, which one do you think more readable?


depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >= 40800

    OR

depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)


-- 
Best Regards
Masahiro Yamada
