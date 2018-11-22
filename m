Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDF7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA3A20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA3A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438126AbeKWC6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:58:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeKWC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:58:00 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gPrfr-0003ud-76; Thu, 22 Nov 2018 17:17:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gPrfo-0001gF-RW; Thu, 22 Nov 2018 17:17:48 +0100
Date:   Thu, 22 Nov 2018 17:17:48 +0100
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
Message-ID: <20181122161748.2ud7f26xkww5g24m@pengutronix.de>
References: <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116095124.GA28631@ulmo>
 <20181116103929.cxfvuc2te7cadhp2@pengutronix.de>
 <20181116122445.GA25386@ulmo>
 <20181118200815.a6hkokt3otfm4yl4@pengutronix.de>
 <20181122150338.GA24661@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181122150338.GA24661@ulmo>
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

On Thu, Nov 22, 2018 at 04:03:38PM +0100, Thierry Reding wrote:
> On Sun, Nov 18, 2018 at 09:08:15PM +0100, Uwe Kleine-König wrote:
> > Thinking a bit about this it doesn't really matter for the consumer if
> > the pin stays in the idle level because there is a pull into the right
> > direction and the PWM is high-Z or if the PWM pulls actively in the
> > right direction. Also for pwm_config(pwm, 0, 100) the PWM could disable
> > its output in the presence of a pull, so the property says true that the
> > effects of pwm_config(pwm, 0, 100) and pwm_disable(pwm) should be the
> > same. And so my claim that pwm_disable is a part of the API that
> > doesn't give any value stays true.
> 
> I still think there's a slight difference there. Granted the effect on
> the consumer is the same whether you disable or set the duty-cycle to
> zero because the power output is the same. pwm_disable() is still more
> explicit, though, so it may involve more than just setting the duty-
> cycle.

If pwm_disable() vs. duty-cycle=0 doesn't make a difference to the
consumer, who do we do a favour by providing pwm_disable()?

> > > But again, why should PWMs be special? You turn off all other resources
> > > when you no longer need them, right? If you power your panel with a
> > > regulator, then when the panel is disabled you want to disable the
> > > regulator, right? Similarily if you don't use your I2C controller you
> > > want to turn off the clock that drives it, right? This is the same for
> > > any resource in your system: if you no longer need it, disable it. The
> > > fact that "disabling" the PWM is not straightforward on i.MX doesn't
> > > mean that we should simply ignore it.
> > 
> > I don't say we should ignore it. I say we shouldn't disable the hardware
> > if the consumer calls pwm_disable() if disabling the hardware results in
> > a state that shouldn't happen on pwm_disable().
> 
> That's backwards. If disabling the hardware results in a state that
> shouldn't happen when you disable the hardware, that just means that
> you're doing something wrong. When you do something wrong you fix it.

For you pwm_disable must imply disabling the PWM hardware. As you cannot
have both (disable the hardware and keep the pin on the idle level
without involving pinmux and GPIO) on i.MX in my eyes it is sensible to
drop one requirement from the framework's expectations to make it
possible for i.MX to fulfill them.

As there is no advantage for anyone to force .disable() to actually
disable the hardware (apart from a little power saving that probably
isn't even measurable) that's IMHO the one to drop.

> If the pin goes to the wrong level when you disable the hardware, the
> natural fix for the problem is to make sure the pin stays at the right
> level.

Ack. And you can do this either in an easy variant or in a more
complicated one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
