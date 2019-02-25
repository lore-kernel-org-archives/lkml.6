Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED4C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0969920989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="KhXM3A2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfBYI4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:56:41 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40139 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBYI4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:56:41 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 4E77B25B791;
        Mon, 25 Feb 2019 19:56:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551084997; bh=7mVTnWDUI4JuAxJZb7H5cSkVWhWeInBaSPMTCnpdFMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhXM3A2vBeEJIPePkiyYDp46zO2wmZ+fneYLgiK7NOtcEDqXhgc8BZ8rHP5z1l3m0
         D/g0UU9reJ+EDOMLjfDH6lPtogeYloVs8Cr9Fg5rXqIluGnuQW7+3oXDPf+ryUAsSG
         gYtqngW/H3JaBkr9OV+DhieIHO0RdArPuYtfJiwU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 5DC7094056F; Mon, 25 Feb 2019 09:56:35 +0100 (CET)
Date:   Mon, 25 Feb 2019 09:56:35 +0100
From:   Simon Horman <horms@verge.net.au>
To:     twischer@de.adit-jv.com
Cc:     patch@alsa-project.org, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiada Wang <jiada_wang@mentor.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: remove unneeded sound
 #address/size-cells
Message-ID: <20190225085635.ztgakkoc42bsal55@verge.net.au>
References: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:34:59AM +0100, twischer@de.adit-jv.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> commit 78bc93b3ffb2 ("arm64: dts: renesas: r8a7796: Add address
> properties to rcar_sound port nodes") added missing #address-cells
> and #size-cells for sound ports.
> But, these are based on platform, not on SoC. This patch cleanups it.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

Thanks,

please CC patches for Renesas SoCs to linux-renesas-soc@vger.kernel.org (CCed)
so they appear in my patch queue.

Otherwise, this patch looks fine to me but I will wait to see if there are
other reviews before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts  |  1 +
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |  1 +
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi            | 11 -----------
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index b4f9567..2aefa53 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -68,6 +68,7 @@
>  	ports {
>  		/* rsnd_port0 is on salvator-common */
>  		rsnd_port1: port@1 {
> +			reg = <1>;
>  			rsnd_endpoint1: endpoint {
>  				remote-endpoint = <&dw_hdmi0_snd_in>;
>  
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
> index 8860be6..fa4ef7c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
> @@ -69,6 +69,7 @@
>  	ports {
>  		/* rsnd_port0 is on salvator-common */
>  		rsnd_port1: port@1 {
> +			reg = <1>;
>  			rsnd_endpoint1: endpoint {
>  				remote-endpoint = <&dw_hdmi0_snd_in>;
>  
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index 0648d12..cc601d9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -2162,17 +2162,6 @@
>  					dma-names = "rx", "tx", "rxu", "txu";
>  				};
>  			};
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				port@0 {
> -					reg = <0>;
> -				};
> -				port@1 {
> -					reg = <1>;
> -				};
> -			};
>  		};
>  
>  		audma0: dma-controller@ec700000 {
> -- 
> 2.7.4
> 
