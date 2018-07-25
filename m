Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03243C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A968A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A968A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeGYJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:21:34 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:41362 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:21:34 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991808AbeGYILAN4emg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Wed, 25 Jul 2018 10:11:00 +0200
Date:   Wed, 25 Jul 2018 10:10:59 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek Belisko <marek@goldelico.com>,
        =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 10/32] ARM: dts: omap3-gta04: update gpmc NAND setup
Message-ID: <20180725081058.GB7467@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <effe8969751cde3a3cd7993aa66c839493af9dd1.1532501910.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effe8969751cde3a3cd7993aa66c839493af9dd1.1532501910.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:58:42AM +0200, H. Nikolaus Schaller wrote:
> to better match omap3-beagle.dts (which was the basis
> of designing the GTA04).
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 03fe404cbf56..9568e0c4d4bf 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -616,27 +616,27 @@
>  		interrupt-parent = <&gpmc>;
>  		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>  			     <1 IRQ_TYPE_NONE>;	/* termcount */
> +		ti,nand-ecc-opt = "ham1";
> +		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
>  		nand-bus-width = <16>;
> -		ti,nand-ecc-opt = "bch8";

You are using weeker ECC scheme just to be compatible with another machine?
So now you cannot boot already deployed filesystem... Also is it enough for
NAND chip used?

	ladis

> +		#address-cells = <1>;
> +		#size-cells = <1>;
>  
> -		gpmc,sync-clk-ps = <0>;
> +		gpmc,device-width = <2>;
>  		gpmc,cs-on-ns = <0>;
>  		gpmc,cs-rd-off-ns = <44>;
>  		gpmc,cs-wr-off-ns = <44>;
>  		gpmc,adv-on-ns = <6>;
>  		gpmc,adv-rd-off-ns = <34>;
>  		gpmc,adv-wr-off-ns = <44>;
> -		gpmc,we-off-ns = <40>;
>  		gpmc,oe-off-ns = <54>;
> +		gpmc,we-off-ns = <40>;
>  		gpmc,access-ns = <64>;
>  		gpmc,rd-cycle-ns = <82>;
>  		gpmc,wr-cycle-ns = <82>;
>  		gpmc,wr-access-ns = <40>;
>  		gpmc,wr-data-mux-bus-ns = <0>;
> -		gpmc,device-width = <2>;
> -
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> +		gpmc,sync-clk-ps = <0>;
>  
>  		x-loader@0 {
>  			label = "X-Loader";
> -- 
> 2.12.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
