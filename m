Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A872ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294820827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5294820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeKIEz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:55:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58593 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeKIEz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:55:58 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKppS-0000CJ-FV; Thu, 08 Nov 2018 20:18:58 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKppP-0001U5-NV; Thu, 08 Nov 2018 20:18:55 +0100
Date:   Thu, 8 Nov 2018 20:18:55 +0100
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
Message-ID: <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:21:44PM +0000, Vokáč Michal wrote:
> Hi Uwe,
> 
> On 7.11.2018 16:01, Uwe Kleine-König wrote:
> >> Interesting idea. I just wonder why nobody else did not come up with such
> >> a simple solution before.
> > 
> > I think I mentioned it already in this thread, but it went unnoticed :-)
> 
> I meant it like "How happened this was not invented years ago, when people
> first noticed the issue with using inverted PWM for backlight on i.MX6."
> In our project, this issue dates back to 2015 :(
> 
> > Then the patch isn't correct yet. The idea is always keep the hardware
> > running and only disable it if it's uninverted.
> 
> OK, I got the point.
> 
> > In imx_pwm_probe it's not yet known what the polarity is supposed to be,
> > right?
> 
> Not really. It can already be known but currently there is no way how to
> pass the information to the probe function. I, as a creator of the device
> (and author of a DTS file) know that the circuit needs inverted PWM signal.
> And I know that the circuit needs to be disabled until I say it can be
> enabled. How I say that can warry. It may be default brightness level > 0
> in DTS file or from a userspace program using PWM sysfs interface.
> 
> > So the right thing to do there is to not touch the configuration
> > of the pwm. I think all states that are problematic then are also
> > problematic with the gpio/pinmux approach.
> 
> I think my use-case I already presented before is an example where
> involving pinctrl solves the problem while the "leave PWM enabled
> for inverted users" does not. That is all the time between
> imx_pwm_probe() and imx_pwm_apply_v2().

You're doing in probe:

  if (pwm_is_running()):
    mux(pin, function=pwm)
  else:
    gpio_set_value(gpio, 0)
    mux(pin, function=gpio)

This gives you the right level assuming the gpio specification uses the
right flag (GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW).

Taking your example with the backlight device you specify an "init" and
a "default" pinctrl and only "default" contains the muxing for the PWM
pin everything should be as smooth as necessary: The pwm is only muxed
when the backlight device is successfully bound. The probe function (of
the backlight) should have initialized the PWM with the right polarity.
Until then nothing happens on the pin (either because it's not muxed as
PWM or because the PWM is already initialized by the bootloader).

The only thing that is (maybe) needed on top of my change is that the
pwm isn't stopped in pwm-imx's .probe.

> >> In probe you do not have any users yet. So you do not know the requested
> >> output polarity. With "default" pinctrl the PWM output would be muxed to
> >> the selected pin and since the PWM chip is most probably disabled
> >> (unless you enabled it in bootloader) you would get low level on the pin.
> >> That means your backlight is fully enabled until the first call to
> >> imx_pwm_apply_v2(). On my system this is 2 seconds.
> > 
> > With the gpio/pinmux approach you don't know the intended polarity
> > either and maybe enable the display, too.
> 
> You know it because the pinctrl solution is optional. So if you use it,
> you use it on purpose to override the default PWM output level in PWM
> disabled state. It is very useful in cases where you need inverted and
> disabled PWM signal from power-up to userspace. Or until some kernel
> driver (backlight, led, fan..) enables it. For this it is the only
> solution I think.
> 
> It allows you to boot with disabled PWM that has normal polarity set
> by default. Later on from your userspace program you configure the PWM
> to desired period/duty, set PWM output to inversed and enable it.
> Until this point the circuit is disabled with my solution.
> 
> > For both the solution is to let the bootloader enable the pwm with
> > the right output level. Am I missing something?
> 
> Bootloader is only a small part of the whole solution I think. And I
> suppose you meant: "enable the *GPIO* with the right output level".

No I meant the pwm. Well, it's as easy as that: Whenever with your
approach you configure the pin as GPIO with the output set to low,
instead configure the pwm with duty_cycle to zero (or disable it).
Whenever with your approach you configure the pin as GPIO with the
output set to high, configure the pwm with duty_cycle to 100%. (Keeping
out inverted PWMs for the ease of discussion, but the procedure can be
adapted accordingly.) The only difference then is that with your
approach you already "know" in pwm-imx's .probe the idle level and can
configure the GPIO accordingly. With my approach you just have to wait
until the first pwm_apply which (as described above) works just as well.
 
>   - Even if you use GPIO in bootloader to set the required level the
>     time frame from imx_pwm_probe to imx_pwm_apply is not covered.
> 
>   - Currently there is no support in Linux pwm-imx driver to detect
>     the PWM chip is already enabled at probe time. I actually send
>     patches for this a month ago [1]. No response yet.
> 
>   - Inverted PWM does not work in U-Boot (on imx at least). And it
>     does not seam like it can be fixed easily. I do not know what is
>     the situation in other bootloaders.
> 
> So my current bootloader solution is one of:
>   - Set the pin to the appropriate (HIGH) level using GPIO.
>   - Do not touch the pin at all, it has 100k pull-up by default.
> 
> >> The other thing is I would prefer to make the change optional. With your
> >> approach you are changing the behavior for all current users of inverted
> >> PWM. I do not think all imx6 users are aware of the problem so they might
> >> not be OK with the sudden change in the behavior.
> > 
> > Isn't my change an improvement for all users? What state do you have in
> > mind that make things worse than they are now?
> 
> Lets say that the user:
> - Needs inverted PWM signal.
> - Needs it to be disabled all the time unless he enable it.

I don't see why anybody should care if the PWM is "disabled". A user
should only care about the output level, how the pwm-imx driver
implements this is out of scope. As backlight-pwm user/author you
shouldn't even care which PWM driver is in use. It might be even an
implementation that cannot be disabled (like the bcm-kona one).

> What you propose (for all users of inverted PWM):
> H|____________________                                     _____________
> L|                    \___________________________________/
>   +-------+------------+-----------------+-----------------+-------------+
>   | reset | bootloader | default pinctrl | PWM enable 100% | PWM disable |
> 
> My solution (for those who want it):
> H|______________________________________                   _____________
> L|                                      \_________________/
>   +-------+------------+-----------------+-----------------+-------------+
>   | reset | bootloader | default pinctrl | PWM enable 100% | PWM disable |
> 

With the above changes there is no relevant difference between your and
my approach. I save your and my time to repeat this once more with these
nice pictures. (If you don't believe me, I can do this later if you
wish.) The nice upside of my approach however is that the pwm-imx driver
stays simpler and the dts author doesn't need to care to add a gpio
specifier and two pinmux configurations instead of one.
 
> So your solution at least allows the user to really disable the circuit.
> I can not really think of cases where this might not be good for current
> users. Maybe that they simply expect that no matter what polarity is set,
> the output in disabled state is always low. And they may have HW that
> get already used to that and does not like the change :)
> 
> And it reminds me of something similar I have done for OLED display reset
> recently [2]. I tried to fix active-low reset sequence that is hardcoded
> in the driver. So you are supposed to use GPIO_ACTIVE_HIGH in DT to make
> the active-low reset work. It was rejected. The reason was backward DTB
> compatibility [3]. In other words: "Users of newer kernels expect that
> the reset still work the same if they do not update DTBs on their boards".
> I think this is kind of similar?

I don't see a compatibility issue here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
