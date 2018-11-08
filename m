Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB74620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PomqLHZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB74620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeKIBLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:11:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40628 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeKIBLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:11:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so4539617oth.7;
        Thu, 08 Nov 2018 07:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nu7S3hUcrKZ6y3lVKfhdu8+uu7qLQFWu+lkXZ4I9dfE=;
        b=PomqLHZZDxDIWR/S1g6mTkuIj/rfo+u9u1WCVeKrb/5mkEVvTJtf+blx5+5Q+cqcJ7
         9vN92pg7TxUMgch8ew8QbV+fxj8gLFzb+DNK9GUaTHj47ASQXEN2ZIiijlBzOfAOOs+m
         s8B/NwC/g2N/7/V/3EPuRBN+ib4HVAo3d0VLFpv11x82gKAujemLwIqXZkLOE8akHRQ9
         Ngrq3O1frVxyza5tZsy2rYpPfGhtXnOAqwDC51NekHQM4EyQBtH4yYrImYo9TlCdPA6K
         UalTX18H0oXV+pRlumASpnStlgBPA9QUoZr1BetuvShYmgiBgWrJUIpuNiD/CWGX51rW
         Hk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu7S3hUcrKZ6y3lVKfhdu8+uu7qLQFWu+lkXZ4I9dfE=;
        b=ORMoidHZLo0kWBvGjMlK6/KkwUsug2MY5dRFnvRJuaxbqpR+L/v7GhJQNa1nDOLg10
         0Vk+s0UZYYMrH4cHZt6v0yPh3IuFJ1CgG7bw9wyEl4H62txyQZQs5/oOY0Kfayl1Ez0x
         De/V8Nxb7KUANiGRB2deoG5lqbf2orC8EEfDv7wPkoXTG9lAeQFwG4k7XY6kNKMxs7Ru
         sas+inqkvsoIYI60agRE9iAcdxDp7rxF/hkMll3O2RD37S0AVdfeqOnG0s0w9pOnfY3O
         EV5jP5Cakl65EFUpsmzZqsoS78ZJIan37A+Jo123Q62nCJwb7xRXoUmXUYp2qoN/ldBE
         AHlg==
X-Gm-Message-State: AGRZ1gIOEKZbh9m8187Fh0yGPDZNAh+RoxLNaVaatG1TwB3UVD7A9vwE
        3yNIzdGzlAg4v0yxQS6Z6PJkgugguG09vvMC+t4=
X-Google-Smtp-Source: AJdET5eKWn455pZni4+Y19clL04A3/tvXd/esiKrOpL03u+Ry+ues9BHjZYtFn/IgA/YyHF9RAFS/aDEedqU+KHC5VY=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr3080629oti.245.1541691329724;
 Thu, 08 Nov 2018 07:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-7-TheSven73@googlemail.com> <CAK8P3a3apbxNa2FpADvdLCe-GzV+2xv2kO1_tosOZrUpY6xWtA@mail.gmail.com>
In-Reply-To: <CAK8P3a3apbxNa2FpADvdLCe-GzV+2xv2kO1_tosOZrUpY6xWtA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 8 Nov 2018 10:35:18 -0500
Message-ID: <CAGngYiWvZze2wd-p4avhwGHap=RCO2XPcwShYWPRcs59c3q65A@mail.gmail.com>
Subject: Re: [PATCH anybus v3 6/6] misc: support HMS Profinet IRT industrial controller
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

These are great questions, I had been wondering when they would be brought up :)

On Thu, Nov 8, 2018 at 9:20 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't understand much about field bus, but I have a general feeling
> that if you configure a mac address and IP address, this should
> be connect ed to the network layer in some form, possibly being
> exposed as a network device and manipulated using netlink
> instead of sysfs or ioctl.
>
> Can you explain how this fits together and why you got the the
> sysfs interface?

I started typing here how a fieldbus differs from a networking
device, and how it does not fit in the kernel abstraction for
networking devices.

Then I started explaining the "roll my own" userspace API I created
for fieldbus devices... and it hit me. There is already a fieldbus API !

include/linux/uio_driver.h

Let me go and check how well it fits with what my device needs.


> > +       struct {
> > +               /* addresses IN NETWORK ORDER! */
> > +               __u32 ip_addr;
> > +               __u32 subnet_msk;
> > +               __u32 gateway_addr;
> > +               __u8  is_valid:1;
> > +       } eth;
>
> Overall, this structure feels too complex for an ioctl interface,
> with the nested structures. If we end up keeping that
> ioctl, maybe at least make it a flat structure without padding,
> or alternatively make it a set of separate ioctls.
>

I agree that it feels complex, but it's the best I could come up with.
There are a few hidden constraints:

1. The profinet card configuration settings must be applied atomically.
And they can only be applied right after device reset.

So if we use smaller, separate ioctls, we will end up resetting the device
each time we send an ioctl. And to assemble a real configuration, we need
5 or 6 ioctls, so the card gets reset 5 or 6 times, which takes ages.
It cannot work this way.

2. Configuration settings are optional. That's why why each little struct
has an is_valid member. If we use a flatter structure, we need a bool for
every config setting in the struct, to indicate if it should be applied.
Which feels clunky.

One way to overcome this is by letting the ioctls change data in the driver,
but not on the card. Then a separate "apply" ioctl could apply the whole
configuration atomically.

Example:
ioctl(clear all settings?);
ioctl(set ip address);
ioctl(set stop mode action);
ioctl(enable internal webserver);
ioctl(apply);

But of course, what happens if two processes try to configure the
driver at the same time?
The ioctl calls would be interleaved, and the result would be very messy...

There must be a better way?
