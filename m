Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9759B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uCyA7S6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9759B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeKABMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:12:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:65062 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKABMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:12:48 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9VGDutl015882;
        Thu, 1 Nov 2018 01:13:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9VGDutl015882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541002437;
        bh=UmiL7c3gvjsh+ptKZvtUrHKvMJqxCMFxSF/Va5BpSJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCyA7S6AxTyetnUb+U29iAmRmJ59QyaRUgw+ven6YcIvExC+FMURclohruCp3LpMe
         huxoN3BGPmFFiq90tAd5JPLzi5H2gUmkoUcI6o6l1teTvPeusQfm10ctxwZ+RBr2ko
         WKsuRlyRnWBV7TGa3Sm4DTQTGr4V83FRO99QaE8AjpMQyI4hQfGhZWDeEnEKou7625
         /+BMhwxlzb6tWqDB0ib24r4jdtFdGG/cp9mQ45tLQtUfFc3QaRSaaD3Vm99ot9md2k
         V1wYe/QaZpCn74o/bctrHhMOmFhTJp5dr+dRaAu6cz1vtqPJ8O4xPX5KP2i+0PoKGf
         ASB8d8vVUP3zA==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id g10so6115448uak.5;
        Wed, 31 Oct 2018 09:13:57 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLaGYk4lvmCbvBApmPcSnQ9s+YxYw2ElBAtdGDV0MPzDHuRM1P4
        ouxe+R31sBxQOz4Rll1yv+Q5NCo3FiOQdPGwap8=
X-Google-Smtp-Source: AJdET5ewJUidOAJ5RzwWfcl7ByHi3oKwPUSaWmC/YlIiUjdsdojSG95H2Lsfh8Rt8/4rvj8dejIc8mE3nt3V3oyYFzE=
X-Received: by 2002:ab0:5444:: with SMTP id o4mr1683275uaa.55.1541002435855;
 Wed, 31 Oct 2018 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181031111444.3472-1-malat@debian.org> <CANiq72mj_iHvxqAEqhGoLT61Tc04-zN6f7Gv1jyNeb6d0R2LGw@mail.gmail.com>
In-Reply-To: <CANiq72mj_iHvxqAEqhGoLT61Tc04-zN6f7Gv1jyNeb6d0R2LGw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Nov 2018 01:13:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyykVuHT1YQ_UWVMFRG-K3VQwEXtjGQxQE4Fgu4wQtDg@mail.gmail.com>
Message-ID: <CAK7LNARyykVuHT1YQ_UWVMFRG-K3VQwEXtjGQxQE4Fgu4wQtDg@mail.gmail.com>
Subject: Re: [PATCH] remove old GCC version implementation
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 8:28 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Oct 31, 2018 at 12:18 PM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > GCC 4.6 is the minimum supported now.
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >  scripts/mod/file2alias.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index 28a61665bb9c..4b59564d4706 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -83,11 +83,7 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
> >  #endif /* __MACH__ */
> >
> >  #if !defined(__used)
> > -# if __GNUC__ == 3 && __GNUC_MINOR__ < 3
> > -#  define __used                       __attribute__((__unused__))
> > -# else
> > -#  define __used                       __attribute__((__used__))
> > -# endif
> > +#define __used                 __attribute__((__used__))
> >  #endif
> >
>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> By the way, is it possible that scripts/ and similar stuff uses
> directly include/linux/compiler_attributes.h (whenever it hits
> mainline, see https://github.com/ojeda/linux/blob/compiler-attributes/include/linux/compiler_attributes.h
> )? It is a header that does not depend on anything, so it could easily
> be shared; and would avoid having to maintain two sets of attributes.
> Let me know, I can take a look at it if you think it is a good idea.

No.
I want to share a header file between kernel and host-tools
only when we need to do so.


In this case, it is wrong to use the linker magic for the host tool
if you look at the so ugly #if defined(__MACH__) part.






> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
