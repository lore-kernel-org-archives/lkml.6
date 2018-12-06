Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CCE20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNLTg4Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CCE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeLFI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:58:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40736 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFI6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:58:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so20963510lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuv/GqEQjpt+FmCZ1hHtpaatnZ/UFWJoiI69v2HIxdY=;
        b=kNLTg4EdTzQhAwxeMsoOmzlBE/Iu1l05HXj0ZY4F1JWoBgcS/v/8SZ3aR9/fCowCzY
         bhswiKUN7lYUHLKWvwxmQPDyjE/r0szzH+2g0pjRQh9rpQcEVzeb8a0BNPG6e2adFoVE
         CuRpw2h8JysXmE0ElVlML1UWGNGYs6/KkK2Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuv/GqEQjpt+FmCZ1hHtpaatnZ/UFWJoiI69v2HIxdY=;
        b=Lec0LByEzlSpyJU2kWSvsJwn/htBE669SsA90TaXsOQnMZ4hT2VhMoy4w6rQ8yGNnA
         fi0Fc5Kmn5RxGLeCN+KudUoFdHeWs9jGCmUT9TviLxye+MBEr+uENyzYyeEIYyWRx1me
         wIXu38luYoeQbrf9hnE4xcSP1LGaIxRwU9S53t747K2Z5YmhPJe1fvQDvttxzvAgos3V
         +dl5Hp1XFoNZi+a+W+nj7anm60r50N5WhEahRWBVZYAR/18jMttZu5BzHdRfYzSXWJPP
         39+CUDF4jbthmcz6OcwrbwnnTgXHg8HFCRv27HmleALbTl+nreH1OVQkec35X47GUB1C
         BKDA==
X-Gm-Message-State: AA+aEWZL9wtXiokjRdg7JnCBmW2SokW7PjX7coF7y0KyXMIvkP+LtGC0
        dO8TUjjwZxDMMOV3Qv/o78Vom+6La8XDjGOTALXo/g==
X-Google-Smtp-Source: AFSGD/VfDisY3yY5CTfAeE+6ytGuVgdvEP2QOz+yoci1JvpXnxLWrSq5WSNUDMmh7dHWBvegFFCm9QzAH4DrOIqg0bU=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr17961982ljk.4.1544086722335;
 Thu, 06 Dec 2018 00:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20181205124721.26624-1-linus.walleij@linaro.org>
 <20181205124721.26624-7-linus.walleij@linaro.org> <20181205134345.GF16508@imbe.wolfsonmicro.main>
 <CACRpkdbJsTc2tAyTriz33a75d-1tJdcvdock0fxi7HdJ+EH_Dw@mail.gmail.com> <20181205153331.GG16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181205153331.GG16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Dec 2018 09:58:30 +0100
Message-ID: <CACRpkdaSuU+v1yZm-GXBH693JbVZysXm6_1939ct50arKJn2qw@mail.gmail.com>
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

On Wed, Dec 5, 2018 at 4:33 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Dec 05, 2018 at 03:42:06PM +0100, Linus Walleij wrote:
> > On Wed, Dec 5, 2018 at 2:43 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Wed, Dec 05, 2018 at 01:47:12PM +0100, Linus Walleij wrote:
> > > > @@ -775,10 +779,13 @@ static int max8973_probe(struct i2c_client *client,
> > > >               /*
> > > >                * We do not let the core switch this regulator on/off,
> > > >                * we just leave it on.
> > > > +              *
> > > > +              * Do not use devm* here: the regulator core takes over the
> > > > +              * lifecycle management of the GPIO descriptor.
> > > >                */
> > > > -             gpiod = devm_gpiod_get_optional(&client->dev,
> > > > -                                             "maxim,enable",
> > > > -                                             GPIOD_OUT_HIGH);
> > > > +             gpiod = gpiod_get_optional(&client->dev,
> > > > +                                        "maxim,enable",
> > > > +                                        GPIOD_OUT_HIGH);
> > >
> > > My comment on v2 still stands here, the GPIO is not passed to
> > > the regulator core on this path.
> >
> > Patch 01 should take care of that, did you check it?
>
> Yeah, patch 1 makes the regulator core consistently handle GPIOs
> that are passed into it.

Sorry. I confused this patch for the max77686 patch. That
one was fixed with patch 01...

> However, on the MAX77621 path in this
> switch statement the GPIO is never passed into the regulator
> core, so the core never takes ownership of it, so the driver still
> needs to manage the lifetime.
>
> It should be a pretty easy fix though as commented on v2, again
> apologies for the slow review.

OK I switch it to devm_ as you suggested, as we implemented
gpiod_unhinge it's a piece of cake nowadays.

Thanks a lot!
Linus Walleij
