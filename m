Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6AFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50E820661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hclKqM9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50E820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeLFLsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:48:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40416 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFLsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:48:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so112481lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+DyQNtTkJ3/ZpvBP6CwoAz3Thk3r1Lx9oLMIY32EoY=;
        b=hclKqM9BlWwm814zOS0to4aCCL5BDy5tnjfTu2vdGlxzaBTI8lCcQXIR16b8CrJwqd
         h6RZxcM3MlU+LJ+Mc4GBmehKsuJuKmw3b+HtMyl0Nns01gc4YuqPQcpSZa/GRNur39sG
         /bevJgygIbXnkrCM53YBKPFvosZR4XGJ1wM80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+DyQNtTkJ3/ZpvBP6CwoAz3Thk3r1Lx9oLMIY32EoY=;
        b=SryVFtOeeoKGGU/7t+N3ZhMnjf0hwr15L48CNXVvwWv+muSeKi0uYc6LT+bTX6v0iS
         vQsHWUlnBKavIRNTOa1naa1F1UQeMu5LTa4IeIGNMxmRlQSuarmpYmDI9qLCo7xtdSUS
         5DUxSzsZCqHXZDpv7pP5YU8mDnhEXlb+86WRlkhtzNv9JwJiaVHe/TP2DzBqINySudxQ
         Ra5bRc78FpsUTBWdND2AFeU078mcYFPjDHmYGqU1BnySMgxBiNYzjfSdiCaT/JOqCqRw
         1AHZYr6Bo7B6BNY1SugiEoDTXzROCm5Rs5Fus98KlLxtggCKOHp0mndejF9IBOlB3ylj
         /QSA==
X-Gm-Message-State: AA+aEWamN+40/js7DEOEwnJv/eC4jtCJx5L80+O3eJgq4fF0h+CgdHHp
        b8+eqEFnZaMb07b4hJwYRNnQ1c2vyXfNaotwOfFoCw==
X-Google-Smtp-Source: AFSGD/XVQ6eYxTzu0jJnjVmIY0bcznlh8f0yJQR+Vaam+w5Z5JnVLqT7WzJ9P0uxwHd6wJoXqjVkmnIv0AsPYjDXVKM=
X-Received: by 2002:a19:c801:: with SMTP id y1mr16153304lff.53.1544096878959;
 Thu, 06 Dec 2018 03:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20181205124721.26624-1-linus.walleij@linaro.org>
 <20181205124721.26624-7-linus.walleij@linaro.org> <20181205134345.GF16508@imbe.wolfsonmicro.main>
 <CACRpkdbJsTc2tAyTriz33a75d-1tJdcvdock0fxi7HdJ+EH_Dw@mail.gmail.com>
 <20181205153331.GG16508@imbe.wolfsonmicro.main> <CACRpkdaSuU+v1yZm-GXBH693JbVZysXm6_1939ct50arKJn2qw@mail.gmail.com>
 <20181206103430.GH16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181206103430.GH16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Dec 2018 12:47:46 +0100
Message-ID: <CACRpkdaO6-ak74zudmNy1G5rXC0G6UVxOJ8Du82X6bZTPoJhpA@mail.gmail.com>
Subject: Re: [PATCH 06/15 v3] regulator: max8973: Let core handle GPIO descriptor
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:34 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Dec 06, 2018 at 09:58:30AM +0100, Linus Walleij wrote:
> > On Wed, Dec 5, 2018 at 4:33 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Wed, Dec 05, 2018 at 03:42:06PM +0100, Linus Walleij wrote:
> > > > On Wed, Dec 5, 2018 at 2:43 PM Charles Keepax
> > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > On Wed, Dec 05, 2018 at 01:47:12PM +0100, Linus Walleij wrote:
> > > > > > @@ -775,10 +779,13 @@ static int max8973_probe(struct i2c_client *client,
> > > > > >               /*
> > > > > >                * We do not let the core switch this regulator on/off,
> > > > > >                * we just leave it on.
> > > > > > +              *
> > > > > > +              * Do not use devm* here: the regulator core takes over the
> > > > > > +              * lifecycle management of the GPIO descriptor.
> > > > > >                */
> > > > > > -             gpiod = devm_gpiod_get_optional(&client->dev,
> > > > > > -                                             "maxim,enable",
> > > > > > -                                             GPIOD_OUT_HIGH);
> > > > > > +             gpiod = gpiod_get_optional(&client->dev,
> > > > > > +                                        "maxim,enable",
> > > > > > +                                        GPIOD_OUT_HIGH);
> > > > >
> > > > > My comment on v2 still stands here, the GPIO is not passed to
> > > > > the regulator core on this path.
> > > >
> > > > Patch 01 should take care of that, did you check it?
> > >
> > > Yeah, patch 1 makes the regulator core consistently handle GPIOs
> > > that are passed into it.
> >
> > Sorry. I confused this patch for the max77686 patch. That
> > one was fixed with patch 01...
> >
> > > However, on the MAX77621 path in this
> > > switch statement the GPIO is never passed into the regulator
> > > core, so the core never takes ownership of it, so the driver still
> > > needs to manage the lifetime.
> > >
> > > It should be a pretty easy fix though as commented on v2, again
> > > apologies for the slow review.
> >
> > OK I switch it to devm_ as you suggested, as we implemented
> > gpiod_unhinge it's a piece of cake nowadays.
> >
>
> You shouldn't really need to use unhinge, you can just use devm
> on the path that doesn't pass it to the core and not on the
> one that does. You just need to update the error case below it to
> use config->ena_gpiod rather than gpiod.

Indeed I just think it will be confusing when people read the code.

It's better consistency if its just devm_* and the  we unhinge the
one we pass to the regulator core IMO.

Yours,
Linus Walleij
