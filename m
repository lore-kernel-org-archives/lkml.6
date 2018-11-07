Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4A520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbeKHAcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:32:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50885 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbeKHAcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:32:17 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKPKg-0003cE-QM; Wed, 07 Nov 2018 16:01:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKPKf-0002au-Ei; Wed, 07 Nov 2018 16:01:25 +0100
Date:   Wed, 7 Nov 2018 16:01:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On Wed, Nov 07, 2018 at 01:32:10PM +0000, Vokáč Michal wrote:
> On 7.11.2018 10:33, Uwe Kleine-König wrote:
> > Hello Michal,
> > 
> > just to state it more explicitly, I think the following patch (not even
> > compile tested) is much preferable over your approach:
> 
> Interesting idea. I just wonder why nobody else did not come up with such
> a simple solution before.

I think I mentioned it already in this thread, but it went unnoticed :-)

> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index 1d5242c9cde0..af88644b5efb 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -216,7 +216,14 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
> >   			cr |= MX3_PWMCR_POUTC;
> >   
> >   		writel(cr, imx->mmio_base + MX3_PWMCR);
> > -	} else if (cstate.enabled) {
> > +	} else if (cstate.enabled && state->polarity == PWM_POLARITY_NORMAL) {
> > +		/*
> > +		 * When disabled in hardware the output pin goes to 0
> > +		 * independant of the polarity setting. The expectation of some
> > +		 * people however is that after disabling the pin goes to the
> > +		 * inactive level which isn't given for an inversed pwm, so
> > +		 * only disable for normal polarity.
> > +		 */
> >   		writel(0, imx->mmio_base + MX3_PWMCR);
> >   
> >   		clk_disable_unprepare(imx->clk_per);
> 
> I tested your patch. It does not work as you expected.
> 
> In v4.20-rc1 the pwm-backlight driver has been converted to atomic API.
> So the pwm_apply_v2 function is called only once to set new period/duty
> and state. With your patch that means that "echo 0 > brightness" has no
> visible effect. It leaves the PWM chip enabled with period/duty set to
> however it was. But the core thinks it was reconfigured:

Then the patch isn't correct yet. The idea is always keep the hardware
running and only disable it if it's uninverted.
> 
> # cat /sys/class/backlight/backight/brightness
> 0
> 
> # cat /sys/kernel/debug/pwm
> platform/2080000.pwm, 1 PWM device
>   pwm-0   (backlight           ): requested period: 500000 ns duty: 0 ns polarity: inverse
> 
> > I think it solves most if not all problems you want to address with the
> > pinctrl stuff.
> 
> Unfortunately not. I also tested your patch on v4.19. It works as you
> probably intended - it is possible to disable backlight without the PWM
> chip being disabled. But it does not solve the time frame between
> imx_pwm_probe() and imx_pwm_apply_v2().

In imx_pwm_probe it's not yet known what the polarity is supposed to be,
right? So the right thing to do there is to not touch the configuration
of the pwm. I think all states that are problematic then are also
problematic with the gpio/pinmux approach. (I might be wrong here, so
feel free to invest some brain cycles to prove me wrong. But I'd be
surprised if there are problems that are relevant.)
 
> In probe you do not have any users yet. So you do not know the requested
> output polarity. With "default" pinctrl the PWM output would be muxed to
> the selected pin and since the PWM chip is most probably disabled
> (unless you enabled it in bootloader) you would get low level on the pin.
> That means your backlight is fully enabled until the first call to
> imx_pwm_apply_v2(). On my system this is 2 seconds.

With the gpio/pinmux approach you don't know the intended polarity
either and maybe enable the display, too. For both the solution is to
let the bootloader enable the pwm with the right output level.
Am I missing something?

> It might not be a big issue for backlight but for motor control it is
> not the right thing to do.
> 
> The other thing is I would prefer to make the change optional. With your
> approach you are changing the behavior for all current users of inverted
> PWM. I do not think all imx6 users are aware of the problem so they might
> not be OK with the sudden change in the behavior.

Isn't my change an improvement for all users? What state do you have in
mind that make things worse than they are now?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
