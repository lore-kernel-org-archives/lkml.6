Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5065CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A6C21852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uytcb79l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfBZMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:09:39 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43527 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBZMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:09:38 -0500
Received: by mail-io1-f65.google.com with SMTP id y6so10257395ioq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFGSDSqsinybQJOsU/D36ElOP7a9yW2c6i9xoNwf52I=;
        b=uytcb79l5j3EcEj+DPAaQ+RSlHdaGaSy8RizIyzQocwB3bD640rLf+3nHmBtYlGbvu
         VUK9wHJAlZYg8szu5He/bcyCF9sGdXTh25dZIX78DYd/z1SmHKrnmA66Bmj/Cb0hpaDg
         CjaHLhDFEFtg3NbwFQML+Tv1JaYBLV+lTF6wA6CGYC3vQYpTlDDr2g2gMBdpBrmFy8L9
         +1hXe76F3uuGM5u99xmkbWfwlN5yIW6P80MuNzskfupz288bWD8tNA+Ja96jTqIXcWYs
         d9ZAuuqw7R8qSA5HwscMXuU8tG+RyBiNG4uu8lse3Dhg9I6F7CkTDu9lRFRGXioFNelX
         n4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFGSDSqsinybQJOsU/D36ElOP7a9yW2c6i9xoNwf52I=;
        b=BjD6F8j/+ZLKET3xxcZIITvaDc/tONGMAQlgr/cyrIhqbHiROZN1E22bsmifZg+Nvq
         +zmi7ochnmyIxW5+8LsLfMTW5v+FELXdBVkTz3OPZSTn4aa14DK+DDQe8X8mimmanhS/
         df48s9pq0mDFhiD5Qc2w/Vidh12Yzga0/oGF/0h1y40aNDAtCuTbb7B/sqfAVYd/L8yZ
         xl1D4PZildMcYcA/Alfx+wQRxcj3S96QOmMxXfi4G2+/r6TGWo/swKW6J4cYkqyu2f6q
         azQs05FSFrQcbXDSx3+4ngHogHaNDt/un7oTBKdWXQYi70W05HaxX7tX+j5X3VBDPBwD
         rivA==
X-Gm-Message-State: AHQUAuYgVJ47X1BjxbVsxU0eu7ZvFSdRbDSuIVUrC3r0HgW9Jbi8CXLr
        DuKm/YewWq6a5a2TqX4CrwQpVJb0W/AzRsX34ifCNw==
X-Google-Smtp-Source: AHgI3IYcdQn8f0YErB1c+1z8veB6DoMZZkGSIotAr8GE0WsLAUrb/RQBbhPycEaVpHCnvImGiUbJGqo/y+jgN8J3778=
X-Received: by 2002:a5e:de05:: with SMTP id e5mr13247886iok.111.1551182977250;
 Tue, 26 Feb 2019 04:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl> <20190204171757.32073-9-brgl@bgdev.pl>
 <bb0bc61a-8c2b-affa-c58a-1e7c14f9390d@ti.com>
In-Reply-To: <bb0bc61a-8c2b-affa-c58a-1e7c14f9390d@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Feb 2019 13:09:26 +0100
Message-ID: <CAMRc=Mf8wGNaPOxNx8xmvw5cRpA1fnRQ1-sc7iyMihcZ=Fb6dw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] ARM: davinci: dm355: switch to using the
 clocksource driver
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lut 2019 o 13:34 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
> > -/*
> > - * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
> > - * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
> > - * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
> > - * T1_TOP: Timer 1, top   :  <unused>
>
> Documenting this timer division is important because DSP usage and
> unused timers are not immediately clear from kernel code alone. Can you
> retain these comments in all patches of this series (I guess T0_BOT etc.
> terminology is changed, so feel free to adjust the comment text).
>
> > - */
> > -static struct davinci_timer_info dm355_timer_info =3D {
> > -     .timers         =3D davinci_timer_instance,
> > -     .clockevent_id  =3D T0_BOT,
> > -     .clocksource_id =3D T0_TOP,
> > +static const struct davinci_timer_cfg dm355_timer_cfg =3D {
> > +     .reg =3D {
> > +             .start          =3D DAVINCI_TIMER0_BASE,
> > +             .end            =3D DAVINCI_TIMER0_BASE + SZ_4K,
>
> Here and other places too, SZ_4K - 1
>
> Thanks,
> Sekhar

I used appropriate DEFINE_RES_x() macros instead.

Bart
