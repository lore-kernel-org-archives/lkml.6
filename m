Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D38BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4567A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4567A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKPSh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:37:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49723 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeKPSh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:37:26 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNZRu-0003yf-U0; Fri, 16 Nov 2018 09:25:58 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNZRt-0000WN-4u; Fri, 16 Nov 2018 09:25:57 +0100
Date:   Fri, 16 Nov 2018 09:25:57 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
References: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181116083430.7f1d8452@ipc1.ka-ro>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Waßmann wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Hello Thierry,
> > 
> > On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:
> > > On Wed, Nov 14, 2018 at 10:51:20PM +0100, Uwe Kleine-König wrote:  
> > > > On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:  
> [...]
> > > > Also dts writes don't need to lookup the needed GPIO numbers and pinctrl.  
> > > 
> > > Just to clarify: I don't think that we need to get the GPIO number
> > > involved in this case, because we don't have to reconfigure the pin as
> > > GPIO to make this work. The only reason that Michal's proposal did that
> > > is because that was believed to be necessary. But if the pin can just be
> > > configured with a 100k pull-up, that's enough to pull the pin high when
> > > we need it.  
> > 
> > Unless the gpio happens to be configured as output at the wrong value.
> > Further I'm not sure if the pwm in disabled state actively pulls to 0
> > and if in this state the PU of the pin is good enough to ensure a one
> > here. That would need verification first.
>
> No. You can disable the output driver via pinctrl, so that only the
> selected pull-up/down is relevant. The pin function and GPIO register
> settings don't matter at all in this case.

Is this about DSE=HI-Z in the pad control register? I didn't know about
this. I see this exists on i.MX6 but not on i.MX25. Also i.MX51 doesn't
seem to have this feature.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
