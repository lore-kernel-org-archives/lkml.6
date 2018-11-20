Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A29AC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B620685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYzceFWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49B620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeKTTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:03:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42619 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKTTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:03:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so879294lja.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSiPe1d0bWPdNx7oo0Ss0xf246U5GzVgXbf7Z/D+qxo=;
        b=aYzceFWzUxtEpWwySFOmjhhGj2AqU9t1YUo5xrmjqaMQ6UPrDA2cD1VNmIJKBpr1kX
         RmEfBYwHw8xbJO4Fbp29LOqI3gfOi9al/26YOlxauEAU+lKHOrsTDirXnfrH6aPorSjM
         E6ddInEUiGal36x/+SOp5AJKsoJ1pb8D/3ivs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSiPe1d0bWPdNx7oo0Ss0xf246U5GzVgXbf7Z/D+qxo=;
        b=eNmYCHJeUWLK+dWVMW5anZvmnwvioo/9ohdSU40l94fbWtntuMxrooiPI5Hknz6YQo
         C4oylR9JBLSUzXI68cRpf1kk7Z5Pcou6ElMHZ7UN2l5SJVlGOsTwhVrwvUMKi7OQ507w
         Q5m/LjDoWSHQ++moqSFFfqKAx5k9VCfWv4YYeQM+D4B1NBHwaOIijM1Nb5r8vJveWgG4
         mBxIC4EB/ajVfCMelHZEIWcdO+T0e+WYCo4nowD1kDdueQuU3hONjp670DN36Ypz1aEV
         Z/FgmDdKnAoxk5aQ0LqYY8sepL0uKH9sV60g5cBziWe+kBNAQEoFoO12T8lF3x9Otupj
         v5lg==
X-Gm-Message-State: AA+aEWY/WFVTAgzNcRIdetWf9SJSdiEk+0eLrballkcBXS/U+pXntKaJ
        UhgWrNwjYpVHnoqIIQkQoOqUqN3SjIhOOOa1ouhFSQ==
X-Google-Smtp-Source: AJdET5cySb9E0XvHdHQJ/4vG/hzHQFyOTGp1VJjL9LfNH5wtYt9TLP8wUBoZZ9orDjlLAwmAvSoUkh/hBM4E1TePXpY=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr637163ljc.97.1542702960157;
 Tue, 20 Nov 2018 00:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com> <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com> <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com> <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo> <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com> <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
In-Reply-To: <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:35:47 +0100
Message-ID: <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled state
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        viresh kumar <viresh.kumar@linaro.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org,
        l.majewski@majess.pl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 9:32 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> To sumarize: When the pwm driver probes it is not yet clear if the idle
> state of the output pin is high or low. Even when the pinctrl device has
> an "init" and a "default" pinctrl, it is not yet fixed when its
> "default" is configured.
>
> The way Thierry wants to fix that is by disabling the output driver
> until the pwm is in use und rely on a pull-up or pull-down in hardware.
>
> The way I want to fix this is to only configure the pwm pin as part of
> the consumer. This is late enough that the consumer already requested
> and configured the pwm such that the idle level is known.
> Thierry's and Lothar's claim was that putting the pin setup of the pwm
> pin into the pwm consumer's pinctrl was forbidden. That's why I asked
> you as pinctrl maintainer if there is a requirement that I don't know
> of.

I think we need to be pragmatic and listen most to whoever has
the hardware and need to get it to work. The system needs
to come up in some reasonable way, preferably so that vendors
doing products with it do not have to apply a fat patch stack
to get that backlight working in an acceptable way. Else the
end result is out-of-tree code to paper over the issue and that
IMO is worse than some minor ugliness in the kernel.

However the whole ordeal points to a problem that is with the
pin control system and Thierry's and Lothar's intuition about this
is right in a way: if the pin control system could read out the
state of the hardware at boot (as we nowadays do with GPIO,
which also has a consumer flag cleverly named GPIOD_ASIS)
the whole thing would be no problem.

The same kind of goes for PWM itself in this case I guess.

The whole issue with splash screens and different hardware
turned over to Linux in running state is a bit imperfect I would
say, I think Viresh was working on boot constraints to get
handover of different systems components into some kind
of shape but maybe that stopped short because of the
complexities involved. Isn't that the real problem here?
https://lkml.org/lkml/2017/8/1/191

Yours,
Linus Walleij
