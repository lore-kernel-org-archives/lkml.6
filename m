Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF35ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE620882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CE620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeINXSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:18:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52332 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeINXSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:18:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 66EA620741; Fri, 14 Sep 2018 20:02:32 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E60E204AE;
        Fri, 14 Sep 2018 20:02:22 +0200 (CEST)
Date:   Fri, 14 Sep 2018 20:02:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20180914180222.GT14988@piout.net>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914145446.GQ14988@piout.net>
 <20180914162638.fgzzjin2bzgx74de@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914162638.fgzzjin2bzgx74de@qschulz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2018 18:26:38+0200, Quentin Schulz wrote:
> Hi Alexandre,
> 
> On Fri, Sep 14, 2018 at 04:54:46PM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 14/09/2018 11:44:26+0200, Quentin Schulz wrote:
> > > In order to use GPIO4 as a GPIO, we need to mux it in this mode so let's
> > > declare a new pinctrl DT node for it.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > ---
> > >  arch/mips/boot/dts/mscc/ocelot.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > index 8ce317c..b5c4c74 100644
> > > --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > @@ -182,6 +182,11 @@
> > >  			interrupts = <13>;
> > >  			#interrupt-cells = <2>;
> > >  
> > > +			gpio4: gpio4 {
> > > +				pins = "GPIO_4";
> > > +				function = "gpio";
> > > +			};
> > > +
> > 
> > For a GPIO, I would do that in the board dts because it is not used
> > directly in the dtsi.
> > 
> 
> And the day we've two boards using this pinctrl we move it to a dtsi. Is
> that the plan?
> 

Not really, at least not for gpios. I've included the pinctrl for the
uart, i2c and spi because they are the only option if you are to use
those peripherals. Else, I've would have left the pinctrl to the board
file. From my point of view, the gpios are too board specific to be in a
soc dtsi.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
