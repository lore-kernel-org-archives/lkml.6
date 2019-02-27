Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D616C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2842075B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JbWi+20J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfB0MnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:43:12 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:36099 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfB0MnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:43:10 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1RCgr78030165;
        Wed, 27 Feb 2019 21:42:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1RCgr78030165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551271374;
        bh=9UjZFunYrDFLNzw/Ouh2o3kM0iTmdbIx0gSMyILnosA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JbWi+20Jt8Img0eIsMcX7Fn/1biZLHCcIt4Pj4eCj5mX8l+GpemC0sTO+yEWTbq7f
         vcoZ2lLTm0zb8lq/JPHnnJ2M4I16AuIqet/GlPVy2gpyfJDDdl4RGrrjP6dr8E9/y7
         T5NOiSh0CllDXgaLbWbcQ2ZrHh0MsQQxxvi2oh58vfuL3kx9XrkTrjGGXBPOlknzha
         EHSAEljgSeYheEq1xPFxVJPoYHsi9hY9gKzNWD/bGEHpvbFrsbzmEZeSL8Is/7AjCL
         NCoBios0kLZGSdFyUtE97WSVLceKLHROeNn7yknYIKFK6Wa1rZ/MBu2tbmiV17wzm4
         vhj3DbExDWBoQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id j8so15118043uae.13;
        Wed, 27 Feb 2019 04:42:53 -0800 (PST)
X-Gm-Message-State: AHQUAuaRm/j6d633nDcAN6hvxWW3274/m6uYyGAy5nbKrAlcfTbMvESE
        e76uJvSH/h+R+XmUAfVtHLqrg5U8qrcKW6sIOVc=
X-Google-Smtp-Source: AHgI3Ibgwyr8P+sHIaHZL4zN1K9e+8vvMGRSiWJet/tWJToUIj56FFUmpWEjNm0o+ekD+rPz+MNVGwVCIazE3ybyFaA=
X-Received: by 2002:ab0:748a:: with SMTP id n10mr1962685uap.89.1551271372722;
 Wed, 27 Feb 2019 04:42:52 -0800 (PST)
MIME-Version: 1.0
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Feb 2019 21:42:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNARND0pCBujV4zM1fQkybZKiC24vkirWJZV96EH_UkGCbQ@mail.gmail.com>
Message-ID: <CAK7LNARND0pCBujV4zM1fQkybZKiC24vkirWJZV96EH_UkGCbQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] scripts/gdb: delay generation of gdb constants.py
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 6:34 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> scripts/gdb/linux/constants.py is never used in the kernel build
> process. There is no good reason to create it so early.
>
> Get it out of the 'prepare' stage.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Added Kieran's Reviewed-by, and applied to linux-kbuild.


>
>  Kbuild   | 10 ----------
>  Makefile | 11 +++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/Kbuild b/Kbuild
> index 65db5be..4cebcc7 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -6,7 +6,6 @@
>  # 2) Generate timeconst.h
>  # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
>  # 4) Check for missing system calls
> -# 5) Generate constants.py (may need bounds.h)
>
>  #####
>  # 1) Generate bounds.h
> @@ -58,14 +57,5 @@ quiet_cmd_syscalls = CALL    $<
>  missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
>         $(call cmd,syscalls)
>
> -#####
> -# 5) Generate constants for Python GDB integration
> -#
> -
> -extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
> -
> -build_constants_py: $(timeconst-file) $(bounds-file)
> -       @$(MAKE) $(build)=scripts/gdb/linux $@
> -
>  # Keep these three files during make clean
>  no-clean-files := $(bounds-file) $(offsets-file) $(timeconst-file)
> diff --git a/Makefile b/Makefile
> index 88db36b..26dbcb7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1513,6 +1513,17 @@ PHONY += $(DOC_TARGETS)
>  $(DOC_TARGETS): scripts_basic FORCE
>         $(Q)$(MAKE) $(build)=Documentation $@
>
> +# Misc
> +# ---------------------------------------------------------------------------
> +
> +PHONY += scripts_gdb
> +scripts_gdb: prepare
> +       $(Q)$(MAKE) $(build)=scripts/gdb/linux build_constants_py
> +
> +ifdef CONFIG_GDB_SCRIPTS
> +all: scripts_gdb
> +endif
> +
>  else # KBUILD_EXTMOD
>
>  ###
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
