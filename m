Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA9721855
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jntSlpts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfBZMJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:09:15 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34953 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfBZMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:09:11 -0500
Received: by mail-it1-f194.google.com with SMTP id 188so3689276itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oZc1chqonr5OFHhPY+4ktv/rItkbHorQByl5DMoQXYk=;
        b=jntSlptsuzdjhBIgeOHESJCA5eDSREADmyB3Wdr6i1TYBo2xfGZsUVeSvKIUKwguDF
         D259eXEv6aQL8KB2xo2SkkLKTkXfTfDB6yDPZrhWWheObDlD1ZKPcR58ZJsD7i0Oaugh
         ForT8c9GicMqc7Hm8yYeAkdxYCJhSVlXfdXPijBHvU1nB+uvRFPv0mNlIR0rADXSNpZE
         HqGNpl3nfI7M0I2gBLXrsJglSxI93f4OurERh5oQMEiIv/uWWT1K39n6RaH/auy57gNa
         E2LrL1ppjP4xJIfcLiR6CBsnXrvXJfzauo5rCTHIDdbupajm51fgBwxGWvwsFTf9Sgz8
         zLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oZc1chqonr5OFHhPY+4ktv/rItkbHorQByl5DMoQXYk=;
        b=U3kCjwbwHaGpgsj4cODl1RtGNn5tUHmDsob0riTba19LATV4PLCcXafR3A9k7JWYoJ
         0vDt1ptjEzsUUinEsseY6OLNAB4y6rB84fooFVYmTJZ8HdJiTxUp8KTeRIT7B2oObHKm
         rOIIe0P5UAuaNwrwTYadxMQH/vyPuFLyMyFg4rbxnYiHJpsIVvz6490W1eEvNWAORRJ5
         QMu0qxrNItVyxORm97LToh7Qbz5B+45RPq3k6E9XiFxhth3okUCcSzCiWXe+FMGkrQD8
         lTS98pN/a0FNyA2E7mPFxPm9eoCRpYJYTjQ/bjSPgF3je3AAKN1vyP1idt0rA6iXo+yz
         t9ow==
X-Gm-Message-State: AHQUAub4geZk91Zo409VfNQ6Yg4Niq0Ls5/rlt3eL9FK4OIk9K1d85Lv
        gXMDyRgPnuW71kjdhAmCGelNLqBH+R7HvwmsA9kGHA==
X-Google-Smtp-Source: AHgI3Ia48KktGK5QKsSpai22ijyl/WUU1c7eWEqaBMKU1Ha0YEClEjFEbs7YBo8vin9N54PSQyS+BjuAkyyanLJAupA=
X-Received: by 2002:a02:c78d:: with SMTP id n13mr12224416jao.57.1551182950139;
 Tue, 26 Feb 2019 04:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl> <20190204171757.32073-5-brgl@bgdev.pl>
 <0750392d-e298-b467-24c0-3c2779ead3f7@lechnology.com>
In-Reply-To: <0750392d-e298-b467-24c0-3c2779ead3f7@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Feb 2019 13:08:59 +0100
Message-ID: <CAMRc=Mcd886pfbOr3cWwMtRJt34DVAEq63B7W8m2Nqkrddw5FQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] ARM: davinci: WARN_ON() if clk_get() fails
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 5 lut 2019 o 03:18 David Lechner <david@lechnology.com> napisa=C5=82(a=
):
>
> On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Currently the timer code checks if the clock pointer passed to it is
> > good (!IS_ERR(clk)). The new clocksource driver expects the clock to
> > be functional and doesn't perform any checks so emit a warning if
> > clk_get() fails. Apply this to all davinci platforms.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   arch/arm/mach-davinci/da830.c  | 4 ++++
> >   arch/arm/mach-davinci/da850.c  | 4 ++++
> >   arch/arm/mach-davinci/dm355.c  | 4 ++++
> >   arch/arm/mach-davinci/dm365.c  | 4 ++++
> >   arch/arm/mach-davinci/dm644x.c | 4 ++++
> >   arch/arm/mach-davinci/dm646x.c | 4 ++++
> >   6 files changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da83=
0.c
> > index 2cc9fe4c3a91..9a4b749cbb6b 100644
> > --- a/arch/arm/mach-davinci/da830.c
> > +++ b/arch/arm/mach-davinci/da830.c
> > @@ -834,6 +834,10 @@ void __init da830_init_time(void)
> >       da830_pll_init(NULL, pll, NULL);
> >
> >       clk =3D clk_get(NULL, "timer0");
> > +     if (WARN_ON(IS_ERR(clk))) {
> > +             pr_err("Unable to get the timer clock\n");
>
> Do we really need a warning _and_ an error?
>

That will give us the reason AND point us to the right place in the code.

Bart

> > +             return;
> > +     }
> >
> >       davinci_timer_init(clk);
> >   }
