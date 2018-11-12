Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB445C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581122241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WRe4fCRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581122241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeKMAIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:08:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55798 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbeKMAIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:08:12 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so3575265itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j2HAvJP7XUwtjDQzyL9ZYAaFXHVbZT2kQclkbgE/fek=;
        b=WRe4fCRGrKX19U7V19JLvYYFo1DdGDbOOKMmYWl1MliLU9hwD5vmv27pZ3f6O2UwsA
         VQ8ODEi5K3Keve9ebkBikzfMPUfzR0DIj8J5j4cb+iYSMkLdN7ZBwplD6hKjFdzU7c+o
         tiwpNmWeqDOtuiwhmG4zFAHu8XfAIK4L/AkVAwcSKz6VVXoCBPTPCxJGjm8XVzT1WBVv
         CkpviOVVIxBY/RP2wr/jQlEebZWXwTuquR1D7UevepO3Kvzs8jtbgCzmi2KgGUkPkpXA
         80/XpTxvgmu9pyOOC4i//qQnJHF2PeESxQnq03ZUl3HIOP09FCZ61xIYw3ibI8PI66X+
         UZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j2HAvJP7XUwtjDQzyL9ZYAaFXHVbZT2kQclkbgE/fek=;
        b=kcdhFqzFepO6xH27aNi+wRj5IM3OtfQzYddBCaqrX6D5DnU1AasFQ0vnuSTh080xoZ
         rULSEANPgnwXH16zXdtWkywRA+5kU5OJRDoUQyvXDpUNzJYuaB5K6/wUFvmLOnEQO6KA
         5ta4B8128zU1N52wRYj2YVfiOwAUqu5ocrWmFlD0vGcLrnDNqJHJFhobUM45WbNjt0L4
         BXhLciJNW90NJBAQKCcNJwCg35X4gNCkRoqJkLEKg78XMuaV1Ee1ieI95AaVZBXCzMXb
         HRf/Jo6YLg9Snsa6UpXKzmjcmG4RYpiZgkMw/6TmyH5bAjlwp1QWsX/rZDjQWwLkaCGI
         iXtQ==
X-Gm-Message-State: AGRZ1gLaZqeFcTrRfyyez1MX0nM7nOOaES8+QinGOfLzguf07S4xarVU
        fLEyna5xcMZCG8yzjgYN532IGM/JZgin2mJsLKSgGQ==
X-Google-Smtp-Source: AJdET5cfFrUM+iUdDnwwpEYS9EylMPgJ90jGuIZNfX9CYxSCKg1KtjNcQQACDY2hnFzC2Hp4r3V97+S5Qn0Ol2x7ttE=
X-Received: by 2002:a02:98bb:: with SMTP id q56mr905164jaj.24.1542032084244;
 Mon, 12 Nov 2018 06:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20181108203546.54rncnydgamud5z3@pengutronix.de>
 <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
 <20181109115424.pe4w26nmt6xplzto@pengutronix.de> <CAMRc=Mdf1GHR0_7uQ4PFFCwL9p3NyKBDMSBkipR826BhTYpz=g@mail.gmail.com>
 <20181109131036.v6d645ojv6jr7v3y@pengutronix.de> <CAMRc=Mf18udrM=2=SZHMg3M2akcccPXb7Fr81vXODpNgjf+uJw@mail.gmail.com>
 <20181109143950.gy7swu6vgaqgg7dw@pengutronix.de> <CAMRc=McF482n+57e6Vz9H1dEQ5QS+4p88SYg6ZjNuUMYZx6t3Q@mail.gmail.com>
 <20181109170323.6b2nj5vvtwu3d5ee@pengutronix.de> <CAMRc=MfY7c21NOBNnVgXKimywXHFifwek5B76Y_3DgmM_hBbgw@mail.gmail.com>
 <20181111165917.zrbg3xbhlitto7xs@pengutronix.de>
In-Reply-To: <20181111165917.zrbg3xbhlitto7xs@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 12 Nov 2018 15:14:31 +0100
Message-ID: <CAMRc=Mfs_Wwm9bW121iMLrAAfuYhhekQnFRHYZBYU=Ry_dEKwg@mail.gmail.com>
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

niedz., 11 lis 2018 o 17:59 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Fri, Nov 09, 2018 at 06:23:01PM +0100, Bartosz Golaszewski wrote:
> > pt., 9 lis 2018 o 18:03 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > Hello Bartosz,
> > >
> > > On Fri, Nov 09, 2018 at 04:24:10PM +0100, Bartosz Golaszewski wrote:
> > > > pt., 9 lis 2018 o 15:39 Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > > > On Fri, Nov 09, 2018 at 02:53:16PM +0100, Bartosz Golaszewski wro=
te:
> > > > > > pt., 9 lis 2018 o 14:10 Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > > > > > Which test failed exactly?
> > > > > >
> > > > > > All gpioinfo tests that check the output of this command and ex=
pect to
> > > > > > see input as line direction.
> > > > >
> > > > > This wasn't the answer I expected. The background of my question =
was:
> > > > > This failing test seems to expect that a given GPIO is an input. =
If that
> > > > > expectation already exists after the gpio is only requested, then=
 the
> > > > > test is broken and a fix is necessary there.
> > > >
> > > > The test is only expected to work with gpio-mockup which is a dummy
> > > > testing module. I believe its behavior should be as deterministic a=
s
> > > > possible to the point where newly created chips always have the sam=
e
> > > > direction.
> > >
> > > Given that the initial direction of a GPIO isn't fixed in my eyes the
> > > test should be able to cope with both possibilities. I'd say it's a b=
ug
> > > in the test if it doesn't.
> > >
> >
> > As I said before: it is and should be fixed in this specific case.
> > This isn't real hardware.
>
> Not sure if we agree here yet. What do you want to fix? The driver or
> the test?
>
> In my eyes test driven development is great. But if something breaks
> because the test is wrong, please don't "fix" the system to repair the
> test, but modify the test to be able to handle reality.
>

No, we don't have an agreement. You think I should fix the test, I
think the dummy driver should continue behaving like before.

Given that there's no real hardware behind, the direction of newly
created dummy lines has always been deterministic - input. Certain
tests have been relying on it. I want to keep on doing it. There's no
harm. It's not broken logic as the very purpose of this module is to
allow for easy testing of the UAPI.

So unless something *else* is wrong with this patch, I intend to push
it upstream.

Best regards,
Bartosz Golaszewski
