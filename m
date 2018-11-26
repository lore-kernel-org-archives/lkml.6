Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064620663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TrojzDq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F064620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeK0Bt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:49:26 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36726 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeK0BtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:49:25 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAQEsxVX021904;
        Mon, 26 Nov 2018 23:55:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAQEsxVX021904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543244100;
        bh=dAcvFYYaqZws5Q5K+4JeCrQ4GzZCAdEnxWoScM6SkWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TrojzDq8Wkc2RSe/GnetFE5/D0//l3fuZwXLFGGEcXxQm0xs2vsG4fPQQiL7f8gQQ
         rB1lF5I4ikgh30whmIUMCHecUx6455yWXAKJBbxTCcyJOjmYlb/krWCa53VhVURY5a
         xvtt16PgnwtDIBQv2N/MymT1pU/VIBZyA78Ec0+E+me4mKKLO5k4k8wMZbKYfk/jRZ
         Zr1pQOYMoG3tX6FNCjOFfwY57wblw4nhe6Pac+a8oNo1Cnug1nNt83GYgVXgXUjopE
         tMYShMJyd6M6zxVpdC2jqHDWsiQHs+xJX1UsTL9lhPU767Rn6x20lAVIgBG3ZY8miC
         wGFtwYLc8clWw==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id z24so6377973ual.8;
        Mon, 26 Nov 2018 06:55:00 -0800 (PST)
X-Gm-Message-State: AA+aEWZU7Un5EqH19OkhvearQnsBQuOFQZ9LvonPGHQwLPuOFrNS2m0p
        +MpnzBRpv8dHCIfRany317X9tTOng3vAjNT8ewg=
X-Google-Smtp-Source: AFSGD/VCaBwdBcYTm9EqmF6m2lOaw9U+MDCd0Vp3MNSzaI9BTjdjV5R6fp4yy5lkDcON5MpCzpWFFivKX8whcSm/qHc=
X-Received: by 2002:ab0:849:: with SMTP id b9mr11535732uaf.93.1543244098699;
 Mon, 26 Nov 2018 06:54:58 -0800 (PST)
MIME-Version: 1.0
References: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Nov 2018 23:54:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9oQteb2pr3yR7FYitXviFH2JPCuOQNS_OoxQUb9RMKg@mail.gmail.com>
Message-ID: <CAK7LNAT9oQteb2pr3yR7FYitXviFH2JPCuOQNS_OoxQUb9RMKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: make 'scripts' depend on 'prepare0'
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 4:57 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Before start descending, Kbuild needs to run 'prepare' and 'scripts',
> which were orthogonal to each other prior to this commit.
>
> Let's consider 'scripts' is a part of the preparation. This will allow
> more cleanups.
>
> Move 'scripts' to the prerequisite of 'prepare0', which starts compiling
> target *.c files.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>
>  Makefile | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 36f3f0e..cee4cec 100644
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
> @@ -1114,7 +1114,7 @@ macroprepare: prepare1 archmacros
>
>  archprepare: archheaders archscripts macroprepare scripts_basic
>
> -prepare0: archprepare gcc-plugins
> +prepare0: scripts archprepare gcc-plugins
>         $(Q)$(MAKE) $(build)=scripts/mod
>         $(Q)$(MAKE) $(build)=.
>
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
