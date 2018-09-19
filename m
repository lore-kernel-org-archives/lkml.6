Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7530AECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9EB214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Nh7o4UX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9EB214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeISOw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:52:28 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:43163 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeISOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:52:27 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0CAA625B77D;
        Wed, 19 Sep 2018 19:15:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537348527; bh=SrikXci+RpodujCUm6OAw5yCEPPOrbZU/JbH6vuMAwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nh7o4UX/1T9dN4wjGDEbw5oSXwqUZktq9meHZCuO9SbwQBep/00+X19eFv0b5wXs9
         XZaAWeQHVdGniuDmiviApGY21aFvymMXJwV0LdqQJ+O8LIUoaZhrfSjEiCPfy5iLb+
         aK0fZ3LEOWsLmDGhUNoAIa+R1WlJHh6/Dk3FgA9o=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0DAAE940270; Wed, 19 Sep 2018 11:15:25 +0200 (CEST)
Date:   Wed, 19 Sep 2018 11:15:24 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: r9a06g032: Add pinctrl node
Message-ID: <20180919091524.rgbk4m6ht34idkpd@verge.net.au>
References: <20180917163609.30457-1-phil.edworthy@renesas.com>
 <20180917163609.30457-4-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917163609.30457-4-phil.edworthy@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 05:36:09PM +0100, Phil Edworthy wrote:
> This provides a pinctrl driver for the Renesas R9A06G032 SoC
> 
> Based on a patch originally written by Michel Pollet at Renesas.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks Phil, I will defer this patch pending acceptance of the bindings.
Please continue to repost this patch with updates to the bindings
or otherwise ping me once they have been accepted.

> ---
> v3:
>  - No changes.
> v2:
>  - Add "renesas,rzn1-pinctrl" compatible fallback string
>  - Register size corrected.
> ---
>  arch/arm/boot/dts/r9a06g032.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> index eaf94976ed6d..2322268bc862 100644
> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -165,6 +165,14 @@
>  			status = "disabled";
>  		};
>  
> +		pinctrl: pin-controller@40067000 {
> +			compatible = "renesas,r9a06g032-pinctrl", "renesas,rzn1-pinctrl";
> +			reg = <0x40067000 0x1000>, <0x51000000 0x480>;
> +			clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> +			clock-names = "bus";
> +			status = "okay";
> +		};
> +
>  		gic: gic@44101000 {
>  			compatible = "arm,cortex-a7-gic", "arm,gic-400";
>  			interrupt-controller;
> -- 
> 2.17.1
> 
