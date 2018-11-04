Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C120854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIZTntuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279C120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeKEABy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:01:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbeKEABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:01:54 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE58204FD;
        Sun,  4 Nov 2018 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541342798;
        bh=9A7jdIR0C1u00rzExYboZ1ejvMSGVulcJheI7g2VeBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIZTntuvxQz5g2sxIA3pm3057e0yeS4YVg93d38NewbmjNpvo/d6L6gosNetWYQkc
         9IkdQZt8V1+2z4CpAAqCwksNyd4M+CdIsLwEJhKtN8pbBDLaNAIeJWg0qPEIVwcD2J
         yuJU1D5wf3eScxZB+96wCedBUDn7QZ/c4U1WnFds=
Date:   Sun, 4 Nov 2018 22:46:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
Message-ID: <20181104144614.GJ26016@tiger>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> function blocks. Add their ipg and per clocks to the device tree.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Are these EPIT devices actually used in upstream kernel, or just
somewhere else?

Shawn

> ---
> 
> I tried to make this similar to gpt1 and gpt2.
> 
>  arch/arm/boot/dts/imx25.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index b25309d26ea5..e80101847aff 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -388,12 +388,16 @@
>  			epit1: timer@53f94000 {
>  				compatible = "fsl,imx25-epit";
>  				reg = <0x53f94000 0x4000>;
> +				clocks = <&clks 83>, <&clks 43>;
> +				clock-names = "ipg", "per";
>  				interrupts = <28>;
>  			};
>  
>  			epit2: timer@53f98000 {
>  				compatible = "fsl,imx25-epit";
>  				reg = <0x53f98000 0x4000>;
> +				clocks = <&clks 84>, <&clks 43>;
> +				clock-names = "ipg", "per";
>  				interrupts = <27>;
>  			};
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
