Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B09C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223B2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D223B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbeKPGrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:47:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59685 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKPGrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:47:03 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNOON-0000El-2P; Thu, 15 Nov 2018 21:37:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNOOL-0005zW-5I; Thu, 15 Nov 2018 21:37:33 +0100
Date:   Thu, 15 Nov 2018 21:37:33 +0100
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
Message-ID: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
References: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181115152545.GA8611@ulmo>
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

On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:
> On Wed, Nov 14, 2018 at 10:51:20PM +0100, Uwe Kleine-König wrote:
> > On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:
> > > On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-König wrote:
> > > > On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vokáč Michal wrote:
> > > > > On 8.11.2018 20:18, Uwe Kleine-König wrote:
> > > > > > Taking your example with the backlight device you specify an "init" and
> > > > > > a "default" pinctrl and only "default" contains the muxing for the PWM
> > > > > > pin everything should be as smooth as necessary: The pwm is only muxed
> > > > > > when the backlight device is successfully bound.
> > > > > 
> > > > > Have you tried that Uwe? The bad news is I tested that before and now
> > > > > again and it does not work like that. We already discussed that earlier.
> > > > 
> > > > The key is that the pinmux setting for the PWM pin should be part of the
> > > > bl pinctrl, not the pwm pinctrl. Then "default" is only setup when the
> > > > bl device is successfully bound which is after the bl's .probe callback
> > > > called pwm_apply().
> > > 
> > > No, that's not at all correct. Pinmux settings should reside with the
> > > consumer of the pin. In this case, the PWM is the consumer of the pin,
> > > whereas the backlight is the consumer of the *PWM*.
> > 
> > This is news to me. Adding Linus W. to Cc, maybe he can comment?!
> > 
> > Grepping through the arm device trees it really seems common to put the
> > pinctrl for the pwm pin into the pwm device. I didn't search in depth,
> > but I didn't find a counter example.
> > 
> > For GPIOs it is common that the pinmuxing is included in the GPIO's
> > consumer pinctrl. Ditto for mdio busses whose pinctrl is included in the
> > ethernet pinctrl.
> 
> GPIO is different from PWM in that the GPIO is already the pin itself
> and is otherwise generic. So typically you put the pinmuxing options
> into the device tree node for the consumer of the GPIO, because it is
> only when the consumer uses the GPIO that you need to configure that
> pin as GPIO.
> 
> For PWM, however, the PWM consumer is only the consumer of the PWM, but
> the PWM device itself is the real consumer of the pin that outputs the
> PWM signal. So the PWM determines when the pinmux states need to be
> applied, whereas the consumer of the PWM only deals with the PWM.
> 
> For MDIO busses, I think they are usually part of, and driven by, the
> ethernet controller, so again it makes sense to put the pinmux into the
> node of the ethernet controller, because the ethernet controller is the
> user of the pins.

Maybe it was a bad idea to broaden the discussion to talk about gpios
and ethernet stuff here. I'd still consider it a valid construct to put
the pwm pin into the backlight's pinctrl unless Linux W. disagrees.

> > > The problem with making the PWM mode the "default" pinctrl state is that
> > > the default state will be applied before the driver is even probed. That
> > > makes it unsuitable for this case. I think what we really want here is
> > > explicitly "active" and "inactive" states for pinctrl where the PWM
> > > driver controls when exactly each state is applied.
> > 
> > Note that this problem goes away nicely if the pwm pin is attached to
> > the backlight. Because it's the backlight's driver that "knows" when the
> > pwm is configured correctly and so the already existing mechanisms that
> > setup the mux when the bl is correctly probed do the right thing at the
> > right time.
> 
> Actually that's not exactly true. The default pinctrl state will be
> applied before the driver's ->probe() implementation, so the pinctrl
> state will be active some time before even the backlight driver gets
> around to setting up the PWM. If you look at drivers/base/dd.c you'll
> see that really_probe() calls pinctrl_bind_pins() before calling the
> driver's ->probe() and will select the default state (unless there's
> also an "init" state defined, in which case that will get applied and
> only after successful probe will the default state be selected).
> 
> So if you use only a default state, then you could even get into a
> situation where ->probe() return -EPROBE_DEFER and it would potentially
> take several seconds before the driver is reprobed, during which time
> the pinmux will already be set up but the PWM not configured properly
> and potentially outputting the wrong level.

If you reread my suggestion to Michal completely you will notice I got
that right.

> > > This solves the problem quite nicely because by default the pinctrl
> > > state isn't touched. For the case where the bootloader didn't initialize
> > > the PWM pin at all, the driver core won't do anything and keep it at the
> > > 100k pull-up default.
> > 
> > Ditto if the pwm pinctrl is attached to the consumer without having to
> > introduce new pwm-specific stuff.
> 
> Well yes, but you'd obviously also have to avoid using the "default"
> state, otherwise you'd run into the issues that I described above.

I'd need "default" and "init", right.

