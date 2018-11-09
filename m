Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83E520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nDwE9+vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83E520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeKJDEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:04:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45379 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeKJDEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:04:44 -0500
Received: by mail-io1-f65.google.com with SMTP id p83-v6so1778499iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LOsSKTFlkAimULcfAaTXeBhmOaA7b5uOGNlA2rHlkC8=;
        b=nDwE9+vudxuBY/05Nyr/4ejlA06j3S488tfe5Eu0EQFmgcIaFUcBTrubFqANDQqpRe
         Zc8HlBStZpak32gW9IgZKuMJsaOZXULOD58xU2XK/pR81OujCmH+buUJL/iHvXSM4rpo
         vvCfn7PiEIC3JEBcIkQW761GGA0qqw6vssqqdN4vNsXbjfFXbZqe3GL6eQarDeEWIwa2
         DP0/M3ymDNNZuZNjKRNMTYtkVbqPt7sbaxEJ5/OGj1rg+a+i8JJbS3TdH968it+JIp0w
         KASnwvIxD7D/T4+XnkYqAjn8c+wgz3bxhYsTHm+NtPLwarGR+Q0NlWSyvFxIoX0703SC
         u0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LOsSKTFlkAimULcfAaTXeBhmOaA7b5uOGNlA2rHlkC8=;
        b=VyEeLxA0AOPmAszeqoThnuczBVVCeE8N+Ks2DR6TFn1EaM8A2gS5R2Zt0TUEF6KcP9
         nqCPz3zLvEZE09kt1PqsZCAInG8GSW5COx36u8yI3Ft+QoiYl1/kMOu4Q08gniF+u8k4
         5k7yzut0n7t+85hAGqaSjrFSxEP6d1uoAJEefStF579xmBBoPPSkYwm4u6nfPXQ+TpB1
         qwWFG6+aDNiaXxukRzeVTxiRj51pc21iBDLNQypw3LwtoDyw1cILuHmrY4wv/c/fgNyg
         8acTD0HekUqGTsRTjEXmTsge5bD8V6WXQst7eIVLNrUnB4Qu6IYqeaCFlGHse0ORoqLa
         xnBA==
X-Gm-Message-State: AGRZ1gJzzp2CINsy2LM6ytkHFtGzcJeCJq4r06fFq9OwaRHAmR/GoUIN
        impiGZ19/S0uId3rYjKen3wMKqRfggkAXROJNmPT8qyW
X-Google-Smtp-Source: AJdET5f/HcDmQK5mjKKhitmet/isdJE7fqXwwaD897gCdAP0KKhmUZZC5xslKdR/CXdNGUYu6zaJ9LkHsBcQKNTkfqI=
X-Received: by 2002:a5e:aa13:: with SMTP id s19-v6mr7711507ioe.187.1541784192954;
 Fri, 09 Nov 2018 09:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-2-brgl@bgdev.pl>
 <20181108203546.54rncnydgamud5z3@pengutronix.de> <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
 <20181109115424.pe4w26nmt6xplzto@pengutronix.de> <CAMRc=Mdf1GHR0_7uQ4PFFCwL9p3NyKBDMSBkipR826BhTYpz=g@mail.gmail.com>
 <20181109131036.v6d645ojv6jr7v3y@pengutronix.de> <CAMRc=Mf18udrM=2=SZHMg3M2akcccPXb7Fr81vXODpNgjf+uJw@mail.gmail.com>
 <20181109143950.gy7swu6vgaqgg7dw@pengutronix.de> <CAMRc=McF482n+57e6Vz9H1dEQ5QS+4p88SYg6ZjNuUMYZx6t3Q@mail.gmail.com>
 <20181109170323.6b2nj5vvtwu3d5ee@pengutronix.de>
In-Reply-To: <20181109170323.6b2nj5vvtwu3d5ee@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 18:23:01 +0100
Message-ID: <CAMRc=MfY7c21NOBNnVgXKimywXHFifwek5B76Y_3DgmM_hBbgw@mail.gmail.com>
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

pt., 9 lis 2018 o 18:03 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Fri, Nov 09, 2018 at 04:24:10PM +0100, Bartosz Golaszewski wrote:
> > pt., 9 lis 2018 o 15:39 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > On Fri, Nov 09, 2018 at 02:53:16PM +0100, Bartosz Golaszewski wrote:
> > > > pt., 9 lis 2018 o 14:10 Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > > > > Which test failed exactly?
> > > >
> > > > All gpioinfo tests that check the output of this command and expect=
 to
> > > > see input as line direction.
> > >
> > > This wasn't the answer I expected. The background of my question was:
> > > This failing test seems to expect that a given GPIO is an input. If t=
hat
> > > expectation already exists after the gpio is only requested, then the
> > > test is broken and a fix is necessary there.
> >
> > The test is only expected to work with gpio-mockup which is a dummy
> > testing module. I believe its behavior should be as deterministic as
> > possible to the point where newly created chips always have the same
> > direction.
>
> Given that the initial direction of a GPIO isn't fixed in my eyes the
> test should be able to cope with both possibilities. I'd say it's a bug
> in the test if it doesn't.
>

As I said before: it is and should be fixed in this specific case.
This isn't real hardware.

Bart
