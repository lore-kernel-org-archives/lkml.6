Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEVM7u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:59:50 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:32276 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeEVM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:59:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4MCxhOG022143
X-Nifty-SrcIP: [209.85.213.54]
X-Google-Smtp-Source: AB8JxZpqam0nIPamVk5RguGlRgtgyXoHtbSMEELVangi01FSzS+MbVma0+DvGRyOpclHbzPbE4Ec1J+PjebWm6y0w/k=
MIME-Version: 1.0
In-Reply-To: <20180522091606.uxvnrz7bbotpxnhn@gmail.com>
References: <20180522091606.uxvnrz7bbotpxnhn@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 21:59:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASA1VQcrqYAtN-8mTNC=Fhy5tcy_ZkWTnv3=13WL9xwSQ@mail.gmail.com>
Message-ID: <CAK7LNASA1VQcrqYAtN-8mTNC=Fhy5tcy_ZkWTnv3=13WL9xwSQ@mail.gmail.com>
Subject: Re: [PATCH v5] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-22 18:16 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> The current code includes 'Kconfig' in ALLSOURCE_ARCHS, but
> it should not (Kconfig is not an architecture). Replace this
> with a find-generated string and directly assign it to
> $ALLSOURCE_ARCHS. The find_all_archs() function is no longer
> needed for a one-liner with obvious semantics, so inline the
> arch generation into the surrounding conditional.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>

Applied to linux-kbuild. Thanks!



>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 78e546ff689c2d5f40..e587610d149271171d 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -26,24 +26,15 @@ else
>  fi
>
>  # ignore userspace tools
>  ignore="$ignore ( -path ${tree}tools ) -prune -o"
>
> -# Find all available archs
> -find_all_archs()
> -{
> -       ALLSOURCE_ARCHS=""
> -       for arch in `ls ${tree}arch`; do
> -               ALLSOURCE_ARCHS="${ALLSOURCE_ARCHS} "${arch##\/}
> -       done
> -}
> -
>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>         ALLSOURCE_ARCHS=${SRCARCH}
>  elif [ "${ALLSOURCE_ARCHS}" = "all" ]; then
> -       find_all_archs
> +       ALLSOURCE_ARCHS=$(find ${tree}arch/ -mindepth 1 -maxdepth 1 -type d -printf '%f ')
>  fi
>
>  # find sources in arch/$ARCH
>  find_arch_sources()
>  {
> --
> 2.17.0.rc1.35.g90bbd502d54fe92035.dirty



-- 
Best Regards
Masahiro Yamada
