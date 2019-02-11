Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE14C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F373121B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjCK47gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfBKSRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:17:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40959 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfBKSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:17:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so2823407pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNKvlhATBFZVonShAC/U+yr/Q9vhBiyJjXe6MSCRJrE=;
        b=UjCK47glau/YbFQXXw4TC1dxBLiIYi/B8lKA/qe/XbMMNyCu55AqD0Za/FCdGQQxhw
         RrGN89Qs/xSPC5Je8OugJagNdxlYNelm5/8lijcXNLcYN0I5iIRmWj1QDW1XPgJWbtwf
         CA210PPgdgEfDAlPyYp97ESsSrmiVl4bQqgx5fvP5K6VutSPWOJWybyHChTX7Cc+RdSM
         SadzDW4vwziXkATSTo02DTAaMQWQ8L9EzEJ60wKg4cqbpGLQeGJsIoJkEwXTTkrwNPCo
         0zV8olNa3n2YAcxqtRFntuyMqi6YLTOmdgexOfkoVZlWr9p6VQ0Z3EA+d9NHEiqnUhyF
         qcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNKvlhATBFZVonShAC/U+yr/Q9vhBiyJjXe6MSCRJrE=;
        b=lbea68tfDvzI+2sfsLRIm0JOy4emcPWm3X61lg072cDsEpgLGF5qFUzEV5mT/XxuGl
         KebRmZaIfp1+y8tBlTaLSOT14pQOVRgX6SjD/bG2kntFypKNUzhGzweZYczlVXwfEa7K
         lNV/+dI8AlriFv9C0GiH1FvV+VAI6w1w2M4vqwGqZ2sSs/wg4Y2ot82+9ICBgdR2J0di
         msLllJQncuast9VPeI+j75YW4J0LJly/2/C64V6hV0xn8aDmAnZ1NXwh92bS04bWeUhW
         vTtxazHbYJQrwG4Ol6mwMJ4Jde4ex1u8iSrx/2dfTYJ7m1gpvbxdwqAUdUe2gfzXMgrc
         xUNA==
X-Gm-Message-State: AHQUAuYiW/sSIfKiWtoZVJzkiL4juQO/5mF84hHoSywcFOafgyFWjRmb
        920SaP8JvbXuEXEttvG0Fl8mHIcpUc0RmqPGaHK4Tg==
X-Google-Smtp-Source: AHgI3IbnG2wI8bPyuZz0pgcU88iFpQo08cAWVJj5p7WViaASCDiqapkdplLyT2zxrJ6Ox8S0TJVk/sK8iYRhES4fFkE=
X-Received: by 2002:a62:109b:: with SMTP id 27mr37424825pfq.227.1549909052874;
 Mon, 11 Feb 2019 10:17:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549532513.git.stefan@agner.ch> <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
 <db0e6b8f034f832c7e52fe3dd47073ad@agner.ch>
In-Reply-To: <db0e6b8f034f832c7e52fe3dd47073ad@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Feb 2019 10:17:21 -0800
Message-ID: <CAKwvOdnqOkdD9fFoXmSKZNmceaXcWtdaZ2iwKej3=X-LL0DS9Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: use unified assembler in c files
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 9:28 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Thanks for the reviews so far.
>
> During some more testing I stumbled upon another issue:
>
> On 07.02.2019 10:48, Stefan Agner wrote:
> > Use unified assembler syntax (UAL) in inline assembler. Divided
> > syntax is considered depricated. This will also allow to build
> > the kernel using LLVM's integrated assembler.
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  arch/arm/mm/copypage-v4mc.c | 2 +-
> >  arch/arm/mm/copypage-v4wb.c | 2 +-
> >  arch/arm/mm/copypage-v4wt.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
> > index b03202cddddb..b19c7ad1a6de 100644
> > --- a/arch/arm/mm/copypage-v4mc.c
> > +++ b/arch/arm/mm/copypage-v4mc.c
> > @@ -56,7 +56,7 @@ static void mc_copy_user_page(void *from, void *to)
> >       ldmia   %0!, {r2, r3, ip, lr}           @ 4\n\
> >       subs    %2, %2, #1                      @ 1\n\
> >       stmia   %1!, {r2, r3, ip, lr}           @ 4\n\
> > -     ldmneia %0!, {r2, r3, ip, lr}           @ 4\n\
> > +     ldmiane %0!, {r2, r3, ip, lr}           @ 4\n\
> >       bne     1b                              @ "
> >       : "+&r" (from), "+&r" (to), "=&r" (tmp)
> >       : "2" (PAGE_SIZE / 64)
> > diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
> > index cd3e165afeed..6e3c9b69dd25 100644
> > --- a/arch/arm/mm/copypage-v4wb.c
> > +++ b/arch/arm/mm/copypage-v4wb.c
> > @@ -38,7 +38,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
> >       ldmia   %1!, {r3, r4, ip, lr}           @ 4\n\
> >       subs    %2, %2, #1                      @ 1\n\
> >       stmia   %0!, {r3, r4, ip, lr}           @ 4\n\
> > -     ldmneia %1!, {r3, r4, ip, lr}           @ 4\n\
> > +     ldmiane %1!, {r3, r4, ip, lr}           @ 4\n\
> >       bne     1b                              @ 1\n\
> >       mcr     p15, 0, %1, c7, c10, 4          @ 1   drain WB"
> >       : "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> > diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
> > index 8614572e1296..4a40fa1cbc2a 100644
> > --- a/arch/arm/mm/copypage-v4wt.c
> > +++ b/arch/arm/mm/copypage-v4wt.c
> > @@ -34,7 +34,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
> >       ldmia   %1!, {r3, r4, ip, lr}           @ 4\n\
> >       subs    %2, %2, #1                      @ 1\n\
> >       stmia   %0!, {r3, r4, ip, lr}           @ 4\n\
> > -     ldmneia %1!, {r3, r4, ip, lr}           @ 4\n\
> > +     ldmiane %1!, {r3, r4, ip, lr}           @ 4\n\
> >       bne     1b                              @ 1\n\
> >       mcr     p15, 0, %2, c7, c7, 0           @ flush ID cache"
> >       : "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
>
> When compiling with gcc, this leads to:
>
> /tmp/ccrvA1wy.s: Assembler messages:
> /tmp/ccrvA1wy.s:180: Error: bad instruction `ldmiane r0!,{r3,r4,ip,lr}'
> make[1]: *** [scripts/Makefile.build:277: arch/arm/mm/copypage-v4wb.o]
> Error 1
> make: *** [Makefile:1042: arch/arm/mm] Error 2
>
> Unfortunately, the gcc option -masm-syntax-unified which allows unified
> syntax in inline assembly is broken (see also
> https://lkml.org/lkml/2019/1/7/1320).
>
> So this requires to sprinkle those inline assembly with ".syntax
> unified" strings, similar to how I've done it in uaccess.h.

Not sure if this is purely a bug in GCC; Clang treats inline asm
statements as unique, so asm directives do not carry over from one
inline asm statement to another.  This has caused issues in other
arch's inline assembly, where we need to repeat asm directives
repeatedly for each inline asm statement.
https://bugs.llvm.org/show_bug.cgi?id=19749

-- 
Thanks,
~Nick Desaulniers
