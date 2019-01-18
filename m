Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C25C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766B320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jsgyobrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfARSNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:13:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38308 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfARSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:13:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so15202480otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=50tTcE0fuv+y66xoAmFC9tV2dL8ySToAWd3FTLnwSjE=;
        b=jsgyobrdU4BXohSCqb6qabVgjeP7kBbUolKAgqEnHpo9dfp/dIFNummRc+nOkLeEaI
         qVX6vfpDy4sCjaVSJL7khpk/mbTLzt1K2Pwbm53Mh7/BbETTBgOCbRmCXhVuAnvl5CR6
         EOr1CyhpC/Q3GlvbdA9yJkd0214I4nerQZxyU261MwbT8pq1meBs6bhZzRsgQqZPhJIT
         wAch7R95q4S/BqaMydgCKH81ezesJLgDyGKD7c0k99bwp2c2CqkgVpNEq4P3Ahwqims0
         Q2vO+gsdW/v5Tu2F9NaEUKc2BFKTzUnnon6yDqq0loWbdW1ly0VfECDev2bFIK9FCWri
         +EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=50tTcE0fuv+y66xoAmFC9tV2dL8ySToAWd3FTLnwSjE=;
        b=LFxrghvDP3gAvDUstOOyGhrH9V7D1IM4E0m5mUW09Jwpg085Fld/IOa017MwW3z/Ae
         v3+rnPWaqTNcy5mRPWtQ1XjKeeVuLYE7xNIlInUyqQoP1tRRFgpg5LkEya4Irl3tVK84
         khbI0fvloiTftmOlnv4CxWIHZLNRsz218h3s3XOEWlQpifwnl72Wo0o2UxbvpUZOWxvQ
         NB1e5P31rDmI60CkC1KZXt3lEhol28b94AnPH4ThQsifXJk7ksjjfDjl3OzSJvbONgB8
         9e1meyXGXwzajM2f8lLq/M2xvUdnT/1p0En2JxwG8/ES1G2AKu2IuPkGn5hYX8s1Ptd4
         7Ccg==
X-Gm-Message-State: AJcUukfJItEX/raaMlwlTmzno8EOZLkmVtTBYpv0jyAUsq0ehNNCnQcE
        U/0mj5H2OI7En9fmwwEHxP/n06T6eTcYzSZG2ti46Q==
X-Google-Smtp-Source: ALg8bN4s9tWui8il2yF6KZdYFzR+t6HVekR0r2EN29zD8v9icHQuIEsuky9yZhQFGppDo4xWOhALRZZiwx+duPOXkeU=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr11945644ote.234.1547835230003;
 Fri, 18 Jan 2019 10:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-9-brgl@bgdev.pl>
 <20190118180148.GD6260@sirena.org.uk>
In-Reply-To: <20190118180148.GD6260@sirena.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 18 Jan 2019 19:13:38 +0100
Message-ID: <CAMpxmJX8OmnDtOhQjWi9edX-4pHu1daKiDkRdNAVw-PZsz9UXA@mail.gmail.com>
Subject: Re: [PATCH 08/13] regulator: max77650: add regulator support
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 18 sty 2019 o 19:01 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Fri, Jan 18, 2019 at 02:42:39PM +0100, Bartosz Golaszewski wrote:
>
> > Add regulator support for max77650. We support all four variants of thi=
s
> > PMIC including non-linear voltage table for max77651 SBB1 rail.
>
> Looks good, the ramping stuff might be a candidate for core (TBH I was
> sure we'd got that implemented already but we don't seem to) but that
> can be done later and the more complex one with non-linear steps does
> feel like it might have to stay in the driver anyway.
>
> A couple of small nits:
>
> > +++ b/drivers/regulator/max77650-regulator.c
> > @@ -0,0 +1,537 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Please make the entire header C++ style so it looks more intentional.
>

Seems like there are more files in the kernel source using the mixed
comment style for the SPDX identifier and I also prefer it over C++
only. Would you mind if it stayed that way?

> > +             for_each_child_of_node(dev->of_node, child) {
> > +                     if (!of_node_name_eq(child, rdesc->desc.name))
> > +                             continue;
> > +
> > +                     init_data =3D of_get_regulator_init_data(dev, chi=
ld,
> > +                                                            &rdesc->de=
sc);
> > +                     if (!init_data)
> > +                             return -ENOMEM;
> > +
> > +                     config.of_node =3D child;
> > +                     config.init_data =3D init_data;
> > +             }
>
> You don't need to do this, the core will do it for you (it will actually
> still do it even with the above, it'll only fall back to using
> config->init_data if it's own lookup fails).

I added this loop specifically because the core would not pick up the
init data from DT. What did I miss (some specific variable to assign)?
I just noticed some other drivers do the same and thought it's the
right thing to do.

Thanks,
Bart
