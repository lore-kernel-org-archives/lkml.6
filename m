Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10853206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10853206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438138AbeKWDEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:04:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51745 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404206AbeKWDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:04:13 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gPrlp-0004PR-3s; Thu, 22 Nov 2018 17:24:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gPrln-0001pJ-Sd; Thu, 22 Nov 2018 17:23:59 +0100
Date:   Thu, 22 Nov 2018 17:23:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
References: <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
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

On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vokáč Michal wrote:
> On 16.11.2018 09:25, Uwe Kleine-König wrote:
> > On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Waßmann wrote:
> > > No. You can disable the output driver via pinctrl, so that only the
> > > selected pull-up/down is relevant. The pin function and GPIO register
> > > settings don't matter at all in this case.
> 
> Lothar, please can you be more specific how would you do that? IFAIK the
> pull-up/down internal resistors have effect only if the pin is configured
> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Output driver:
> 
>   "Internal pull-up, pull-down resistors, and pad keeper are disabled in
>    output mode."
> 
> > Is this about DSE=HI-Z in the pad control register? I didn't know about
> > this. I see this exists on i.MX6 but not on i.MX25. Also i.MX51 doesn't
> > seem to have this feature.
> 
> Uwe, I also did not find the DSE option on other SoCs in their respective
> manuals and source code. But even if it would be available on all SoCs
> I still think it is not enough.

If I understand Lothar correctly and this is about the pad control
register, there is no need for software support. You just specify the
value you want to have written to the pad register in the device tree.

So I'd expect this to really work on i.MX6 but not the earlier SoCs
without a gpio specifier.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
