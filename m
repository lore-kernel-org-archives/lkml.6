Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BACC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9B42075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544690236;
	bh=nD7n/82AXVUneKO2X3DqoWgSLaID97nrZDBF+Tn+Ipc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vig7kmMoWW2KlfnGRCYDhQyGkYeSKIwUZlsNcYbCtOqoEdZA8LLYcCX6B+EoUGnXe
	 yOvDTa/VkRUIjAF9yRN6Po2UXRGTU7ZTWtP8FZml0Jdx4Q1OKbdE33sh3LY1gKmJAl
	 67/wMyieukg98AMxLIu8A9u1VqPah6BIie98EX/c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9B42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeLMIhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeLMIhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:37:15 -0500
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377A520849;
        Thu, 13 Dec 2018 08:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544690233;
        bh=nD7n/82AXVUneKO2X3DqoWgSLaID97nrZDBF+Tn+Ipc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NUVAp9oyyDA4ZFUvTpuoPZpZ5rKkW53tyOkTdecZrEus+V6zNZeaZXQkNrlMtTpNK
         DhqrxzjNhX7QYWDYEeR5s8kzLDWZ9XLwUg04om5ZGO/qcIIW8bTJmAJ3CCnNTRj9B0
         zNGZGsU59gxtkjguloRbVzXbVw1fsxU66tDeJ/aI=
Received: by mail-lf1-f46.google.com with SMTP id p86so903165lfg.5;
        Thu, 13 Dec 2018 00:37:13 -0800 (PST)
X-Gm-Message-State: AA+aEWaRZbMAhlk/ZLFTXcY9ksNz1Th4ybczMqw4tav8G+byEALM7w8Q
        a3Oztm+a6i8NYESh/1VTLYoFwVvjrBISJlQ8sEg=
X-Google-Smtp-Source: AFSGD/UUwhofiUbjQ7F5z6NO1xyBHQk/tI6teRfQ30vw3rVNIvHhPtcFUZQBbn7v7jfRVRv/o7r1ND0cvg7BuQiHj/A=
X-Received: by 2002:a19:2d16:: with SMTP id k22mr12888503lfj.12.1544690231326;
 Thu, 13 Dec 2018 00:37:11 -0800 (PST)
MIME-Version: 1.0
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
 <1544613406-27026-2-git-send-email-krzk@kernel.org> <20181212123221.GA12040@amd>
In-Reply-To: <20181212123221.GA12040@amd>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 13 Dec 2018 09:36:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcTtX+fsnbjAEu5C=5rsNoqpTWVqV0DKsg+BrLVobE87g@mail.gmail.com>
Message-ID: <CAJKOXPcTtX+fsnbjAEu5C=5rsNoqpTWVqV0DKsg+BrLVobE87g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: leds: Add pattern initialization from
 Device Tree
To:     pavel@ucw.cz
Cc:     jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, baolin.wang@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 at 13:32, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-12-12 12:16:42, Krzysztof Kozlowski wrote:
> > Document new linux,trigger-pattern property for initialization of LED
> > pattern trigger.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/leds/common.txt | 36 +++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> > index aa1399814a2a..3daccd4ea8a3 100644
> > --- a/Documentation/devicetree/bindings/leds/common.txt
> > +++ b/Documentation/devicetree/bindings/leds/common.txt
> > @@ -37,6 +37,42 @@ Optional properties for child nodes:
> >       "ide-disk" - LED indicates IDE disk activity (deprecated),
> >                    in new implementations use "disk-activity"
> >       "timer" - LED flashes at a fixed, configurable rate
> > +     "pattern" - LED alters the brightness for the specified duration with one
> > +                 software timer (requires "led-pattern" property)
> > +
> > +- led-pattern : String with default pattern for certain triggers. Each trigger
> > +                may parse this string differently:
> > +                - one-shot : two numbers specifying delay on and delay off,
> > +                - timer : two numbers specifying delay on and delay
> off,
>
> Needs specifying that numbers are in miliseconds, at the very least.

Sure.

> > +                - pattern : The pattern is given by a series of tuples, of
> > +                  brightness and duration (ms).  The LED is expected to traverse
> > +                  the series and each brightness value for the specified
> > +                  duration.  Duration of 0 means brightness should immediately
> > +                  change to new value.
> > +
> > +                  1. For gradual dimming, the dimming interval now is set as 50
> > +                  milliseconds. So the tuple with duration less than dimming
> > +                  interval (50ms) is treated as a step change of brightness,
> > +                  i.e. the subsequent brightness will be applied without adding
> > +                  intervening dimming intervals.
> > +
> > +                  The gradual dimming format of the software pattern values should be:
> > +                  "brightness_1 duration_1 brightness_2 duration_2 brightness_3
> > +                  duration_3 ...".
> > +                  For example "0 1000 255 2000" will make the LED go gradually
> > +                  from zero-intensity to max (255) intensity in 1000
> > +                  milliseconds, then back to zero intensity in 2000
> > +                  milliseconds.
> > +
> > +                  2. To make the LED go instantly from one brightness value to
> > +                  another, pattern should use zero-time lengths (the brightness
> > +                  must be same as the previous tuple's). So the format should be:
> > +                  "brightness_1 duration_1 brightness_1 0 brightness_2
> > +                  duration_2 brightness_2 0 ...".
> > +                  For example "0 1000 0 0 255 2000 255 0" will make the LED
> > +                  stay off for one second, then stay at max brightness for two
> > +                  seconds.
> > +
>
> No. Duplicated code is bad, and so is duplicated documentation. Maybe
> the documentation should be in device tree part, but lets put it into
> separate file, and reference it from the sysfs docs.

I guess this would satisfy both needs - no external references from
bindings and no duplication.

> 50msec for step change is really a implementation detail of Linux. May
> be worth documenting for sysfs, but not for device tree
> description. People should always specify 0 if they want step change.
>
> Actually, no, I don't think this is quite suitable.
>
> These are arrays of integers. They probably should not be specified as
> strings in dts...?

Makes sense although this would limit the possible formats for other
triggers and LED drivers. Probably there are not many of such use
cases (pattern different than integer numbers) so maybe there is no
point to worry about it too much.

Best regards,
Krzysztof

>
> (Plus, of course, timer and one-shot are subset of pattern, all we
> need is to specify number of repeats...)
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
