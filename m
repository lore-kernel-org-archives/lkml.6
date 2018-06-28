Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13A8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7397121654
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xOT02njw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7397121654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeF1Axj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeF1Axh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:53:37 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D854D25386;
        Thu, 28 Jun 2018 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530147217;
        bh=vvrrQzSAl5rf+JrsKblFktm606TjW0PCleLZvPVM9i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOT02njwLWUJiV/fsj6goU89dVZYVdpX1qfFgKuT59byeQAmQeX9Z7NEvJU5trHZW
         bnpaLksvbaXX8kQ77VtU+46XsIcJitlq6qf0GJ+t4FKN5c5w3RL5+HD02Zx6Tb8rLV
         47bMyfiWFAOtYlsRdcVteUDPqQiuGLnOiUUUXFvU=
Date:   Thu, 28 Jun 2018 08:52:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Message-ID: <20180628005217.GC22683@dragon>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 03:14:39AM +0000, Anson Huang wrote:
> Gentle Ping...

I cannot apply this dts patch until the clock patch is landed on
mainline, because it has a dependency on new clock ID IMX6UL_CLK_GPIO1
created by clock patch.

Shawn

> > -----Original Message-----
> > From: Anson Huang
> > Sent: Sunday, June 3, 2018 9:44 AM
> > To: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > mturquette@baylibre.com; sboyd@kernel.org;
> > michael@amarulasolutions.com; matteo.lisi@engicam.com
> > Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-clk@vger.kernel.org
> > Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
> > 
> > i.MX6UL has GPIO clock gates in CCM CCGR, add clock property for GPIO driver
> > to make sure all GPIO banks work as expected.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > 	no changes since V1.
> >  arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> > index 1241972..405e068 100644
> > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > @@ -437,6 +437,7 @@
> >  				reg = <0x0209c000 0x4000>;
> >  				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> >  					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6UL_CLK_GPIO1>;
> >  				gpio-controller;
> >  				#gpio-cells = <2>;
> >  				interrupt-controller;
> > @@ -450,6 +451,7 @@
> >  				reg = <0x020a0000 0x4000>;
> >  				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> >  					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6UL_CLK_GPIO2>;
> >  				gpio-controller;
> >  				#gpio-cells = <2>;
> >  				interrupt-controller;
> > @@ -462,6 +464,7 @@
> >  				reg = <0x020a4000 0x4000>;
> >  				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> >  					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6UL_CLK_GPIO3>;
> >  				gpio-controller;
> >  				#gpio-cells = <2>;
> >  				interrupt-controller;
> > @@ -474,6 +477,7 @@
> >  				reg = <0x020a8000 0x4000>;
> >  				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> >  					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6UL_CLK_GPIO4>;
> >  				gpio-controller;
> >  				#gpio-cells = <2>;
> >  				interrupt-controller;
> > @@ -486,6 +490,7 @@
> >  				reg = <0x020ac000 0x4000>;
> >  				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> >  					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX6UL_CLK_GPIO5>;
> >  				gpio-controller;
> >  				#gpio-cells = <2>;
> >  				interrupt-controller;
> > --
> > 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
