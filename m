Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF19C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57A9205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KSlNN9KE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57A9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632767AbeKXCoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:44:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53839 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbeKXCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:44:44 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so19008645ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KUyQwwXH5QTSiVHnwU9MghnxKneMD8YKN2Ce7sL0lCA=;
        b=KSlNN9KE4BV7aykuKFcnJypuZ+4wdSMOv1igMHv7lLG/a9fncw1Un5Jdqikk2Y/uJJ
         qaI8+h4Rqh3NVosWWsc78mysUQstW5/bDNY1oUsOb+trT4wIqetHeM35iHQsK2YvQ50o
         HZzO6/xKIGxB6bAxEY4KIcXHn3iUHG3vg3wVNJO+mO3srRcWK/uejBYZQVyNoauyFrv2
         BnCj8xFk+D29YJXL6bRE1xC0Ii2AK6LNsMkE/PEMXg41rjtHX2CoL01vWry1Tq0xcsZW
         ondXAmAjt1b1Fh35duvJMMEHnhFfXGBNWWrORg11fHenECQxiaieTPCQbYNtDA4Z6g7Q
         sCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KUyQwwXH5QTSiVHnwU9MghnxKneMD8YKN2Ce7sL0lCA=;
        b=Tsx27O/z5NGi5Hscvo2BCmWU0xdvUjLkbsr5GMAaLqGGCnUix3QZwluMx969+WpSxc
         Myf6fjcQM2hXfnwgF9oxCioT2xk0YFsfb+LzzPXIH0ohNvJ7zbrWeHmqp1gBGeA81IML
         GcGko4F9ZRgJTsSvtYlsR+3idkKrcvRhqkp/Dk3wV364Vp4L4CB0J+CAYg2rh2WMuG9L
         VCV9KShB005K6sZAGBIignk6Yd+WXdJXRXrjh0RsB2gwreHVWHdepMhku28FB+G9xam4
         u62x1+V4xc01W/ejJx85O5Tyh4IgYMsT4s3xoFvO4/RTS7Sn+pJGDIJyqncioE48Dw8T
         mAIQ==
X-Gm-Message-State: AA+aEWYYjoK8805SlOw5RN6nD3Vt+UKGOHNpR2m+V3q/Kugi79wm4Dti
        CAwe6MqU3/oJUnIZGZOLBqoxMovFZSvpJCP+08GMOg==
X-Google-Smtp-Source: AFSGD/WUNN2UJevhLv1w3mZnQMdu0Cp9ZgeucfajbKmWtWm2eN1IHXtJwVOKDZ3h2bqguZFZQTIajJaY4My7Wx7KMy4=
X-Received: by 2002:a24:9d1:: with SMTP id 200mr5447945itm.53.1542988797504;
 Fri, 23 Nov 2018 07:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de> <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de>
In-Reply-To: <20181121191509.ia2vcklvx4q2rh56@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 23 Nov 2018 16:59:46 +0100
Message-ID: <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 21 lis 2018 o 20:15 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Wed, Nov 21, 2018 at 05:34:32PM +0100, Bartosz Golaszewski wrote:
> > wt., 20 lis 2018 o 18:17 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > On Tue, Nov 20, 2018 at 02:40:31PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > The irq_sim irqchip doesn't allow to configure the sensitivity so e=
very
> > > > call to irq_sim_fire() fires a dummy interrupt. This used to not ma=
tter
> > > > for gpio-mockup (one of the irq_sim users) until commit fa38869b016=
1
> > > > ("gpiolib: Don't support irq sharing for userspace") which made it
> > > > impossible for gpio-mockup to ignore certain events (e.g. only rece=
ive
> > > > notifications about rising edge events).
> > > >
> > > > Introduce a specialized variant of irq_sim_fire() which takes anoth=
er
> > > > argument called edge. allowing to specify the trigger type for the
> > > > dummy interrupt.
> > >
> > > I wonder if it's worth the effort to fix irq_sim. If you take a look =
in
> > > my gpio-simulator patch, it is trivial to get it right without extern=
al
> > > help with an amount of code that is usual for a driver that handles
> > > irqs.
> >
> > You're basically recommending handcrafting another local piece of code
> > for simulating interrupts - something that multiple users may be
> > interested in. You did that in your proposed gpio-simulator and I
> > still can't understand why you couldn't reuse the existing solution.
> > Even if it's broken for your use-case, it's surely easier to fix it
> > than to rewrite and duplicate it? There are very few cases where code
> > consolidation is not a good thing and I don't think this is one of
> > them.
>
> I don't say that factoring out common stuff is bad. But if in the end
> you call
>
>         irq_sim_something(some, parameters, offset);
>
> with the simulator and if you don't use the irq simulator you do
>
>         irq =3D irq_find_mapping(irqdomain, offset);
>         generic_handle_irq(irq);
>
> I prefer the latter because it's only a single additional line and in
> return it's more obvious what it does because it's the same that many
> other drivers (for real hardware) also do.
>

I'm not sure I'm following you. You still need to add ~150 LOC for the
gpio_simulator_irqtrigger() worker and gpio_simulator_irq_*() routines
locally as you did in your gpio-simulator patch. A generic simulator +
using the irq_work saves you that.

Bart