> > > > > > No I meant the pwm. Well, it's as easy as that: Whenever with your
> > > > > > approach you configure the pin as GPIO with the output set to low,
> > > > > > instead configure the pwm with duty_cycle to zero (or disable it).
> > > > > > Whenever with your approach you configure the pin as GPIO with the
> > > > > > output set to high, configure the pwm with duty_cycle to 100%. (Keeping
> > > > > > out inverted PWMs for the ease of discussion, but the procedure can be
> > > > > > adapted accordingly.) The only difference then is that with your
> > > > > > approach you already "know" in pwm-imx's .probe the idle level and can
> > > > > > configure the GPIO accordingly. With my approach you just have to wait
> > > > > > until the first pwm_apply which (as described above) works just as well.
> > > > > 
> > > > > While here I am quite confident you are talking about kernel code, right?
> > > > > If yes, then your approach is clear to me.
> > > > > 
> > > > > The problem is I am quite sure your approach does not solve the cases
> > > > > the pinctrl solution does. And according to my tests so far it does not
> > > > > work at all because the "init" and "default" states does not work as you
> > > > > are saying.
> > > > 
> > > > That's as pointed out above, because you're looking at the pwm's pinctrl
> > > > and I at the pwm-consumer's pinctrl.
> > > > 
> > > > Note that a sysfs consumer cannot be operated smoothly here, because
> > > > there is no pinctrl node to add the PWM mode to that only gets active
> > > > after the first configuration. This however is something that should not
> > > > be addressed in the imx driver but in the pwm core (if at all).
> > > 
> > > With the pinctrl-based solution outlined above you can even operate a
> > > sysfs consumer properly. The pinctrl states are where they belong, with
> > > the PWM device and therefore they can be properly set when the PWM is
> > > used, rather than waiting for a PWM consumer to muck with the pinmux.
> > > 
> > > Note how all the pieces are suddenly falling into place. In my
> > > experience that's usually a good indication that you're on the right
> > > track.
> > 
> > OK, sysfs is the only point where the "put pinctrl stuff into the pwm
> > core (or driver)" is superior to the already existing and otherwise
> > completely working status quo. (Apart from bugs that need fixing in
> > your scenario, too.)
> 
> Nope, sorry. It's superior in all of the other cases as well. You've
> said elsewhere already that the prerequisite for the current solution to
> support inverse polarity with the i.MX driver is to keep the driver
> running, even after the PWM is no longer used. Sorry but that's just not
> an option for me.

You want that after pwm_disable() the pin still keeps the idle level. As
the hardware doesn't provide this feature "as is" something has to be
done about it. This can be reached either by operating the pin as PWM
with 0% duty cycle or by switching to GPIO that is configured to the
desired level. From the PWM driver's POV the first is the more natural,
as this can be accomplished with the registers this driver cares about
anyhow.

Also note this is similar in the pwm-bcm-kona driver that doesn't seem
to have the concept of "disable" at all. kona_pwmc_disable() just sets
up 0% duty cycle. In my eyes this is an argument that is good enough to
at least nack the imx-specific implementation of that pinctrl stuff.

If the pinctrl idea is implemented in the pwm core, I won't object.
 
> > Given that I would not want to encourage people to stick to the sysfs
> > interface for their use case, that's ok IMHO. (And note that with the
> > bootloader's help you can even do this in a smooth way today.)
> 
> No it's not. sysfs is a supported interface, so we shouldn't treat it
> differently from the other in-kernel users. And we also shouldn't rely
> on bootloaders to always do the right thing. People may not always be
> able to update the bootloader, or they may not have a use to drive a
> PWM from the bootloader and hence choose to leave it uninitialized.

If they are unable to adapt the bootloader they might be unable to (for
example) keep a display off until the kernel takes full control of all
necessary hardware to disable it. Yes, you might call that "bad hardware
design" if the display is on after a power cycle. I call it "reality".
And if these people care about each edge on the pwm output because the
PWM is connected to a rocket engine, they better have control over the
bootloader.

> > Other than that my approach looks more elegant to me (which obviously is
> > subjective). It works in all cases apart from sysfs (which is special
> > because it's not integrated into the device model) and there is no need
> > to teach the pwm framework about pinmuxing and invent new pinctrl modes
> > for it.
> 
> Elegance is useless if what you have doesn't work consistently and
> reliably.
> 
> I don't understand your resistance to the pinctrl work. It's not rocket
> science. Michal already posted patches showing how it can be done and
> they're not very complicated. Also we're not doing anything out of the
> ordinary here. This is exactly the purpose of the pinctrl framework, so
> let's use the best tool at hand.

In my last exchange with Michal I had the impression that he liked
my approach, too.
 
> > Also dts writes don't need to lookup the needed GPIO numbers and pinctrl.
> 
> Just to clarify: I don't think that we need to get the GPIO number
> involved in this case, because we don't have to reconfigure the pin as
> GPIO to make this work. The only reason that Michal's proposal did that
> is because that was believed to be necessary. But if the pin can just be
> configured with a 100k pull-up, that's enough to pull the pin high when
> we need it.

Unless the gpio happens to be configured as output at the wrong value.
Further I'm not sure if the pwm in disabled state actively pulls to 0
and if in this state the PU of the pin is good enough to ensure a one
here. That would need verification first.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
