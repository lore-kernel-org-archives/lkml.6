Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965955AbeCAEVQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 23:21:16 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:56248 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965841AbeCAEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 23:21:11 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w214L5w0026566
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: AG47ELtbhH+kmbNCfPHifjhhKrIozdVH+NM7S/P+uZmvs4D5Nt6BSsNMkwmkL4IAnVyb+3A7vWQvSkxIxMSxpLQIcKU=
MIME-Version: 1.0
In-Reply-To: <20180228233249.26281-2-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-2-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 13:20:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLq5MVhT5nZO_MTya7YhHee17UhJ7jnq51oeiJVL26QA@mail.gmail.com>
Message-ID: <CAK7LNAQLq5MVhT5nZO_MTya7YhHee17UhJ7jnq51oeiJVL26QA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: remove remaining use of undefined YACC_PREFIX
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
> Commit eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and
> YACC_PREFIX") removed YACC_PREFIX definition, but left one use of it. There
> was not any build error since there is no user of "cmd_bison_h" currently.
> Remove the last remaining occurrence of YACC_PREFIX.
>
> Fixes: eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and YACC_PREFIX")
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

You can replace CC with my

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5589bae34af6..1bc2f90cb8c0 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -217,7 +217,7 @@ $(filter %.tab.c,$(targets)): $(obj)/%.tab.c: $(src)/%.y FORCE
>         $(call if_changed,bison)
>
>  quiet_cmd_bison_h = YACC    $@
> -      cmd_bison_h = bison -o/dev/null --defines=$@ -t -l -p $(YACC_PREFIX) $<
> +      cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
>
>  ifdef REGENERATE_PARSERS
>  .PRECIOUS: $(src)/%.tab.h_shipped
> --
> 2.14.1
>



-- 
Best Regards
Masahiro Yamada
