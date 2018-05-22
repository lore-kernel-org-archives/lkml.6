Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeEVOXm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:23:42 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:37037 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEVOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:23:41 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4MENQQh023125
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: AB8JxZo2daSxfcDh3ajVpRTvFLlWaYVAKtJLQF5q6FmxV38fkIelz1mvVzzLgtpmrDebQ1Fw5zki2YlNmoqp9pi2/D8=
MIME-Version: 1.0
In-Reply-To: <1526885928-1712-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1526885928-1712-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 23:22:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATojz3pvx=KsJiJDvgykUSqrNUmoQsvn7d5SJQ-Wh7+Pg@mail.gmail.com>
Message-ID: <CAK7LNATojz3pvx=KsJiJDvgykUSqrNUmoQsvn7d5SJQ-Wh7+Pg@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: mini_lock: improve performance
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-21 15:58 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> Replace <+... ...+> by ... when any.  <+... ...+> is slow, and in some
> obscure cases involving backward jumps it doesn't force the unlock to
> actually come after the end of the if.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---

Applied to linux-kbuild. Thanks!

>  scripts/coccinelle/locks/mini_lock.cocci |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle/locks/mini_lock.cocci
> index 47f649b..19c6ee5 100644
> --- a/scripts/coccinelle/locks/mini_lock.cocci
> +++ b/scripts/coccinelle/locks/mini_lock.cocci
> @@ -67,12 +67,14 @@ identifier lock,unlock;
>  @@
>
>  *lock(E1@p,...);
> -<+... when != E1
> +... when != E1
> +    when any
>  if (...) {
>    ... when != E1
>  *  return@r ...;
>  }
> -...+>
> +... when != E1
> +    when any
>  *unlock@up(E1,...);
>
>  @script:python depends on org@
>



-- 
Best Regards
Masahiro Yamada
