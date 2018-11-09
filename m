Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396ADC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB142080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dmOI623b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB142080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeKJBFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:05:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36368 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeKJBFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:05:24 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so3768483itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eTqsaeFYQfrCRdb3MjhGyVjBFoiEsc8ewr3JBpNcnt0=;
        b=dmOI623bswZWTBLADhfOf0Fjv7SJB86mHKDcOmIinAC22x7CBnbW+GMcEpaS58Dtzj
         DJ0OBiHNsxqumB7++ShyCJ5zYzEYWIKuZAfcoTT1UrJzEintBJw0rhqYUXV92BAKJbQ6
         Rhlu78lkgxbRd6urglfxdUUaVa8dyIJIrmxk9sOv8ww6lEkZ9tjZv1/7klug9LH2iIbr
         v31Ao2lfGH3qplR8gUjY4AKibbA17WxJcQbhPkDP7RnF7L9evi+keIhGF1r6GBFmPRjq
         mMSCuprtfMsgQsEUFxBwsWWUkRjTqEnJKU1AWSCMN6iIA4NRytlt3n+TA1CHKpDfJ7/f
         /MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eTqsaeFYQfrCRdb3MjhGyVjBFoiEsc8ewr3JBpNcnt0=;
        b=mvHpdnvAI/f/nEU1R/x7TnGAareFEksJxCf9rDi08IZp/PU/BI/3LTKpcdV0WEaVf8
         tHzQoIxtN7eWR2/7XcKpiv/hqgkmn9XF3mRr1pR/xctKdcn2FSex9WkJA3HwCouBqca5
         HQSRg/RnutexkR1fPG0Vu/h0WdHr4q/2YfrA05inTJFd7Iu+1N2yiXyMyTECSAkpzZcy
         xmZvUizPdFxW8Qp0l7zOo3ilztdQISc/n5fBN+SloQxH7PNlNMTjPrAGwDj9grRZDf5T
         k/+DgZcWLXEz/z8/PHwDbGaJVyUz79YnceqO5GKiFqYRqttJlvCilDl2qeP8Dmw40fBi
         BgRw==
X-Gm-Message-State: AGRZ1gLE2+uugv9SI33lxXzvEg7krgHcR+0T4OkiShvAuBUqwvaOT7vv
        iYZqubzcKY7pfniaMGLQG5bxVY//neJYV0xCV5F1+A==
X-Google-Smtp-Source: AJdET5f5D8TGdXkaBJjkQ2eHpNxdaQGvYSm6QoJyRT1Aj/MBhoioaPvhPtRd8XMD51BQl9/sDx+9l0XUVn8huqJgYTA=
X-Received: by 2002:a24:a70e:: with SMTP id a14-v6mr2416698itf.74.1541777061393;
 Fri, 09 Nov 2018 07:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-2-brgl@bgdev.pl>
 <20181108203546.54rncnydgamud5z3@pengutronix.de> <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
 <20181109115424.pe4w26nmt6xplzto@pengutronix.de> <CAMRc=Mdf1GHR0_7uQ4PFFCwL9p3NyKBDMSBkipR826BhTYpz=g@mail.gmail.com>
 <20181109131036.v6d645ojv6jr7v3y@pengutronix.de> <CAMRc=Mf18udrM=2=SZHMg3M2akcccPXb7Fr81vXODpNgjf+uJw@mail.gmail.com>
 <20181109143950.gy7swu6vgaqgg7dw@pengutronix.de>
In-Reply-To: <20181109143950.gy7swu6vgaqgg7dw@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 16:24:10 +0100
Message-ID: <CAMRc=McF482n+57e6Vz9H1dEQ5QS+4p88SYg6ZjNuUMYZx6t3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: mockup: fix indicated direction
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 9 lis 2018 o 15:39 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Fri, Nov 09, 2018 at 02:53:16PM +0100, Bartosz Golaszewski wrote:
> > pt., 9 lis 2018 o 14:10 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > Hello,
> > >
> > > On Fri, Nov 09, 2018 at 01:24:36PM +0100, Bartosz Golaszewski wrote:
> > > > pt., 9 lis 2018 o 12:54 Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > > > On Fri, Nov 09, 2018 at 12:13:44PM +0100, Bartosz Golaszewski wro=
te:
> > > > > > czw., 8 lis 2018 o 21:35 Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > > > > > On Thu, Nov 08, 2018 at 05:52:53PM +0100, Bartosz Golaszewski=
 wrote:
> > > > > > > > Commit 3edfb7bd76bd ("gpiolib: Show correct direction from =
the
> > > > > > > > beginning") fixed an existing issue but broke libgpiod test=
s by
> > > > > > > > changing the default direction of dummy lines to output.
> > > > > > >
> > > > > > > The indicated commit only changed what was shown in debugfs, =
but didn't
> > > > > > > touch the actual direction of a GPIO, doesn't it? If someone =
called
> > > > > > > gpiod_get_direction before it would have returned "output", t=
oo, unless
> > > > > > > I miss something.
> > > > > > >
> > > > > >
> > > > > > This commit (3edfb7bd76bd) sets the correct direction of the li=
ne by
> > > > > > actually calling get_direction() instead of assuming input if
> > > > > > direction_input is not NULL. It just so happened that previousl=
y the
> > > > > > default direction of gpio-mockup lines was output but it would =
be
> > > > > > displayed as input due to this inconsistency.
> > > > >
> > > > > Does the test that fails since 3edfb7bd76bd use debugfs/gpio to f=
ind out
> > > > > the direction of a gpio? I'd say it's a bad idea to depend on thi=
s as
> > > > > (AFAICT) debugfs is only a debug aid and you shouldn't depend on =
stuff
> > > > > contained in it.
> > > >
> > > > No, this is what we get from the LINEINFO ioctl(). I only use debug=
fs
> > > > for triggering dummy interrupts.
> > >
> > > A right, gpio_ioctl uses these flags, too.
> > >
> > > > > I'd weaken the commit log a bit to not claim that the commit brok=
e
> > > > > libgpiod but that it only made the inconsistency visible. After a=
ll this
> > > > > commit didn't "change the default direction of dummy lines to out=
put",
> > > > > they were an output already before.
> > > >
> > > > Well it did break the tests you know. ;)
> > >
> > > Which test failed exactly?
> > >
> >
> > All gpioinfo tests that check the output of this command and expect to
> > see input as line direction.
>
> This wasn't the answer I expected. The background of my question was:
> This failing test seems to expect that a given GPIO is an input. If that
> expectation already exists after the gpio is only requested, then the
> test is broken and a fix is necessary there.
>

The test is only expected to work with gpio-mockup which is a dummy
testing module. I believe its behavior should be as deterministic as
possible to the point where newly created chips always have the same
direction.

Bart
