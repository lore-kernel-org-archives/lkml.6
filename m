Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B66C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752082133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GmRY2gSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfB0Mjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:39:31 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43806 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfB0Mja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:39:30 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1RCdPqR018731;
        Wed, 27 Feb 2019 21:39:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1RCdPqR018731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551271166;
        bh=r1divGBUE66G06en0aoDQbR1kyvd3tc3ImJpkDY0ut0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GmRY2gSFe2DKjBYmny/cJd0n+CiypFPsLo/kLCTZ1l8WGYCbpShyVitPg4SZrPQ2p
         Sn5D8ch7X2RZx5YY2sNsWF/3jDD0m7sPmzTwLbtqV2Qz7a39t3nCTAjIBcYWCZ4Xtw
         FybaUeT8MFsBtKwshLO7R5LKoItnuchMxsGaqLv57Qa/zfMr+yZXTFlIbRDFhQ9kVi
         10cT/MFg/yNWfDweCw3zeEa3AG2HYFe6WunvB+Rbqrr9Z/Amm/89BA5kkxiSBs9rT0
         W2je/xCeSGmBMlyAT/cQhbf3d9ts4wZHloer4iUEZVItwMOJQM2mhEBOtTsp79MM1+
         yk3eDQNX/R29A==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id k64so3810443vke.1;
        Wed, 27 Feb 2019 04:39:26 -0800 (PST)
X-Gm-Message-State: AHQUAub98+Qq582tyH/w4t7+EmejuDaxRR5UIw6YTWQpp9XPjmi25Z5H
        T9koavybUKvf/ONiMxHFTxg8j6xxpN+xf0cy49I=
X-Google-Smtp-Source: AHgI3IZ0yG4C2yC5IeIRbvFVvbwzt+B9CNJpCxGo3znCi3DYojD434/pH6PM9idvAgMzuV25P8+NLa7fraokOs7G75w=
X-Received: by 2002:a1f:5e96:: with SMTP id s144mr498808vkb.74.1551271165216;
 Wed, 27 Feb 2019 04:39:25 -0800 (PST)
MIME-Version: 1.0
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
 <1550568787-18710-3-git-send-email-yamada.masahiro@socionext.com> <b7edc974-ab67-44ee-3aaa-8cac3d9bd82b@ideasonboard.com>
In-Reply-To: <b7edc974-ab67-44ee-3aaa-8cac3d9bd82b@ideasonboard.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Feb 2019 21:38:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARD-kVxntRx8hHfRXExafqZsMJp0L8gXpY6gvQZO3m2-w@mail.gmail.com>
Message-ID: <CAK7LNARD-kVxntRx8hHfRXExafqZsMJp0L8gXpY6gvQZO3m2-w@mail.gmail.com>
Subject: Re: [PATCH 3/5] scripts/gdb: do not descend into scripts/gdb from scripts
To:     kieran.bingham@ideasonboard.com
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Wed, Feb 27, 2019 at 8:46 PM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Yamada-san,
>
> On 19/02/2019 09:33, Masahiro Yamada wrote:
> > Currently, Kbuild descends from scripts/Makefile to scripts/gdb/Makefile
> > just for creating symbolic links, but it does not need to do it so early.
> >
> > Merge the two descending paths to simplify the code.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  Makefile                   | 2 +-
> >  scripts/Makefile           | 3 +--
> >  scripts/gdb/linux/Makefile | 9 +++------
> >  3 files changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 26dbcb7..a5762c6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1518,7 +1518,7 @@ $(DOC_TARGETS): scripts_basic FORCE
> >
> >  PHONY += scripts_gdb
> >  scripts_gdb: prepare
> > -     $(Q)$(MAKE) $(build)=scripts/gdb/linux build_constants_py
> > +     $(Q)$(MAKE) $(build)=scripts/gdb
> >
> >  ifdef CONFIG_GDB_SCRIPTS
> >  all: scripts_gdb
> > diff --git a/scripts/Makefile b/scripts/Makefile
> > index feb1f71..9d442ee 100644
> > --- a/scripts/Makefile
> > +++ b/scripts/Makefile
> > @@ -39,7 +39,6 @@ build_unifdef: $(obj)/unifdef
> >  subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
> >  subdir-$(CONFIG_MODVERSIONS) += genksyms
> >  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> > -subdir-$(CONFIG_GDB_SCRIPTS) += gdb
> >
> >  # Let clean descend into subdirs
> > -subdir-      += basic dtc kconfig mod package
> > +subdir-      += basic dtc gdb kconfig mod package
> > diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
> > index aba23be..7545806 100644
> > --- a/scripts/gdb/linux/Makefile
> > +++ b/scripts/gdb/linux/Makefile
> > @@ -14,11 +14,8 @@ quiet_cmd_gen_constants_py = GEN     $@
> >       $(CPP) -E -x c -P $(c_flags) $< > $@ ;\
> >       sed -i '1,/<!-- end-c-headers -->/d;' $@
> >
> > -targets += constants.py
> > -$(obj)/constants.py: $(SRCTREE)/$(obj)/constants.py.in FORCE
> > +extra-y += constants.py
> > +$(obj)/constants.py: $(src)/constants.py.in FORCE
> >       $(call if_changed_dep,gen_constants_py)
> >
> > -build_constants_py: $(obj)/constants.py
> > -     @:
> > -
> > -clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py) $(obj)/constants.py
> > +clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py)
>
>
> This looks like the generated file will no longer be cleaned on
> distclean, if the build is 'in-tree'... Is that right? Or OK if so?


As you noticed in 5/5, files listed in $(extra-y) are cleaned up.

So, I removed the now redundant $(obj)/constants.py from 'clean-files'.



> Perhaps I'm mis-understanding the "$(if $(KBUILD_SRC),*.py)" statement
> intent?


$(if $(KBUILD_SRC),*.py) will clean *.py only for out-of-tree build.

'*.py' files in the build directory are symbolic links.

'*.py' files in the source directory are check-in source files.



> As long as you're content with the result, and it's understood:
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>



--
Best Regards

Masahiro Yamada
