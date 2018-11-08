Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5147C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6226D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="c3FoOcJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6226D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeKHWV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:21:57 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:45342 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKHWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:21:57 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AEBEE25B772;
        Thu,  8 Nov 2018 23:46:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1541681195; bh=M+jnMI/+IyBClfXTUWP5Re/QbswoDg/M3DCGDPykcl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3FoOcJnn6vTRYF4Q4og18M0wunqTeJ/s2G19+smJZ3FijGWxPxJAuctyj0Au0l6c
         Mq5NRXKjNva8ju7fjo3ZqDLfGDYEebKZ9PqEBcLcRL3bg6uDI0Ig7IwywJErWTidFb
         x1FGhPrQb5DbEHxd0r/yB6/8HJKkywUuXZGRuecg=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 981B494048A; Thu,  8 Nov 2018 13:46:32 +0100 (CET)
Date:   Thu, 8 Nov 2018 13:46:32 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Message-ID: <20181108124632.fd52533ws7l7j2r2@verge.net.au>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB17709C158FEAC53383231CB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB17709C158FEAC53383231CB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 11:25:23AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> Who is the best person to take this patch?

I believe this one is for Marc.

> Thanks,
> Fab
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 10 September 2018 11:43
> > Subject: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
> >
> > Document RZ/G2M (r8a774a1) SoC specific bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > v1->v2:
> > * dropped "renesas,rzg-gen2-can" and fixed "clocks" property description
> >   as per Geert's comments.
> >
> > This patch applies on top of next-20180910.
> >
> >  Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > index 94a7f33..f3b160c 100644
> > --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
> >  Required properties:
> >  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
> >        "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> > +      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
> >        "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
> >        "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
> >        "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> > @@ -16,15 +17,21 @@ Required properties:
> >        "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
> >        "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
> >        compatible device.
> > -      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
> > +      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
> > +      compatible device.
> >        When compatible with the generic version, nodes must list the
> >        SoC-specific version corresponding to the platform first
> >        followed by the generic version.
> >
> >  - reg: physical base address and size of the R-Car CAN register map.
> >  - interrupts: interrupt specifier for the sole interrupt.
> > -- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> > -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> > +- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> > +  devices.
> > +  phandles and clock specifiers for 3 CAN clock inputs for every other
> > +  SoC.
> > +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> > +       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> > +       "can_clk".
> >  - pinctrl-0: pin control group to be used for this controller.
> >  - pinctrl-names: must be "default".
> >
> > @@ -41,8 +48,9 @@ using the below properties:
> >  Optional properties:
> >  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
> >      <0x0> (default) : Peripheral clock (clkp1)
> > -    <0x1> : Peripheral clock (clkp2)
> > -    <0x3> : Externally input clock
> > +    <0x1> : Peripheral clock (clkp2) (not supported by
> > +    RZ/G2 devices)
> > +    <0x3> : External input clock
> >
> >  Example
> >  -------
> > --
> > 2.7.4
> 
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 
