Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4259BECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A1B208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s0B2i8Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A1B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJGFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:12:18 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:42431 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeJGFMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:12:17 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w96M72lI022398;
        Sun, 7 Oct 2018 07:07:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w96M72lI022398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538863623;
        bh=e+TojN0ogn9FsM2JXCapMP0R876z1XX0QFM3+58tV2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s0B2i8Tp52/phs5m50JU4wcCGOON1atRTcmDhFDgoRUIVOiBenDXTYOs5car+Y0h1
         +vppql+/CsXTc3w9G1Jw+IFpR+bzlAXcP0GGAzCR9MDppab+UvviBnU7NpQwG797xR
         MREz6QYoPPD5YdFL7Xvz/bcBTYMjTJVrb/N2/+szeAkY3zXku+BYEE81/kBF4B3Q1T
         uIqzuTJVk2A6k9dn5U2CuWoP9J8PDR8+nu7YseE87msUGthDgdwe0OkleWu9wl1PcB
         WolFXddJdz/E91YbaJDib00wX4DJhUm7bpGK8AKS4khVJ6F/Btjdv+LlzLDmq+EUw2
         50knE1szDwFvg==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id b80-v6so1968089vke.3;
        Sat, 06 Oct 2018 15:07:03 -0700 (PDT)
X-Gm-Message-State: ABuFfohGaG2JaVEsZqfc5JvexlPnSEDQDTynkOoKFzqY+BeUqKGaDd7m
        VrA4a/WD3xLpHBmwyvAKizbGPDubdx8NAP20gyo=
X-Google-Smtp-Source: ACcGV60BdEliZNjdGcX8GdHRm2TTQcZ3ME1d89FkVWtBWvfBBJT/Nxe+mBav+Pw40Pq3lHi0Oo4DyfnYOpqvEGiKS3A=
X-Received: by 2002:a1f:b215:: with SMTP id b21-v6mr818273vkf.0.1538863622119;
 Sat, 06 Oct 2018 15:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de> <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
 <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
In-Reply-To: <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Oct 2018 07:06:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATycNLxzB=FtrBy9M4E6m9wx4Uhk=DQ7gcCMD2J_vfmfQ@mail.gmail.com>
Message-ID: <CAK7LNATycNLxzB=FtrBy9M4E6m9wx4Uhk=DQ7gcCMD2J_vfmfQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     miguel.ojeda.sandonis@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kieran.bingham+renesas@ideasonboard.com,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 6:58 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Miguel,
>
>
> On Sun, Oct 7, 2018 at 6:18 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Fri, Oct 5, 2018 at 10:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > Building any configuration with 'make W=3D1' produces a warning:
> > >
> > > kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmis=
sing-prototypes]
> > >
> > > When also passing -Werror, this prevents us from building any
> > > other files. Nobody ever calls the function, but we can't make
> > > it 'static' either since we want the compiler output.
> > >
> > > Calling it 'main' instead however avoids the warning, because gcc
> > > does not insist on having a declaration for main.
> >
> > I think marking the function as static __used should do the trick and
> > would be less confusing.
>
>
>
>
> I tried __used, but I still see the warning.
>
>
> masahiro@grover:~/ref/linux$ git diff
> diff --git a/kernel/bounds.c b/kernel/bounds.c
> index c373e88..aee0101 100644
> --- a/kernel/bounds.c
> +++ b/kernel/bounds.c
> @@ -13,7 +13,7 @@
>  #include <linux/log2.h>
>  #include <linux/spinlock_types.h>
>
> -void foo(void)
> +void __used foo(void)
>  {
>         /* The enum constants to put into include/generated/bounds.h */
>         DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> masahiro@grover:~/ref/linux$ make W=3D1  prepare
>   CC      kernel/bounds.s
> kernel/bounds.c:16:13: warning: no previous prototype for =E2=80=98foo=E2=
=80=99
> [-Wmissing-prototypes]
>  void __used foo(void)
>              ^
>   CC      arch/x86/kernel/asm-offsets.s



Sorry, I forgot to add 'static'.

Adding both static and __used worked for me,
and I like the idea.



--=20
Best Regards
Masahiro Yamada
