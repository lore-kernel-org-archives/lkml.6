Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F16DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFFD21A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUK0JA1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFFD21A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeGDQ5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:57:53 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37553 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGDQ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:57:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so3157210qke.4;
        Wed, 04 Jul 2018 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QluImoJbaAJ5YuG3hVWSfomWGBvS7G8PjC62nr6Bxws=;
        b=pUK0JA1+uhm+IoBWtmjYDmqo9DcLQdCgwRsN5ZavLMB4j+vYxMOAmLpiiSB9F4F6Y8
         y2+rkgw4UAAE60sZ0C2dIPzSDQpQ72qTlIsj79+gH/oYtrhLhburWEKk/2Yuif591+SE
         7PveD2j0eHvQdypErCfmwf7SQPSPoIqdRU42PUJWjOxSypDI5rL2X/STSpFbU7ml+lMI
         xyAEzNo+v6nNgy0aIN8sHke/yKQXc6aiMD91O4mwmUQSHqiL965g7hwR/PZ1+sWgDA+t
         vNQWQQ4dozE9cEGlI2SGcNz/p6eAVZKeJzeZrbTvTs0L4DirPtVpgXVL0jYIZ4HsttjA
         QC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QluImoJbaAJ5YuG3hVWSfomWGBvS7G8PjC62nr6Bxws=;
        b=NrqZNdr0/s51/qp1JBCU6/uJZNQt3ZDxwMZGhtNJEaty64ThCgs2H780/0269x1dpV
         sG6bHSi0s0OdNnBxyI+TQLjOvRYL7vxeb9Ir1DYYAJQEjUlaOGSaywji/F1TR89LZs8j
         n4rW7+Thik5OixvR0r4afhPVzrCkF9Ds0qGEKKpZVvtTglD0QCl0kw5WgqYOq+pOy6IN
         qBEezzklL8mWZiAxfUgeQZ2pv6j4JlWaNpocSheYwx5QjJXa8xQlmpwBR73ioGLGUMLh
         uKdVcueDAN2QjxpdrZhCW26Du66r6dxH4534mzBzGu+oHkqphcmOojPB0qT2jAVM2bE4
         ovKw==
X-Gm-Message-State: APt69E0rZ4l4g7KdpjQN1rSHebv4fsz5qJa9A54V4FGgCg+t6RnS5CHt
        pXeBPqpdu/ld9gzueW5DwrQKsNiecJQCZHv1w8g=
X-Google-Smtp-Source: AAOMgpeBo1XwrdfqXeoCD3V9Ke96lKJvTh6p+KYa9HY0RZ+O6EMGFex/yF/GyshokcAKDWR7/Z7rdOVHEtf5NDZkND8=
X-Received: by 2002:a37:3c85:: with SMTP id j127-v6mr2228293qka.171.1530723470459;
 Wed, 04 Jul 2018 09:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com> <20180704145623.zgei3ehrwdpcu26r@penguin>
In-Reply-To: <20180704145623.zgei3ehrwdpcu26r@penguin>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 4 Jul 2018 18:57:39 +0200
Message-ID: <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

Missatge de Dmitry Torokhov <dmitry.torokhov@gmail.com> del dia dc., 4
de jul. 2018 a les 17:10:
>
> Hi Enric,
>
> On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > Hi Matti,
> >
> > Thanks for the patch, a few comments below, some are feedback I
> > received when I sent some patches to this subsystem.
> >
> > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > dia dt., 19 de juny 2018 a les 12:57:
> > > +};
> > > +
> > > +/* bd71837 multi function cells */
> > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > > +       {
> > > +               .name = "bd71837-clk",
> > > +       }, {
> > > +               .name = "bd718xx-pwrkey",
> > > +               .resources = &irqs[0],
> > > +               .num_resources = ARRAY_SIZE(irqs),
> > > +       }, {
> > > +               .name = "bd71837-pmic",
> > > +       },
> > nit: no comma at the end
>
> Actually, trailing comma is preferred on structures/arrays without
> sentinels, because if one needs to add a new entry/new member, then in
> the diff there will have only one new line added, instead of one line
> being changed (adding now necessary comma) and one added.
>

Many thanks for sharing your knowledge! That looks to me a good
reason. I did this comment because at some point I received this
comment. I try to mark this kind of things as nitpicks because
sometimes there are differences between maintainers. E.g: some
maintainers prefer 'if (something == NULL)', others 'if (!something)';
others are fine using goto even there is nothing to unwind, other
prefer plain returns, etc.

Matti, I don't want to beat about the bush with these nitpicks. It is
not my intention. So I'd say, do what the maintainer wants :)

Dmitry, I really appreciate this kind of comments, especially when
there is a justification, so I can learn more and more to do better
patches.

Thanks,
  Enric
> Thanks.
>
> --
> Dmitry
