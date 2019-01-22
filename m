Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A829C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200421019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfAVMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:52:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37507 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfAVMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:52:32 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1glvXa-0001MQ-AN; Tue, 22 Jan 2019 13:52:30 +0100
Message-ID: <1548161549.2465.24.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Tue, 22 Jan 2019 13:52:29 +0100
In-Reply-To: <AM0PR04MB4211B9003857795EBC79541480980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
         <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
         <1547801609.2626.5.camel@pengutronix.de>
         <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
         <1547806960.2626.9.camel@pengutronix.de>
         <AM0PR04MB42111FE266342A2C2EAECC3580980@AM0PR04MB4211.eurprd04.prod.outlook.com>
         <1548154758.2465.20.camel@pengutronix.de>
         <AM0PR04MB4211B9003857795EBC79541480980@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 22.01.2019, 12:03 +0000 schrieb Aisheng Dong:
> > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Tuesday, January 22, 2019 6:59 PM
> > 
> > Am Dienstag, den 22.01.2019, 10:39 +0000 schrieb Aisheng Dong:
> > > > > > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > > > 
> > > > Sent: Friday, January 18, 2019 6:23 PM
> > > 
> > > [...]
> > > > > > This has been discussed when upstreaming the driver. The
> > > > > > controller may support multiple output IRQs, but only one them
> > > > > > is actually used depending on the CHANCTRL config. There is no
> > > > > > use in hooking up all the output IRQs in DT, if only one of them
> > > > > > is actually used. Some of the outputs may not even be visible to
> > > > > > the Linux system, but may belong to a Cortex M4 subsystem. All
> > > > > > of those configurations can be described in DT by changing the
> > > > > > upstream interrupt and "fsl,channel" in a
> > > > 
> > > > coherent way.
> > > > > > 
> > > > > > Please correct me if my understanding is totally wrong.
> > > > > 
> > > > > I'm afraid your understanding of CHAN seems wrong.
> > > > > (Binding doc of that property needs change as well).
> > > > > 
> > > > > On QXP DC SS, the IRQSTEER supports 512 interrupts with 8
> > > > > interrupt output Conntected to GIC.
> > > > > The current driver does not support it as it assumes only one
> > > > > interrupt
> > > > 
> > > > output used.
> > > > 
> > > > Okay, so let's take a step back. The description in the QXP RM is
> > > > actually better than what I've seen until now. Still it's totally confusing that
> > 
> > the "channel"
> > > > terminology used with different meanings in docs. Let's try to avoid
> > > > this as much as possible.
> > > > 
> > > > So to get things straight: Each irqsteer controller has a number of IRQ
> > 
> > groups.
> > > > All the input IRQs of one group are ORed together to form on output IRQ.
> > > > Depending on the SoC integration, a group can contain 32 or
> > > > 64 IRQs, where DCSS irqsteer on MX8M and the big 512 input
> > > > controllers on QXP and QM both use 64 IRQs per group. You are
> > > > claiming that the smaller controllers on both QXP am QM have only 32
> > 
> > IRQs per group, right?
> > > > 
> > > > So the only change that is needed is that the driver needs to know
> > > > the number of input IRQs per group, with a default of 64 to not break DT
> > 
> > compatibility.
> > > > 
> > > 
> > > Not exactly.
> > > from HW point of view , there're two parameters during IRQSTEER
> > 
> > integration.
> > > For example,
> > > DC in QXP:
> > > > > > > > > > > > > > > parameter  IRQCHAN		=  1; 	//Number of IRQ Channels/Slots
> > > > > parameter  NINT32		=  8;	//Number of interrupts in multiple
> > 
> > of 32
> > 
> > If this is always in multiples of 32, the only change we need to make to the
> > driver is to fix DT binding and interpretation of the "fsl,irq-groups" property to
> > be in multiples of 32.
> > 
> > This means i.MX8MQ DCSS irqsteer would need to change to 2 irq-groups, but
> > as this isn't used upstream yet we can still do this change without breaking too
> > much stuff and I would rather correct this now than keeping a DT binding
> > around that doesn't match the HW.
> > 
> 
> We want to avoid using of irq-groups as it's wrong.
> Stick to HW parameters, only channel number and interrupts number should be used.

