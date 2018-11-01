Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E2B20821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GDM9SXKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E2B20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeKAMep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:34:45 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64240 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeKAMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:34:44 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wA13XPdY002650;
        Thu, 1 Nov 2018 12:33:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wA13XPdY002650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541043206;
        bh=rZwgGJIbmqUwKwIjVioty/meABZBord0fvxK7ZB6M1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GDM9SXKukcyCLl3JLUtJiUUuNVequqnDBP01TnGvfwRHPe6ee2eHDhtwGQ3e1+JkK
         mor/e77XB2+zkUkURvWXOBN7TTdC3NhyZyLdnEf7m1lv0LIB10heJphkEDcugfUSWe
         xAHhW9nEMFmdsvpAmFzFaXncvgkhSbyxv6lCSM8aMkRvTGxJn+qvQ/3nE5WZlJNZK9
         zWG2sXvstHFBzy3XFw3yBU/SkU5cTxoXAKRWtRZiysdDk3sg+rLG+Jmfx5VY3u7nBf
         yqMRK2eskqIC0H0QDuZpED6IbAXoJHA5Yowfgg9roDuMHaS5WlwKb8KYf7GmbL2OxY
         4XC5nYG73CX8A==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id t17so8274206vsc.8;
        Wed, 31 Oct 2018 20:33:26 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLn685vOF6rPP1GEyawnV1CVWZlBHJe+eopbYaMXGPp+F2Oxdrs
        AVZWMFur2JhITeviE+L9ef5eJWfcIDY6+aqUrug=
X-Google-Smtp-Source: AJdET5cJSu2h+khmGG1KEdOwhCZLijngc9jY+MZeR0Xq3IG9+wxEpVHMu1GFoo1PZsdegVBg/fhzanyZTtPR08WGZo4=
X-Received: by 2002:a67:a858:: with SMTP id r85mr2498052vse.215.1541043205014;
 Wed, 31 Oct 2018 20:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181031145907.1ee2e866@canb.auug.org.au> <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Nov 2018 12:32:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
Message-ID: <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,


On Thu, Nov 1, 2018 at 6:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 10/31/18, Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 10/30/18 8:59 PM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Please do not add any v4.21/v5.1 code to your linux-next included trees
> >> until after the merge window closes.
> >>
> >> Changes since 20181030:
> >>
> >
> >
> > on i386:
> >
> > ld: drivers/virt/vboxguest/vboxguest_core.o: in function
> > `vbg_ioctl_hgcm_call':
> > vboxguest_core.c:(.text+0x212b): undefined reference to `vbg_hgcm_call32'
> >
> >
> > Full randconfig file is attached.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
>
> I ran into the same thing, and lots of others like it; they all go back to
> the -Og compiler option introduced in commit 94c7dfd01652 ("kernel
> hacking: support building kernel with -Og optimization level").
>
>
> I have patches for most of these, but I'd prefer if we could leave
> that patch out of 4.20 for now, and have it in linux-next for merging
> into the next merge window, to give us more time to fix up all the
> regressions. This particular instance is fixed by the patch below.


Hmm, I was considering the -Og support for the current MW,
but it might be better to postpone it for 4.21-rc1...



> Other symptoms caused by the change are tons of 'section mismatch'
> warnings for functions that are no longer automatically inlined, and
> sprintf format string overflow warnings when gcc fails to propagate
> an upper bound on an integer argument that is printed into a fixed
> length string.
>
>      Arnd
> ---
> From 8172e650c6797b9cc64c6f7b1c9e5433156290cc Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 31 Oct 2018 16:24:35 +0100
> Subject: [PATCH] vbox: fix link error with 'gcc -Og'
>
> With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
> error in the vboxguest driver, when that fails to optimize out the
> call to the compat handler:
>
> drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
> vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'
>
> Another compile-time check documents better what we want and avoids
> the error.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c
> b/drivers/virt/vboxguest/vboxguest_core.c
> index 3093655c7b92..1475ed5ffcde 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
>                 return -EINVAL;
>         }
>
> -       if (f32bit)
> +       if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
>                 ret = vbg_hgcm_call32(gdev, client_id,
>                                       call->function, call->timeout_ms,
>                                       VBG_IOCTL_HGCM_CALL_PARMS32(call),

Right, but adding the CONFIG_COMPAT guard to both the caller and the callee
looks a bit redundant...


I think most cases causing this kind of problem
rely on the assumption that 'static' functions are inlined.

We can force the compiler to do so
by replacing 'static' with 'static __always_inline'


-- 
Best Regards
Masahiro Yamada
