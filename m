Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEBPwU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:52:20 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:40543 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:52:18 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w42Fq1qV006657
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AB8JxZqXQJVNbQqr+FKpqMftgeFtmmox5Obf60ffKCR5ARhaEEczmy6ZvB2hSdfHRiyg54iLXBdgzVlHYRmiH6ZzC1g=
MIME-Version: 1.0
In-Reply-To: <20180322210525.25361-1-linux@rasmusvillemoes.dk>
References: <20180322150005.15061-2-linux@rasmusvillemoes.dk> <20180322210525.25361-1-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 May 2018 00:51:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDS3rqMRNa7GkzmeKYa-k=tTthSLMHG3ZBgKo1CgLUOw@mail.gmail.com>
Message-ID: <CAK7LNATDS3rqMRNa7GkzmeKYa-k=tTthSLMHG3ZBgKo1CgLUOw@mail.gmail.com>
Subject: Re: [RFC resend 1/2] modpost: delete stale comment
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 6:05 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> Commit (7840fea200cd "kbuild: Fix computing srcversion for modules")
> fixed the comment above parse_source_files to refer to the new source_
> line, but left this one behind that could still give the impression that
> drivers/net/dummy.c appears in the deps_ variable.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Resending because I didn't reach any current kbuild maintainers nor
> the kbuild mailing list.
>
>  scripts/mod/sumversion.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
> index 944418da9fe3..0f6dcb4011a8 100644
> --- a/scripts/mod/sumversion.c
> +++ b/scripts/mod/sumversion.c
> @@ -330,14 +330,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
>                 goto out;
>         }
>
> -       /* There will be a line like so:
> -               deps_drivers/net/dummy.o := \
> -                 drivers/net/dummy.c \
> -                   $(wildcard include/config/net/fastroute.h) \
> -                 include/linux/module.h \
> -
> -          Sum all files in the same dir or subdirs.
> -       */
> +       /* Sum all files in the same dir or subdirs. */
>         while ((line = get_next_line(&pos, file, flen)) != NULL) {
>                 char* p = line;
>
> --
> 2.15.1
>


Applied to linux-kbuild/fixes.  Thanks!



-- 
Best Regards
Masahiro Yamada
