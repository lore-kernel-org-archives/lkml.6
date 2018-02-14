Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967423AbeBNLc1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:32:27 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19259 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967342AbeBNLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:32:26 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1EBWA38001195
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AH8x226UZ2ZNtZmvKP6u+YUwcFrl/Qx3FKK5OKH8IN7NAQHCtG0uwOerLkMBUdDyP6cf/J+HpWW53je43rKv5NKMHSQ=
MIME-Version: 1.0
In-Reply-To: <6f19ae3f-249e-2d20-dcd6-e34c475a2638@cn.fujitsu.com>
References: <fb60e245-86f2-53c6-79d8-bd395ef011dd@cn.fujitsu.com>
 <CAK7LNARjks+EWiKq4KkHrbQTOAYWzRku_fuj_-8dcThQB=h6PA@mail.gmail.com> <6f19ae3f-249e-2d20-dcd6-e34c475a2638@cn.fujitsu.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Feb 2018 20:31:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATofb+-Y=hTQd2B2rGW=-XrQ9wN0+nXozhLpPv+dhWHfg@mail.gmail.com>
Message-ID: <CAK7LNATofb+-Y=hTQd2B2rGW=-XrQ9wN0+nXozhLpPv+dhWHfg@mail.gmail.com>
Subject: Re: why scripts/link-vmlinux.sh has a final build of init/
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-13 16:08 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:

> BTW, I still have 2 questions.
>
> 1. In final build, why need
>
>    GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
>
> Doesn't GCC_PLUGINS_CFLAGS already exist in the environment?
>
> I also tested the Randomizing Structure Layout plugin with this patch,
> the plugin seems works in my test.


I have not tested, but GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
is probably unnecessary.



> 2. scripts/link-vmlinux.sh seems just handle only one argument: clean.
> So why shouldn't it be:


To detect the change of $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
because link-vmlinux.sh depends on them.



> diff --git a/Makefile b/Makefile
> index ccd981892ef2..21d93b545381 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -998,7 +998,7 @@ ARCH_POSTLINK := $(wildcard
> $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
>
>  # Final link of vmlinux with optional arch pass after final link
>  cmd_link-vmlinux =                                                 \
> -       $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
> +       $(CONFIG_SHELL) $<;                                         \
>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
>  vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE



-- 
Best Regards
Masahiro Yamada
