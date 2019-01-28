Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A7C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5BE2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjBO6NAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfA1Oq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:46:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43724 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfA1OqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:46:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so12008136lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0A15Ao45YICdfHTMKUh/nirt0xQjJRx12IsNVpUXSk=;
        b=fjBO6NASJUNwGZiT0ipeqUMB2WymDWSu+H+iMvHuPha+BKeq3OXDHrrvdsxLaLcvZ9
         H2TGSGUD7NE9ji9cvg95etV9hMmO2VN3Yc7h6OdH8kviUdKnJ47vHsEws2VrRu/lfOVW
         a0cKBLUbHDNZjmV7NHwVagWFvZyPeeNDOeWyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0A15Ao45YICdfHTMKUh/nirt0xQjJRx12IsNVpUXSk=;
        b=tdcOhDi8NLZ3B5cvp50B0uq4Yx6Gzy6qchebQq9KOxMFd8Sr8efx+tKC34/0Lnr/Q+
         MhPyusDa2YI2WCdfyOvOoq1qwPQrZ6BAWvcbO4O+wsj+wFyibHGYsKGx+EKouU9yLLv4
         m8c3r+Uds9+byosqBZfvwfJHYau6ZgqCLivvewJtgWEdPWZiYPOaGlFhjE9k+nHewlha
         bRBgSxFWpz0C/5EiIrnLIZ0Bwqj2qc98CLQbX4DoTIiEVcBkSGLfy3P2Efs0zhlv9VJu
         cxww3uRkqptiVAQ/BinITOdRwi57Egotg6VCM7LCvoSRtKGJUv3IkjQzN2YBuoNQqEUX
         QHcQ==
X-Gm-Message-State: AJcUuke90STAs09dmRqOAXGAsTsoJXADxxxgmjc9pVlf2NmlN6LrurIy
        6Aj15uVgtCDntZFMIe5G4sPyjVNTnIbp4PU2vOLbKw==
X-Google-Smtp-Source: ALg8bN4UdQe0NnePjP5wtLROColhji+ieN3FU0f/+czK7dWpJFjaW7J4FEonaVXj/SfJNJ31lI9Os4gslG7LjPJz6e8=
X-Received: by 2002:a19:8096:: with SMTP id b144mr16277616lfd.8.1548686782648;
 Mon, 28 Jan 2019 06:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20190125110600.GA29332@localhost.localdomain> <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
 <20190128135354.GA4156@localhost.localdomain>
In-Reply-To: <20190128135354.GA4156@localhost.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 15:46:10 +0100
Message-ID: <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 2:54 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> > These charging drivers are growing wild. This is starting to get out
> > of hand, we need some more framework for properly handling charging
> > state machines the kernel. Not specifically your problem, but
> > when working on the driver try to keep generic support in mind.
>
> I for sure can try - but as the power subsystem is quite new to me - any
> specific items you would like me to really pay attention?

So I am not saying you have to do this or anything, but I think
what we need is a generic state machine and policy engine
for charging, where different charging drivers just plug in.

They all seem to have trickle and fast charging, USB phy
interaction and AC plug interaction of some kind for detecting
those and in some cases temperature detection directly
or using an ADC.

We have a bunch of drivers with software-controlled charging:
ab8500*
axp288*
etc.

If we could get just two drivers to share some changing
infrastructure we would have a start.

I have no idea how hard it could be, but I think it would
be a pretty interesting adventure if someone gathered
some different hardwares and started to generalize parts
of this.

> > So what I am seeing is that these states are starting to turn up in more
> > and more drivers, so we really need to think about a central management
> > component for charging state machines. I do not think they are all
> > that different after all.
>
> Any suggestions how I should take this into account with bd70528?

Not more than above, it is unfair to ask random contributors to
invent entire new worlds of kernel infrastructure. But I guess I
just need to say it so we are aware: this charging state machine
engine is needed. Doing it is another thing.

> > I am certain you must have a graphical picture of this state
> > machine somewhere, it seems to be how charging hardware people
> > do their thinking.
>
> I don't have any document I could link to yet. I can ask around if we
> can have some public doc for this :/ And as a last resort I can do some
> ASCII art in commenets - if this is seen helpfull.

That'd be nice.

> > If I'm not mistaken this is yet another instance of linear interpolation
> > from a table?
>
> "linear interpolation from a table" is really not part of my
> vocabulary :] But I guess you know the REGULATOR_LINEAR_VOLTAGE - macro?
> I borrowed the idea from there...

I'm referring to this essentially:
https://en.wikipedia.org/wiki/Linear_interpolation

What many charging drivers tends to do is:
- Look up where I am in a table, say between row 4 and 5
- For x-axis n..n+1, interpolate y-axis between
  the values found for x=1 and x=n+1 using
  common linear interpolation.

> > We really need to think about abstracting this. Last time this
> > duplication appeared I suggested adding linear interpolation
> > primitives to:
> > include/linux/fixp-arith.h
>
> ... I really think a generic helper for this would be usefull.

Indeed.

> It will take some time untill I can send a proper (non RFC patch) for
> the charger block as I currently lack of HW I could use for testing the
> charger properly. Do you think it is better to drop the charger part
> from the series untill then and submit it only later?

Not really, we need to face the hardware out there and I usually
use the stance "rough consensus and running code". If noone
invents a unified charging framework, your hardware needs to
run so a custom driver isn't that bad either, and it's still better
to have it in-tree than to maintain it out-of-tree as long as it
is clearly isolated.

> As I mentioned in
> cover-letter, the charger part is currently submitted more to give an
> overview of the chip than to be applied as 'finalized' version of
> driver.

That's OK.

Yours,
Linus Walleij
