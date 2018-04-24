Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeDXPwN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:52:13 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61773 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeDXPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:52:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w3OFpu2X005438
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AIpwx4+y1UCl/85LkYpRk41OQx/M/O294WXz7cHQqnmpDjULigYH167fRtXWEdOODiKJiKwI4n7G6rlU3Udnz5rP/E4=
MIME-Version: 1.0
In-Reply-To: <20180424084408.28034-1-sedat.dilek@credativ.de>
References: <20180424084408.28034-1-sedat.dilek@credativ.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 25 Apr 2018 00:51:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsJ2kvw4JMS-2WsU7a9wrqcYLmfHPBwQDwbAEVFa8E1g@mail.gmail.com>
Message-ID: <CAK7LNATsJ2kvw4JMS-2WsU7a9wrqcYLmfHPBwQDwbAEVFa8E1g@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix typo s/HOST_LOADLIBES/HOST_LOADLIBS
To: Sedat Dilek <sedat.dilek@credativ.de>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-24 17:44 GMT+09:00 Sedat Dilek <sedat.dilek@credativ.de>:
> Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 83b6c541565a..e1869dc08288 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -366,7 +366,7 @@ HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
>                 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
>  HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
>  HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
> -HOST_LOADLIBES := $(HOST_LFS_LIBS)
> +HOST_LOADLIBS := $(HOST_LFS_LIBS)
>
>  # Make variables (CC, etc...)
>  AS             = $(CROSS_COMPILE)as
> @@ -433,7 +433,7 @@ LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
> -export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
> +export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBS
>  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
>  export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>

Why is this a typo?


Our Makefiles use HOST_LOADLIBES consistently.


$ git grep HOST_LOADLIB
Makefile:HOST_LOADLIBES := $(HOST_LFS_LIBS)
Makefile:export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
scripts/Makefile.host:          $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
scripts/Makefile.host:                    $(HOST_LOADLIBES)
$(HOSTLOADLIBES_$(@F))
scripts/Makefile.host:                    $(HOST_LOADLIBES)
$(HOSTLOADLIBES_$(@F))
scripts/Makefile.host:                    $(HOST_LOADLIBES)
$(HOSTLOADLIBES_$(@F))
scripts/Makefile.host:                    $(HOST_LOADLIBES)
$(HOSTLOADLIBES_$(@F))




-- 
Best Regards
Masahiro Yamada
