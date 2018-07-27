Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B505CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EA920891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EA920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeG0JvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:51:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0JvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:51:09 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fiy8c-0003mQ-9I; Fri, 27 Jul 2018 10:30:14 +0200
Message-ID: <1532680211.32306.36.camel@pengutronix.de>
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 27 Jul 2018 10:30:11 +0200
In-Reply-To: <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
         <20180726092220.17250-2-o.rempel@pengutronix.de>
         <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
         <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
         <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
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

Hi Robin,

Am Freitag, den 27.07.2018, 01:51 +0000 schrieb Robin Gong:
[...]
> > > > ---
> > > >  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > index a45ca67a9d5f..e1308346e00d 100644
> > > > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > @@ -6,6 +6,14 @@ Required properties:
> > > >  - interrupts: Should contain CCM interrupt
> > > >  - #clock-cells: Should be <1>
> > > > 
> > > > +Optional properties:
> > > > +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
> > > > +signal
> > > > +  on power off.
> > > > +  Use this property if the SoC should be powered off by external
> > > > +power
> > > > +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> > > 
> > > PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
> > 
> > No. First, it was only one customer specific issue. After some research I found
> > even publicly available boards (for example RioTboard) which has same/similar
> > design. After seeing this in imx6 documentation as valid power off way, I have
> > no doubts - there should be even more devices doin this in the wild.
> 
> Not sure why the customer didn't follow reference design, since PMIC_ON_REQ can
> provide power off/on feature by pressing ONOFF key which connected ONOFF
> pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to power off/on PMIC). The official
> power off/on way (PMIC_ON_REQ) can also power off all power rails of PFUZE except
> snvs as your patch did on PMIC_STBY_REQ.  PMIC_STBY_REQ is used to notify pmic
> switch power mode (PFM/APS) or decrease voltage to save power in kernel suspend,
> not power off....I am not sure if we need this patchset to 'workaround' the board issue.
> 
Not all boards follow the reference design, that's a fact of life.

Please look at the i.MX6Q reference manual. The sequence implemented in
this patchset can be found as a valid way to power off the system in
"60.4.3 Power mode transitions" "Normal ON to OFF with external PMIC",
so there is hardly any way to argue that this is a board specific
quirk. This is one of the Freescale/NXP recommended sequences to turn
off the system.

Regards,
Lucas
