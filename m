Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA19AC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953E22146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q1TXm/Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953E22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeLBCKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:10:03 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22300 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLBCKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:10:03 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wB1Ev8Uc006347;
        Sat, 1 Dec 2018 23:57:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wB1Ev8Uc006347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543676229;
        bh=HKiTxFk5BiwWN91pJfdQ/j4r/lRX+V9IA6cQqN7JUQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q1TXm/BbsJKovN47204zbiHu4HjDHqyvM69u/lTy/cWrKkiiQ6uc/mYLEqy/XBAWc
         UmryyB57dyXSPDS9iMNO8318fbkvbPG0IkkB2s2Gv+/0Dmnl9Vioi0cpcffjj3z81e
         +KWtB4c7cColfyJXptGApTq6GbGD1EoU2XnrL/jdnj5f91k2DfDhkeogncmkM1Tar0
         LKo2Acb3owdNsdn479b0UProIs2O3nVNUBapVh6X0isgThoaxQsZuwWsnl63eyftfE
         BI/H9791PRHj4nLRrUvdhiG+byvD5q0PbgmARwT4qTopfW1jVkhTh8FHuhlpOguBua
         JRDJYlcRqlEsA==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id n7so2933431uao.7;
        Sat, 01 Dec 2018 06:57:08 -0800 (PST)
X-Gm-Message-State: AA+aEWZ30tS36S4fIteh0XB5yNDiRH5pj39whoBCDzM0r5EBDcoMvZwb
        NAibXmFvvbevG3s9sMyrLaIKyURQzdFTaMz1SBM=
X-Google-Smtp-Source: AFSGD/WM+C2EFR8YKrBYLaDHvHDd7s9lLujv/Z8HP1Gb8ej6yzyKq3e1/NgIvEvsne8onk1yhHGOGgo4fda81lyBSbU=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr4433915uam.89.1543676227898;
 Sat, 01 Dec 2018 06:57:07 -0800 (PST)
MIME-Version: 1.0
References: <1543463791-18391-1-git-send-email-yamada.masahiro@socionext.com> <1543463791-18391-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543463791-18391-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Dec 2018 23:56:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoQweReaTV7cFkf1VmiS3JzO+iGGPBMvvzsFqpw3JJOw@mail.gmail.com>
Message-ID: <CAK7LNARoQweReaTV7cFkf1VmiS3JzO+iGGPBMvvzsFqpw3JJOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:57 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Now that 'archprepare' depends on 'scripts', Kbuild can descend into
> scripts/gcc-plugins in a more standard way.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---

Applied to linux-kbuild.


> Changes in v2:
>   - It turned out UML + CONFIG_GCC_PLUGINS is broken for a long time.
>     https://patchwork.kernel.org/patch/10703853/
>     Rebased on the top of the fix-up
>
>  Makefile                     | 2 +-
>  scripts/Makefile             | 3 ++-
>  scripts/Makefile.gcc-plugins | 8 --------
>  3 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9eb3f4f..c1f87cf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1112,7 +1112,7 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
>
>  macroprepare: prepare1 archmacros
>
> -archprepare: archheaders archscripts macroprepare scripts gcc-plugins
> +archprepare: archheaders archscripts macroprepare scripts
>
>  prepare0: archprepare
>         $(Q)$(MAKE) $(build)=scripts/mod
> diff --git a/scripts/Makefile b/scripts/Makefile
> index b48259d..feb1f71 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -36,9 +36,10 @@ PHONY += build_unifdef
>  build_unifdef: $(obj)/unifdef
>         @:
>
> +subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
>  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
>
>  # Let clean descend into subdirs
> -subdir-        += basic dtc kconfig mod package gcc-plugins
> +subdir-        += basic dtc kconfig mod package
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 46c5c68..c36f199 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -49,11 +49,3 @@ KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
>  # All enabled GCC plugins are collected here for building below.
>  GCC_PLUGIN := $(gcc-plugin-y)
>  export GCC_PLUGIN
> -
> -# Actually do the build, if requested.
> -PHONY += gcc-plugins
> -gcc-plugins: scripts_basic
> -ifdef CONFIG_GCC_PLUGINS
> -       $(Q)$(MAKE) $(build)=scripts/gcc-plugins
> -endif
> -       @:
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
