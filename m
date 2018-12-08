Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BBA20700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dWJNxF5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BBA20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLHTTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:19:42 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53911 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeLHTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:19:42 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wB8JJTI7010693
        for <linux-kernel@vger.kernel.org>; Sun, 9 Dec 2018 04:19:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wB8JJTI7010693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544296770;
        bh=E/4MwRgLGLDh7pOhq5IHJUWOQywDWsxtqGjIY3Y/aNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dWJNxF5uH0ifMpGtUH1hPZZmZP4BShL4oJhzf9xvsCrdoY/Ue7sRNn7Y5cL19+doY
         7w5F2Sn4hR8p7SOCbv9J0l2o2XVrYt4u4yL4tXgxxY6el0HBw/lXFKhtI0BFjDbQY1
         YM2imP7JfTK69sRiHfOsduMrsM5MaqqKDoC7pcNyNcJRrvLa+rR0eku4RYxmZdFdXm
         jn6AuhaKBOjcGiqWU/YfA9AZvEWVaDsZ6qEJi5XCEQAKtzDZBagSpbk4tOPaspz0sJ
         BHjhvdSo8CRO3iHAuezAgIAMaW+B9mcCtX2AJBD7Mu3m7bd9gE3TMSTV2RWmXFOWIy
         gEiaDFMV/aFCg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id h78so4405195vsi.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 11:19:30 -0800 (PST)
X-Gm-Message-State: AA+aEWaNrfYtnpw3pid8KABo8aDDIX6bHm9U0EzGIq6zKUoN/jaiM+tp
        imW9d3wVT+wOz4NNLvFJF/u/qQtKM0nTOHgVfj0=
X-Google-Smtp-Source: AFSGD/UCURCMphoiLVeYHR5V/QWrOc0Rbt31F3zKueqWYM1VCFb6tIT0v0Qu8PQhHd5LNrtBTi2SdPP4TzSgxJlKuHc=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr2974586vsb.155.1544296768991;
 Sat, 08 Dec 2018 11:19:28 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <2624257.jg98z2FPBI@blindfold> <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
 <1855895.dlXT8REgUo@blindfold>
In-Reply-To: <1855895.dlXT8REgUo@blindfold>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 9 Dec 2018 04:18:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkxBbOMAOXUfVbD_Osz2wuQvd=7Afp_7j1Lihrktxa3w@mail.gmail.com>
Message-ID: <CAK7LNATkxBbOMAOXUfVbD_Osz2wuQvd=7Afp_7j1Lihrktxa3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
To:     Richard Weinberger <richard@nod.at>
Cc:     Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Sat, Dec 8, 2018 at 5:55 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Samstag, 8. Dezember 2018, 07:35:47 CET schrieb Masahiro Yamada:
> > x86 maintainers,
> >
> >
> > Ping.
>
> I thought you carry this via your kbuild tree.
> That said, I can merge it also via the um tree.
> x86 is of course also fine. :-)


The second patch also touches x86 Makefiles.

So, I think both should be applied to x86 tree.

Thanks.




> >
> >
> > On Tue, Nov 13, 2018 at 6:48 PM Richard Weinberger <richard@nod.at> wrote:
> > >
> > > Am Montag, 12. November 2018, 03:35:19 CET schrieb Masahiro Yamada:
> > > > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > > > bumped the minimum GCC version to 4.6 for all architectures.
> > > >
> > > > '$(call cc-option,-fno-unit-at-a-time)' is now dead code since
> > > > '$(cc-version) -lt 0400' is always false.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > ---
> > > >
> > > >  arch/x86/Makefile.um | 8 ++------
> > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> > > > index 91085a0..577976b 100644
> > > > --- a/arch/x86/Makefile.um
> > > > +++ b/arch/x86/Makefile.um
> > > > @@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
> > > >  # an unresolved reference.
> > > >  cflags-y += -ffreestanding
> > > >
> > > > -# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > > > -# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> > > > -# 4.3.0 needs -funit-at-a-time for extern inline functions.
> > > > -KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
> > > > -                     echo $(call cc-option,-fno-unit-at-a-time); \
> > > > -                     else echo $(call cc-option,-funit-at-a-time); fi ;)
> > > > +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> > > > +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> > >
> > > Acked-by: Richard Weinberger <richard@nod.at>
>
> Thanks,
> //richard
>
>


-- 
Best Regards
Masahiro Yamada
