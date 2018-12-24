Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC0C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C41C2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jxYBW8e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLXPTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:19:40 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40187 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:19:39 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wBOFJTXk016901;
        Tue, 25 Dec 2018 00:19:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBOFJTXk016901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545664770;
        bh=Du9ckvFj2azBEJpy/e+Ld8zMxw7IgEkGjLN/fYgumDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jxYBW8e2RrBeSGT3Wi23NWrDP+76Y9Tv0WG+v30bzBH60qpPVt3GaDpLYZc9xS1ev
         3I6KmiNHPBV598vek35p8A3XtFCBx8Pz1MnL6130vFogjBHu2eTZWKlrt17bOwvSzU
         fMgy6RlQdSvcnYz/1uXIWT4XQXZCTlq0Z4gthAAJ6dU1mhrLexFx64LuoqL6D7DwO0
         nycbUKk8rAgbjgOzrdftBgyZ/eKDGRlsxIsF2PNrHDN/1jwMaDFvFu7og8f0rM8qte
         fHosqSs4fzxMLDYg6VgNNrA01JlkI+dDXENy9mf695W4/DveoPQlRWwLe56oLYKd2n
         akr/1wMSGIWvA==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id n126so2613046vke.12;
        Mon, 24 Dec 2018 07:19:29 -0800 (PST)
X-Gm-Message-State: AJcUukfzx7/qfvm23zEaj/v1QFkgLx00RyY+7nLb91fPli5Kw06OV/49
        MyZl9l74FcCT3PpDYzQSfdzwpRYw4TvdPg3qnPw=
X-Google-Smtp-Source: ALg8bN4UVomGoKBDrWC7U7LaRA/QZhdfUnnGKMY+TpmixQ3IN9zaBtB25LGkVky27TCVUeBjE5gV5GijMZmd4KVc8UQ=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr4842867vki.84.1545664768464;
 Mon, 24 Dec 2018 07:19:28 -0800 (PST)
MIME-Version: 1.0
References: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 25 Dec 2018 00:18:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNTmwJraW_Bbvc3s0-G__yYotR9rbXtLTkyf-kVHRuDQ@mail.gmail.com>
Message-ID: <CAK7LNASNTmwJraW_Bbvc3s0-G__yYotR9rbXtLTkyf-kVHRuDQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] kconfig: split some C files out of zconf.y
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I want to compile each C file independently instead of including all
> of them from zconf.y.
>
> These 4 files are low hanging fruits.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild/kconfig.


