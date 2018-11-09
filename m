Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0177C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A8820840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TasJ8pbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A8820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeKIWFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:05:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50886 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeKIWFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:05:11 -0500
Received: by mail-it1-f196.google.com with SMTP id k206-v6so2787135ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V24aEW63G2BeJMGrAJPsI8RJ5Q4StwEhcOvI9bgBaE4=;
        b=TasJ8pbhRhoblNCm2PrvQXtU2dB2mcloFXDDTqH/RVpxk+z9EbT8ehe5W09YfeI1oW
         Lx8Cfvi4lI2Unf4L3bIiFTlMx5tgCBPXs5XmJ9zuDUTg+wfAaswnZRKSHmt25Dogf+nt
         6y51eQL/6g/Q66xdUtUAzf3Sje2VS9Dh6zpBP497nizsSIPSNEkaXGlmmOuv+opfeEXI
         s7kWQVut8kbwcWLENxcLKde6YJlPKFESEYlJG7kSHLEvR0a7TfgGRQZ+qIcLyGmyMKMs
         8rdzGvOwdvOkTQTXfxRkl3aTrAhGvIk2ht0jMvLnlJsDO6iMedC7Xc38fjitaAZ5oCTF
         lXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V24aEW63G2BeJMGrAJPsI8RJ5Q4StwEhcOvI9bgBaE4=;
        b=fakMeBiEwW9o042XvpeNXkVzWWbpetGuq7ZS1uVZRQnM+c2Jky6+uKB4ESv6Rd7u93
         VIHjXPvxJmR8Hf2XMe7aBmeSye8PcVT0obLCegzTBCi2zu2/ql2Yy+7M0++bjyNuZXLT
         FcTLK6Jwp7FhZy/XuSwk0NzHuBanNFi7tli57gbYN3PVYuoKBG86P7Ugq9Ak1PqZOAX2
         4xLSorjgtHYq3XXnc9IvJ3P3tAA07SoptS8wmHz8/YRccefpFh+Uzy5sOY4tTXAnfvJB
         xrcRIrNzW2VMij2I6I2D52cv5uiHyNAOwV8LwMCCCXdGbqdIPZn+mCbpk7hav1KNiV3H
         +n7A==
X-Gm-Message-State: AGRZ1gI60Ae9LsgsaxFpz0vOL3bk+7xgmsAsX90lUFnA3YVM3OPxhcFr
        YwYwOx4Tc0tgXpOg+u23xIXkquYdCTsCuWXuI55CsA==
X-Google-Smtp-Source: AJdET5cJPkMQzPhmxGjwTXSq8gXWvc+zp6/pMxZxN/suUMUOA1v1slz1L85FqjPhu8ST8R7mralEDXBW2Z9MlsNcQTQ=
X-Received: by 2002:a02:9804:: with SMTP id t4-v6mr8109544jaj.136.1541766287337;
 Fri, 09 Nov 2018 04:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-2-brgl@bgdev.pl>
 <20181108203546.54rncnydgamud5z3@pengutronix.de> <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
 <20181109115424.pe4w26nmt6xplzto@pengutronix.de>
In-Reply-To: <20181109115424.pe4w26nmt6xplzto@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 13:24:36 +0100
Message-ID: <CAMRc=Mdf1GHR0_7uQ4PFFCwL9p3NyKBDMSBkipR826BhTYpz=g@mail.gmail.com>
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

pt., 9 lis 2018 o 12:54 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Fri, Nov 09, 2018 at 12:13:44PM +0100, Bartosz Golaszewski wrote:
> > czw., 8 lis 2018 o 21:35 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > On Thu, Nov 08, 2018 at 05:52:53PM +0100, Bartosz Golaszewski wrote:
> > > > Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
> > > > beginning") fixed an existing issue but broke libgpiod tests by
> > > > changing the default direction of dummy lines to output.
> > >
> > > The indicated commit only changed what was shown in debugfs, but didn=
't
> > > touch the actual direction of a GPIO, doesn't it? If someone called
> > > gpiod_get_direction before it would have returned "output", too, unle=
ss
> > > I miss something.
> > >
> >
> > This commit (3edfb7bd76bd) sets the correct direction of the line by
> > actually calling get_direction() instead of assuming input if
> > direction_input is not NULL. It just so happened that previously the
> > default direction of gpio-mockup lines was output but it would be
> > displayed as input due to this inconsistency.
>
> Does the test that fails since 3edfb7bd76bd use debugfs/gpio to find out
> the direction of a gpio? I'd say it's a bad idea to depend on this as
> (AFAICT) debugfs is only a debug aid and you shouldn't depend on stuff
> contained in it.
>

No, this is what we get from the LINEINFO ioctl(). I only use debugfs
for triggering dummy interrupts.

> I'd weaken the commit log a bit to not claim that the commit broke
> libgpiod but that it only made the inconsistency visible. After all this
> commit didn't "change the default direction of dummy lines to output",
> they were an output already before.
>

Well it did break the tests you know. ;)

I guess no harm in rewording the message.

Bart
