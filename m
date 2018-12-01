Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20108C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB182146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MhdP1Rfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB182146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeLBCJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:09:38 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38878 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:09:38 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wB1EukSS009362;
        Sat, 1 Dec 2018 23:56:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wB1EukSS009362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543676207;
        bh=sl8hJEIk639NDizKuOEjZ6l+4wJgJ+XaIwv/ealQCyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MhdP1RfbtbIew1R6a4efBBbTJgHJ9OZAyg5xiN3gSJM1jUxzLoPnRJp8sPM2t4IXk
         9S6o0u0jm9MEOEajuEdmSqpQXKjl3UmPyeOdHLsklrhzHnOEv1tgqs/EipGl1pQCxj
         XKc2id7ZcUtudupt5agesyPQ1+0cTjs4LiGMZRF0+u2qs2b1TlNNWQXR2ifD3s4/nM
         jKjn4FwynIycb+qoFNSXoc3Gid0laTqBelCKA14nYiemdlf0LxZJIaZkUOC5mTC7Bu
         rXY+QrYMjP66egoO+ClOsOl2DiQ7Jyst6oVNlhb/2HJ7D6QAsub30dFe7xoOtDD7/6
         yLifIvNEgfcCg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id z3so5084997vsf.7;
        Sat, 01 Dec 2018 06:56:46 -0800 (PST)
X-Gm-Message-State: AA+aEWY4ujNgKGMfxyLzVBTuhBxBZVfivMdAxAk9YPX8Unv9TudnEF3S
        oY1a0VIvnEquiS9x9iTz9pEFN4D7mcySWlxM/J4=
X-Google-Smtp-Source: AFSGD/Uoxf8ZgUJDZQ6qaETaLvN3+JCoPTULW+INpHdCAOqOq0gdnY9R2g5GP7JRRDBXJp4Cp/RmbLNSyg7JTboShHc=
X-Received: by 2002:a67:385a:: with SMTP id f87mr4279684vsa.179.1543676205839;
 Sat, 01 Dec 2018 06:56:45 -0800 (PST)
MIME-Version: 1.0
References: <1543463791-18391-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543463791-18391-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Dec 2018 23:56:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsm-puLZnuq9OVGg3K3jvX=N2c6766u+FT8A74N8gKsw@mail.gmail.com>
Message-ID: <CAK7LNASsm-puLZnuq9OVGg3K3jvX=N2c6766u+FT8A74N8gKsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: make 'archprepare' depend on 'scripts'
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:57 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Before start descending, Kbuild needs to run 'prepare' and 'scripts',
> which has been orthogonal to each other.
>
> Going forward, let's consider 'scripts' is a part of the preparation.
> This will allow more cleanups.
>
> Move 'scripts' to the prerequisite of 'archprepare', where UML starts
> compiling target *.c files.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - It turned out UML + CONFIG_GCC_PLUGINS is broken for a long time.
>     https://patchwork.kernel.org/patch/10703853/
>     Rebased on the top of the fix-up

Applied to linux-kbuild.


>  Makefile | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f7cc3ee..9eb3f4f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1062,7 +1062,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
>  # Error messages still appears in the original language
>
>  PHONY += $(vmlinux-dirs)
> -$(vmlinux-dirs): prepare scripts
> +$(vmlinux-dirs): prepare
>         $(Q)$(MAKE) $(build)=$@ need-builtin=1
>
>  define filechk_kernel.release
> @@ -1112,7 +1112,7 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
>
>  macroprepare: prepare1 archmacros
>
> -archprepare: archheaders archscripts macroprepare scripts_basic gcc-plugins
> +archprepare: archheaders archscripts macroprepare scripts gcc-plugins
>
>  prepare0: archprepare
>         $(Q)$(MAKE) $(build)=scripts/mod
> @@ -1286,7 +1286,7 @@ modules.builtin: $(vmlinux-dirs:%=%/modules.builtin)
>
>  # Target to prepare building external modules
>  PHONY += modules_prepare
> -modules_prepare: prepare scripts
> +modules_prepare: prepare
>
>  # Target to install modules
>  PHONY += modules_install
> @@ -1604,11 +1604,9 @@ help:
>         @echo  '  clean           - remove generated files in module directory only'
>         @echo  ''
>
> -# Dummies...
> -PHONY += prepare scripts
> +PHONY += prepare
>  prepare:
>         $(cmd_crmodverdir)
> -scripts: ;
>  endif # KBUILD_EXTMOD
>
>  clean: $(clean-dirs)
> @@ -1712,33 +1710,33 @@ else
>          target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
>  endif
>
> -%.s: %.c prepare scripts FORCE
> +%.s: %.c prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.i: %.c prepare scripts FORCE
> +%.i: %.c prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.o: %.c prepare scripts FORCE
> +%.o: %.c prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.lst: %.c prepare scripts FORCE
> +%.lst: %.c prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.s: %.S prepare scripts FORCE
> +%.s: %.S prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.o: %.S prepare scripts FORCE
> +%.o: %.S prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.symtypes: %.c prepare scripts FORCE
> +%.symtypes: %.c prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.ll: %.c prepare scripts FORCE
> +%.ll: %.c prepare FORCE
>         $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
>
>  # Modules
> -/: prepare scripts FORCE
> +/: prepare FORCE
>         $(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
>         $(build)=$(build-dir)
>  # Make sure the latest headers are built for Documentation
>  Documentation/ samples/: headers_install
> -%/: prepare scripts FORCE
> +%/: prepare FORCE
>         $(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
>         $(build)=$(build-dir)
> -%.ko: prepare scripts FORCE
> +%.ko: prepare FORCE
>         $(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
>         $(build)=$(build-dir) $(@:.ko=.o)
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
