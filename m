Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195DEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4920675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGmGG/fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeLNNue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:50:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33361 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeLNNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:50:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so4319958lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TT1Xs744YvFr5FAOSJ08uVRir7gQf/QP/n2KzZnawb4=;
        b=IGmGG/fR90Y4O2GWuPCFosA3GPigBCBFBNgDMnigNYaRp29bz+Q64UKDZ3ciUk8yHw
         7Gs09Ev9iiu6JyOo3nFwZ0IE3PdcBBpYZLTzU4xL003pMsLgJKswjiIrhdj6+IgnPkv4
         wV5x+yytrMqp85gCYnD8rqNfM9U/4WazcNCqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TT1Xs744YvFr5FAOSJ08uVRir7gQf/QP/n2KzZnawb4=;
        b=VrOk4lpLhoNSqW0Xmh/21UbhXvmhJ7fvjYuzNw1EAWX4nUcOIk4C0V++SJVBbAcbXN
         lGfuNEqLOfRsL8rrLJQ6lBbEpaj//RvGRPvFnBC2C99+HDkYpRfG5xn1a9llNbPrxEe+
         9NZCYuuI9orwrJ+LxCHeXjG+3gH0zqQ3Ygo7wq0CNatXBdksEhcy880byR/XrOXBefQl
         cBppRyvf7a4zqIsDbG0kCVXM66U8tQEmAOYqISmpMeU7TJ2qM7ax8wAYUjTvs+FXeO0L
         Zzo88y2BU42GoEuduyuz9OGxe2rH78BCQN4BeysaXGjHUOZPXP+WAEG38g4BD+1V6a2U
         PRMw==
X-Gm-Message-State: AA+aEWYwcyMPrtk6XENZLZv5/YUw5UOj8yJhnHJW4nH3xaxvdquFpExM
        7sPPKjYP3snlnhQ3JUtUUDvBfag2udfRgMqkU2L74g==
X-Google-Smtp-Source: AFSGD/UqPR5H867B8OQqykdWDeMpN/oCXYbkKZLdsU9DGeKyv5jHL9rQd2rVYFonCRchJ54w/zm7nWjRae35TLhjVgk=
X-Received: by 2002:a19:4849:: with SMTP id v70mr1849137lfa.62.1544795432320;
 Fri, 14 Dec 2018 05:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de> <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de>
In-Reply-To: <20181213204219.onem3q6dcmakusl2@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 14:50:20 +0100
Message-ID: <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:42 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> [Adding Linus Walleij to Cc:]
>
> Hello,
>
> On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> > Le jeu. 13 d=C3=A9c. 2018 =C3=A0 10:24, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > > >  The PWM in the JZ4725B works the same as in the JZ4740, except tha=
t
> > > > it
> > > >  only has 6 channels available instead of 8.
> > >
> > > this driver is probed only from device tree? If yes, it might be
> > > sensible to specify the number of PWMs there and get it from there.
> > > There doesn't seem to be a generic binding for that, but there are
> > > several drivers that could benefit from it. (This is a bigger project
> > > though and shouldn't stop your patch. Still more as it already got
> > > Thierry's ack.)
> >
> > I think there needs to be a proper guideline, as there doesn't seem to =
be
> > a consensus about this. I learned from emails with Rob and Linus (Walle=
ij)
> > that I should not have in devicetree what I can deduce from the compati=
ble
> > string.
>
> I understood them a bit differently. It is ok to deduce things from the
> compatible string. But if you define a generic property (say) "num-pwms"
> that is used uniformly in most bindings this is ok, too. (And then the
> two different devices could use the same compatible.)
>
> An upside of the generic "num-pwms" property is that the pwm core could
> sanity check pwm phandles before passing them to the hardware drivers.

I don't know if this helps, but in GPIO we have "ngpios" which is
used to augment an existing block as to the number of lines actually
used with it.

The typical case is that an ASIC engineer synthesize a block for
32 GPIOs but only 12 of them are routed to external pads. So
we augment the behaviour of that driver to only use 12 of the
32 lines.

I guess using the remaining 20 lines "works" in a sense but they
have no practical use and will just bias electrons in the silicon
for no use.

So if the PWM case is something similar, then by all means add
num-pwms.

Yours,
Linus Walleij
