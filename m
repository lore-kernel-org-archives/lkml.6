Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E0C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFDD20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hbNksNzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFDD20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408171AbeKWPqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:46:15 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:56787 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeKWPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:46:15 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wAN53HPH015148;
        Fri, 23 Nov 2018 14:03:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wAN53HPH015148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542949398;
        bh=cw1YI/Tdp8pjMDn66rzvq23bx1Rm/g7R0V/lcLntKzU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbNksNzznUqE/Pw+UaJRFKzXwhcurpL7/DZT6MjBzZsIFpmomQyp16RDGzoPA9rmP
         4IiQKOmM/J3x+ztocPgLeVBOt4aNqC9bGVGqpB6FQhIS8JorirmhCzIiyvNNHS8LKR
         A7nlpTJYrBj6Y1YlKdGGqHcm719vf78kodSXRd8d1Mpqm7qMJp1uy66xMQqjaXS7Kn
         atf8nzgGwr7yjRWn6eIPTHujPBN8vjAcu/YITkw3cEx0FxQwIsV79TVMuy44kCX7pv
         kujtW93rGXM4cX2QWbeF8YwE7h7sKwkyYVcss73cttKu9vOu8xJxG8F67wZu8O/2Q/
         bp/RwdDg6XvGQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id b74so6486848vsd.9;
        Thu, 22 Nov 2018 21:03:17 -0800 (PST)
X-Gm-Message-State: AGRZ1gJAxDRCpQg3ebBM/jxNkzGa04lhcnpcFQ2oVk6kL+ujNeJ/oCc4
        7oS+KiGoBkM74LHb2jv1vcEWCYB17G5MExZ8Ebs=
X-Google-Smtp-Source: AJdET5dQYUuxXvaUK3JCMxUp7wNYPmzdmSVtZSgFs9yUyRXtwQ8y9gc0NnlkM814GNN3mCA62G+3LPIsf/w/QxnXnk4=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr6001761vsb.155.1542949396352;
 Thu, 22 Nov 2018 21:03:16 -0800 (PST)
MIME-Version: 1.0
References: <1542734004-2673-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542734004-2673-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 14:02:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT35jjpRr_n7p-mUTXj9fCtBzyGcwQfwZdbL8_CtUA9mg@mail.gmail.com>
Message-ID: <CAK7LNAT35jjpRr_n7p-mUTXj9fCtBzyGcwQfwZdbL8_CtUA9mg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move modpost out of 'scripts' target
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 2:16 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I am eagar to build under the scripts/ directory only with $(HOSTCC),
> but scripts/mod/ highly depends on the $(CC) and target arch headers.
> That it why the 'scripts' target must depend on 'asm-generic',
> 'gcc-plugins', and $(autoksyms_h).
>
> Move it to the 'prepare0' stage. I know this is a cheesy workaround,
> but better than the current situation.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-kbuild.



> ---
>
>  Makefile             | 3 ++-
>  scripts/Makefile     | 3 +--
>  scripts/mod/Makefile | 2 --
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b78cc97..21a7729 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1073,7 +1073,7 @@ include/config/kernel.release: $(srctree)/Makefile FORCE
>  # Carefully list dependencies so we do not try to build scripts twice
>  # in parallel
>  PHONY += scripts
> -scripts: scripts_basic scripts_dtc asm-generic gcc-plugins $(autoksyms_h)
> +scripts: scripts_basic scripts_dtc
>         $(Q)$(MAKE) $(build)=$(@)
>
>  # Things we need to do before we recursively start building the kernel
> @@ -1111,6 +1111,7 @@ macroprepare: prepare1 archmacros
>  archprepare: archheaders archscripts macroprepare scripts_basic
>
>  prepare0: archprepare gcc-plugins
> +       $(Q)$(MAKE) $(build)=scripts/mod
>         $(Q)$(MAKE) $(build)=.
>
>  # All the preparing..
> diff --git a/scripts/Makefile b/scripts/Makefile
> index ece52ff..b48259d 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -37,9 +37,8 @@ build_unifdef: $(obj)/unifdef
>         @:
>
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
> -subdir-y                     += mod
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
>  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
>
>  # Let clean descend into subdirs
> -subdir-        += basic dtc kconfig package gcc-plugins
> +subdir-        += basic dtc kconfig mod package gcc-plugins
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index a5b4af4..42c5d50 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -4,8 +4,6 @@ OBJECT_FILES_NON_STANDARD := y
>  hostprogs-y    := modpost mk_elfconfig
>  always         := $(hostprogs-y) empty.o
>
> -CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
> -
>  modpost-objs   := modpost.o file2alias.o sumversion.o
>
>  devicetable-offsets-file := devicetable-offsets.h
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
