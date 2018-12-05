Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FDEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB70420989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvh1W6hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB70420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeLEXTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:19:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33308 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeLEXTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:19:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so10804318plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YlBMkJkpTpZ3nrqYYdySevUvE+u+8g6B7blYj0tBs8=;
        b=jvh1W6hmIRYaI3y1y+H9ApY1qXlPNwYhkTQvi+M3YoIYvAZO5pALSYFKeo+IS+KiJz
         Vyu/6dtD1XrP29uUPJoHIFLLZSXwZQTxjL8onnGXKBXMZ8v+HohQNEv8sQgE1NXGpZ8U
         Vm07LvNw0BhVaK5/tB/rutNGMPKPS3mQ3oWW277EBF267AsFhaKfrO/QcKCbOjKjZ4wf
         fa+uKySQ0LECB4kPVNwwGNOMIWeCb+wXdrNwtxgm6f6yMHDlLW8CY8g0Y8FLD0yHg3p2
         Dj/layW3Edppy4iT7ZG79EeX8IspnsFShhxBcs3nNcVTwOpnu9C9d91aMmX1Gti4BuPd
         IyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YlBMkJkpTpZ3nrqYYdySevUvE+u+8g6B7blYj0tBs8=;
        b=Neb1c/edWffzobcIgviLeliowOPHmlzDxOPDqqHNXMU4u5KspMfzaRyMEtghliJewW
         dN99OxE3BvcpZZ84LjyIseDrr9GzkFQlxHY6oyXl8V+bKavYKK6eywR6FldhzMUL0fL2
         mwwgTLT1PXI1gqKyPrqREDJaWyi/JLxfvwUIupOlH737CuzLtLjZiA0ykPxBx8g2OgUJ
         VYyFJrymMUo+Wh27AUHPRSsxqyGsnZ4T/Qe/WmEn3+8pCqfyY1tzZZzDTzeRHjS6LuWp
         nHwGuBdbn4wjDYLB9oEEe3FjOjb+HBco+/LAKYpdsUt1B/ukZ98deqQMKt3t9d85EfN/
         rSTw==
X-Gm-Message-State: AA+aEWYlCEkn+to650L+O7MeH0ccEfoE3xcgJtSTFns5tD/QKkbNH0ml
        uPqIiBOrzQ1UN0oZLzxhcJpHdM47s2ZCJ9asM7Wq/Q==
X-Google-Smtp-Source: AFSGD/XTaU9ns/7GRI6Ah4JeU4RhqvbOlEsC7/Uhl+EFXVSnZU5ObkzSMES88EmOE4y5OXM55XCI2guYHo5SVsJshqM=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr25785398pll.320.1544051970720;
 Wed, 05 Dec 2018 15:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox> <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox> <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
 <CAKwvOdnQy0HsfDgJeq02opRD1A7fje=bZfpypUFcXWj9CHVyVg@mail.gmail.com> <baba21221482726e9eab67c24c308870@agner.ch>
In-Reply-To: <baba21221482726e9eab67c24c308870@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Dec 2018 15:19:19 -0800
Message-ID: <CAKwvOd=3_s9ogeHvLmb4KzAHbQWjie0rzvj8vkGjHu7HLh8hag@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Stefan Agner <stefan@agner.ch>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux@armlinux.org.uk,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:59 PM Stefan Agner <stefan@agner.ch> wrote:
>
> On 05.12.2018 19:41, Nick Desaulniers wrote:
> > On Wed, Dec 5, 2018 at 10:40 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> >
> >> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> >> > > (+ Arnd)
> >> > >
> >> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> > > >
> >> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> >> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> > > > > >
> >> > > > > > This flag is not supported by lld:
> >> > > > > >
> >> > > > > >     ld.lld: error: unknown argument: --pic-veneer
> >> > > > > >
> >> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> > > > >
> >> > > > > Hi Nate,
> >> > > > >
> >> > > > > Does this mean ld.lld is guaranteed to produce position independent
> >> > > > > veneers if you build kernels that are bigger than the typical range of
> >> > > > > a relative branch?
> >> > > > >
> >> > > >
> >> > > > Hi Ard,
> >> > > >
> >> > > > Honestly, I'm not quite sure. I saw your commit that introduced this
> >> > > > flag and I wasn't quite sure what to make of it for lld. What
> >> > > > configuration would I use to verify and what would I check for?
> >> > > >
> >> > >
> >> > > Try building allyesconfig, and check the resulting binary for veneers
> >> > > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> >> > > them). These veneers should not take the [virtual] address of the
> >> > > branch target directly, but take a PC relative offset (as in the
> >> > > example in the commit log of that patch you are referring to)
> >> > >
> >> >
> >> > Alright, compiling with allyesconfig is a little rough at the moment
> >> > (bug reports I will file in due time) but I was able to do it. Here's
> >> > the disassembly specifically for the functions you had in your commit,
> >> > my assembly knowledge is pretty much non-existent unfortunately so I am
> >> > not sure what to make of it (it doesn't look like there is a virtual
> >> > address for pc in that mix?). I am happy to provide any more information
> >> > that is needed.
> >> >
> >> > c03030cc <__enable_mmu>:
> >> > c03030cc:       e3c00002        bic     r0, r0, #2
> >> > c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
> >> > c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
> >> > c03030d8:       e3a05051        mov     r5, #81 ; 0x51
> >> > c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
> >> > c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
> >> > c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
> >> > c03030e8:       e320f000        nop     {0}
> >> > c03030ec:       e320f000        nop     {0}
> >> > c03030f0:       e320f000        nop     {0}
> >> > c03030f4:       e320f000        nop     {0}
> >> > c03030f8:       e320f000        nop     {0}
> >> > c03030fc:       e320f000        nop     {0}
> >> >
> >> > c0300000 <__turn_mmu_on>:
> >> > c0300000:       e1a00000        nop                     ; (mov r0, r0)
> >> > c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> >> > c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
> >> > c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> >> > c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> >> > c0300014:       e1a03003        mov     r3, r3
> >> > c0300018:       e1a0300d        mov     r3, sp
> >> > c030001c:       e1a0f003        mov     pc, r3
> >> >
> >>
> >> Thanks Nate.
> >>
> >> So these functions no longer appear to reside far away from each
> >> other, so there no veneer has been emitted.
> >>
> >> What we're looking for are veneers, i.e., snippets inserted by the
> >> linker that serve as a trampoline so a branch target that is far away
> >> can be reached.
> >>
> >> If no symbols exist with 'veneer' in their name *, it might make sense
> >> to rebuild the kernel as Thumb2, which has a branching range of only 8
> >> MB (as opposed to 16 MB for ARM mode)
> >
> > Heh, Arnd and I were just talking about this yesterday.  Is there a
> > config that sets Thumb2 mode for the kernel?
> >
>
> Yes there is CONFIG_THUMB2_KERNEL, and it works also with LLVM/Clang.

Sounds like something we should put under CI?
https://github.com/ClangBuiltLinux/continuous-integration/issues/94

>
> However, it sometimes leads to surprising issues, like I just
> encountered a few days ago:
>
> https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/
>
> --
> Stefan
>
> >>
> >> * I have no idea whether lld names its veneers like this, or even at all



-- 
Thanks,
~Nick Desaulniers
