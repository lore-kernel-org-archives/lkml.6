Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8297521C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="V7vZvFkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8297521C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHIHW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:22:29 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:28926 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeHIHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:22:29 -0400
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w794xLh1029064;
        Thu, 9 Aug 2018 13:59:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w794xLh1029064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533790762;
        bh=owH3HWjesSxYMSqoSGCl6iBo93VGPyPraRGtvmxSaU0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=V7vZvFkwUYjAoqXUJzue69w7iWEYWOgnbe1r61MhHmNLKGb4qCi+Raxq2hP2fawMO
         uc8GDEoVWoybaiRL5tNSCpLoJgerEA9PSMmzK0hTdKu8x5/881eZr5raQhJtSlGPy+
         ecoCSfZzI4/+XHP/Lps0OQRfSaFCgxOroIR+KuV90Qw6NpVwJq30gDnezs/KYVq/e8
         pM2QGsItTA5D1OSn057gM0Slp1fQVeQFWevxusADp5ohKs+ldD4SyM5sEzU933Vh/e
         R4QeRu0gYE7hodCv98zzM8j97Ced1w4eIUnsm29HVVdTgsXz2yfUKcdDwmH1xkwNx6
         8fK42c5zFArag==
X-Nifty-SrcIP: [209.85.217.172]
Received: by mail-ua0-f172.google.com with SMTP id i4-v6so4956410uak.0;
        Wed, 08 Aug 2018 21:59:22 -0700 (PDT)
X-Gm-Message-State: AOUpUlHYCvV+OhbYNrMvLOjUyRhfD/gXskIM0l40Gci3BRi3QemI5bF/
        MrJo+7YlfrtDhMjeJIUS0L/bfxF5H6zEfH5IJpg=
X-Google-Smtp-Source: AA+uWPxHpHUzfeBrredRvMfRYdO3FQbgEMMu+ujeOzTt70R4sbmClJ1dLQ0BvC/jU4/+jlWz0WmJmHJzv6OvzPJL7qU=
X-Received: by 2002:a1f:5f44:: with SMTP id t65-v6mr328785vkb.135.1533790761341;
 Wed, 08 Aug 2018 21:59:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 21:58:40 -0700 (PDT)
In-Reply-To: <patch.git-39444503b4d3.your-ad-here.call-01533562662-ext-6094@work.hours>
References: <patch.git-39444503b4d3.your-ad-here.call-01533562662-ext-6094@work.hours>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 Aug 2018 13:58:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARivbQ57+raPUkek2=bsnYDhXS+hSK3kwf+0K7Hvxj31g@mail.gmail.com>
Message-ID: <CAK7LNARivbQ57+raPUkek2=bsnYDhXS+hSK3kwf+0K7Hvxj31g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add Map option to save vmlinux linker map file(s)
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-06 22:38 GMT+09:00 Vasily Gorbik <gor@linux.ibm.com>:
> Add "Map" kbuild option, so that "make Map=1" would save vmlinux linker
> map into vmlinux.map, which is quite useful during making kernel changes
> related to how the kernel is composed.
>
> KBUILD_SAVE_LINK_MAP flag is exported and architectures
> supporting compressed kernel images might respect it and produce
> arch/*/boot/compressed/vmlinux.map for the decompressor code as well.
>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---


If the map file is quite useful, should it be generated all the time?
Or, how about CONFIG option if you want this conditionally generated?

I do not want to increase fine-grained command-line switches
except _really_ useful ones.




>  .gitignore |  1 +
>  Makefile   | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 97ba6b79834c..1d2308e597ad 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -44,6 +44,7 @@
>  *.xz
>  Module.symvers
>  modules.builtin
> +vmlinux.map
>
>  #
>  # Top-level generic files
> diff --git a/Makefile b/Makefile
> index 7a3c4548162b..f1790deae03b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -176,6 +176,14 @@ ifndef KBUILD_CHECKSRC
>    KBUILD_CHECKSRC = 0
>  endif
>
> +# Use 'make Map=1' to enable saving linker map file(s):
> +# vmlinux.map for vmlinux,
> +# (arch/*/boot/compressed/vmlinux.map for arch/*/boot/compressed/vmlinux)
> +
> +ifeq ("$(origin Map)", "command line")
> +       export KBUILD_SAVE_LINK_MAP := $(Map)
> +endif
> +
>  # Use make M=dir to specify directory of external module to build
>  # Old syntax make ... SUBDIRS=$PWD is still supported
>  # Setting the environment variable KBUILD_EXTMOD take precedence
> @@ -838,6 +846,11 @@ ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
>  LDFLAGS_vmlinux        += $(call ld-option, -X,)
>  endif
>
> +ifdef KBUILD_SAVE_LINK_MAP
> +LDFLAGS_vmlinux        += -Map=vmlinux.map
> +CLEAN_FILES    += vmlinux.map
> +endif
> +
>  # insure the checker run with the right endianness
>  CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
>
> @@ -1434,6 +1447,7 @@ help:
>         @echo  '                2: warnings which occur quite often but may still be relevant'
>         @echo  '                3: more obscure warnings, can most likely be ignored'
>         @echo  '                Multiple levels can be combined with W=12 or W=123'
> +       @echo  '  make Map=1 [targets] Save vmlinux linker map file(s)'
>         @echo  ''
>         @echo  'Execute "make" or "make all" to build all targets marked with [*] '
>         @echo  'For further info see the ./README file'
> --
> 2.18.0.13.gd42ae10
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
