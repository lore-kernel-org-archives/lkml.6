Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D732C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B552145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B552145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbeKPScZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:32:25 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:63712 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPScY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:32:24 -0500
X-Greylist: delayed 2797 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 13:32:23 EST
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1gNYe7-00063P-UR; Fri, 16 Nov 2018 08:34:31 +0100
Date:   Fri, 16 Nov 2018 08:34:30 +0100
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
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
Message-ID: <20181116083430.7f1d8452@ipc1.ka-ro>
In-Reply-To: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
References: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
        <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
        <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
        <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
        <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
        <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
        <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
        <20181114113449.GB2620@ulmo>
        <20181114215120.vddykljqyavm64wj@pengutronix.de>
        <20181115152545.GA8611@ulmo>
        <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello Thierry,
> 
> On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:
> > On Wed, Nov 14, 2018 at 10:51:20PM +0100, Uwe Kleine-König wrote:  
> > > On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:  
[...]
> > > Also dts writes don't need to lookup the needed GPIO numbers and pinctrl.  
> > 
> > Just to clarify: I don't think that we need to get the GPIO number
> > involved in this case, because we don't have to reconfigure the pin as
> > GPIO to make this work. The only reason that Michal's proposal did that
> > is because that was believed to be necessary. But if the pin can just be
> > configured with a 100k pull-up, that's enough to pull the pin high when
> > we need it.  
> 
> Unless the gpio happens to be configured as output at the wrong value.
> Further I'm not sure if the pwm in disabled state actively pulls to 0
> and if in this state the PU of the pin is good enough to ensure a one
> here. That would need verification first.
> 
No. You can disable the output driver via pinctrl, so that only the
selected pull-up/down is relevant. The pin function and GPIO register
settings don't matter at all in this case.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