>  scripts/kconfig/Makefile     | 19 +++++++++----------
>  scripts/kconfig/confdata.c   |  1 +
>  scripts/kconfig/expr.c       |  2 ++
>  scripts/kconfig/lkc.h        |  1 +
>  scripts/kconfig/preprocess.c |  2 ++
>  scripts/kconfig/symbol.c     |  2 +-
>  scripts/kconfig/zconf.y      |  4 ----
>  7 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 63b6092..d3bd687 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -142,13 +142,8 @@ help:
>         @echo  '  testconfig      - Run Kconfig unit tests (requires python3 and pytest)'
>
>  # ===========================================================================
> -# Shared Makefile for the various kconfig executables:
> -# conf:          Used for defconfig, oldconfig and related targets
>  # object files used by all kconfig flavours
> -
> -conf-objs      := conf.o  zconf.tab.o
> -
> -hostprogs-y := conf
> +common-objs    := confdata.o expr.o symbol.o preprocess.o zconf.tab.o
>
>  targets                += zconf.lex.c
>
> @@ -156,9 +151,13 @@ targets            += zconf.lex.c
>  HOSTCFLAGS_zconf.lex.o := -I$(src)
>  HOSTCFLAGS_zconf.tab.o := -I$(src)
>
> +# conf: Used for defconfig, oldconfig and related targets
> +hostprogs-y    += conf
> +conf-objs      := conf.o $(common-objs)
> +
>  # nconf: Used for the nconfig target based on ncurses
>  hostprogs-y    += nconf
> -nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
> +nconf-objs     := nconf.o nconf.gui.o $(common-objs)
>
>  HOSTLDLIBS_nconf       = $(shell . $(obj)/.nconf-cfg && echo $$libs)
>  HOSTCFLAGS_nconf.o     = $(shell . $(obj)/.nconf-cfg && echo $$cflags)
> @@ -169,7 +168,7 @@ $(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/.nconf-cfg
>  # mconf: Used for the menuconfig target based on lxdialog
>  hostprogs-y    += mconf
>  lxdialog       := checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
> -mconf-objs     := mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))
> +mconf-objs     := mconf.o $(addprefix lxdialog/, $(lxdialog)) $(common-objs)
>
>  HOSTLDLIBS_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
>  $(foreach f, mconf.o $(lxdialog), \
> @@ -181,7 +180,7 @@ $(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/.mconf-cfg
>  # qconf: Used for the xconfig target based on Qt
>  hostprogs-y    += qconf
>  qconf-cxxobjs  := qconf.o
> -qconf-objs     := zconf.tab.o
> +qconf-objs     := $(common-objs)
>
>  HOSTLDLIBS_qconf       = $(shell . $(obj)/.qconf-cfg && echo $$libs)
>  HOSTCXXFLAGS_qconf.o   = $(shell . $(obj)/.qconf-cfg && echo $$cflags)
> @@ -196,7 +195,7 @@ $(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
>
>  # gconf: Used for the gconfig target based on GTK+
>  hostprogs-y    += gconf
> -gconf-objs     := gconf.o zconf.tab.o
> +gconf-objs     := gconf.o $(common-objs)
>
>  HOSTLDLIBS_gconf    = $(shell . $(obj)/.gconf-cfg && echo $$libs)
>  HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index e32ada9..ea88355 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -7,6 +7,7 @@
>  #include <ctype.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <limits.h>
>  #include <stdarg.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
> index ddb9c86..265f2af 100644
> --- a/scripts/kconfig/expr.c
> +++ b/scripts/kconfig/expr.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
>   */
>
> +#include <ctype.h>
> +#include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index 4ff33cd..160a931 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -108,6 +108,7 @@ const char *str_get(struct gstr *gs);
>  /* symbol.c */
>  void sym_clear_all_valid(void);
>  struct symbol *sym_choice_default(struct symbol *sym);
> +struct property *sym_get_range_prop(struct symbol *sym);
>  const char *sym_get_string_default(struct symbol *sym);
>  struct symbol *sym_check_deps(struct symbol *sym);
>  struct property *prop_alloc(enum prop_type type, struct symbol *sym);
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> index b028a48..592dfbfa 100644
> --- a/scripts/kconfig/preprocess.c
> +++ b/scripts/kconfig/preprocess.c
> @@ -2,6 +2,7 @@
>  //
>  // Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
>
> +#include <ctype.h>
>  #include <stdarg.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> @@ -9,6 +10,7 @@
>  #include <string.h>
>
>  #include "list.h"
> +#include "lkc.h"
>
>  #define ARRAY_SIZE(arr)                (sizeof(arr) / sizeof((arr)[0]))
>
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index 364afa1..860414d 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -88,7 +88,7 @@ static struct property *sym_get_default_prop(struct symbol *sym)
>         return NULL;
>  }
>
> -static struct property *sym_get_range_prop(struct symbol *sym)
> +struct property *sym_get_range_prop(struct symbol *sym)
>  {
>         struct property *prop;
>
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index 60ee8e7..32be913 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -730,8 +730,4 @@ void zconfdump(FILE *out)
>
>  #include "zconf.lex.c"
>  #include "util.c"
> -#include "confdata.c"
> -#include "expr.c"
> -#include "symbol.c"
>  #include "menu.c"
> -#include "preprocess.c"
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
