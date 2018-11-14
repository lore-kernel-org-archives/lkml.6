Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2E22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC2E22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKOH43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:56:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42423 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeKOH43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:56:29 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gN34E-00026Y-JX; Wed, 14 Nov 2018 22:51:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gN34C-0006WR-4j; Wed, 14 Nov 2018 22:51:20 +0100
Date:   Wed, 14 Nov 2018 22:51:20 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181114215120.vddykljqyavm64wj@pengutronix.de>
References: <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114113449.GB2620@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thierry,

On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:
> On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-König wrote:
> > On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vokáč Michal wrote:
> > > On 8.11.2018 20:18, Uwe Kleine-König wrote:
> > > > Taking your example with the backlight device you specify an "init" and
> > > > a "default" pinctrl and only "default" contains the muxing for the PWM
> > > > pin everything should be as smooth as necessary: The pwm is only muxed
> > > > when the backlight device is successfully bound.
> > > 
> > > Have you tried that Uwe? The bad news is I tested that before and now
> > > again and it does not work like that. We already discussed that earlier.
> > 
> > The key is that the pinmux setting for the PWM pin should be part of the
> > bl pinctrl, not the pwm pinctrl. Then "default" is only setup when the
> > bl device is successfully bound which is after the bl's .probe callback
> > called pwm_apply().
> 
> No, that's not at all correct. Pinmux settings should reside with the
> consumer of the pin. In this case, the PWM is the consumer of the pin,
> whereas the backlight is the consumer of the *PWM*.

This is news to me. Adding Linus W. to Cc, maybe he can comment?!

Grepping through the arm device trees it really seems common to put the
pinctrl for the pwm pin into the pwm device. I didn't search in depth,
but I didn't find a counter example.

For GPIOs it is common that the pinmuxing is included in the GPIO's
consumer pinctrl. Ditto for mdio busses whose pinctrl is included in the
ethernet pinctrl.

> The problem with making the PWM mode the "default" pinctrl state is that
> the default state will be applied before the driver is even probed. That
> makes it unsuitable for this case. I think what we really want here is
> explicitly "active" and "inactive" states for pinctrl where the PWM
> driver controls when exactly each state is applied.

Note that this problem goes away nicely if the pwm pin is attached to
the backlight. Because it's the backlight's driver that "knows" when the
pwm is configured correctly and so the already existing mechanisms that
setup the mux when the bl is correctly probed do the right thing at the
right time.

> This solves the problem quite nicely because by default the pinctrl
> state isn't touched. For the case where the bootloader didn't initialize
> the PWM pin at all, the driver core won't do anything and keep it at the
> 100k pull-up default.

Ditto if the pwm pinctrl is attached to the consumer without having to
introduce new pwm-specific stuff.

> Only when the PWM is actually taken into active use will the "active"
> state (i.e. PWM mode) be applied, so that the PWM can drive it with
> the right configuration to give the desired result. If the bootloader
> did initialize the PWM it would also work because then at PWM driver
> probe time we don't do anything either, keeping the pin in the PWM
> mode as configured by the bootloader and not touching the PWM
> configuration either.

Ditto if the pwm pinctrl is attached to the consumer without having to
introduce new pwm-specific stuff.

> If hardware readout is implemented, we can load
> the exact state that we're in and seamlessly take over in the kernel
> driver. Enabling the PWM in this case would apply the current setting,
> which should be a no-op, or at least idempotent.

Ditto if the pwm pinctrl is attached to the consumer without having to
introduce new pwm-specific stuff.

> > > > No I meant the pwm. Well, it's as easy as that: Whenever with your
> > > > approach you configure the pin as GPIO with the output set to low,
> > > > instead configure the pwm with duty_cycle to zero (or disable it).
> > > > Whenever with your approach you configure the pin as GPIO with the
> > > > output set to high, configure the pwm with duty_cycle to 100%. (Keeping
> > > > out inverted PWMs for the ease of discussion, but the procedure can be
> > > > adapted accordingly.) The only difference then is that with your
> > > > approach you already "know" in pwm-imx's .probe the idle level and can
> > > > configure the GPIO accordingly. With my approach you just have to wait
> > > > until the first pwm_apply which (as described above) works just as well.
> > > 
> > > While here I am quite confident you are talking about kernel code, right?
> > > If yes, then your approach is clear to me.
> > > 
> > > The problem is I am quite sure your approach does not solve the cases
> > > the pinctrl solution does. And according to my tests so far it does not
> > > work at all because the "init" and "default" states does not work as you
> > > are saying.
> > 
> > That's as pointed out above, because you're looking at the pwm's pinctrl
> > and I at the pwm-consumer's pinctrl.
> > 
> > Note that a sysfs consumer cannot be operated smoothly here, because
> > there is no pinctrl node to add the PWM mode to that only gets active
> > after the first configuration. This however is something that should not
> > be addressed in the imx driver but in the pwm core (if at all).
> 
> With the pinctrl-based solution outlined above you can even operate a
> sysfs consumer properly. The pinctrl states are where they belong, with
> the PWM device and therefore they can be properly set when the PWM is
> used, rather than waiting for a PWM consumer to muck with the pinmux.
> 
> Note how all the pieces are suddenly falling into place. In my
> experience that's usually a good indication that you're on the right
> track.

OK, sysfs is the only point where the "put pinctrl stuff into the pwm
core (or driver)" is superior to the already existing and otherwise
completely working status quo. (Apart from bugs that need fixing in
your scenario, too.)

Given that I would not want to encourage people to stick to the sysfs
interface for their use case, that's ok IMHO. (And note that with the
bootloader's help you can even do this in a smooth way today.)

Other than that my approach looks more elegant to me (which obviously is
subjective). It works in all cases apart from sysfs (which is special
because it's not integrated into the device model) and there is no need
to teach the pwm framework about pinmuxing and invent new pinctrl modes
for it. Also dts writes don't need to lookup the needed GPIO numbers
and pinctrl.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
