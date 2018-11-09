Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC10C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EB820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="B/539OWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EB820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeKIXeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:34:11 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46310 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKIXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:34:10 -0500
Received: by mail-io1-f65.google.com with SMTP id y22-v6so1261038ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZzZKA2mowjJsWpyH62tDEWelFTlq84VqIoHpTa9gjsI=;
        b=B/539OWIu4Dch7dodn6J4bQqlmnVLUNKflLyLKl4+vEPgrlWYhQ1/Jj2MrSwfJEsJX
         M0HpEgBXbpYZ56MpmV7nm+uUUNn8V1RdpfzqrCefUvwiVRugMM/+NrBaP0x/abJ3y0Wm
         Amuz+4Z8/DYYusm/QDH7uU+JA5Dui9p6AmmtdI8a7/jWXHb6yscVk0lgJfTJimbVMnfJ
         QdNdSJllDPN7Ptn7ygYDWcPuZy1TjoBE5iuhb7m21R7rM5+HmnfNcdXV7hxI6olUOT3g
         aTiD/SUscVwTKW/4FybD/C6uOpZ4+G3DVRmu5ld98zUHEhc2ADytxII6KikgO2Xp4kvv
         eNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzZKA2mowjJsWpyH62tDEWelFTlq84VqIoHpTa9gjsI=;
        b=KpQnX0MnOA7s8+YZ2TYpnZb3QYQyJE2Zc2N63ShjCoLKtgGrsg3kt8WXk8z+Udkk78
         BRxAhExa810lSJnHC4v6n4sjs4js+xNingp0nQT0JTG2PfD6CMV+vD0LGePHa9L99AV7
         G3QCw3hIblU9FMQ5+H3rLKuBr3wxfLRefPk+izICL0rm42+XDKaIJ1RgFvJ6U28jupr0
         lcRtyDsZkHSwXAci2kLnrDXEm7VIiU3ffb2PWRMNY7oNxGbDPgL4No+4MUp2U2d9c9Pa
         3CRlPhKolwNl6qKJGHG6+TRcOmWtIwWwILcVbCu157aisMkfSc3n89/Q6KPnhn53NKrq
         Xelw==
X-Gm-Message-State: AGRZ1gK4QsuvOp+wgkeJz7oQwNa3iKzB8kFRwOjxeTf8tM/DQnLI+EB8
        F0ijnOkyfWjLOFV+VPknO1Fg1bpLHqztLu+M01ZDZGmw
X-Google-Smtp-Source: AJdET5dm6dWzzsThIDosLFVfzRTnzpGaa+2wkgpyTPAYpdcopIcWCJPrq9xZ+IL0y5PmOCnQPYqBjKYX9z2gGBTTJtE=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10-v6mr7468396ioq.111.1541771607064;
 Fri, 09 Nov 2018 05:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-2-brgl@bgdev.pl>
 <20181108203546.54rncnydgamud5z3@pengutronix.de> <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
 <20181109115424.pe4w26nmt6xplzto@pengutronix.de> <CAMRc=Mdf1GHR0_7uQ4PFFCwL9p3NyKBDMSBkipR826BhTYpz=g@mail.gmail.com>
 <20181109131036.v6d645ojv6jr7v3y@pengutronix.de>
In-Reply-To: <20181109131036.v6d645ojv6jr7v3y@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 14:53:16 +0100
Message-ID: <CAMRc=Mf18udrM=2=SZHMg3M2akcccPXb7Fr81vXODpNgjf+uJw@mail.gmail.com>
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

pt., 9 lis 2018 o 14:10 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello,
>
> On Fri, Nov 09, 2018 at 01:24:36PM +0100, Bartosz Golaszewski wrote:
> > pt., 9 lis 2018 o 12:54 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > On Fri, Nov 09, 2018 at 12:13:44PM +0100, Bartosz Golaszewski wrote:
> > > > czw., 8 lis 2018 o 21:35 Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > > > On Thu, Nov 08, 2018 at 05:52:53PM +0100, Bartosz Golaszewski wro=
te:
> > > > > > Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
> > > > > > beginning") fixed an existing issue but broke libgpiod tests by
> > > > > > changing the default direction of dummy lines to output.
> > > > >
> > > > > The indicated commit only changed what was shown in debugfs, but =
didn't
> > > > > touch the actual direction of a GPIO, doesn't it? If someone call=
ed
> > > > > gpiod_get_direction before it would have returned "output", too, =
unless
> > > > > I miss something.
> > > > >
> > > >
> > > > This commit (3edfb7bd76bd) sets the correct direction of the line b=
y
> > > > actually calling get_direction() instead of assuming input if
> > > > direction_input is not NULL. It just so happened that previously th=
e
> > > > default direction of gpio-mockup lines was output but it would be
> > > > displayed as input due to this inconsistency.
> > >
> > > Does the test that fails since 3edfb7bd76bd use debugfs/gpio to find =
out
> > > the direction of a gpio? I'd say it's a bad idea to depend on this as
> > > (AFAICT) debugfs is only a debug aid and you shouldn't depend on stuf=
f
> > > contained in it.
> >
> > No, this is what we get from the LINEINFO ioctl(). I only use debugfs
> > for triggering dummy interrupts.
>
> A right, gpio_ioctl uses these flags, too.
>
> > > I'd weaken the commit log a bit to not claim that the commit broke
> > > libgpiod but that it only made the inconsistency visible. After all t=
his
> > > commit didn't "change the default direction of dummy lines to output"=
,
> > > they were an output already before.
> >
> > Well it did break the tests you know. ;)
>
> Which test failed exactly?
>

All gpioinfo tests that check the output of this command and expect to
see input as line direction.

Bart
