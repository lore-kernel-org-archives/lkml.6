Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C8820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tRHdfcC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C8820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeK0Bt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:49:56 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37294 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0Bt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:49:56 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAQEtP4h022181;
        Mon, 26 Nov 2018 23:55:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAQEtP4h022181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543244126;
        bh=0ZYh7UerNa9XzKiBjGOQe93lulCC/tndsVcjx9iE+1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tRHdfcC5KEmae9BvPLVd9U0p7eTOpUn3vq0UyfSNXDu0Oc5QfjHbVRSEd9gL8PA7f
         cBP3LDBimRlbWi8w7xtUdQh29BcIhgBH22DRAi0eZ6o8BAQM3C0E1EnHLQ78gPZ7IY
         pH2ZxpHUQWXtLhSfTRAxrYvYzTIfOTGRncEeoki+UdHjc/OhSv0zjxdmcohrwiQOhI
         qZaEORFiXZekIpOPuW7ShC10WD51UwIb7BGw8yEpiWMDw8mMKsQGpwtwHXdu2dSvwq
         +kTpf/+GY2uOQJJL2OMzLPHC/ALBswg9ntP2BDsGwBkr3pylS5fTnD+HzScXwF7F6F
         Nkn7uv1tQ09qQ==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id t127so4209540vke.8;
        Mon, 26 Nov 2018 06:55:25 -0800 (PST)
X-Gm-Message-State: AA+aEWYWHNECL4A/5PS4Zxsqa+4W0RFJOOXMauCzeocjqFYcm/PWl1CO
        UQZLYNUK0oMI3j3uMymJJrIrUGqmRDUEXivK3Vo=
X-Google-Smtp-Source: AFSGD/XuTCJnY0c17B1z0BCj/Pg0ImOsXt6KeVy7xxm/n+7eGqQ1hp86UUrKtx4ZWSajZsoQqpv26HPtWg+2SpkU130=
X-Received: by 2002:a1f:5e47:: with SMTP id s68mr10532227vkb.64.1543244124570;
 Mon, 26 Nov 2018 06:55:24 -0800 (PST)
MIME-Version: 1.0
References: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com> <1542948687-7326-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542948687-7326-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Nov 2018 23:54:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARi6+vOgi-NUhLT4QEZm=i+T6r26z9M6OjuXtVyyLqmUA@mail.gmail.com>
Message-ID: <CAK7LNARi6+vOgi-NUhLT4QEZm=i+T6r26z9M6OjuXtVyyLqmUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: descend into scripts/gcc-plugins/ via scripts/Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 4:57 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Now that 'prepare0' depends on 'scripts', building GCC plugins can
> go into scripts/Makefile, which is a more standard way.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


>  Makefile                     | 2 +-
>  scripts/Makefile             | 3 ++-
>  scripts/Makefile.gcc-plugins | 8 --------
>  3 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index cee4cec..a8bbe68 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1114,7 +1114,7 @@ macroprepare: prepare1 archmacros
>
>  archprepare: archheaders archscripts macroprepare scripts_basic
>
> -prepare0: scripts archprepare gcc-plugins
> +prepare0: scripts archprepare
>         $(Q)$(MAKE) $(build)=scripts/mod
>         $(Q)$(MAKE) $(build)=.
>
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
