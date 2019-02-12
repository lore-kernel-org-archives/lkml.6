Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5073C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26572184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="M4gVzWxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfBLLKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:10:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37530 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfBLLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:10:11 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so6536552iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T8dK2KMpZ8QSiNr+8g35NywCf/tdgQPftRQJOvlPkto=;
        b=M4gVzWxo4dfkMF0LfmbG7U0Nego/6ppoMxFP0JT5NFRNAetg0qh3GydBlYmdwD+Wsf
         IRrZEatHR1A++97mxwAz2yV7P6n8mzYsNi8vVt+MLD6HVjSczCPkyLggl6qMChV7X9jl
         xmPfwFpU8+b5vzWAC9/DC7w3JlQB+9GdQxIRKsD4OQDoszp2HAnS6MTQ+sorpCoEnrBy
         fEyeIl+lZJ2J8bSKQltTqJsBmeHeQ/LNjTm/vipI1rz5HulngT5sVM8Z7x0bxs7hyInj
         jP9bR5hY6ztNv4lmZBefahoS6FgdtrcqIO7eoWBOI3oe9qY5LlsFcvrtbm2lcUC3mfwv
         dcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T8dK2KMpZ8QSiNr+8g35NywCf/tdgQPftRQJOvlPkto=;
        b=fCoK8es1geZEwoyzrkzKBumDcDqoYO9OOSv7O25aBMUvAX9G+5SCM26hQ4hlREOckF
         FDb7ZFFEG1Q/M9sLZyoSfr1YE0krkP6mtPcmTIzOHnGdu4SgC54vIcqHIaTTCJHJ6De0
         du3LNNg6AyLo4dr43uNzGp3MmKgYkBZ9Xi1hYHSGb1IKK/jMuhh/EXUTJDWmVAoKdoUg
         YCH8PsHFEOluukmKeL52+gq8onhbtj8JNHUQhwvMQOVcKtbzcEdQfOhirDHCW866DNqg
         FKRw//LHg4R2TbcdapnaBRGykAfrFPGuvSW5OjMV6NpBTLjANIYx2EYH+H9jyBbVo3qr
         HCHA==
X-Gm-Message-State: AHQUAubnkCO6QS4liaXRm0L9Jn2i/0yOjfkazqV+qgMUBC31OvwJPvPJ
        87yqNFIHR9cVk4AAJYUKJBJ69Cf1D3MDFfYpA1wYIg==
X-Google-Smtp-Source: AHgI3IZ0sBrMl0P0F7yxMGjBlmerKm00Gaz2bRFfzqVL3pLdhpMCHnug1J3LGfkGCXrgXE9741i0TtWB64oa4hMcJ2c=
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr1780591iol.187.1549969810428;
 Tue, 12 Feb 2019 03:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129084411.30495-1-brgl@bgdev.pl> <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com> <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
 <c562c67d-d6e3-15c3-b10b-315e8fb181a5@arm.com> <20190212110501.wd7ks7vms7pi63dk@pengutronix.de>
In-Reply-To: <20190212110501.wd7ks7vms7pi63dk@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 12:09:59 +0100
Message-ID: <CAMRc=MdqhHZPoemkr8XL2vmUQELzgJrUW0y=RVD4kH11k2iQhQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 12:05 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Tue, Feb 12, 2019 at 10:27:54AM +0000, Marc Zyngier wrote:
> > On 12/02/2019 09:19, Bartosz Golaszewski wrote:
> > > When userspace wants to monitor GPIO line interrupts, the GPIO
> > > framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
> > > IRQF_TRIGGER_RISING or both. The testing module tries to act like rea=
l
> > > hardware and so if we pass only one of the *_TRIGGER_* flags, we want
> > > the simulated interrupt of corresponding type to be fired.
> >
> > Well, that's not how HW works.
>
> I cannot follow. I agree with Bartosz here. If you configure your SoC's
> irq-controller to only fire on a raising edge, you don't get an event
> when the line falls.
>
> > > Another solution - if you don't like this one -  would be to have mor=
e
> > > specialized functions: irq_sim_fire_rising() and
> > > irq_sim_fire_falling(). How about that?
> >
> > I think you're missing the point. So far, your API has been "an
> > interrupt has fired", no matter what the trigger is, and that's fine.
> > That's just modeling the output of an abstract interrupt controller int=
o
> > whatever the irqsim is simulating.
> >
> > Now, what you're exposing is "this is how the line changed". Which is a=
n
> > entirely different business, as you're now exposing the device output
> > line. Yes, you can model it with raising/falling, but you need at least
> > resampling for level interrupts, and actual edge detection (raising
> > followed by raising only generates a single interrupt, while
> > raising-falling-raising generates two).
>
> This matches my concern and that's why I suggested somewhere else in
> this thread to put the configuration of the sensitiveness and the actual
> tracking of the line in the same component (either irqsim or
> gpio-mockup). Given that there are only two irqsim users and the other
> one (something in iio) doesn't need that sensitiveness stuff (and I
> cannot imagine another user of irqsim with the sensitiveness support) I
> think it is best to move this to the mockup driver. That's how "normal"
> hardware drivers have to do it, too.
>

This is what v1 of this series did - it provided a function to
retrieve the type and the logic lived in gpio-mockup. Maybe we need to
get back to that solution.

Bart
