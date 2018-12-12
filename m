Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6450FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B52720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544604167;
	bh=KLuhL7t22RWYcbx/tC/6LnsUjH8VrE3kFuFmaudhbbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OZsYVdoaUZi9ku+xL9D/xOK6mGj1B0+uTbirm98qWf8UJT9PcgrIkq4zFtH8oYS9w
	 B83TP3Fis5Z0A/AeEQr3jiyVDl3DU2NbNwaufFa/TUMh2CX2SBCQ0eYb/cH/GUOE6j
	 WmAvlLM+Jax0v1Q3vpo6ZN/Aq6NNEpUcGablU/gI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B52720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeLLImq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbeLLImp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:42:45 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23872086D;
        Wed, 12 Dec 2018 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544604164;
        bh=KLuhL7t22RWYcbx/tC/6LnsUjH8VrE3kFuFmaudhbbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgDBKkPz/qAsMgp/BefEHAMCesjXh8YGBhq8J3LERjBEFFcYk1aSfSBRkKCM/tfVB
         nBQCHegDYz/zoIfAB7lsy0ivs8kE0QFUkpHaCOb3K/DQpUtnmGZQBLBOySznanqOXf
         b5vyN7CK4WYdkp7jPehtoYRkx6bInaFBalDr6Db0=
Received: by mail-lj1-f181.google.com with SMTP id v15-v6so15475810ljh.13;
        Wed, 12 Dec 2018 00:42:43 -0800 (PST)
X-Gm-Message-State: AA+aEWZ4LKxA4hP/26EPIvTbwMDMAXyOru/pfCqjvuWNZQu+pTY4oCte
        AUZk3l9LLpcZzmKF/UPKIqGt2xmGLHrMONzuEUA=
X-Google-Smtp-Source: AFSGD/XVye5jmUsGnJ8lnX2EvNOVE43DrKefw6a/Ep61e6Ia8j2iIk3tewxJl9XxQYvlFptj2ZJeEqnNOgMzFMncsa8=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr11380240ljb.153.1544604161699;
 Wed, 12 Dec 2018 00:42:41 -0800 (PST)
MIME-Version: 1.0
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
 <1544434201-14190-5-git-send-email-krzk@kernel.org> <CABGGiszi3cgkQy0+h4q6nEY0V1Td2x3eR_kZ50cu3awrSGscMQ@mail.gmail.com>
In-Reply-To: <CABGGiszi3cgkQy0+h4q6nEY0V1Td2x3eR_kZ50cu3awrSGscMQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 12 Dec 2018 09:42:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfrRKvvK0fq9SS5xOgeT-vS30z0JwFh=55bow4-tktSZQ@mail.gmail.com>
Message-ID: <CAJKOXPfrRKvvK0fq9SS5xOgeT-vS30z0JwFh=55bow4-tktSZQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: leds: Add pattern initialization from
 Device Tree
To:     robh@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, baolin.wang@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 18:23, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 10, 2018 at 3:30 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Document new linux,trigger-pattern property for initialization of LED
> > pattern trigger.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/leds/common.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> > index aa1399814a2a..4c65e854bb91 100644
> > --- a/Documentation/devicetree/bindings/leds/common.txt
> > +++ b/Documentation/devicetree/bindings/leds/common.txt
> > @@ -37,6 +37,13 @@ Optional properties for child nodes:
> >       "ide-disk" - LED indicates IDE disk activity (deprecated),
> >                    in new implementations use "disk-activity"
> >       "timer" - LED flashes at a fixed, configurable rate
> > +     "pattern" - LED alters the brightness for the specified duration with one
> > +                 software timer (see
> > +                 Documentation/ABI/testing/sysfs-class-led-trigger-pattern)
> > +
> > +- linux,trigger-pattern : Default pattern for "pattern" trigger (see
> > +                          Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> > +                          for description of format)
>
> Binding documents should generally not refer to kernel docs and need
> to stand on their own.

I'll copy then the description of pattern.

> I don't think this needs to be linux specific. I'd just call it
> 'led-pattern'. I don't think this should be tied to the trigger types.
> Isn't possible you would want to tie a pattern to different triggers.
> IOW, when event X happens, run the pattern. And you could have
> one-shot versus continuous.

In general pattern has trigger specific format. For pattern-trigger it
would look like "0 1000 255 1000". For timer trigger it would be just
a single number (period for blinks). Quite similar for the oneshot
trigger. I can change it to "led-pattern" (or maybe
"led-default-pattern" to match "linux,default-trigger" property?) and
document that the pattern itself is trigger specific

Best regards,
Krzysztof
