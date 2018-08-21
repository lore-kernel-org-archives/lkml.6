Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B029C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD171216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAb6bVix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD171216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHUUSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:18:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34272 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHUUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:18:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so8731178pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt8NKNjnFYqTumjIQyKLOk7XINO5y66ZYHHMjTS1uWI=;
        b=XAb6bVixTf+P1rEEfh5H2iN8kNNIQZO6ecrJDTkZa6TdwYylNrD1gy2EUay4Ucin9x
         raOKFi2rx3fadIwVfxGzfUIEsq1iQhRpu0swx0JoE6N03HJ8ZWOUKHLT/mJHeUqUkxoa
         FZUaStC2B7sj2y7boJj12gdqQi4SUWATq7gVGNPqinCL27ZrB9RdCHImQHjp9VmOR7Nn
         XOvEtCp0GiAVHTmNqHHpChB9Aag4RYllLbQ/x1C2L+hAJMhJFnVl3Wmri7NHDqiAOayA
         d9PPUuiXosTxE7f5NOfm4eHm4MKRe1fS/Hx/YHEnSusfh5eWWi0h5R+wpLG/3AyxjC6k
         hoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt8NKNjnFYqTumjIQyKLOk7XINO5y66ZYHHMjTS1uWI=;
        b=KzPS77U3011hwHxCaybYD/PAFo6To+NlJFI1f9PM29/KJbI6VjYRzLGJKtvkNFFh58
         daNWFfV+J/AqNCu4f9LhHRxoCCqxlvwpQzNLa46m+mSAPGpoGjEotjs8QcAmRa1LWpzq
         usDr8vedj1wO/nwCqk+fQ2uECT5kKlkmbxLS3iKt4GlMIxMt+SZM3Ch30bmuXfpsUaBN
         wqU3NyK06G6kwbEKKjimv3sX9KdcIRxKS89rH1/O4CEVdkBaR4QzkW3s6boswCDRBsWp
         15pHSIKXDBZCrfL3eAWIQgu0zRX0lx84ITVRbHoeR51lfr3K7l7SzowU7XzmtDeewrHo
         i2fg==
X-Gm-Message-State: AOUpUlEzee59BHbyg4b/ilkT3PUR3yX1bcOza4cicO1J+TXk1L30sGFI
        /GBQTS6cLWUVtsaZAhLWMqD34h1994v2L/GP+Vm4SQ==
X-Google-Smtp-Source: AA+uWPxgc9ILFsWPB7EWfF9H3tcyiEiALu3D/erqbS/sbU6jlke3dH0dV5n9AtAEGvDbcr29quJ/EUaGnFVHeCcRZ6o=
X-Received: by 2002:a63:2352:: with SMTP id u18-v6mr9951593pgm.202.1534870643289;
 Tue, 21 Aug 2018 09:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com> <6b1d5081e2da107537f72125fc595229128b46e6.camel@perches.com>
In-Reply-To: <6b1d5081e2da107537f72125fc595229128b46e6.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 09:57:11 -0700
Message-ID: <CAKwvOdkgtoNJuagT_uoNnDKcxHAjsvfWo9hQMP2OKz9_qpstNQ@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     joe@perches.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 9:33 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
> > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > missed the fact that <linux/compiler-gcc.h> is included by Clang
> > as well as by GCC.
> >
> > Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
> > and it looks like GCC 4.2.1.
> >
> >   $ scripts/gcc-version.sh -p clang
> >   040201
> >
> > If you try to build the kernel with Clang, you will get the
> > "Sorry, your compiler is too old - please upgrade it."
> > followed by a bunch of "unknown attribute" warnings.
> >
> > Add !defined(__clang__) to the minimum version check.
> >
> > Also, revive the version test blocks for versions >= 4.2.1
> > in order to disable features not supported by Clang.
>
> What is the minimum clang version required to compile the kernel?

Depends on the architecture and which kernel version/LTS branch you're
using.  I'm trying to backport fixes to LTS branches, but sometimes a
compiler upgrade is required.  I know that's not great, but I'm
actively trying to fix it.

> What features are not supported by the minimum clang version?
>
> On my system, using clang
>
> $ clang -v
> clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>
> and
>
> $ git checkout v4.16 ; make clean ; make CC=clang defconfig ; make CC=clang
> HEAD is now at 0adb32858b0b... Linux 4.16
>
> is successful
>
> but
>
> $ git checkout v4.17 ; make clean ; make CC=clang defconfig ; make CC=clang
> HEAD is now at 29dcea88779c... Linux 4.17
> arch/x86/Makefile:184: *** Compiler lacks asm-goto support..  Stop.
> arch/x86/Makefile:184: *** Compiler lacks asm-goto support..  Stop.
>

See commit e501ce9 ("x86: Force asm-goto").

$ git describe --contains e501ce9 | sed 's/~.*//'
v4.17-rc1

-- 
Thanks,
~Nick Desaulniers
