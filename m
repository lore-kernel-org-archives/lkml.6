Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925C32082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqkHsvjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925C32082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeLEVDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:03:41 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40585 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLEVDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:03:41 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so17873258ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2LeyrbYXfRH1BI9PT1B9H1Kioax9Jrm51xlN681W0s=;
        b=gqkHsvjkVRz2Tt67G5Und+P2Bl37mNfBtjVB9Tr2NR3D4Kj5yNYvaWPuHfeC0Ev6xd
         z5AvRO4URcERCJpVtxgd5Wvlwf9NKoDIaI9qCJ8G9tkmJqdRuAyQI9c73/1c67PfCDJY
         OMmFrpXJ1z71K05Rwy9rMkwdb8/Ulp5Ug2jVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2LeyrbYXfRH1BI9PT1B9H1Kioax9Jrm51xlN681W0s=;
        b=YQeJq5NBQhsuhtHth1K4knd58zn8iCZ8argqHHqq+ob7cjTNUzr/aBaNCY+OUDOiIs
         4I2qSnUQT/YPX6Mj9bc94HSb9GfCMYmUJrE3RhupyaFaKIQHon2EEdrcfDrAr7uRB+eR
         Nz1fVXzktCx37sp0M1l6JjJFGZ9iHG0JJBhsFGRH9E0Sp551/jV1CPnjK4L5vbFjPlfK
         90qnj1P3tcsinrxWgHjJs/+UIYwAbroke9x0D42gN1SP7cd1sMDWqlaZQP21UAIwftzB
         pA0B72qyo8cYI1KzTl3kexSOsf1N3CMhXrPfK+9u68b6mOHzIgGYS3HXnX8JtZfzWRzV
         hmQg==
X-Gm-Message-State: AA+aEWaR1/2erwy30oWxhVKCg/JPIoUmsF2nufU9inswtiWko7M5H0Ux
        CYFgBWDa8NQ0wWKrE5dGeQqnll5biS17yL2mx0eTyFvpOis=
X-Google-Smtp-Source: AFSGD/W0ZS4IOVynKxF0LMHE134uRY44SMcfmqZCnOyLeN8uEonDA53X1jNKq2qrFkaSrIqT9GiKrMPiFVOFwSMNfng=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr16777850iok.60.1544043819677;
 Wed, 05 Dec 2018 13:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox> <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox> <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
 <20181205194519.GA9197@flashbox>
In-Reply-To: <20181205194519.GA9197@flashbox>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Dec 2018 22:03:28 +0100
Message-ID: <CAKv+Gu_gCZA5Rg9y9_ujK-KDfhq0dZxytR0TPRMjWW=t1x=0bQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 20:45, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> On Wed, Dec 05, 2018 at 07:39:55PM +0100, Ard Biesheuvel wrote:
> > On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> > > > (+ Arnd)
> > > >
> > > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > >
> > > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > > > >
> > > > > > > This flag is not supported by lld:
> > > > > > >
> > > > > > >     ld.lld: error: unknown argument: --pic-veneer
> > > > > > >
> > > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > >
> > > > > > Hi Nate,
> > > > > >
> > > > > > Does this mean ld.lld is guaranteed to produce position independent
> > > > > > veneers if you build kernels that are bigger than the typical range of
> > > > > > a relative branch?
> > > > > >
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > Honestly, I'm not quite sure. I saw your commit that introduced this
> > > > > flag and I wasn't quite sure what to make of it for lld. What
> > > > > configuration would I use to verify and what would I check for?
> > > > >
> > > >
> > > > Try building allyesconfig, and check the resulting binary for veneers
> > > > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> > > > them). These veneers should not take the [virtual] address of the
> > > > branch target directly, but take a PC relative offset (as in the
> > > > example in the commit log of that patch you are referring to)
> > > >
> > >
> > > Alright, compiling with allyesconfig is a little rough at the moment
> > > (bug reports I will file in due time) but I was able to do it. Here's
> > > the disassembly specifically for the functions you had in your commit,
> > > my assembly knowledge is pretty much non-existent unfortunately so I am
> > > not sure what to make of it (it doesn't look like there is a virtual
> > > address for pc in that mix?). I am happy to provide any more information
> > > that is needed.
> > >
> > > c03030cc <__enable_mmu>:
> > > c03030cc:       e3c00002        bic     r0, r0, #2
> > > c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
> > > c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
> > > c03030d8:       e3a05051        mov     r5, #81 ; 0x51
> > > c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
> > > c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
> > > c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
> > > c03030e8:       e320f000        nop     {0}
> > > c03030ec:       e320f000        nop     {0}
> > > c03030f0:       e320f000        nop     {0}
> > > c03030f4:       e320f000        nop     {0}
> > > c03030f8:       e320f000        nop     {0}
> > > c03030fc:       e320f000        nop     {0}
> > >
> > > c0300000 <__turn_mmu_on>:
> > > c0300000:       e1a00000        nop                     ; (mov r0, r0)
> > > c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> > > c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
> > > c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> > > c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> > > c0300014:       e1a03003        mov     r3, r3
> > > c0300018:       e1a0300d        mov     r3, sp
> > > c030001c:       e1a0f003        mov     pc, r3
> > >
> >
> > Thanks Nate.
> >
> > So these functions no longer appear to reside far away from each
> > other, so there no veneer has been emitted.
> >
> > What we're looking for are veneers, i.e., snippets inserted by the
> > linker that serve as a trampoline so a branch target that is far away
> > can be reached.
> >
> > If no symbols exist with 'veneer' in their name *, it might make sense
> > to rebuild the kernel as Thumb2, which has a branching range of only 8
> > MB (as opposed to 16 MB for ARM mode)
> >
> > * I have no idea whether lld names its veneers like this, or even at all
>
> Thanks Ard, I understand now, I appreciate that.
>
> I compiled with CONFIG_THUMB2_KERNEL (config attached) and I am still
> not seeing any veneers or thunks as Peter said they would be called for
> lld in the LLVM bug report linked earlier in the thread. Peter did note
> that the branch ranges were 32MB and 16MB for ARM and Thumb2
> respectively, which could be playing into this.
>

Ah, indeed. Off by one :-)

However, even when building in ARM rather than Thumb2 mode,
allyesconfig gives me

ard@harold:~/linux-build-arm$ size vmlinux
   text    data     bss     dec     hex filename
107708906 50335363 15258568 173302837 a546435 vmlinux
ard@harold:~/linux-build-arm$ grep -cE _veneer$ System.map
16199

so surely, lld is emitting veneers but perhaps it doesn't emit symbols
for them in the same way as ld.bfd does.

Actually, most of those veneers are fine, given that the vast majority
of the code will only run at its proper link time address. However,
some pieces run with the MMU off, either at early boot or around
suspend/resume, and so we need veneers to be position independent.
