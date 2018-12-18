Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431A4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFC321841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545123990;
	bh=VqraFm2+x2Yj9V6ayZp+yL2VrH5cKJw3S6fKK1EV7gU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YJM6UGqXEaf0SvcircB7JcVi6jw0wTLcMmgEOb4VbkaAr39pNsewWjfbb4vR6nA8F
	 Z2ubDxqNVYIqmlfPq9iz5Xzb3VilRHdYjZbi3ums/fRMqPD4YL03lwGX4q8r4R+lj9
	 DHnZMORZJDjUm+sBQgLdply4kvJGVBdeXSZavhNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLRJG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbeLRJG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:06:28 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A76A21848;
        Tue, 18 Dec 2018 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545123987;
        bh=VqraFm2+x2Yj9V6ayZp+yL2VrH5cKJw3S6fKK1EV7gU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BeJbW/f6Mlsyx9xMXgem+bAJkEzlDvSThM2t9zCfcQ/yxqVG/tyOzeWi1V8kPFTIl
         PcQ1kIZ0OY+kOAcUWnoyOkrvDvePZHCXgYdtKm7MPdeOfVe2Jfj5XczQBBfkw+Aq+w
         LyHsuR1Wbfl7Q+GfF5ULBfEZmTpaZ+D1aj6Tce/M=
Received: by mail-lf1-f42.google.com with SMTP id l10so11630570lfh.9;
        Tue, 18 Dec 2018 01:06:27 -0800 (PST)
X-Gm-Message-State: AA+aEWZAZfx8JCJSLkgwSoy7L4dcsC1zlmq3KI6QYofkKvesvI/Cmrxq
        KE7fd3eWt7lBD0aL696fwRlitf7lt9z53ILPIA8=
X-Google-Smtp-Source: AFSGD/XX6wB7kVBonNTVJLE8BlssE/gnftnVG1gcwyk613R8eArAVwryxhPDCpcP/HAg8IXevMxE9NwXmjyFEEJhlv4=
X-Received: by 2002:a19:660a:: with SMTP id a10mr10192399lfc.146.1545123985402;
 Tue, 18 Dec 2018 01:06:25 -0800 (PST)
MIME-Version: 1.0
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
 <1544613406-27026-2-git-send-email-krzk@kernel.org> <20181217224029.GA16132@bogus>
In-Reply-To: <20181217224029.GA16132@bogus>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 18 Dec 2018 10:06:14 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd_icrPUQJhbcHkovQ7DFYM5mVZmXG_qbHv3KKjxVEdbg@mail.gmail.com>
Message-ID: <CAJKOXPd_icrPUQJhbcHkovQ7DFYM5mVZmXG_qbHv3KKjxVEdbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: leds: Add pattern initialization from
 Device Tree
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 23:40, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Dec 12, 2018 at 12:16:42PM +0100, Krzysztof Kozlowski wrote:
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
> > +                - timer : two numbers specifying delay on and delay off,
>
> I misunderstood that these triggers applied to this. Is there any point
> to supporting these modes?

I am not sure whether I explained this clearly enough, so let me be
more specific. The "led-pattern" is a string with pattern which will
be interpreted differently, based on LED trigger. One-shot and timer
triggers expect two numbers. Pattern trigger expects full pattern.

> Aren't they just a subset or simplification
> of a pattern?

Yes, they are.

>
> Can we control the timer frequency from DT? The pattern could address
> that limitation.

No, currently we cannot. This patch with pattern solves that issue.

>
> > +                - pattern : The pattern is given by a series of tuples, of
>
> Don't you need one-shot vs. repeat modes for patterns too?

Repeat mode is defined by trigger. One-shot is one time. Timer and
patter triggers are repeating.

>
> I could imagine you'd want a pattern for any trigger.

In general I think that only these three triggers require such
initialization through pattern. Other triggers - like heartbeat or
activity - have they own bindings (or do not need any).

Following Pavel's suggestion, I could convert it to array of integers
which still should be suitable for these and any future triggers
operating on numbers.

Best regards,
Krzysztof
