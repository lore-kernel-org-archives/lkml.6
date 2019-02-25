Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C02EC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C96B2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="YhHbNE+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfBYI5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:57:05 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40155 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBYI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:57:05 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E4AD825B849;
        Mon, 25 Feb 2019 19:57:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551085023; bh=zzFsRCh4NQnx7hUS+pkkeJhfYgKyaWJXV97j284vxAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhHbNE+d3m/TWN2a0GQJtfy+9Tz4hRZkoURprvKXPTOlS7iG8L+alCnozZg9a/r+W
         3nBh8SL9UC4bwIXr7CPo3Uv/N81x2tkbxAFePE2eq0Qris2rUQgX6RU3Bvwm467ufg
         y0lR43L0BBoRg1OLuL0nQQkNObOW0ToLXhrCPBto=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 069DE94056F; Mon, 25 Feb 2019 09:57:00 +0100 (CET)
Date:   Mon, 25 Feb 2019 09:57:00 +0100
From:   Simon Horman <horms@verge.net.au>
To:     twischer@de.adit-jv.com
Cc:     patch@alsa-project.org, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiada Wang <jiada_wang@mentor.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a77965: add SSIU support for sound
Message-ID: <20190225085700.a3k3l3otqpdlztvr@verge.net.au>
References: <1550829612-6495-1-git-send-email-twischer@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550829612-6495-1-git-send-email-twischer@de.adit-jv.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:00:12AM +0100, twischer@de.adit-jv.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> rsnd driver supports SSIU now, let's use it.
> Then, BUSIF DMA settings on rcar_sound,ssi (= rxu, txu) are
> no longer needed.
> Applies commit 8d14bfa074db ("arm64: dts: renesas: r8a7796: add SSIU
> support for sound") for r8a77965.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 211 ++++++++++++++++++++++++++++++

Thanks,

please CC patches for Renesas SoCs to linux-renesas-soc@vger.kernel.org
(CCed)
so they appear in my patch queue.

Otherwise, this patch looks fine to me but I will wait to see if there are
other reviews before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

>  1 file changed, 211 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> index 4b3730f..cc77c2e 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -1585,6 +1585,217 @@
>  				};
>  			};
>  
> +			rcar_sound,ssiu {
> +				ssiu00: ssiu-0 {
> +					dmas = <&audma0 0x15>, <&audma1 0x16>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu01: ssiu-1 {
> +					dmas = <&audma0 0x35>, <&audma1 0x36>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu02: ssiu-2 {
> +					dmas = <&audma0 0x37>, <&audma1 0x38>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu03: ssiu-3 {
> +					dmas = <&audma0 0x47>, <&audma1 0x48>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu04: ssiu-4 {
> +					dmas = <&audma0 0x3F>, <&audma1 0x40>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu05: ssiu-5 {
> +					dmas = <&audma0 0x43>, <&audma1 0x44>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu06: ssiu-6 {
> +					dmas = <&audma0 0x4F>, <&audma1 0x50>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu07: ssiu-7 {
> +					dmas = <&audma0 0x53>, <&audma1 0x54>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu10: ssiu-8 {
> +					dmas = <&audma0 0x49>, <&audma1 0x4a>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu11: ssiu-9 {
> +					dmas = <&audma0 0x4B>, <&audma1 0x4C>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu12: ssiu-10 {
> +					dmas = <&audma0 0x57>, <&audma1 0x58>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu13: ssiu-11 {
> +					dmas = <&audma0 0x59>, <&audma1 0x5A>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu14: ssiu-12 {
> +					dmas = <&audma0 0x5F>, <&audma1 0x60>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu15: ssiu-13 {
> +					dmas = <&audma0 0xC3>, <&audma1 0xC4>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu16: ssiu-14 {
> +					dmas = <&audma0 0xC7>, <&audma1 0xC8>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu17: ssiu-15 {
> +					dmas = <&audma0 0xCB>, <&audma1 0xCC>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu20: ssiu-16 {
> +					dmas = <&audma0 0x63>, <&audma1 0x64>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu21: ssiu-17 {
> +					dmas = <&audma0 0x67>, <&audma1 0x68>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu22: ssiu-18 {
> +					dmas = <&audma0 0x6B>, <&audma1 0x6C>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu23: ssiu-19 {
> +					dmas = <&audma0 0x6D>, <&audma1 0x6E>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu24: ssiu-20 {
> +					dmas = <&audma0 0xCF>, <&audma1 0xCE>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu25: ssiu-21 {
> +					dmas = <&audma0 0xEB>, <&audma1 0xEC>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu26: ssiu-22 {
> +					dmas = <&audma0 0xED>, <&audma1 0xEE>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu27: ssiu-23 {
> +					dmas = <&audma0 0xEF>, <&audma1 0xF0>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu30: ssiu-24 {
> +					dmas = <&audma0 0x6f>, <&audma1 0x70>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu31: ssiu-25 {
> +					dmas = <&audma0 0x21>, <&audma1 0x22>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu32: ssiu-26 {
> +					dmas = <&audma0 0x23>, <&audma1 0x24>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu33: ssiu-27 {
> +					dmas = <&audma0 0x25>, <&audma1 0x26>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu34: ssiu-28 {
> +					dmas = <&audma0 0x27>, <&audma1 0x28>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu35: ssiu-29 {
> +					dmas = <&audma0 0x29>, <&audma1 0x2A>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu36: ssiu-30 {
> +					dmas = <&audma0 0x2B>, <&audma1 0x2C>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu37: ssiu-31 {
> +					dmas = <&audma0 0x2D>, <&audma1 0x2E>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu40: ssiu-32 {
> +					dmas =	<&audma0 0x71>, <&audma1 0x72>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu41: ssiu-33 {
> +					dmas = <&audma0 0x17>, <&audma1 0x18>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu42: ssiu-34 {
> +					dmas = <&audma0 0x19>, <&audma1 0x1A>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu43: ssiu-35 {
> +					dmas = <&audma0 0x1B>, <&audma1 0x1C>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu44: ssiu-36 {
> +					dmas = <&audma0 0x1D>, <&audma1 0x1E>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu45: ssiu-37 {
> +					dmas = <&audma0 0x1F>, <&audma1 0x20>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu46: ssiu-38 {
> +					dmas = <&audma0 0x31>, <&audma1 0x32>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu47: ssiu-39 {
> +					dmas = <&audma0 0x33>, <&audma1 0x34>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu50: ssiu-40 {
> +					dmas = <&audma0 0x73>, <&audma1 0x74>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu60: ssiu-41 {
> +					dmas = <&audma0 0x75>, <&audma1 0x76>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu70: ssiu-42 {
> +					dmas = <&audma0 0x79>, <&audma1 0x7a>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu80: ssiu-43 {
> +					dmas = <&audma0 0x7b>, <&audma1 0x7c>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu90: ssiu-44 {
> +					dmas = <&audma0 0x7d>, <&audma1 0x7e>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu91: ssiu-45 {
> +					dmas = <&audma0 0x7F>, <&audma1 0x80>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu92: ssiu-46 {
> +					dmas = <&audma0 0x81>, <&audma1 0x82>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu93: ssiu-47 {
> +					dmas = <&audma0 0x83>, <&audma1 0x84>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu94: ssiu-48 {
> +					dmas = <&audma0 0xA3>, <&audma1 0xA4>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu95: ssiu-49 {
> +					dmas = <&audma0 0xA5>, <&audma1 0xA6>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu96: ssiu-50 {
> +					dmas = <&audma0 0xA7>, <&audma1 0xA8>;
> +					dma-names = "rx", "tx";
> +				};
> +				ssiu97: ssiu-51 {
> +					dmas = <&audma0 0xA9>, <&audma1 0xAA>;
> +					dma-names = "rx", "tx";
> +				};
> +			};
> +
>  			rcar_sound,ssi {
>  				ssi0: ssi-0 {
>  					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.7.4
> 
