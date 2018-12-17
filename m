Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2094FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35722084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbeLQHng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:43:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35925 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:43:35 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gYnYg-0007x4-Pw; Mon, 17 Dec 2018 08:43:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gYnYc-0000eS-P6; Mon, 17 Dec 2018 08:43:18 +0100
Date:   Mon, 17 Dec 2018 08:43:18 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH v8 12/26] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20181217074318.y3mtn5aqmnknae3d@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-13-paul@crapouillou.net>
 <20181213091822.r5ilpsllfhzaiqw4@pengutronix.de>
 <1544709511.18952.0@crapouillou.net>
 <20181213203243.ucjwqtkyp6aboxp4@pengutronix.de>
 <1544967364.1649.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544967364.1649.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sun, Dec 16, 2018 at 02:36:03PM +0100, Paul Cercueil wrote:
> Le jeu. 13 déc. 2018 à 21:32, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Thu, Dec 13, 2018 at 02:58:31PM +0100, Paul Cercueil wrote:
> > >  Hi,
> > > 
> > >  Le jeu. 13 déc. 2018 à 10:18, Uwe Kleine-König
> > >  <u.kleine-koenig@pengutronix.de> a écrit :
> > >  > On Wed, Dec 12, 2018 at 11:09:07PM +0100, Paul Cercueil wrote:
> > >  > >  The TCU channels 0 and 1 were previously reserved for system
> > > tasks,
> > >  > > and
> > >  > >  thus unavailable for PWM.
> > >  > >
> > >  > >  The driver will now only allow a PWM channel to be requested if
> > >  > > memory
> > >  > >  resources corresponding to the register area of the channel
> > > were
> > >  > >  supplied to the driver. This allows the TCU channels to be
> > > reserved
> > >  > > for
> > >  > >  system tasks from within the devicetree.
> > >  > >
> > >  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  >
> > >  > While there is someone caring for this driver I'd like to
> > > complete (a
> > >  > bit) my picture about the different capabilities and specialities
> > > of the
> > >  > supported PWMs. So I have a few questions:
> > >  >
> > >  > Is there a publicly available reference manual for this device?
> > > (If
> > >  > yes, adding a link to the driver would be great.)
> > > 
> > >  I have them here: https://zcrc.me/~paul/jz_docs/
> > 
> > Is this link good enough to add it to the driver? From a quick view I'd
> > say this is another pwm implementation that gets active on
> > pwm_disable().
> > Can you confirm this?
> 
> It's my website, so if these get moved, I can update the link.
> 
> What do you mean it gets active on pwm_disable()? If pwm_disable() gets
> called the PWM line goes back to inactive state, which is what it
> should do.

The register description for TCSRn.PWM_EN reads:

	1: PWM pin output enable
	0: PWM pin output disable, and the PWM pin will be set to the
	   initial level according to INITL

As I read the manual (but that differes from the driver) you should use
INITL=1 for an uninverted PWM such that the period starts with the
output being 1. And with that I'd expect that the output goes high on
disable. Given that the driver inverts this and sets INITL (called
JZ_TIMER_CTRL_PWM_ACTIVE_LOW in the driver) for an inverted pwm that
behaviour is ok. With this approach the bug is not the level when
pwm_disable was called but that the period doesn't start with the active
part of the period.

> > >  > jz4740_pwm_config looks as if the currently running period isn't
> > >  > completed before the new config is in effect. Is that correct? If
> > > yes,
> > >  > can this be fixed? A similar question for set_polarity: Does
> > > setting the
> > >  > JZ_TIMER_CTRL_PWM_ACTIVE_LOW bit in the control register take
> > > effect
> > >  > immediately or is this shadowed until the next period starts?
> > > 
> > >  I don't really know. We only use this driver for a rumble motor and
> > >  backlight.
> > >  Somebody would have to check with a logic analyzer.
> > 
> > depending on the possible timings you might also be able to test this
> > e.g. by setting:
> > 
> > 	duty_cycle=1ms, period=5s
> > 
> > and then
> > 
> > 	duty_cycle=5s, period=5s
> > 
> > . If the implementation is right your display should be dark for nearly
> > 5 seconds. (And the second call to pwm_apply should also block until the
> > display is on.)
> 
> So it switches to full ON as soon as I set the duty cycle to 5s. Same for
> the polarity, it is updated as soon as the register is written. So the
> registers are not shadowed.

Then I think the right thing to do is to gracefully disable the hardware
on a duty/period change first to ensure the currently running period is
completed before the next configuration gets active.

> > >  > How does the device's output behave after the PWM is disabled?
> > >  > Does it complete the currently running period? How does the output
> > >  > behave then? (active/inactive/high/low/high-z?)
> > > 
> > >  There's a bit to toggle between "graceful" shutdown (bit clear) and
> > > "abrupt"
> > >  shutdown (bit set). TCSR bit 9. I think that graceful shutdown will
> > > complete
> > >  the running period, then keep the level active. Abrupt shutdown
> > > will keep
> > >  the
> > >  current level of the line.
> > 
> > Can you confirm the things you think above? I'd like to have them
> > eventually documented in the driver.
> 
> From what I can see, with "abrupt" shutdown the line will always return to
> its inactive state (be it low or high, depending on the polarity). Setting
> this bit to "graceful" shutdown, the only difference is that the hardware
> will keep its current state, active or inactive. That's why we use the
> "abrupt" shutdown in the PWM driver.

That sounds backwards from your last mail and the reference manual. As I
read the manual "graceful" means the period is completed until FULL
matches. And I understand "aprupt" as "immediatly freeze". If this is
the case the names in the manual are well chosen.

For the pwm framework the intended behaviour is the graceful one. (For
both, disable and duty/period change.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
