Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8147FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516B420851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516B420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeLMUc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58281 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMUc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:58 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXXf4-0002sW-Mz; Thu, 13 Dec 2018 21:32:46 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXXf1-0000z0-Sz; Thu, 13 Dec 2018 21:32:43 +0100
Date:   Thu, 13 Dec 2018 21:32:43 +0100
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
Message-ID: <20181213203243.ucjwqtkyp6aboxp4@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-13-paul@crapouillou.net>
 <20181213091822.r5ilpsllfhzaiqw4@pengutronix.de>
 <1544709511.18952.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544709511.18952.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:58:31PM +0100, Paul Cercueil wrote:
> Hi,
> 
> Le jeu. 13 déc. 2018 à 10:18, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Wed, Dec 12, 2018 at 11:09:07PM +0100, Paul Cercueil wrote:
> > >  The TCU channels 0 and 1 were previously reserved for system tasks,
> > > and
> > >  thus unavailable for PWM.
> > > 
> > >  The driver will now only allow a PWM channel to be requested if
> > > memory
> > >  resources corresponding to the register area of the channel were
> > >  supplied to the driver. This allows the TCU channels to be reserved
> > > for
> > >  system tasks from within the devicetree.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > 
> > While there is someone caring for this driver I'd like to complete (a
> > bit) my picture about the different capabilities and specialities of the
> > supported PWMs. So I have a few questions:
> > 
> > Is there a publicly available reference manual for this device? (If
> > yes, adding a link to the driver would be great.)
> 
> I have them here: https://zcrc.me/~paul/jz_docs/

Is this link good enough to add it to the driver? From a quick view I'd
say this is another pwm implementation that gets active on pwm_disable().
Can you confirm this?

> > jz4740_pwm_config looks as if the currently running period isn't
> > completed before the new config is in effect. Is that correct? If yes,
> > can this be fixed? A similar question for set_polarity: Does setting the
> > JZ_TIMER_CTRL_PWM_ACTIVE_LOW bit in the control register take effect
> > immediately or is this shadowed until the next period starts?
> 
> I don't really know. We only use this driver for a rumble motor and
> backlight.
> Somebody would have to check with a logic analyzer.

depending on the possible timings you might also be able to test this
e.g. by setting:

	duty_cycle=1ms, period=5s

and then

	duty_cycle=5s, period=5s

. If the implementation is right your display should be dark for nearly
5 seconds. (And the second call to pwm_apply should also block until the
display is on.)

> > How does the device's output behave after the PWM is disabled?
> > Does it complete the currently running period? How does the output
> > behave then? (active/inactive/high/low/high-z?)
> 
> There's a bit to toggle between "graceful" shutdown (bit clear) and "abrupt"
> shutdown (bit set). TCSR bit 9. I think that graceful shutdown will complete
> the running period, then keep the level active. Abrupt shutdown will keep
> the
> current level of the line.

Can you confirm the things you think above? I'd like to have them
eventually documented in the driver.

> > >  @@ -42,11 +68,7 @@ static int jz4740_pwm_request(struct pwm_chip
> > > *chip, struct pwm_device *pwm)
> > >   	char clk_name[16];
> > >   	int ret;
> > > 
> > >  -	/*
> > >  -	 * Timers 0 and 1 are used for system tasks, so they are
> > > unavailable
> > >  -	 * for use as PWMs.
> > >  -	 */
> > >  -	if (pwm->hwpwm < 2)
> > >  +	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
> > >   		return -EBUSY;
> > 
> > Maybe EBUSY isn't the best choice here. If the needed register space for
> > the requested pwm is not included in the memory resources provided to
> > the device I'd prefer ENXIO or ENODEV.
> 
> The idea was that if we don't get the register space we need, that means
> the channel is used for something else, hence the EBUSY. Should I switch
> it to ENXIO?

I understand your reasoning, but I think it's misleading. If I get
-EBUSY from a PWM driver I'd start searching for another user of said
resource. With ENXIO or ENODEV it's more obvious that the driver isn't
responsible for the resource that was requested.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
