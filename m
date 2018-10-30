Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ABC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14E22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GO4Y/bPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14E22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJaAry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:47:54 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:21954 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJaAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:47:54 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w9UFrj8r000501;
        Wed, 31 Oct 2018 00:53:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9UFrj8r000501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540914826;
        bh=CKniLgXz8dUH930owUPENtyfG8FEv8M/QPpG1WaKR7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GO4Y/bPTpFnbRHLV/eJZPwTw8VKDCHRQ/HeIetgf6tIhQxWuDxj6m9hH96c2e9Iq/
         NQduQjH/g7cJz2abYLFOhEOA8sK+/GdDd0kj7XVyWm2AfOTq50+Wz84Cch/2fZivMR
         /KPh9GETrpEuKAZzvOhZSIxvd51RuUl683SWV2rXGSLP/hpgGbFjRE6RyF3D5yNZ5j
         AdJaeop2Qr1GD0F9wW5S+/hGaNUVeDC/tjq8RVFjDMpDjDlDHtt41EyD15mLPB1Ubr
         ez863Ydyt45IsBrT9trMYLDB3qi73FtFiTKd/Wr2a7hjN/udkfY7PcJufb2vreSpbf
         XrzKAzIyyoh7w==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id p74so1004511vsc.0;
        Tue, 30 Oct 2018 08:53:46 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKEdgi5ZYy00rj+2yH8J6ETeZ0Le70kfsDMMkrlhjPqMFfJbERo
        STqTifKjnBhalS8ZtfvsdBHWxfhJEDF3z0IntCw=
X-Google-Smtp-Source: AJdET5emySK/WnJxnhf2Tkkb0nTi51SfcdMJ+QkOa9ml50kTKllFKFAcWA7aYU/jvP40NfOoufgkgFDRO8BVcSg7uyE=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr1523408vsb.155.1540914824725;
 Tue, 30 Oct 2018 08:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181030104637.382c26d0@canb.auug.org.au> <20181030104941.4fef7dad@canb.auug.org.au>
 <CANiq72k2w2T0Cy0D--OEmE+sOPkjZtXpukBm+Mz1_xY6MCGg0A@mail.gmail.com> <20181030150412.peayixjav2lvbp4s@mail.google.com>
In-Reply-To: <20181030150412.peayixjav2lvbp4s@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 31 Oct 2018 00:53:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARsV=GbwERyy_TViiYB_Go1GqYC2_GNbtvhoArSo1zgsg@mail.gmail.com>
Message-ID: <CAK7LNARsV=GbwERyy_TViiYB_Go1GqYC2_GNbtvhoArSo1zgsg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the compiler-attributes tree with the
 kbuild tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:06 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Tue, Oct 30, 2018 at 12:21:52PM +0100, Miguel Ojeda wrote:
> > On Tue, Oct 30, 2018 at 12:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > On Tue, 30 Oct 2018 10:46:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Today's linux-next merge of the compiler-attributes tree got a conflict
> > > > in:
> > > >
> > > >   include/linux/compiler-gcc.h
> > > >
> > > > between commit:
> > > >
> > > >   94c7dfd01652 ("kernel hacking: support building kernel with -Og optimization level")
> > > >
> > > > from the kbuild tree and commits:
> > > >
> > > >   5c67a52f3da0 ("Compiler Attributes: always use the extra-underscores syntax")
> > > >   989bd5000f36 ("Compiler Attributes: remove unneeded sparse (__CHECKER__) tests")
> > > >
> > > > from the compiler-attributes tree.
> > > >
> > > > I fixed it up (the latter just removed the __CHECKER__ check, so I did
> > > > that) and can carry the fix as necessary. This is now fixed as far as
> > >
> > > On reflection, that may not have been the correct resolution ...
> >
> > From a quick look, it seems we want:
> >
> > #ifndef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
> > #define __compiletime_warning(message) __attribute__((__warning__(message)))
> > #define __compiletime_error(message) __attribute__((__error__(message)))
> > #endif
> >
> > i.e. kbuild tree added the CONFIG_CC_OPTIMIZE_FOR_DEBUGGING guard,
> > while the compiler-attributes tree removed the __CHECKER__ one, so we
> > still need the former.
> >
> > By the way, I think 94c7dfd01652 is wrong: it changes the guard also
> > for __latent_entropy (and it does not change the corresponding comment
> > at "#endif /* __CHECKER__ */").
> >
> > Also, the commit message does not mention __compiletime_warning --
> > should that one be guarded too by CONFIG_CC_OPTIMIZE_FOR_DEBUGGING?
> >
> To avoid future possible warning, __compiletime_warning should also be
> guarded. So I did the flow change so __latent_entropy is not affected.
>
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -85,9 +85,11 @@
>
>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
> -#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
> +#if !defined(__CHECKER__)
> +#if !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
>  #define __compiletime_warning(message) __attribute__((warning(message)))
>  #define __compiletime_error(message) __attribute__((error(message)))
> +#endif
>
>  #ifdef LATENT_ENTROPY_PLUGIN
>  #define __latent_entropy __attribute__((latent_entropy))
>


OK, I locally fixed it up.

I hope it will be fine for tomorrow's linux-next

Thanks.

-- 
Best Regards
Masahiro Yamada
