Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68174C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F74214ED
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX40Tgd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F74214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKUI62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:58:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33953 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:58:28 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so11171312itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8iTMUup+fMq2xCHtBbPhYH3+pQ2W/gi6YpVLC3y7gvg=;
        b=IX40Tgd7V8wwI8qipmhkzVGsrgOK85aWBcakbhj8AZUlEHs1Wl9s9fqrKJPWkI5vIO
         8I5bw3ZFjvE59cEEl2rWo2D8I30fjzmJbPuMh5Ns56BxUMRm+hbcmqp6um/Ql08NUUfJ
         If4LyzmTckYOOvYUvMj7r1bw4ERR0cpNM7d48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8iTMUup+fMq2xCHtBbPhYH3+pQ2W/gi6YpVLC3y7gvg=;
        b=KDA8l8ovKmmA7ZfcDqWPbr0rUs7iyVBDBastSYy52N5O9WukQ+Rejc15Cz1Y3/Me4U
         9Zjp6SjBG7xP8qtOkWPh6DgYIDmQtleUf27GawATKv4V00ETh73O+9LY06Z/u7x5FodA
         axGVyfCw/7O7iX541+7lUOd5eaGIeu+C/Ll7Rs6RlBSzWs+CyHQaI4JvfxHZWPP9Z4EL
         Qf/m4JFPqG9jmMXmfUQnPbnL/KWRSYhYJaV72x8JkVkbl8M/CCoRJjY9wONBibjPOwQj
         x3v0LTPyrm1o8KHq9Os2fVuKs7z05pYqZG0PElqEjiSRGHSr1DsdpLVBPyxGz5NjJS7x
         HidQ==
X-Gm-Message-State: AA+aEWaa9XgyAZPrhgI+4DPG6j936syYfsLeEaYaPdPa/wdvw34a7/9s
        5pE6qmjltPVCKr2OD2cB91oFEd47fU1OjgqIWhEAaw==
X-Google-Smtp-Source: AFSGD/Xk+7mtS7dZzbB6WkKwQB58nvoZoEs/WHCDJd8uSjdTo5aT7caplkpWaj/kqWtOthRTAaHWisdA8bNWKTpUH70=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr3616335ity.78.1542752824198;
 Tue, 20 Nov 2018 14:27:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 14:26:23
 -0800 (PST)
In-Reply-To: <9f63ea203ec54a86f1edc636e44acc9b5e51aea1.camel@collabora.co.uk>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com> <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai> <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai> <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
 <CAPDyKFrFz9bHa5EmiBmQvXnoRibbL4-Gq9E7E5vDBbd=uj_2kA@mail.gmail.com>
 <515b72f2bd526d144fdc662126aa6e1e8484a25c.camel@collabora.co.uk>
 <CAPDyKFoCyXSQ9bVD9iYYcr4Y7e87Ltdt2+QNg0euvNijRGi83Q@mail.gmail.com> <9f63ea203ec54a86f1edc636e44acc9b5e51aea1.camel@collabora.co.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 23:26:23 +0100
Message-ID: <CAPDyKFr+PhPhZLbHa0bS+yxB_H+NyuAFd1mpJOw3of4JVpHRQQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
To:     Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Faiz Abbas <faiz_abbas@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Hal Emmerich <hal@halemmerich.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 November 2018 at 15:55, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> On Tue, 2018-11-20 at 15:24 +0100, Ulf Hansson wrote:
>> On 20 November 2018 at 15:00, Sjoerd Simons
>> <sjoerd.simons@collabora.co.uk> wrote:
>> > On Tue, 2018-11-20 at 14:08 +0100, Ulf Hansson wrote:
>> > > + Hal Emmerich
>> > >
>> > > On 20 November 2018 at 12:38, Sjoerd Simons
>> > > <sjoerd.simons@collabora.co.uk> wrote:
>> > > > On Tue, 2018-11-20 at 11:23 +0100, Wolfram Sang wrote:
>> > > > So if you know the pattern, or just happen to hit it often in
>> > > > e.g.
>> > > > automated testing, it does show up during development.
>> > > > Otherwise it
>> > > > can
>> > > > appear to "happen once in a while randomly".
>> > >
>> > > I don't quite follow. As far as I understand, the extended
>> > > timeout is
>> > > needed when turning the cache on.
>> > >
>> > > The above seems more related to flushing the cache, no? Flushing
>> > > have
>> > > no timeout (also reported to be an issue [1]), which happens
>> > > either
>> > > at
>> > > _mmc_hw_reset() or at _mmc_suspend().
>> > >
>> > > What is the relation here?
>> >
>> > Yes it's the kinda of behaviour you would expect on a flush indeed!
>> > I
>> > don't know what the card actaully does when turning the cache on,
>> > whether it's actually flush of something persistent when turning
>> > the
>> > cache on after a hard poweroff or doing some other validation.
>> >
>> > All i can share is what our testing seems to indicate, which is
>> > that
>> > there is a wide spread in the time the card needs *and* there seems
>> > to
>> > be strong correlation to the I/O activity before the hard power off
>> > and
>> > the time taken by "cache on".
>>
>> So the hard power off, means that you are cutting the power to the
>> platform and not doing a graceful power off? Just so I understand
>> correctly.
>
> Correct. With hard power off i mean cutting the power to the board in
> some way. When doing a gracefull power off, the issue does not occur on
> my boards (cache on is fast). Presumably as the eMMC got its cache
> flushed as part of the shutdown procedure..

Okay, got it.

>
>> > > Using no limit of the timeout, would mean we may hang for ~10
>> > > minutes
>> > > (MMC_OPS_TIMEOUT_MS) instead, no thanks.
>> >
>> > Probably a silly question, but would this actually cause e.g. boot
>> > to
>> > hang while waiting for the card (assuming rootfs is somewhere
>> > else)?
>>
>> Nope.
>>
>> [...]
>
> Then i'm probably just being dense, but i'm unsure what the issue is
> with waiting for 10 minuts in this case. Apart from having to wait for
> 10 minutes before the user gets an indication in the kernel that the
> card is not usable?

Exactly, to long timeouts is never good. Then it's better to timeout
in a reasonable time and log some error message to the let user know
of what went wrong.

To sum up, if someone wants to send a patch changing the timeout for
enabling the cache to let's say 1500 ms (and by adding a comment why),
I am fine to take it. In other words, lets drop the quirk-approach as
people seems more in favor of general change of the default behavior.

Kind regards
Uffe
