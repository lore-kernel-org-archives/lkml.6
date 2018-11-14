Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A392C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A96A22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96A22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbeKNTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:12:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53703 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbeKNTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:12:23 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gMrBL-00061a-Ta; Wed, 14 Nov 2018 10:09:55 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gMrBJ-0006LU-R8; Wed, 14 Nov 2018 10:09:53 +0100
Date:   Wed, 14 Nov 2018 10:09:53 +0100
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
Message-ID: <20181114090953.jc6wkvgshn32bcm5@pengutronix.de>
References: <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
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

On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-König wrote:
> On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vokáč Michal wrote:
> > On 8.11.2018 20:18, Uwe Kleine-König wrote:
> > > On Thu, Nov 08, 2018 at 03:21:44PM +0000, Vokáč Michal wrote:
> > >> Hi Uwe,
> > >>
> > >> On 7.11.2018 16:01, Uwe Kleine-König wrote:
> > >>>> Interesting idea. I just wonder why nobody else did not come up with such
> > >>>> a simple solution before.
> > >>>
> > >>> I think I mentioned it already in this thread, but it went unnoticed :-)
> > >>
> > >> I meant it like "How happened this was not invented years ago, when people
> > >> first noticed the issue with using inverted PWM for backlight on i.MX6."
> > >> In our project, this issue dates back to 2015 :(
> > >>
> > >>> Then the patch isn't correct yet. The idea is always keep the hardware
> > >>> running and only disable it if it's uninverted.
> > >>
> > >> OK, I got the point.
> > >>
> > >>> In imx_pwm_probe it's not yet known what the polarity is supposed to be,
> > >>> right?
> > >>
> > >> Not really. It can already be known but currently there is no way how to
> > >> pass the information to the probe function. I, as a creator of the device
> > >> (and author of a DTS file) know that the circuit needs inverted PWM signal.
> > >> And I know that the circuit needs to be disabled until I say it can be
> > >> enabled. How I say that can warry. It may be default brightness level > 0
> > >> in DTS file or from a userspace program using PWM sysfs interface.
> > >>
> > >>>   So the right thing to do there is to not touch the configuration
> > >>> of the pwm. I think all states that are problematic then are also
> > >>> problematic with the gpio/pinmux approach.
> > >>
> > >> I think my use-case I already presented before is an example where
> > >> involving pinctrl solves the problem while the "leave PWM enabled
> > >> for inverted users" does not. That is all the time between
> > >> imx_pwm_probe() and imx_pwm_apply_v2().
> > > 
> > > You're doing in probe:
> > > 
> > >    if (pwm_is_running()):
> > >      mux(pin, function=pwm)
> > >    else:
> > >      gpio_set_value(gpio, 0)
> > >      mux(pin, function=gpio)
> > > 
> > > This gives you the right level assuming the gpio specification uses the
> > > right flag (GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW).
> > 
> > Agree.
> > 
> > > Taking your example with the backlight device you specify an "init" and
> > > a "default" pinctrl and only "default" contains the muxing for the PWM
> > > pin everything should be as smooth as necessary: The pwm is only muxed
> > > when the backlight device is successfully bound.
> > 
> > Have you tried that Uwe? The bad news is I tested that before and now
> > again and it does not work like that. We already discussed that earlier.
> 
> The key is that the pinmux setting for the PWM pin should be part of the
> bl pinctrl, not the pwm pinctrl. Then "default" is only setup when the
> bl device is successfully bound which is after the bl's .probe callback
> called pwm_apply().

Did my mail clear up my suggestion? Do you agree it should work like
this (or even did you test that, as I did not)?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
