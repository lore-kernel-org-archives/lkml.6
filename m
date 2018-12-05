Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9A20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgCam7tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE9A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeLESWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:22:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46028 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLESWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:22:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so10437776plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVLcth+zve8W7kZxNyGn8rpNinwxID8cOavPYQSqwts=;
        b=kgCam7tA0eMY0XXt46aDp8ig7QGiNW9BUhL8hTvZHSxqRp6M/ZLJpdGGkkOljnc/cN
         rTCz+V12g17zADlUNYA5TMrsztTAyuFKzzbsPPJ19x+WuNDpPZC6GfIS1WNKkQuXGpwz
         k6hpiahvEELTp57CfEcqtiDOcn3wGkAAwj9SOph6cfmXnumBni3Jet/K014Uqr3sL63w
         YMWKqIk4ukAEr2l+F9nRGmZ9pNre8Oh4C63zAVVAVTg991Zc4uaRfzQgZ15G8ye0yoDX
         gs4+ZBBojxehXuzAcH8apu4ek4eySlU0uCPXJQw3If8HxmeLWXBhskAsrNAI55Y+lhT3
         /iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVLcth+zve8W7kZxNyGn8rpNinwxID8cOavPYQSqwts=;
        b=fsPSGUjfKZXSwI9vaBtHycp9squjuiYKCNyyOkEULqvsG7fcMFaYFHhz2xporDuACN
         q/iYq4NDAgp1mjQ4Qx2f02JlGQsWj/vWBmen6H4OJ7faORkD7uao+UQeDPK+M3AFri+T
         2rcvYtVRcSkLInzhmovzwUOKIfp/kCsQeU0j5xq/zI//yLSSsurrkaoI7ODwhnHfPoik
         AnFhINxeSx8XCLT4QtoUO5tadqda1vDThYFHUQF/wTHu00etISgiHvEJlTT3ImaLlUvK
         GYBvWabsMUdcxXC1S9kJbZRHpGwz6gnmIl/oKjX7Siu3RCldFFuQU/LoMy9Z7h/oZlow
         KSQQ==
X-Gm-Message-State: AA+aEWbjUsY0IJQh6pNZ+1r8NMpYpbfl1EHe1cBKBypThxviCJKpQN10
        jHuuolzuDXKFWahYuXx423V/IiFYRMJ154FlrPwMZg==
X-Google-Smtp-Source: AFSGD/Wi9BMXahehLr+8WB6jiJzmP/eUMkEtF+wPuZKmyeTRRGER2RJTk3IUYznC/2FRZ24UZh7Rq78AJltqlqpFoEE=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr24955859pll.320.1544034122740;
 Wed, 05 Dec 2018 10:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox> <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Dec 2018 10:21:51 -0800
Message-ID: <CAKwvOdno9AdzNvMVmzqV7y+_u_z7VgfbRvKm73rRZ+iUuraYtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux@armlinux.org.uk,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Peter Smith <peter.smith@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 12:10 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
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

(+ Peter) who might be able to answer this.

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

Not sure clang can compile an arm32 allyesconfig (haven't tried
personally, yet, TODO), but we could try gcc+lld.

>
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



-- 
Thanks,
~Nick Desaulniers
