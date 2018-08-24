Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1302AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1459021763
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="SmqQ2tOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1459021763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeHXMu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:50:56 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35842 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHXMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:50:56 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A818225BE91;
        Fri, 24 Aug 2018 19:17:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1535102229; bh=32MY8bRnGepIccNfzjspn1WwNilZQhcPS4R49RKclSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmqQ2tOobNWvthWuciCPBnZPZn/g9GQ3jnBxCjrjcn6iFoK/w6a2Dfsy5ijRdtCcz
         1/U/hpqwp2fu7tJMY+0T3t2E9xh423ZKsfxVJJgMrB8RHrkTbhQLPO0yGyZcWPcCMT
         boo4JjDsG5C98BA8o9mEPZ20Ruzl2xiAZbcxlKt4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 9F8D6940443; Fri, 24 Aug 2018 11:17:06 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:17:06 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Message-ID: <20180824091706.pcxymf7suyxcdprz@verge.net.au>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 02:07:33PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (r8a774a1) SoC specific bindings and RZ/G2
> generic bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Are we sure these clocks are for all RZ/G2 SoCs?
If so:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> This patch applies on next-20180823
> 
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> index 94a7f33..ae8fccc 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
>  Required properties:
>  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
>  	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
>  	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>  	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>  	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> @@ -17,6 +18,7 @@ Required properties:
>  	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
>  	      compatible device.
>  	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
> +	      "renesas,rzg-gen2-can" for a generic RZ/G2 compatible device.
>  	      When compatible with the generic version, nodes must list the
>  	      SoC-specific version corresponding to the platform first
>  	      followed by the generic version.
> @@ -24,7 +26,9 @@ Required properties:
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
>  - clocks: phandles and clock specifiers for 3 CAN clock inputs.
> -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> +	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> +	       "can_clk".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>  
> @@ -41,8 +45,9 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
>  			    <0x0> (default) : Peripheral clock (clkp1)
> -			    <0x1> : Peripheral clock (clkp2)
> -			    <0x3> : Externally input clock
> +			    <0x1> : Peripheral clock (clkp2) (not supported by
> +				    RZ/G2 devices)
> +			    <0x3> : External input clock
>  
>  Example
>  -------
> -- 
> 2.7.4
> 
