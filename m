Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BA4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1416A21916
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dTtXeyV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfBAKwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:52:15 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64156 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbfBAKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:52:15 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x11AphUk012643;
        Fri, 1 Feb 2019 19:51:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x11AphUk012643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549018304;
        bh=D73uc5Z+rm98tmfaD9439KOgVb5WRM/ZBtFXwiAHoIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dTtXeyV00MOL15Y6rAQpPw7C0SsppeCvoJYUOkvgqO5dysCoiwNtShb9ikGS+ae7C
         D2HyTjvYgY1qJkF2h0o9yT/NjUTFWnxCSYhJGFMLDAll4DFkegubph4/oTjZszb8hu
         OS3ZQXNha48J2J/Z8VdyFIfhi07Sc3VWfzSEvusUumCreGWWEpEBY0wceD34E4kzUb
         TGTbqzEeR0Aj6OIV4wRqF3wIhpPHbEPYx/3tE3FUsFil9GIs6YWZf/3dk8dGCxsplT
         XuPVjj3X3OZdu0dVIVqZXGNNUqSeaqRZnKwW18w3k1E4DcsyHxA2+Ju7V0uid+jZ3j
         pU0lnItUy/R3Q==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id v205so3915614vsc.3;
        Fri, 01 Feb 2019 02:51:44 -0800 (PST)
X-Gm-Message-State: AJcUukcyUaEXUwU++FlZS6LwfJT+t1xv7phqh8P9ZyQkQ2ulX8z5ztXy
        I01CAZ9QMB0DbMpn+Pu9Wsw/PhiiNJHqj9mM7o4=
X-Google-Smtp-Source: ALg8bN5//g3YaP9rWH5Ly1O8rWzAuCmHngGdRKzaZgeWdTnWjmHifPLLImSCXy8e2INK40SCuujEpDUCx8jHKonVrAs=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr16248259vsd.155.1549018303249;
 Fri, 01 Feb 2019 02:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20190121095338.8565-1-bp@alien8.de> <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic> <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic>
In-Reply-To: <20190201103038.GE31854@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 19:51:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATW11-DBFZtF0j8S9KsCa1gOGcfAbfNeWm2epkb=1RnGg@mail.gmail.com>
Message-ID: <CAK7LNATW11-DBFZtF0j8S9KsCa1gOGcfAbfNeWm2epkb=1RnGg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 7:32 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 01, 2019 at 07:09:36PM +0900, Masahiro Yamada wrote:
> > I provide the result of "perf stat" of the incremental build for you.
>
> One more question: what exactly is that "incremental build" you're
> measuring with?


I meant "make" after you the full build


> Exact command line please.


$ make defconfig
$ make -j8

 [Wait until the full build finished]

$ perf stat --repeat 20 --null make -j8

 [Wait until the perf result is displayed]




> > Without your patch:
> >
> >
> >  Performance counter stats for 'make -j8' (20 runs):
> >
> >        2.721312445 seconds time elapsed
> >           ( +-  1.02% )
> >
> >
> >
> > With you patch:
> >
> >
> >  Performance counter stats for 'make -j8' (20 runs):
> >
> >        5.038521415 seconds time elapsed
> >           ( +-  0.56% )
>
> This can't be a full kernel build.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.


--
Best Regards
Masahiro Yamada
