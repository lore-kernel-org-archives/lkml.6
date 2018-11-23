Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3887CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B0220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B0220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409335AbeKWVJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:09:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33815 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393918AbeKWVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:09:23 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gQ8eZ-0002MM-Ga; Fri, 23 Nov 2018 11:25:39 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gQ8eY-000770-Ou; Fri, 23 Nov 2018 11:25:38 +0100
Date:   Fri, 23 Nov 2018 11:25:38 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Message-ID: <20181123102538.7gpabj7idmuraaid@pengutronix.de>
References: <20181121123508.25119-1-peron.clem@gmail.com>
 <20181122200536.ndgrxuxealtovngy@pengutronix.de>
 <CAJiuCcdt9Kk3z6gsr68O1JrPfan-ENpRjo0dnBaGxs4xDidOzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdt9Kk3z6gsr68O1JrPfan-ENpRjo0dnBaGxs4xDidOzQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clément,

On Fri, Nov 23, 2018 at 10:31:18AM +0100, Clément Péron wrote:
> On Thu, 22 Nov 2018 at 21:05, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Related to this driver I have a set of questions: If the disable
> > callback completed, does the hardware still drive the pin? If yes, would
> > it be possible to disable the pin driver such that the pin gets high-Z?
> > If yes, how?
> 
> The output pin type is configured with the bit "21:16 PWMOUT_TYPE RW
> default 0x3F" in the Control register
> PWM_CONTROL_TYPE_SHIFT macro in the driver
> Datasheets says : "When set to 1 the PWM Output signal will have a
> push/pull type.When set to 0 the PWM Output signal will have an open
> drain output type.Recommend to leave it push/pull type."
> 
> In the driver we actually set push/pull mode for all channels :
> /* Set push/pull for all channels */
> for (chan = 0; chan < kp->chip.npwm; chan++)
> value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));

So if disabling the output driver was part of the requirements for
.disable the bcm-kona driver could not implement this for both inverted
and uninverted PWMs. (At least not without resorting to pinmuxing.)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
