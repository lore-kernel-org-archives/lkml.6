Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B400CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C15208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C15208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeKTUVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:21:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeKTUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:21:55 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gP2iq-0000s9-Bn; Tue, 20 Nov 2018 10:53:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gP2io-0006yH-D5; Tue, 20 Nov 2018 10:53:30 +0100
Date:   Tue, 20 Nov 2018 10:53:30 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     viresh kumar <viresh.kumar@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org,
        l.majewski@majess.pl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181120095330.ccdaquzgsuiyznki@pengutronix.de>
References: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
 <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
 <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 20, 2018 at 09:35:47AM +0100, Linus Walleij wrote:
> On Mon, Nov 19, 2018 at 9:32 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > To sumarize: When the pwm driver probes it is not yet clear if the idle
> > state of the output pin is high or low. Even when the pinctrl device has
> > an "init" and a "default" pinctrl, it is not yet fixed when its
> > "default" is configured.
> >
> > The way Thierry wants to fix that is by disabling the output driver
> > until the pwm is in use und rely on a pull-up or pull-down in hardware.
> >
> > The way I want to fix this is to only configure the pwm pin as part of
> > the consumer. This is late enough that the consumer already requested
> > and configured the pwm such that the idle level is known.
> > Thierry's and Lothar's claim was that putting the pin setup of the pwm
> > pin into the pwm consumer's pinctrl was forbidden. That's why I asked
> > you as pinctrl maintainer if there is a requirement that I don't know
> > of.
> 
> I think we need to be pragmatic and listen most to whoever has
> the hardware and need to get it to work. The system needs
> to come up in some reasonable way, preferably so that vendors
> doing products with it do not have to apply a fat patch stack
> to get that backlight working in an acceptable way. Else the
> end result is out-of-tree code to paper over the issue and that
> IMO is worse than some minor ugliness in the kernel.
> 
> However the whole ordeal points to a problem that is with the
> pin control system and Thierry's and Lothar's intuition about this
> is right in a way: if the pin control system could read out the
> state of the hardware at boot (as we nowadays do with GPIO,
> which also has a consumer flag cleverly named GPIOD_ASIS)
> the whole thing would be no problem.

Well, on the problematic machine the setup currently is:

The bootloader configures the brightness pin as GPIO high output to
disable the backlight, the PWM isn't touched and so is off and
uninverted.

The next relevant event is that the PWM driver is probed.
The PWM registers are not touched, so keeps being off and outputs
a 0. If in this state the pin is muxed as PWM the output becomes 0 which
should be prevented, so this must not be part of a "default" or "init"
pinctrl for the PWM node.

The next event is that the backlight driver is probed. The probe
function grabs the PWM, tells it to be inverted and off. So the output
of the PWM is a 1 and only after that the PWM pin can be safely muxed as
PWM.

So the options are:

 a) In the bootloader setup the PWM as inverted and configure the pin as
    PWM.

 b) Make the PWM aware that it is off and let it mux an "idle" setting
    that depending on the SoC might involve muxing the pin as GPIO and
    setting the GPIO as input.

 c) setup the PWM pin as PWM only when the backlight is probed.

a) has the downside that configuring a PWM is a tad more complex then
setting up a GPIO. Also it's a bit ugly to let Linux impose a limitation
on the bootloader about how to disable the backlight there.

b) has the downside that the dts author has to specify a GPIO and the
idle level and two instead of only one pinctrl setting. Conceptually
this is not so nice, because normally the PWM doesn't know if it is used
inverted or not. With the GPIO specification this information is
implicitly added. (Also there might be additional hurdles, for example
on i.MX31 (IIRC) there are pins that cannot be muxed as GPIO but are in
use as CS signal for spi. I didn't check if there is a similar
limitation for PWM pins.)

With c) the pwm is setup only when the backlight driver requests it. If
the backlight driver fails to probe or is disabled nothing happens to
the PWM pin. If the backlight driver was loaded successfully the PWM pin
is muxed just after it was set up with the right polarity. Similar as
with b) there is no limitation about how the bootloader disabled the
backlight. The beauty I see in c) is this is a solution that doesn't
have to care about GPIOs and muxing pins depending on the PWM state. And
given that there is such a way, I don't see why we should impose on dts
authors to specify these things that are not technically necessary.

Both b) and c) is about delaying muxing the pin as PWM late enough.
Suggestion b) is about doing this explicitly somewhere below driver/pwm,
c) only uses pinctrl as available automatically for all devices.

Probably its subjective if you consider b) or c) as the better/prettier
solution.

Note that the solution b) is independent of the imx uglyness[1] and
applies to all PWMs that don't disable its output driver on disable.
(And for PWMs that disable the output driver, the solution might be
needed anyhow because there is "broken" hardware that doesn't have the
right pullups assembled to ensure the right idle level when the pin
doesn't drive.)

So the sensible options are in my eyes:

 - Implement b) in the PWM core (and not the pwm-imx driver); or
 - just use c) accepting that the PWM is muxed not by itself but by its
   consumer.

In my eyes doing b) consequently would result in letting the PWM know
the intended idle level even without a consumer. Not only implicitly by
a GPIO specification, but explicitly using something like:

	&pwm3 {
		pwm-default-inverted;
	};

in the device tree. (And with that the GPIO solution would loose
its importance because every PWM is able to drive a constant 1 and a
constant 0. It might just be useful as an optimisation that draws less
power.)

> The same kind of goes for PWM itself in this case I guess.

So as pinmuxing is involved it doesn't solve the problem as the driver
would diagnose the PWM to be uninverted and off and so would enable the
backlight. There is still a solution needed to delay the muxing.

> The whole issue with splash screens and different hardware
> turned over to Linux in running state is a bit imperfect I would
> say, I think Viresh was working on boot constraints to get
> handover of different systems components into some kind
> of shape but maybe that stopped short because of the
> complexities involved. Isn't that the real problem here?
> https://lkml.org/lkml/2017/8/1/191

The Boot Constraints core solves things like "Don't let the UART change
the clk frequency of a common parent of the UART itself and the PWM that
is needed to show the splash screen." This is orthogonal to the problem
here I'd say.

Best regards
Uwe

[1] If you disable the imx PWM while being inverted it outputs a 0
    also a 1 would be more consistent.
-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
