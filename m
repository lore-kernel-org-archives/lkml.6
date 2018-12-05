Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A926220878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQYUvzFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A926220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeLESgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:36:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLESgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:36:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so13906151wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QdeLinFVWlRffPPHpnfEES3zo4hzZSLEoEYwaiieWlQ=;
        b=DQYUvzFgyT9aIMFj52X9fYmF9+HFOk16vU7bA+zH4ECEepnWIA6P9Daffin6+eJea/
         CYtYRNRwCbPUkura2R2TU3RO4VmT9CrYIMYzQpunfJsCLMx9ur1cHpfNiGSNDozLm6uh
         huSa0YPv92BQpTD9e/W493VH8KuWNEzjczfOQetHO7NoGLgUwPq/hFfjzncd1XyW5U3b
         E41jMakN5zx89o3U+pIPOYSEp7V7Ct1j/QV2feNjUR5VhOT3z/udXxbMONoJe7Vi+kHK
         /9hv0/Mp1xCFQGRzgJrXF7D8KSP1dhAi5SDokyp76JH9gLI3QTJ2H9neOW7Uev/JSEZe
         fQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QdeLinFVWlRffPPHpnfEES3zo4hzZSLEoEYwaiieWlQ=;
        b=YaxyQukJlgtcDyQy6KMHGCoA2//FjuOuqrCEXc3GpYQI8yQmXnPW5f4eAFDe5d6/yN
         0Hs6bWwEUyPJusqBv5nFImA4rDgq4Xrzch+a9Q5soEILjpbHY/w1FQwIwJb2V8iQi0/w
         qvrFuh5K9AtQLsK1UXjRjjtbcVy7T+y2ye08oyZcBwThSaIHZgtwAbXukPHcLSL5x13m
         GWoSE5yAiC8jySVJCmOS8R6BGb9gJ9Wa8Q3PjNTkbSDuh5EKf2GNdeIzA4qoCr+EpYor
         ktZTJHrLJ9ZkT0godNSOg8UZ5RnfgnafOxQ1KFGFa5PbnZfYGEBWRYgeI01gPEcgIxKP
         zQ2g==
X-Gm-Message-State: AA+aEWbxg5F3DQ+NhObLy2GCL5G7gnCwXjuyVhw/OvIxgOLqiQK6WJx9
        Nd1DLjUQSyzwsQWUBw2TdYFtphf98Uw=
X-Google-Smtp-Source: AFSGD/VdnihbwcrWWNsq+TpV00iIjO/2MKYax/+IfJcMzBjitTLGR5ORcnMu5mgwVKxjwyjn4nMDRg==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr17695633wmd.36.1544034969401;
        Wed, 05 Dec 2018 10:36:09 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h16sm31801534wrb.62.2018.12.05.10.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:36:08 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:36:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
Message-ID: <20181205183606.GA7274@flashbox>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >
> > > > This flag is not supported by lld:
> > > >
> > > >     ld.lld: error: unknown argument: --pic-veneer
> > > >
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > Hi Nate,
> > >
> > > Does this mean ld.lld is guaranteed to produce position independent
> > > veneers if you build kernels that are bigger than the typical range of
> > > a relative branch?
> > >
> >
> > Hi Ard,
> >
> > Honestly, I'm not quite sure. I saw your commit that introduced this
> > flag and I wasn't quite sure what to make of it for lld. What
> > configuration would I use to verify and what would I check for?
> >
> 
> Try building allyesconfig, and check the resulting binary for veneers
> (which have 'veneer' in the symbol name, at least when ld.bfd emits
> them). These veneers should not take the [virtual] address of the
> branch target directly, but take a PC relative offset (as in the
> example in the commit log of that patch you are referring to)
> 

Alright, compiling with allyesconfig is a little rough at the moment
(bug reports I will file in due time) but I was able to do it. Here's
the disassembly specifically for the functions you had in your commit,
my assembly knowledge is pretty much non-existent unfortunately so I am
not sure what to make of it (it doesn't look like there is a virtual
address for pc in that mix?). I am happy to provide any more information
that is needed.

c03030cc <__enable_mmu>:
c03030cc:	e3c00002 	bic	r0, r0, #2
c03030d0:	e3c00b02 	bic	r0, r0, #2048	; 0x800
c03030d4:	e3c00a01 	bic	r0, r0, #4096	; 0x1000
c03030d8:	e3a05051 	mov	r5, #81	; 0x51
c03030dc:	ee035f10 	mcr	15, 0, r5, cr3, cr0, {0}
c03030e0:	ee024f10 	mcr	15, 0, r4, cr2, cr0, {0}
c03030e4:	eafff3c5 	b	c0300000 <__turn_mmu_on>
c03030e8:	e320f000 	nop	{0}
c03030ec:	e320f000 	nop	{0}
c03030f0:	e320f000 	nop	{0}
c03030f4:	e320f000 	nop	{0}
c03030f8:	e320f000 	nop	{0}
c03030fc:	e320f000 	nop	{0}

c0300000 <__turn_mmu_on>:
c0300000:	e1a00000 	nop			; (mov r0, r0)
c0300004:	ee070f95 	mcr	15, 0, r0, cr7, cr5, {4}
c0300008:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
c030000c:	ee103f10 	mrc	15, 0, r3, cr0, cr0, {0}
c0300010:	ee070f95 	mcr	15, 0, r0, cr7, cr5, {4}
c0300014:	e1a03003 	mov	r3, r3
c0300018:	e1a0300d 	mov	r3, sp
c030001c:	e1a0f003 	mov	pc, r3

Thanks,
Nathan

> > Additionally, I have filed an LLVM bug for the lld developers to
> > check and see if this is a flag they should support:
> >
> > https://bugs.llvm.org/show_bug.cgi?id=39886
> >
> > Thanks for the quick reply,
> > Nathan
> >
> > > > ---
> > > >  arch/arm/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > index e2a0baf36766..4fab2aa29570 100644
> > > > --- a/arch/arm/Makefile
> > > > +++ b/arch/arm/Makefile
> > > > @@ -10,7 +10,7 @@
> > > >  #
> > > >  # Copyright (C) 1995-2001 by Russell King
> > > >
> > > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > > >  LDFLAGS_vmlinux        += --be8
> > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > > --
> > > > 2.20.0.rc1
> > > >
