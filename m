Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEBQRw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:17:52 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:62679 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeEBQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:17:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w42GHb7d015727
X-Nifty-SrcIP: [209.85.217.173]
X-Google-Smtp-Source: AB8JxZoWIFzhV1Mn63u4FuTy8nvIn0qZJOCYzmzT2i8uS+B5O1TmwRGBOkPj8MxAARS640t9RE7Ituz8ghJyeEPmmU8=
MIME-Version: 1.0
In-Reply-To: <1524568033-25026-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524568033-25026-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 May 2018 01:16:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFG_9+R_n7sNqon8V=quTiiWHKtTqUcYOeTHx5CnzDvg@mail.gmail.com>
Message-ID: <CAK7LNARFG_9+R_n7sNqon8V=quTiiWHKtTqUcYOeTHx5CnzDvg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: replace hardcoded bison in cmd_bison_h with $(YACC)
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-24 20:07 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Commit 73a4f6dbe70a ("kbuild: add LEX and YACC variables") missed to
> update cmd_bison_h somehow.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/fixes.


>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 07d0740..5af34a2b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -196,7 +196,7 @@ $(obj)/%.tab.c: $(src)/%.y FORCE
>         $(call if_changed,bison)
>
>  quiet_cmd_bison_h = YACC    $@
> -      cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
> +      cmd_bison_h = $(YACC) -o/dev/null --defines=$@ -t -l $<
>
>  $(obj)/%.tab.h: $(src)/%.y FORCE
>         $(call if_changed,bison_h)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
