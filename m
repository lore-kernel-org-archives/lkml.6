Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EA220657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfAQH2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:28:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42309 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbfAQH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:28:45 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gk26V-0001mp-1v; Thu, 17 Jan 2019 08:28:43 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gk26T-00031b-VX; Thu, 17 Jan 2019 08:28:41 +0100
Date:   Thu, 17 Jan 2019 08:28:41 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190117072841.e57tilkbrtnifss4@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <CAJ2_jOEuE1Y8G3xnYqa+aA9GSRGmN8xN7fh4nBs0_Yb68Br9bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2_jOEuE1Y8G3xnYqa+aA9GSRGmN8xN7fh4nBs0_Yb68Br9bg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 17, 2019 at 12:15:38PM +0530, Yash Shah wrote:
> On Wed, Jan 16, 2019 at 10:16 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
> > > > >
> > > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > > [Atish: Various fixes and code cleanup]
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > ---
> > > > >  drivers/pwm/Kconfig      |  10 ++
> > > > >  drivers/pwm/Makefile     |   1 +
> > > > >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 257 insertions(+)
> > > > >  create mode 100644 drivers/pwm/pwm-sifive.c
> > > > >
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > index a8f47df..3bcaf6a 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > > >         To compile this driver as a module, choose M here: the module
> > > > >         will be called pwm-samsung.
> > > > >
> > > > > +config PWM_SIFIVE
> > > > > +     tristate "SiFive PWM support"
> > > > > +     depends on OF
> > > > > +     depends on COMMON_CLK
> > > >
> > > > I'd say add:
> > > >
> > > >         depends on MACH_SIFIVE || COMPILE_TEST
> > > >
> > > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> > >
> > > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > > @Paul, Do you have any comments on this?
> >
> > If this is not going to be available at least protect it by
> >
> >         depends RISCV || COMPILE_TEST
> >
> > > > I wonder if such an instance should be only a single PWM instead of
> > > > four. Then you were more flexible with the period lengths (using
> > > > pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.
> > > >
> > > > I didn't understand how the deglitch logic works yet. Currently it is
> > > > not used which might result in four edges in a single period (which is
> > > > bad).
> > >
> > > I can enable deglitch logic by just setting a bit (BIT_PWM_DEGLITCH) in
> > > REG_PWMCFG. Will do that.
> >
> > This only works for the first pwm output though.

I mixed this up with pwmzerocmp; deglitch should work on all four
outputs.

> > > > > +struct sifive_pwm_device {
> > > > > +     struct pwm_chip chip;
> > > > > +     struct notifier_block notifier;
> > > > > +     struct clk *clk;
> > > > > +     void __iomem *regs;
> > > > > +     unsigned int approx_period;
> >
> > When thinking about this a bit more, I think the better approach would
> > be to let the consumer change the period iff there is only one consumer.
> > Then you can drop that approx-period stuff and the result is more
> > flexible. (Having said that I still prefer making the driver provide
> > only a single PWM with the ability to have periods other than powers of
> > two.)
> >
> 
> I am not confident about the implementation of the way you are suggesting.
> As of now, I am going to stick with the current implementation.

The idea is to count the users using the .request and .free callbacks.
Iff there is exactly one, allow changes to period.

But please consider moving to an abstraction that only provides a single
pwm instead.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
