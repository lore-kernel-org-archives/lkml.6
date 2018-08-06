Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E16A21A28
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E16A21A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeHFS7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:59:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60447 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbeHFS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:59:39 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fmihL-0002Ha-JU; Mon, 06 Aug 2018 18:49:35 +0200
Message-ID: <1533574172.2809.11.camel@pengutronix.de>
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
Date:   Mon, 06 Aug 2018 18:49:32 +0200
In-Reply-To: <DB6PR04MB3223362445234D81383F0D1689200@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
         <20180726092220.17250-2-o.rempel@pengutronix.de>
         <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
         <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
         <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
         <1532680211.32306.36.camel@pengutronix.de>
         <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
         <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
         <DB6PR04MB3223362445234D81383F0D1689200@DB6PR04MB3223.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 06.08.2018, 02:34 +0000 schrieb Robin Gong:
> > > > Not all boards follow the reference design, that's a fact of
> > > > life.
> > > > 
> > > > Please look at the i.MX6Q reference manual. The sequence
> > > > implemented
> > > > in this patchset can be found as a valid way to power off the
> > > > system
> > > > in
> > > > "60.4.3 Power mode transitions" "Normal ON to OFF with external
> > > > PMIC", so there is hardly any way to argue that this is a board
> > > > specific quirk. This is one of the Freescale/NXP recommended
> > > > sequences to
> > 
> > turn off the system.
> > 
> > > Okay, but could you add one more comment for this solution? RTC
> > > alarm
> > > and ONOFF Button wakeup feature can't be support in this case.
> > 
> > Enough to add it in to changelog? or should it go to the binding
> > documentation?
> 
> The binding doc is better.

Sorry, I disagree.

A binding is a way to describe a specific hardware layout, it isn't the
right place to advice a hardware designer on the implications of a
specific hardware implementation. The NXP hardware design guide is a
more suitable place for this information.

We also don't mention in random bindings that the system won't be able
to brew a fresh cup of coffee.

Regards,
Lucas
