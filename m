Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1475AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8B32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewFQM0Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8B32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeLEIKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:10:10 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35262 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEIKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:10:10 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so18921086itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZ3hSwv8XRSBREnEXqtCrC4UEedzsNDdAjUoXfYalNw=;
        b=ewFQM0VqiOFg9qI5CSQ0Tbe7PkqavFPB5Fi1+3/uMSIxfHI23kxEUVaOljt0izfYRl
         k7MBOQfNdDPPSrgEeyc3cwwMFy8FUlwqgeOH/bxHAnKV8/fK7I2ADY0fQff88ce4AK2I
         9kAOg03LR6uYo7tcKl39suY981XQPMx/dJQ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZ3hSwv8XRSBREnEXqtCrC4UEedzsNDdAjUoXfYalNw=;
        b=TH1/DDCgTFoIQ1tOu0faQv7psdSQcEopKWbx9xrgNJVPIg2Zn49RzBTy33SD9TiCyL
         Si0OlJl3Gmp5u8PC1JPx44fqp5ansrfKLRfvJsX++p/g1xwIJhO+XcpwDpQbjRWJZoSJ
         XLULN8BbG9XaRB881sSyx8S7TsmKYaUe7zzPiNutQChtJU7PciRODVbuCMTeQ7hQ3kKk
         19+Y/vgRBPOYxvSllGlixFhFaMxhpC5HeSiS5kg3PeizOJlYfRxn1f6xD6C0MS9MUbiS
         qs1c1Z2uieOLahf9EJ3XOfteu86LS0mH6MClAVOYAi9/Kp78zsgL0N6AIgajVBbWRoO7
         2Ttg==
X-Gm-Message-State: AA+aEWbWNVaOvEnbSWJqI+WeP7/JVu71TnybtrjIwo9ls3oQ5ojbu0EY
        /eLDlGKcGwqlRjZ9HPz1XKbTtojR/GLByHAytZ4DPw==
X-Google-Smtp-Source: AFSGD/XgScyNPdqqz4t4IlEYaAIiwvuydGMdGI5LldpztAWT+L6WELWwOB6zzpFPccWsajg/1/cKUiW+jIJG/x29ETE=
X-Received: by 2002:a02:183:: with SMTP id 3mr7522139jak.130.1543997408631;
 Wed, 05 Dec 2018 00:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
In-Reply-To: <20181205080645.GA11936@flashbox>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Dec 2018 09:09:56 +0100
Message-ID: <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
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

(+ Arnd)

On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > This flag is not supported by lld:
> > >
> > >     ld.lld: error: unknown argument: --pic-veneer
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Hi Nate,
> >
> > Does this mean ld.lld is guaranteed to produce position independent
> > veneers if you build kernels that are bigger than the typical range of
> > a relative branch?
> >
>
> Hi Ard,
>
> Honestly, I'm not quite sure. I saw your commit that introduced this
> flag and I wasn't quite sure what to make of it for lld. What
> configuration would I use to verify and what would I check for?
>

Try building allyesconfig, and check the resulting binary for veneers
(which have 'veneer' in the symbol name, at least when ld.bfd emits
them). These veneers should not take the [virtual] address of the
branch target directly, but take a PC relative offset (as in the
example in the commit log of that patch you are referring to)

> Additionally, I have filed an LLVM bug for the lld developers to
> check and see if this is a flag they should support:
>
> https://bugs.llvm.org/show_bug.cgi?id=39886
>
> Thanks for the quick reply,
> Nathan
>
> > > ---
> > >  arch/arm/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index e2a0baf36766..4fab2aa29570 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -10,7 +10,7 @@
> > >  #
> > >  # Copyright (C) 1995-2001 by Russell King
> > >
> > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > >  LDFLAGS_vmlinux        += --be8
> > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > --
> > > 2.20.0.rc1
> > >
