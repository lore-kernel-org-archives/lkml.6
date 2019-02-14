Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A75222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L/wiytS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404956AbfBNCKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:48 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35392 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393208AbfBNCKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:46 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x1E2AN6q021663;
        Thu, 14 Feb 2019 11:10:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x1E2AN6q021663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550110224;
        bh=NSQMTcNaXTqiGZ0wR123OhbEK3fPd6EroBCfbsKBZDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L/wiytS1KE2GFAqyWp+pWZst4oRu7NQICSAiU4SjF2UBBJ636ZPq58VeH+AbC7Hj8
         rgvlpSQU+3b+2QZTtF428FfrAZKYdJj+OhWIqpwW49ZwzKjw4cFlGh5SKBb8gjSC/2
         CMDrWGa149BKqk4WI/cXTWf5kqtU8nVhQ/5HAMW2lli3hqDTWOVMQGJfLT07m/+GWG
         kJpLVnKyv/a991Y6EZAOFxWB7C++mnnNduGJpzvp8WtSe7GHP+ykYyjzENQ5pBddz9
         PhE+XkUdXbPmDnMLsEO10PGehBuZAazzY3J9a3ueE2BDbDMl/rGWEYnRe4VT7Tac/j
         kkzcxUx716fiw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id r201so2683772vsc.11;
        Wed, 13 Feb 2019 18:10:24 -0800 (PST)
X-Gm-Message-State: AHQUAuY5ez+Aw2rumjLNGFaVWueoZ2l/kezg4u2sH9L5m/i26DXdbHVK
        TqHcGyPQNxksxw649TLVdCVonTOF3bRe72eJnxg=
X-Google-Smtp-Source: AHgI3IbsKOo5unpK201l/M2bLEIUtuS8Um9p09zc5mH9RGRunZzSCkBK9fPSTH/pUbjo21o9LYzkqrjEdpTpQKNrAjc=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr715092vsd.155.1550110223142;
 Wed, 13 Feb 2019 18:10:23 -0800 (PST)
MIME-Version: 1.0
References: <1549352017-3503-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1549352017-3503-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Feb 2019 11:09:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATM-A_+KE59Q2oJTsvd_sgYnkuN4QqXjWdZrB_zxT94MA@mail.gmail.com>
Message-ID: <CAK7LNATM-A_+KE59Q2oJTsvd_sgYnkuN4QqXjWdZrB_zxT94MA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move archive command to scripts/Makefile.lib
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 4:34 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> scripts/Makefile.build and arch/s390/boot/Makefile use the same
> command (thin archiving with symbol table creation).
>
> Avoid the code duplication, and move it to scripts/Makefile.lib.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>  arch/s390/boot/Makefile | 3 ---
>  scripts/Makefile.build  | 6 +-----
>  scripts/Makefile.lib    | 6 ++++++
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index 11ca879..c844eaf 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -57,9 +57,6 @@ $(obj)/section_cmp%: vmlinux $(obj)/compressed/vmlinux FORCE
>  $(obj)/compressed/vmlinux: $(obj)/startup.a FORCE
>         $(Q)$(MAKE) $(build)=$(obj)/compressed $@
>
> -quiet_cmd_ar = AR      $@
> -      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> -
>  $(obj)/startup.a: $(OBJECTS) FORCE
>         $(call if_changed,ar)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index f8e2794..99be01c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -424,13 +424,9 @@ $(modorder-target): $(subdir-ym) FORCE
>  # Rule to compile a set of .o files into one .a file (with symbol table)
>  #
>  ifdef lib-target
> -quiet_cmd_link_l_target = AR      $@
> -
> -# lib target archives do get a symbol table and index
> -cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
>
>  $(lib-target): $(lib-y) FORCE
> -       $(call if_changed,link_l_target)
> +       $(call if_changed,ar)
>
>  targets += $(lib-target)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index c0abd9a..8a1f64f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -233,6 +233,12 @@ $(obj)/%: $(src)/%_shipped
>  quiet_cmd_ld = LD      $@
>        cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
>
> +# Archive
> +# ---------------------------------------------------------------------------
> +
> +quiet_cmd_ar = AR      $@
> +      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> +
>  # Objcopy
>  # ---------------------------------------------------------------------------
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
