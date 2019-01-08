Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1471C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEDC2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfAHWIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:08:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:08:44 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ggzY8-0001yS-Cz; Tue, 08 Jan 2019 23:08:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ggzY6-0002vf-Ug; Tue, 08 Jan 2019 23:08:38 +0100
Date:   Tue, 8 Jan 2019 23:08:38 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190108220838.amrun6jsa24yeisg@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
 <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:21:34AM +0000, Claudiu.Beznea@microchip.com wrote:
> Hi Uwe,
> 
> On 08.01.2019 00:10, Uwe Kleine-König wrote:
> > Hello Claudiu,
> > 
> > On Mon, Jan 07, 2019 at 09:30:55AM +0000, Claudiu.Beznea@microchip.com wrote:
> >> On 05.01.2019 23:05, Uwe Kleine-König wrote:
> >>> On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>>>
> >>>> Add basic PWM modes: normal and complementary. These modes should
> >>>> differentiate the single output PWM channels from two outputs PWM
> >>>> channels. These modes could be set as follow:
> >>>> 1. PWM channels with one output per channel:
> >>>> - normal mode
> >>>> 2. PWM channels with two outputs per channel:
> >>>> - normal mode
> >>>> - complementary mode
> >>>> Since users could use a PWM channel with two output as one output PWM
> >>>> channel, the PWM normal mode is allowed to be set for PWM channels with
> >>>> two outputs; in fact PWM normal mode should be supported by all PWMs.
> >>>
> >>> I still think that my suggestion that I sent in reply to your v5 using
> >>> .alt_duty_cycle and .alt_offset is the better one as it is more generic.
> >>
> >> I like it better my way, I explained myself why.
> > 
> > I couldn't really follow your argument though. You seemed to acknowledge
> > that using .alt_duty_cycle and .alt_offset is more generic.
> 
> True it is more generic in the way that it gives the possibility to
> configure all kind of waveforms. But not all controllers supports this.
> The use case of this would be to have dead-times with any values, right?

Well, I didn't target that. The model I suggested is just a generic set
of parameters that are able to describe the wave forms for all three
modes you suggested. That it allows to express dead-times is just a nice
by-product.

> >>> I fail to see the upside of storing the mode as 2^mode instead of a
> >>> plain enum pwm_mode. Given that struct pwm_state is visible for pwm
> >>> users a plain pwm_mode would at least be more intuitive.
> >>
> >> To have all modes supported by a controller grouped in pwm_caps::modes_msk.
> > 
> > My question was not about struct pwm_caps::modes_msk but about
> > struct pwm_state::modebit. As struct pwm_state has visibility even
> > outside of the pwm API (i.e. it is used by consumers) it is beneficial
> > to keep that simple. Letting a consumer pass in the mode he wants is
> > easier to explain than setting a single bit. Also error checking with a
> > plain enum is easier because you just do:
> > 
> > 	if (mode >= MODE_CNT)
> > 		error()
> > 
> > which is easy to grasp. Compare that to
> > 
> > 	if (!is_power_of_two(modebit) || modebit >= PWM_MODE_BIT(CNT))
> > 		error()
> > 
> > (modulo syntactical correctness).
> 
> The reason I choose to have it as bit was the memcmp() at the beginning of
> pwm_apply_state() and to avoid starting enum pwm_mode from 1 and to avoid
> having bit 0 of pwm_caps::modes_msk unused (in the driver I'm using
> PWM_MODE_BIT() macro to fill in the driver's supported modes).

Does that mean you are convinced by my argument?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
