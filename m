Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F32ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D937E20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q8qgoasx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937E20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeINWRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:17:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34977 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeINWRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ak5OAcbYxLE4bMySEw3+mZli71x/Nhk0YQkd91OJsPw=;
        b=Q8qgoasxgh8vNqzLSLdzmNPOhy3fN1+WIVMUw8Hj3B+7Z/KHXB6se3YlFJt/6Sfnxy3k0wPu4ZmXJYE7OqNS8p7Ir++9/XOSO4kisFxETod512QdHPUSwU5c3wp+FzTfGUcYYeQUMr0UCytNAiShHwg2BpymHZaL2ki0r7qB9tg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0rU5-00062l-MM; Fri, 14 Sep 2018 19:02:21 +0200
Date:   Fri, 14 Sep 2018 19:02:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20180914170221.GB3811@lunn.ch>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914145446.GQ14988@piout.net>
 <20180914162638.fgzzjin2bzgx74de@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914162638.fgzzjin2bzgx74de@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 06:26:38PM +0200, Quentin Schulz wrote:
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

Hi Quentin

gpio4 appears to be pretty arbitrary. Could a different design use a
different gpio? It me, this seems like a board property.

    Andrew
