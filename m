Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E55C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79778218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545161542;
	bh=/nHdXQ/zF4C6rNYzrfEFgxg7f8Fg6aD4YYC1RllIsgQ=;
	h=References:In-Reply-To:To:Cc:Subject:From:Date:List-ID:From;
	b=UevWz7e1lzhOjb8IwoiyhcvrjisSrKKw8PfyJmqpN/jePNzYP822Kemuvz6EeAg3t
	 jegbuaMIiE4bRzD+r4I/4FungSamxeLbjd5UyP+XAyMPkYH1YKdC0FVL+eFZf7dC8P
	 hImOpAfwRgUOTEZ203pIUJZAIfyzRuQFii977O4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLRTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbeLRTcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:32:21 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A4721841;
        Tue, 18 Dec 2018 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545161539;
        bh=/nHdXQ/zF4C6rNYzrfEFgxg7f8Fg6aD4YYC1RllIsgQ=;
        h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
        b=flodcFugnfW7N/z0SNd08BA5O3pDIQ80oJ+jsq+TnObvZoXY2uGqVawHTb3319F4w
         E7zACZB48CujJqAluwrnYsEWRUmszG2wSpKanJi6p/BQ1tUIxvnXhMc+9yWXB7AmJ5
         muFgJnyeGAViXn2z4JpleQE1nL89RZ20tNhtYK3s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com> <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com> ,<1545129634.5874.20.camel@pengutronix.de> <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com> ,<1545140504.5874.25.camel@pengutronix.de> <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com> <1545141748.5874.27.camel@pengutronix.de>
Message-ID: <154516153880.238328.15274393304999995060@swboyd.mtv.corp.google.com>
In-Reply-To: <1545141748.5874.27.camel@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M composite clock
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 18 Dec 2018 11:32:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lucas Stach (2018-12-18 06:02:28)
> Am Dienstag, den 18.12.2018, 13:53 +0000 schrieb Anson Huang:
> [...]
> > >=20
> > > > Regarding about the over head, yes, the change in common composite
> > > > clock register has too many over head for other clocks, what if I
> > > > ONLY have dram core clock to pass the CLK_GET_RATE_NOCACHE flag to
> > > > register the composite clock?
> > >=20
> > > IMHO marking clocks under TF-A control explicitly as nocache would be
> > > much more acceptable than doing it for every composite clock. This
> > > seems okay for a short term solution.
> > >=20
> > > Still I think that whatever is causing the bus frequency scale to
> > > change should have a way to explicitly invalidate the clock cache for
> > > the affected clocks eventually.
> >=20
> > It is because the DDR PLL/clocks can only be changed with strict DDR
> > freq change flow, and it is done in TF-A, Linux kernel can NOT touch
> > it in runtime, so we have to mark the child clock of DDR PLL to be
> > uncached, in V2 patch, I will just add the flag for the DDR PLL child
> > clocks to be a shorten solution, should be only very few ones, hope
> > it is acceptable, thanks.
>=20
> I fully understand why you are doing the frequency change in TF-A and I
> agree with the reasoning to do so. I also think that using uncached for
> the few clocks under TF-A control is fine for now.
>=20
> But if/when the bus frequency scaling is actually implemented for
> upstream I think the flow should look something like that:
>=20
> 1. Bus freq scaling driver determines that a change is necessary
> 2. Scaling driver calls into TF-A to do the change
> 3. TF-A reconfigures clock rates
> 4. Scaling driver calls into clock driver to signal that a clock change
> might have happened
> 5. Clock driver invalidates and recalculates cached values for the
> affected clocks
>=20

Does any clk consuming driver of the downstream clks that are branched
off of the bus clk managed by firmware care about the frequency? Or do
they just want the clk to be on. If they don't care then it's possible
to break the parent dependency and just not care to tell them what the
bus frequency is anymore.

I don't know how you would implement #4 above, besides by having the bus
freq scaling driver use clk_set_rate() to tell the bus clk that it wants
a new rate and then having that clk implementation do #2. That way the
rate propagation works without having to notify clk code somehow.

