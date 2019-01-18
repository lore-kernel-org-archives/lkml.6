Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F2C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05D020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RXJTTLb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfARSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:18:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46039 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfARSSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:18:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so15155399ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTnq31kfAduQXnRBnjSow7bpYSdbOJof7kvnlR0myXk=;
        b=RXJTTLb3HQEvZ0C6uNFzv8777CP+IudDuWEnb8qSS6Xcp7bBoci5OFhHgU1/ckVl0k
         paUyF+mwS+LMfbl+zeDhKPg7L5eHBsGNQEyWTAuCxzy9VRUkL3usPLQ+gMgS5ljKvLgQ
         rmShT0vJgR6N/heYDK/a//ri3fG2uejl4noxU0SH6NTQzcyKpar4G1UcDvFyE3w3cDI+
         o4omKTEWzq4tB/ZeCLA66KlRkKsDWE5WzLASdgzCMk384CCxSrAi7qfW9MDe6uvS9Nf3
         PK37BCpiXRZ/f2E42XRiM7hjwJgWChAeRMLuBDPK+0hhd2pTw9+D3xSwcmSDyV8926DT
         VZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTnq31kfAduQXnRBnjSow7bpYSdbOJof7kvnlR0myXk=;
        b=JUMb6zViSOLlqv0FOJHBAcDJllCfjipH79l0DyVxjL1KxwZOjMOIr5nH3juptfG1Nl
         UCNZuPppuUGe0fk6JPQuZ85/MMg5OwfdquC6RohKnVo8xnlsQp06gTxJobwgnFOyHYFt
         u6qcmYC7WUh680ZUBzVS9mIP7yp7HoEtk6FzyGodHzQM3HoBQGkSWRRnoMh4DmOWlXqO
         nKplmuy/0+HxlIL360+OFh3dKe2FAY/WXT2Cl1mgGF/BKtL+94QvnURd++BY1/6jvinG
         9/7SJhyA08o+7OZ7brf2Gyr37eoeQchAoRvqzxw+ShIjRfTRSJYRoeCBVAi1cD+7/C+p
         i/lw==
X-Gm-Message-State: AJcUukcohoHbCjZcicwaMei6AUg0hd/9yKX/ONyNkX7qp2rE0m6jCihY
        gb9nLfK8N79cDWerKlqAjHlSMkAegTLcB8L48NvyyQ==
X-Google-Smtp-Source: ALg8bN6iYGZz7u2mJqkt1EjJNSjkPVwAARpEKbSo/OvGcVb+CnTymFMWZCHUyaOUbT0Gz0BkxVl3vP+65/FnMdcQeRs=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr11956468ote.234.1547835490877;
 Fri, 18 Jan 2019 10:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-9-brgl@bgdev.pl>
 <20190118180148.GD6260@sirena.org.uk>
In-Reply-To: <20190118180148.GD6260@sirena.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 18 Jan 2019 19:18:00 +0100
Message-ID: <CAMpxmJV6bjT558OTiqAGAxHe1ZcJ5u-LPVF45P677EZweXxrSw@mail.gmail.com>
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

Sorry for spamming, I missed it the last time.

> Looks good, the ramping stuff might be a candidate for core (TBH I was
> sure we'd got that implemented already but we don't seem to) but that
> can be done later and the more complex one with non-linear steps does
> feel like it might have to stay in the driver anyway.
>

I'm thinking about implementing that in the core for the next release
cycle and then making this driver the first user.

Bart

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
