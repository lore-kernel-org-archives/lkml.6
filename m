Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14024C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B330920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B330920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeKJCh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:37:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51359 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:37:29 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gLA4b-0001J3-4e; Fri, 09 Nov 2018 17:55:57 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gLA4Z-0003nT-6L; Fri, 09 Nov 2018 17:55:55 +0100
Date:   Fri, 9 Nov 2018 17:55:55 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
References: <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vokáč Michal wrote:
> On 8.11.2018 20:18, Uwe Kleine-König wrote:
> > On Thu, Nov 08, 2018 at 03:21:44PM +0000, Vokáč Michal wrote:
> >> Hi Uwe,
> >>
> >> On 7.11.2018 16:01, Uwe Kleine-König wrote:
> >>>> Interesting idea. I just wonder why nobody else did not come up with such
> >>>> a simple solution before.
> >>>
> >>> I think I mentioned it already in this thread, but it went unnoticed :-)
> >>
> >> I meant it like "How happened this was not invented years ago, when people
> >> first noticed the issue with using inverted PWM for backlight on i.MX6."
> >> In our project, this issue dates back to 2015 :(
> >>
> >>> Then the patch isn't correct yet. The idea is always keep the hardware
> >>> running and only disable it if it's uninverted.
> >>
> >> OK, I got the point.
> >>
> >>> In imx_pwm_probe it's not yet known what the polarity is supposed to be,
> >>> right?
> >>
> >> Not really. It can already be known but currently there is no way how to
> >> pass the information to the probe function. I, as a creator of the device
> >> (and author of a DTS file) know that the circuit needs inverted PWM signal.
> >> And I know that the circuit needs to be disabled until I say it can be
> >> enabled. How I say that can warry. It may be default brightness level > 0
> >> in DTS file or from a userspace program using PWM sysfs interface.
> >>
> >>>   So the right thing to do there is to not touch the configuration
> >>> of the pwm. I think all states that are problematic then are also
> >>> problematic with the gpio/pinmux approach.
> >>
> >> I think my use-case I already presented before is an example where
> >> involving pinctrl solves the problem while the "leave PWM enabled
> >> for inverted users" does not. That is all the time between
> >> imx_pwm_probe() and imx_pwm_apply_v2().
> > 
> > You're doing in probe:
> > 
> >    if (pwm_is_running()):
> >      mux(pin, function=pwm)
> >    else:
> >      gpio_set_value(gpio, 0)
> >      mux(pin, function=gpio)
> > 
> > This gives you the right level assuming the gpio specification uses the
> > right flag (GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW).
> 
> Agree.
> 
> > Taking your example with the backlight device you specify an "init" and
> > a "default" pinctrl and only "default" contains the muxing for the PWM
> > pin everything should be as smooth as necessary: The pwm is only muxed
> > when the backlight device is successfully bound.
> 
> Have you tried that Uwe? The bad news is I tested that before and now
> again and it does not work like that. We already discussed that earlier.

The key is that the pinmux setting for the PWM pin should be part of the
bl pinctrl, not the pwm pinctrl. Then "default" is only setup when the
bl device is successfully bound which is after the bl's .probe callback
called pwm_apply().

> The "default" state is selected by the pinctrl core driver when imx-pwm's
> driver probe is finished. And it does not matter if the imx-pwm driver
> has some in-kernel users or not. See:
> 
> https://elixir.bootlin.com/linux/v4.20-rc1/source/drivers/pinctrl/core.c#L1497
> 
> It is possible that I made some mistake. So this is what I have in DT:
> 
> 	pinctrl_pwm: pwm1grp {
> 		// PWM out
>          	fsl,pins = <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x8>;
> 	}:
> 
> 	pinctrl_pwm_gpio: pwm1gpiogrp {
> 		// GPIO, 100k pull-up
>          	fsl,pins = <MX6QDL_PAD_GPIO_9__GPIO1_IO09 0xb000>;
> 	};
> 
> 	&pwm1 {
> 		#pwm-cells = <3>;
> 		pinctrl-names = "init", "default";
> 		pinctrl-0 = <&pinctrl_pwm_gpio>;
> 		pinctrl-1 = <&pinctrl_pwm>;
> 		status = "okay";
> 	};

With this dt snippet the effect is as you describe. But that's not what
I meant. (Also "init" should/could be empty.)

> > The probe function (of
> > the backlight) should have initialized the PWM with the right polarity.
> 
> Agree.
> 
> > Until then nothing happens on the pin (either because it's not muxed as
> > PWM or because the PWM is already initialized by the bootloader).
> 
> I do not agree. My tests repeatedly show it does not work like that.

See above.

> > The only thing that is (maybe) needed on top of my change is that the
> > pwm isn't stopped in pwm-imx's .probe.
> > 
> >>>> In probe you do not have any users yet. So you do not know the requested
> >>>> output polarity. With "default" pinctrl the PWM output would be muxed to
> >>>> the selected pin and since the PWM chip is most probably disabled
> >>>> (unless you enabled it in bootloader) you would get low level on the pin.
> >>>> That means your backlight is fully enabled until the first call to
> >>>> imx_pwm_apply_v2(). On my system this is 2 seconds.
> >>>
> >>> With the gpio/pinmux approach you don't know the intended polarity
> >>> either and maybe enable the display, too.
> >>
> >> You know it because the pinctrl solution is optional. So if you use it,
> >> you use it on purpose to override the default PWM output level in PWM
> >> disabled state. It is very useful in cases where you need inverted and
> >> disabled PWM signal from power-up to userspace. Or until some kernel
> >> driver (backlight, led, fan..) enables it. For this it is the only
> >> solution I think.
> >>
> >> It allows you to boot with disabled PWM that has normal polarity set
> >> by default. Later on from your userspace program you configure the PWM
> >> to desired period/duty, set PWM output to inversed and enable it.
> >> Until this point the circuit is disabled with my solution.
> >>
> >>> For both the solution is to let the bootloader enable the pwm with
> >>> the right output level. Am I missing something?
> >>
> >> Bootloader is only a small part of the whole solution I think. And I
> >> suppose you meant: "enable the *GPIO* with the right output level". 
> 
> I am sorry I am confused. Were you talking about the bootloader code or
> about the kernel code? Because your previous sentence was clear to me:
> 
>   "For both the solution is to let the bootloader enable the pwm
>    with the right output level".
> 
> My comment to that is: I think it is not necessery to configure and
> enable PWM just to keep the right level on the pin. In bootloader.
> I would certainly use GPIO or nothing at all depending on what logic
> level I actually need.

That's a valid option, too, that should work with the solution that is
implemented in the end. Both our ideas are compatible with that.
 
> > No I meant the pwm. Well, it's as easy as that: Whenever with your
> > approach you configure the pin as GPIO with the output set to low,
> > instead configure the pwm with duty_cycle to zero (or disable it).
> > Whenever with your approach you configure the pin as GPIO with the
> > output set to high, configure the pwm with duty_cycle to 100%. (Keeping
> > out inverted PWMs for the ease of discussion, but the procedure can be
> > adapted accordingly.) The only difference then is that with your
> > approach you already "know" in pwm-imx's .probe the idle level and can
> > configure the GPIO accordingly. With my approach you just have to wait
> > until the first pwm_apply which (as described above) works just as well.
> 
> While here I am quite confident you are talking about kernel code, right?
> If yes, then your approach is clear to me.
> 
> The problem is I am quite sure your approach does not solve the cases
> the pinctrl solution does. And according to my tests so far it does not
> work at all because the "init" and "default" states does not work as you
> are saying.

That's as pointed out above, because you're looking at the pwm's pinctrl
and I at the pwm-consumer's pinctrl.

Note that a sysfs consumer cannot be operated smoothly here, because
there is no pinctrl node to add the PWM mode to that only gets active
after the first configuration. This however is something that should not
be addressed in the imx driver but in the pwm core (if at all).

> With your approach you need to fully configure the PWM to produce 0% duty
> cycle signal to keep HIGH level on the pin. Not just let it run as it is.
> I only spent short time looking at the code trying to figure out how I
> would do that. And I could not come up with a simple solution that does
> not radically change all the current if-else logic. But my experience is
> limited.

Ah right, that's something I forgot in my patch. On disable of an
inverted PWM it is necessary to configure the pwm to output a 1.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
