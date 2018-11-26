Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E1EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5293F20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5293F20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeKZXRU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:17:20 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:3218 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZXRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:17:20 -0500
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1gRFv3-0003rW-Ll; Mon, 26 Nov 2018 13:23:17 +0100
Date:   Mon, 26 Nov 2018 13:23:16 +0100
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
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
Message-ID: <20181126132316.541a4131@ipc1.ka-ro>
In-Reply-To: <20181126115123.GA15164@ulmo>
References: <20181114215120.vddykljqyavm64wj@pengutronix.de>
        <20181115152545.GA8611@ulmo>
        <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
        <20181116083430.7f1d8452@ipc1.ka-ro>
        <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
        <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
        <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
        <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
        <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
        <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
        <20181126115123.GA15164@ulmo>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Nov 23, 2018 at 03:15:11PM +0000, Vokáč Michal wrote:
> > On 22.11.2018 20:03, Uwe Kleine-König wrote:  
> > > On Thu, Nov 22, 2018 at 04:46:39PM +0000, Vokáč Michal wrote:  
> > >> On 22.11.2018 17:23, Uwe Kleine-König wrote:  
> > >>> On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vokáč Michal wrote:  
> > >>>> On 16.11.2018 09:25, Uwe Kleine-König wrote:  
> > >>>>> On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Waßmann wrote:  
> > >>>>>> No. You can disable the output driver via pinctrl, so that only the
> > >>>>>> selected pull-up/down is relevant. The pin function and GPIO register
> > >>>>>> settings don't matter at all in this case.  
> > >>>>
> > >>>> Lothar, please can you be more specific how would you do that? IFAIK the
> > >>>> pull-up/down internal resistors have effect only if the pin is configured
> > >>>> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Output driver:
> > >>>>
> > >>>>     "Internal pull-up, pull-down resistors, and pad keeper are disabled in
> > >>>>      output mode."  
> > > 
> > > This would mean you'd have to rely on an external pull up for your use
> > > case. I wouldn't be surprised however if DSE=0 wouldn't count as "output
> > > mode". Given the reliability of NXP documentation I wouldn't bet neither
> > > on one nor the other possibility.  
> > 
> > Yeah, the NXP documentation sometimes does not really match reality.
> > My use case is based on the fact that I configure the pin as input in
> > the driver. Then it works just fine.
> >   
> > >>> So I'd expect this to really work on i.MX6 but not the earlier SoCs
> > >>> without a gpio specifier.  
> > >>
> > >> Maybe you would expect it to work but I already tested and measured
> > >> that weeks ago ;) It did not work.  
> > > 
> > > Which pin/gpio do we talk about? Which i.MX6 variant did you test this
> > > on? (Assuming i.MX6D or i.MX6Q and PAD_DISP0_DATA09, did you try setting
> > > 
> > > 	IOMUXC_SW_MUX_CTL_PAD_DISP0_DATA09 (0x020E0194) = 0x00000005
> > > 	IOMUXC_SW_PAD_CTL_PAD_DISP0_DATA09 (0x020E04A8) = 0x0000b080
> > > 
> > > and then play with GPIO 4.30 direction and output value?)  
> > 
> > My test setup is as follows:
> > - SoC is i.MX6DL or i.MX6S - I have three board variants in total.
> > - Pin used for PWM/GPIO is PAD_GPIO9.
> > - The pin is not connected to any circuit. Just a test point.
> > - pinctrl setup in DT:
> >    - for "pwm":
> >      - fsl,pins = <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x8>
> >      - IOMUXC_SW_MUX_CTL_PAD_GPIO09 = 0x00000004
> >      - IOMUXC_SW_PAD_CTL_PAD_GPIO09 = 0x00000008
> > 
> >    - for "gpio":
> >     - fsl,pins = <MX6QDL_PAD_GPIO_9__GPIO1_IO09 0xb000>
> >     - IOMUXC_SW_MUX_CTL_PAD_GPIO09 = 0x00000005
> >     - IOMUXC_SW_PAD_CTL_PAD_GPIO09 = 0x0000b000  
> 
> Does it help if you additionally set the ODE bit (bit 11) here?
> 
That only helps to NOT actively pulling the pin HIGH, but the opposite
is what is needed here.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
