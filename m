Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F80226C3A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDpc2bWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F80226C3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966044AbeFZOYx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:24:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40160 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966021AbeFZOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:24:49 -0400
Received: by mail-qk0-f196.google.com with SMTP id b129-v6so9583149qke.7;
        Tue, 26 Jun 2018 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D31kFDHYVRdEreczmok+iIBNSYLFxRODEYX/0Rw4BWA=;
        b=NDpc2bWiNILe5wtecEXkGOGqIHZE03R2BZZzEC9xBNSQXP5uxWgwv8BAPrUpZbXxGp
         uLpBTFsxmNWnU2lM+yJVFUcu2s52/OQvG+mWgG71r622pjX+PnUsQcsjCA8SGJFEY2TR
         5bxs/Y6Z9t99rwO1BSVCY2Fm+XKIy+R2jCjx1lWQe8wg0xKsORQXXTK0c2JcFSBX0Nvm
         mZGLbIwCKFIabW9kxSRJ7JNa+f+cudKBAjoPmMmWH55I9F6NApXk6i2u6oGMGIryP/QJ
         Z/J8n7t6GsWikJPnssMBA3jUIemXnTNiu1H7fLlK3ioGVltyvxQCWrSnGKjqO9F1WVep
         TfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D31kFDHYVRdEreczmok+iIBNSYLFxRODEYX/0Rw4BWA=;
        b=JEv8oSJWpB3oEAgshiwu0Czs3GNmi3ZE41Otuc70ptfRhn8jbuWkWV6Lc/uQaIaQsg
         B5d8xQfA0ditqaNffoBXPIFUpkhdckZvp7l868jiIfTuimJeOmaJ7qc+OoQ/BGnTqyRO
         pg+ymzbBkn2OTuNq+RCFngnA5Fyy7cVDEqARjqdPhoXJZpJ2pk81T5/BuXHz1bfVC5Fz
         EYKmZdDnvF42ew4wy9lVRJRl69BmMRaCx88PWvM3l41OC4SbIRPAcIycwM4Oj4C7smCV
         sXPX1k6bW6pP5B/xJmsAQc9S+/K6HUosFaSWzmLJZ5a7paRQXl4Znko4EtPa9HS8iE6Y
         OfXw==
X-Gm-Message-State: APt69E2UKZ393CRk0i94jOPs+Lz0MErw7tbYUBBBrYCTnfCGJwMy8TX2
        KckB3roYqPEpwAU0RCXFqCv4WHv6gtgIrWTFvXk=
X-Google-Smtp-Source: AAOMgpcR3FdqKnDfwLq4U8vvXvTU2pQ9nVaYIFq+LZ4pb6PhI5xfm8hQIEtydLq7hXdsTVVn4+cuhC4HkeFUqXf6qmw=
X-Received: by 2002:a37:9f0b:: with SMTP id i11-v6mr1447839qke.171.1530023088909;
 Tue, 26 Jun 2018 07:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain> <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
 <20180626120306.GD2118@localhost.localdomain>
In-Reply-To: <20180626120306.GD2118@localhost.localdomain>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 26 Jun 2018 16:24:37 +0200
Message-ID: <CAFqH_52v3-L1xLL12hzyGCbuooX5T52Lm7BXHM3sBX1ERWmhiQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
dia dt., 26 de juny 2018 a les 14:03:
>
> Hello Again Eric,
>
> On Tue, Jun 26, 2018 at 01:40:40PM +0200, Enric Balletbo Serra wrote:
> > Hi Matti,
> > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > dia dt., 26 de juny 2018 a les 13:25:
> > > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > > dia dt., 19 de juny 2018 a les 12:57:
> > >
> > > > > +static const struct of_device_id bd71837_of_match[] = {
> > > > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > > > +       { },
> > > >
> > > > nit: { /* sentinel */ }
> > >
> > > I am sorry but I didn't quite get the point here. Could you please
> > > explain what did you expect to be added here?
> > >
> >
> > It's a nit but It is a good practice to specify that the last entry is
> > a sentinel. Just this.
> >
> > +static const struct of_device_id bd71837_of_match[] = {
> > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > +       { /* sentinel */ }
> > +};
>
> Oh, I see. Finally something I can disagree =) I quickly opened few
> random drivers which declare match table. None of them practiced this
> good practice. So I guess it is not such a standard after all. And I
> guess the meaning of last entry in match table should be quite obvious.
> Adding the comment /* sentinel */ sounds like stating the obvious at
> best - at worst it gets one just to wonder what the "sentinel" means =)
>

git grep "/\* sentinel \*/"

Anyway, I marked this change as a nit, so you don't need to change. I
just commented because at some point I received a "complain" when I
didn't add it. But this is up to the maintainer and I am not sure if
the "complain" was received in this subsystem :)

Cheers,
 Enric

> >
> > And just noticed, is .data = (void *)0 really required?
>
> As static structs should be initialized to zero I'd say it is not
> required. Will remove this. Thanks for pointing this out.
>
> Br,
>         Matti Vaittinen
>
