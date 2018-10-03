Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AEFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC320835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEOPJovF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJCOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:39:44 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50546 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeJCOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:39:43 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so7132714ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wc5fZIa98HMRT4qXqLJFJZdeUCYRVhMGnHUiGtpHK6E=;
        b=JEOPJovFXYFD8p/kXSq6fSS/KkoiLhCzG70OrIsWTSIr//bB+F2JLu2l/tkslOhiIl
         hEYGtDLifsuGDSVhX0KPNlO3VDULY0e/JA6sOCgeCxGZnb9c3WmORIcVIzsQCtSNbwU+
         M1UN4QTPnDBEFUolbsk+HB8f0hP3+uZXnYQWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wc5fZIa98HMRT4qXqLJFJZdeUCYRVhMGnHUiGtpHK6E=;
        b=Y0WGD55uzgIZQJ8p6V7JPOfn6PhcYvdH+SzqdP3sRLaFsCSsBjCzhsHPZuQVBfN5Jx
         oKPG3TynheSd/zY8yw7zvAbfVbK3ZbHvltTF1NsT19lXRUOceE8xNTrIiy4akevk7p01
         VZmwhx6aNliMqPXXRtGSxfWITc5pvtWrDpPPBvyZnEvYVpts7fErJs9YhfcBZbIvsidP
         WfC0blVPae5jwqpVS1bM6y3JwrIXoBAuRgHRSc30IGR3uVj/z/fmHb54Yr5ieTIzok17
         G/mGyiWOMy760fL5ir0uZGwA7mvREReblueDIJZ9KN33/6QLB0Q/NXb821yUTEqqIbsQ
         XxKQ==
X-Gm-Message-State: ABuFfoiGfoc0rjU8FHhMJRGgXmWEVjDp1mFriYbnKGtIe2HOznBVygyz
        +nv3Sco38YMIxnPGYjEu0HLW3vc1box3xthuOehBRA==
X-Google-Smtp-Source: ACcGV603ikW5Md9iDZOJrT0P6VTz0su6Axw9t2pF7eZSKqZDmLN+Lf/MVPFYpHUr9SWKwVvlMMM1wsXtJtFPEPhtjsY=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr478311ite.16.1538553148110;
 Wed, 03 Oct 2018 00:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-7-thierry.reding@gmail.com> <CACRpkdYnrf7FknvnZyFSgfT5aCrcWT4hxSnQo0UqxYfR6Fkqwg@mail.gmail.com>
 <20180925093315.GB7097@ulmo> <CACRpkdbOpVPB5MqgCyF5x_ENzLscz5oYEstYqwVceqeKZq2w5g@mail.gmail.com>
 <20180925111716.GA7925@ulmo>
In-Reply-To: <20180925111716.GA7925@ulmo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 09:52:16 +0200
Message-ID: <CACRpkdY8PnfrfPcD8Gusk-HeiCmVxdyB0GAsb9nvg3JYY3vpLQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] gpio: Add support for hierarchical IRQ domains
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:17 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Sep 25, 2018 at 12:33:54PM +0200, Linus Walleij wrote:
> > On Tue, Sep 25, 2018 at 11:33 AM Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > > On Tue, Sep 25, 2018 at 10:11:06AM +0200, Linus Walleij wrote:

> > As I see it there are some ways to go about this:
> >
> > 1. Create one gpiochip per bank and just register the number of
> > GPIOs actually accessible per bank offset from 0. This works
> > if one does not insist on having one gpiochip covering all pins,
> > and as long as all usable pins are stacked from offset 0..n.
> > (Tegra186 doesn't do this, it is registering one chip for all.)
> >
> > 2. If the above cannot be met, register enough pins to cover all
> > (e.g. 32 pins for a 32bit GPIO register) then mask off the
> > unused pins in .valid_mask in the gpio_chip. This was fairly
> > recently introduced to add ACPI support for Qualcomm, as
> > there were valid, but unusable GPIO offsets, but it can be
> > used to cut arbitrary holes in any range of offsets.
> >
> > 3. Some driver-specific way. Which seems to be what Tegra186
> > is doing.
> >
> > Would you consider to move over to using method (2) to
> > get a more linear numberspace? I.e. register 8 GPIOs/IRQs
> > per port/bank and then just mask off the invalid ones?
> > .valid_mask in gpio_chip can be used for the GPIOs and
> > .valid_mask in the gpio_irq_chip can be used for IRQs.
> >
> > Or do you think it is nonelegant?
>
> This is all pretty much the same discussion that I remember we had
> earlier this year. Nothing's changed so far.
>
> Back at the time I had pointed out that we'd be wasting a lot of memory
> by registering 8 GPIOs/IRQs per bank, because on average only about 60-
> 75% of the GPIOs are actually used. In addition we waste processing
> resources by having to check the GPIO offset against the valid mask
> every time we want to access a GPIO.
>
> I think that's inelegant, but from the rest of what you're saying you
> don't see it that way.

(...)

> > Sorry for being a pest, I just have a feeling we are reinventing
> > wheels here, I really want to pull as many fringe cases as
> > possible into gpiolib if I can so the maintenance gets
> > simpler.
>
> Like I said, we had this very discussion a couple of months ago, and I
> don't think I want to go through all of it again. I think, yes, I could
> make Tegra186 work with .valid_mask, even if I consider it wasteful. So
> if that's what you want, I'll go rewrite the driver so we'll never have
> to repeat this again.

Well, IMO rolling custom code into every driver that needs a
hierarchical interrupt is pretty inelegant too, so I guess it is one
of those choose the lesser evil situations for me as a maintainer.

I am very happy if this hairy hierarchical irqdomain handling can
be standardized and pushed into the core, and as it seems this
memory optimization stops that and forces a local solution with
some necessarilily different code, also for xlate since a while
back and now for the hierarchical irqdomain.

So if I let this pass then I will just be grumpy again the next
time another local kludge needs to be added.

I am worried that there will be more and more of this special
code just to account for the nonlinear blocks of GPIOs.

I agree memory footprint matters, as does performance,
as does maintainability and reuse. So it's not like there is
a hard factor determining this.

How much memory are we talking about for a tegra186, and
how much is that in proportion to how much memory a
typical tegra186 system has connected to it? If it is significant
and hurting the kernel and/or applications on that platform
I would agree we need to look into memory optimizations.

Yours,
Linus Walleij
