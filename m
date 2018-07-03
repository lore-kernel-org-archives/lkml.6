Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ADB21990
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlG578xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ADB21990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGCIKJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:10:09 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41208 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeGCIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:10:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so808581qto.8;
        Tue, 03 Jul 2018 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nkgbvc8+ZzArun5dfqpxB/ydYBicslUnb7vPVIZFuaw=;
        b=HlG578xDD03x+bM0SiiE6025/NEQRFzzuXc/Y2McaeoKFKogqHDsbyjfFZKeb6f1Xx
         q2s6SqjUCtlevgZ+hnj3wJUDdkED42N0GFvhRF5bemcYNu8RdZTCr3zLJdkrBVdlZD4L
         2WcfPW3qSMuduwv+lT3Zi2PlSRIC0YCu8yUVm6qb79Iv0Hp1CtxA7aNWIJein+65/ua/
         cM2+oKl5ejYkyRMs69S7wn9mE3A43vc4+suXaWEWPeoMOE/HCbGbnQQwd1oBtkz0lUDZ
         K/qhreeDGUujArWO9vl7xGEoINYsOGQcNLYdB05eKqPfCG28JuCbofc7xUX9u7nSiI5V
         zgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nkgbvc8+ZzArun5dfqpxB/ydYBicslUnb7vPVIZFuaw=;
        b=L3ngjc9nU5A6VsFTI1rffQF8jOszJkxPqmIqlhpgdpLWxlaf6t8NMIt0egamTkLGj9
         XFw9MHzoJfLZD0bJxOjyabQZyi8AIickknKdLZl644s1uf+4s/a30DAPzRkjkPZDGpRG
         Wp0GiYYYwgDYnOBBvDlJcIEQs6WW6boKRRYL1TPRLB7XqldZodvBzYTC+XcD/SJmK/Lj
         txna9LvH3Axs5WchuEYXyFqcSD85h/0CzTkzK2hdSQ4kZ/YVnjYJ89CBgPFRrsDL4sDH
         D2f8EdS9GdCwEVU5zKDwXYdtXkTEiw2Y9YJ1XqIr/dKY9ncfaTCyk/LnEb6iM5YD75f3
         /ulg==
X-Gm-Message-State: APt69E05bN8Vq9Y7Mwgpud+sO0SGC1J9kcYMm1NsyKJjq31ovmd8eLYc
        8XMHqgLH0HJAjRFBaUnlZODOSCXUYBe1FygVQmc=
X-Google-Smtp-Source: AAOMgpeB8DL6gR9BMsNr4btburPDy5P/QXZNe0ZJaVwEkhdyBNCuhMDJHTjONg81V1BPqA+7uSOBEZbVpY1wHPuo/fo=
X-Received: by 2002:ac8:2dc1:: with SMTP id q1-v6mr10594940qta.219.1530605404352;
 Tue, 03 Jul 2018 01:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain> <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
 <20180626120306.GD2118@localhost.localdomain> <CAFqH_52v3-L1xLL12hzyGCbuooX5T52Lm7BXHM3sBX1ERWmhiQ@mail.gmail.com>
 <20180703065648.GB20176@dell>
In-Reply-To: <20180703065648.GB20176@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 3 Jul 2018 10:09:53 +0200
Message-ID: <CAFqH_53qUTeTcG1ijX-pbfgwwEes-f9i5MzOtv4eeM03V2Bq1Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Missatge de Lee Jones <lee.jones@linaro.org> del dia dt., 3 de jul.
2018 a les 8:56:
>
> On Tue, 26 Jun 2018, Enric Balletbo Serra wrote:
>
> > Hi Matti,
> >
> > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > dia dt., 26 de juny 2018 a les 14:03:
> > >
> > > Hello Again Eric,
> > >
> > > On Tue, Jun 26, 2018 at 01:40:40PM +0200, Enric Balletbo Serra wrote:
> > > > Hi Matti,
> > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > > dia dt., 26 de juny 2018 a les 13:25:
> > > > > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wr=
ote:
> > > > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>=
 del
> > > > > > dia dt., 19 de juny 2018 a les 12:57:
> > > > >
> > > > > > > +static const struct of_device_id bd71837_of_match[] =3D {
> > > > > > > +       { .compatible =3D "rohm,bd71837", .data =3D (void *)0=
},
> > > > > > > +       { },
> > > > > >
> > > > > > nit: { /* sentinel */ }
> > > > >
> > > > > I am sorry but I didn't quite get the point here. Could you pleas=
e
> > > > > explain what did you expect to be added here?
> > > > >
> > > >
> > > > It's a nit but It is a good practice to specify that the last entry=
 is
> > > > a sentinel. Just this.
> > > >
> > > > +static const struct of_device_id bd71837_of_match[] =3D {
> > > > +       { .compatible =3D "rohm,bd71837", .data =3D (void *)0},
> > > > +       { /* sentinel */ }
> > > > +};
> > >
> > > Oh, I see. Finally something I can disagree =3D) I quickly opened few
> > > random drivers which declare match table. None of them practiced this
> > > good practice. So I guess it is not such a standard after all. And I
> > > guess the meaning of last entry in match table should be quite obviou=
s.
> > > Adding the comment /* sentinel */ sounds like stating the obvious at
> > > best - at worst it gets one just to wonder what the "sentinel" means =
=3D)
> > >
> >
> > git grep "/\* sentinel \*/"
> >
> > Anyway, I marked this change as a nit, so you don't need to change. I
> > just commented because at some point I received a "complain" when I
> > didn't add it. But this is up to the maintainer and I am not sure if
> > the "complain" was received in this subsystem :)
>
> Certainly not from me.  I don't agree with the practice.
>
Ok, Removed from my notes.

> I'd like to know who is enforcing this!

I tried to find from where my note comes from but I did not find it.
Anyway, it's clear now that you don't like it, so I'll remove from the
pending patches I have and see if someone complains about it again.

Thanks,
 Enric

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