The fsl,irq-groups property is exactly your NINT32 parameter above. I
just wrongly assumed that it's always in multiples of 64, as that's
what the i.MX8MQ DCSS irqsteer module looks like. We should fix this
and be done with it.

> > > MIPI CSI in MQ:
> > > > > > > > Parameter  IRQCHAN		= 1
> > > > Parameter  NINT32		= 1
> > > 
> > > You will see no group concept used here. Only channel number and
> > 
> > interrupts number.
> > > The group is an IP internal concept that ORed a group of 64 interrupts
> > > into an output interrupt. But it may also only use 32 interrupts in the same
> > 
> > group.
> > 
> > I suppose that the OR group size at that point is always 64 input IRQs per
> > output IRQ, right? So with NINT32 == 1 you end up with 1 output IRQ, but for
> > NINT32 == 3 you get 2 output IRQs, correct?
> 
> Yes, that's right.
> 
> > 
> > > > Also if the connection between IRQ group and output IRQ is fixed,
> > > > the driver should be more clever about handling the chained IRQ. If
> > > > you know which of the upstream IRQs fired you only need to look at
> > > > the 32 or 64 IRQ status registers of that specific group, not all of them.
> > > 
> > > Yes, that's right.
> > > I planned to do that later with a separate patch before.
> > 
> > Let's do it right with the first patch. This doesn't seem like a big change.
> > 
> 
> We can do it.
> 
> > > 
> > > > 
> > > > Can you please clarify what the CHANCTRL setting changes in this setup?
> > > > 
> > > 
> > > IRQsteer supports up to 5 separate CAHNNELS which each of them
> > > supports up to 512 interrupts. CHANCTL is used to enable those respective
> > 
> > CHAN output interrupts.
> > > e.g.
> > > 1~8 output interrupts of CHAN0.
> > > 
> > > One notable thing is the each channel has a separate address space.
> > > That means the chan1 reg address is not the one we specified in default reg
> > 
> > property.
> > > So the correct dts may be like for multi channels cases.
> > > interrupt-controller@32e2d000 {
> > >         compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
> > >         reg = <0x32e2d000 0x1000>,
> > >               <0x32e2e000 0x1000>,
> > >               <0x32e2f000 0x1000>;
> > >               ...
> > >         reg-names = "ch0", "ch1", "ch2", ...;
> > >         interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > >         fsl,irqs-per-chan= <64>;
> > >         interrupt-controller;
> > >         #interrupt-cells = <2>; //cell 0: chan index cell 2: interrupt
> > > number }; This makes the things quite complicated.
> > 
> > With the current binding, what keeps us from describing such a multi- channel
> > irqsteer with multiple DT nodes and have multiple driver instances? I don't see
> > why we would need to mix this all into one driver instance. 
> > So for your above
> > example, something like:
> > 
> > interrupt-controller@32e2d000 {
> > 	compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";>
> > 	reg = <0x32e2d000 0x1000>;
> > 	interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > 	fsl,channel = <0>;
> > };
> > 
> > interrupt-controller@32e2e000 {
> > 	compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";>
> > 	reg = <0x32e2e000 0x1000>;
> > 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > 	fsl,channel = <1>;
> > };
> > 
> 
> Because from HW point of view, it IS actually one IRQSTEER module with multi
> channels supported. So I feel describe each channel into several nodes
> seems violate the HW a bit. That why I made the former dts binding as an example.

Yes, DT describes HW but that doesn't mean we slavishly need to stick
to the HW module boundaries. DT is always also an abstraction over the
hardware, so if we can both describe the HW more easily and keep the
driver simpler by treating the HW block as multiple instances of the
same thing, I think we should do this.

> Another point is that there's only one physical CHANCTL register shared with multi
> channels. However, each channel seems use a mirror CAHNCTRL register in its separate
> register space to enable the channel. But needs care about overwrite others.
> (Got this information after discussing with IC guys, still not verified)

So that's something I don't understand yet. The docs state that only
one of the CHANCTL CH bit can be active at any time. If it's only one
physical register this can't be true.

If the CHANCTL in each channel register space is just a mirror of a
single physical register then sure, we could get into issues when
multiple driver instances try to change their "private" CHANCTL mirror
via a RMW cycle. So it's quite crucial to find out how it's wired up
internally.

Regards,
Lucas
