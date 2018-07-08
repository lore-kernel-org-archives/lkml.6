Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7B9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265A7208B4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fDEDxbJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265A7208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeGHCbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:31:38 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19282 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754461AbeGHCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:31:36 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w682VQ8x027009;
        Sun, 8 Jul 2018 11:31:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w682VQ8x027009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531017087;
        bh=LQqTCNPN1RighRE77vfhdqO5Zew9J/XsZgyTylrE+cY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=fDEDxbJQQNsqiK59CBsvYC1qf80LEmQVgMvVr6qvL+D+Zuyj5nMqxDgwPRfOeCyUL
         MoziCUjGrwBlU8Z+X8Pn4eWAEwLw6idFHhr7qhA1YkGo8BBzD/Q9uvDmGN/2Bd2PCo
         ObIr6gORu5nxQJM1YKumklUN2FFE9q140XYWzSOqLWpMRk/WhHB4cBALYfUs7P6WkZ
         7S4iYemGNf6nsU9d1EqSiuugpLBWqiwS+9C4o48PrTJoOlfBAMdR7vFJvh3IbssBKb
         Gzag/MIpH/a9YP+tpziA/Yup8WZtGwxI7WTlieEcqqtPcCtc9fvt99JDJQ5AuI6UaN
         jeABeYRxUCsvw==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id x24-v6so9780557ual.10;
        Sat, 07 Jul 2018 19:31:27 -0700 (PDT)
X-Gm-Message-State: APt69E0LIizCDYS2onq5hXB8QMl++NlAiGYQJi+V9HOYA8FUoK6ezi+U
        w31wkBwIq7LoxCSYNJSNUGCz1NR3E3AYN2Tw78Q=
X-Google-Smtp-Source: AAOMgpfvWpH4hbJxouW0bZlXwpOuY5b0z0eCPI9DJCqYuW4SaZSsn0qnTfAsapH0BKcpA4a5J2yYC0lgnaQ9+hNODcY=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr9800362uae.140.1531017086379;
 Sat, 07 Jul 2018 19:31:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 19:30:45 -0700 (PDT)
In-Reply-To: <20180707010709.16648-5-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com> <20180707010709.16648-5-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 11:30:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGX_qyGHCZYpHuizULrvurxa-5eSBRd4H+QnEf7FRvfQ@mail.gmail.com>
Message-ID: <CAK7LNATGX_qyGHCZYpHuizULrvurxa-5eSBRd4H+QnEf7FRvfQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] treewide: Rename HOSTCXXFLAGS to KBUILD_HOSTCXXFLAGS
To:     Laura Abbott <labbott@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-07 10:07 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> In preparation for enabling command line CXXFLAGS, re-name HOSTCXXFLAGS to
> KBUILD_HOSTCXXFLAGS as the internal use only flags. This should not have any
> visible effects.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  Makefile                 | 4 ++--
>  scripts/Makefile.host    | 4 ++--
>  scripts/kconfig/Makefile | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 16cab22b1f40..9c3f1864d678 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -361,7 +361,7 @@ HOSTCC       = gcc
>  HOSTCXX      = g++
>  KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
>                 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
> -HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
> +KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
>  HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
>  HOST_LOADLIBES := $(HOST_LFS_LIBS)
>
> @@ -432,7 +432,7 @@ GCC_PLUGINS_CFLAGS :=
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
>  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
> -export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> +export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 7a4c90f2b0ce..1c153cc5b530 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -64,8 +64,8 @@ host-cxxshobjs        := $(addprefix $(obj)/,$(host-cxxshobjs))
>
>  _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
>                   $(KBUILD_HOSTCFLAGS_$(basetarget).o)
> -_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
> -                 $(HOSTCXXFLAGS_$(basetarget).o)
> +_hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
> +                 $(KBUILD_HOSTCXXFLAGS_$(basetarget).o)
>
>  ifeq ($(KBUILD_SRC),)
>  __hostc_flags  = $(_hostc_flags)
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index f98a22618e1f..37605d92c597 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -192,7 +192,7 @@ qconf-cxxobjs       := qconf.o
>  qconf-objs     := zconf.tab.o
>
>  HOSTLOADLIBES_qconf    = $(shell . $(obj)/.qconf-cfg && echo $$libs)
> -HOSTCXXFLAGS_qconf.o   = $(shell . $(obj)/.qconf-cfg && echo $$cflags)
> +KBUILD_HOSTCXXFLAGS_qconf.o    = $(shell . $(obj)/.qconf-cfg && echo $$cflags)


Please keep HOSTCXXFLAGS_<file>.o as-is.





-- 
Best Regards
Masahiro Yamada
