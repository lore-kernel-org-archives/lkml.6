Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD42081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9FAF89+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AD42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeLESlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:41:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeLESlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:41:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so10433013pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+1EMzKOjBiwuGhi/MG7K020+yXNrdMNTDqMByOmEvg=;
        b=a9FAF89+5mJzJDYK0vVpio2YzWrh8xf0wB8knrh4Ke7fIXgXegBewd2sQcbLbsXcSn
         5TfdISC02xFy7I1TY0IXNGErq8X+ZmeAobFzYt1G8kyPiPxNYsyjMWjfdSlgPCDhL/jl
         hcG+OF9TfhfvrxYX5lVA5I5wolPBFFrzrEPl9N02VyBpFVKyobmYvoQBlgZsCPi6+mCB
         8ulO1oglNCKGM8rBao53rwQVNWHujtvEeW4yP0ymt6VKO7chEGLjTGQRD9xvG3xG/VKO
         yPRezMUBU++CtACz8A2C1wm6Xpziyk2R5qN7H4K6gKudv/oZk8QTbm4Z0Oppb4JrwWyR
         tKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+1EMzKOjBiwuGhi/MG7K020+yXNrdMNTDqMByOmEvg=;
        b=Mh00Nn/pWUD9YZ6OxSqPMtyI/t5ekj4lo0CtVSNwerkervFgeIPmOH0Zs7/q4p1mug
         inOn1NlizPeyz9gKbvvhbohCuCv7hKWa6AVOFxa8YdBOaDr4SmVVEWtMPnr2V8qxopqN
         0EWkXWI/28XkQa1Xbb/b/i6zRT0z9Y3dV+5LhhWMjsBkC5tHMn8PbbPbDjCkCB7KEoAs
         tlfvHiVjUmK8AJ6MUjrIFXUJ1ToTIUOmsSPhMnk5oRF8amHRHRof5yCelDcFRajxKglH
         /ZtvVQHU7gBhqs6tx58gLsSbz6Q4RhAx7uk++WAIzeEt9GAyCWcE5g8gIxvAbl02jxlr
         cpEA==
X-Gm-Message-State: AA+aEWY7s3Gfy2fIKrmamdeSO+Chc8/LmvEVKtO/l+RxEso0AijSqoJy
        b9Ad1e5wH0JvVUXqfxqibD1Af8JzAKngmyoUdcGlSw==
X-Google-Smtp-Source: AFSGD/V0tUGv06YjyOZoyqygkks8HCVAH16MVZixH/mtBr7QSJV2jc6pDPU/UYkzGu/kXH91xsC8ArpERy0YINJNE34=
X-Received: by 2002:a62:b80a:: with SMTP id p10mr25381895pfe.32.1544035304921;
 Wed, 05 Dec 2018 10:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox> <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox> <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Dec 2018 10:41:33 -0800
Message-ID: <CAKwvOdnQy0HsfDgJeq02opRD1A7fje=bZfpypUFcXWj9CHVyVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux@armlinux.org.uk,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 10:40 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> > > (+ Arnd)
> > >
> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > > >
> > > > > > This flag is not supported by lld:
> > > > > >
> > > > > >     ld.lld: error: unknown argument: --pic-veneer
> > > > > >
> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > >
> > > > > Hi Nate,
> > > > >
> > > > > Does this mean ld.lld is guaranteed to produce position independent
> > > > > veneers if you build kernels that are bigger than the typical range of
> > > > > a relative branch?
> > > > >
> > > >
> > > > Hi Ard,
> > > >
> > > > Honestly, I'm not quite sure. I saw your commit that introduced this
> > > > flag and I wasn't quite sure what to make of it for lld. What
> > > > configuration would I use to verify and what would I check for?
> > > >
> > >
> > > Try building allyesconfig, and check the resulting binary for veneers
> > > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> > > them). These veneers should not take the [virtual] address of the
> > > branch target directly, but take a PC relative offset (as in the
> > > example in the commit log of that patch you are referring to)
> > >
> >
> > Alright, compiling with allyesconfig is a little rough at the moment
> > (bug reports I will file in due time) but I was able to do it. Here's
> > the disassembly specifically for the functions you had in your commit,
> > my assembly knowledge is pretty much non-existent unfortunately so I am
> > not sure what to make of it (it doesn't look like there is a virtual
> > address for pc in that mix?). I am happy to provide any more information
> > that is needed.
> >
> > c03030cc <__enable_mmu>:
> > c03030cc:       e3c00002        bic     r0, r0, #2
> > c03030d0:       e3c00b02        bic     r0, r0, #2048   ; 0x800
> > c03030d4:       e3c00a01        bic     r0, r0, #4096   ; 0x1000
> > c03030d8:       e3a05051        mov     r5, #81 ; 0x51
> > c03030dc:       ee035f10        mcr     15, 0, r5, cr3, cr0, {0}
> > c03030e0:       ee024f10        mcr     15, 0, r4, cr2, cr0, {0}
> > c03030e4:       eafff3c5        b       c0300000 <__turn_mmu_on>
> > c03030e8:       e320f000        nop     {0}
> > c03030ec:       e320f000        nop     {0}
> > c03030f0:       e320f000        nop     {0}
> > c03030f4:       e320f000        nop     {0}
> > c03030f8:       e320f000        nop     {0}
> > c03030fc:       e320f000        nop     {0}
> >
> > c0300000 <__turn_mmu_on>:
> > c0300000:       e1a00000        nop                     ; (mov r0, r0)
> > c0300004:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> > c0300008:       ee010f10        mcr     15, 0, r0, cr1, cr0, {0}
> > c030000c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> > c0300010:       ee070f95        mcr     15, 0, r0, cr7, cr5, {4}
> > c0300014:       e1a03003        mov     r3, r3
> > c0300018:       e1a0300d        mov     r3, sp
> > c030001c:       e1a0f003        mov     pc, r3
> >
>
> Thanks Nate.
>
> So these functions no longer appear to reside far away from each
> other, so there no veneer has been emitted.
>
> What we're looking for are veneers, i.e., snippets inserted by the
> linker that serve as a trampoline so a branch target that is far away
> can be reached.
>
> If no symbols exist with 'veneer' in their name *, it might make sense
> to rebuild the kernel as Thumb2, which has a branching range of only 8
> MB (as opposed to 16 MB for ARM mode)

Heh, Arnd and I were just talking about this yesterday.  Is there a
config that sets Thumb2 mode for the kernel?

>
> * I have no idea whether lld names its veneers like this, or even at all



-- 
Thanks,
~Nick Desaulniers
