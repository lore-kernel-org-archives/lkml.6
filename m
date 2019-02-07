Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3326AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D6321908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="fEeev61H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBGPNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:13:10 -0500
Received: from plaes.org ([188.166.43.21]:57832 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBGPNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:13:10 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id DE87940354;
        Thu,  7 Feb 2019 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1549552387; bh=tckvz0Scm9xOwUcXteZ8DyWxyS+qroECcDEjDflYUPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEeev61HXSNF8Gu0QvIhQcIpoTyuBNmtlgqPgQdbUbHkTNXCXfuwoNKxiIyfovOyg
         CnN0d4AQ+bYVp5GF1PxNCJdoB3LTG9WDoz4fu/FcjV3ynHWrWJ0xu1vXluv2fO6eDo
         MbC0JU7R/W+V/C9GzatyJABT+g6HDhTN7F08UBgeq0LD1BWe66i52NlKS0dDm6NEJZ
         C80mUdN2Zkgfj1TrfqGrl8CMbRetsUW8mSrs7XzLPYbEUONpPjRlyKMcyzojI8gFyx
         tn4lW2LlTxOObcMcvIdrLDL3W9FpSTgkaLzXWv33qDoBoWfntCvERRCLI80pQJw6mT
         liznSxG6Zcehw==
Date:   Thu, 7 Feb 2019 15:13:06 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] [RFT PATCH 7/9] mfd: axp20x: add USB power supply
 mfd cell to AXP813
Message-ID: <20190207151306.lyjcwyllshwm4o6q@plaes.org>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207064535.9226-8-wens@csie.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:45:33PM +0800, Chen-Yu Tsai wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> supports this variant, we can add an mfd cell for it to use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> [wens@csie.org: add commit message]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3c97f2c0fdfe..17b115845993 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>  };
>  
> +/* AXP803 and AXP813/AXP818 share the same interrupts */
> +static struct resource axp803_usb_power_supply_resources[] = {

const, if possible?

> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  static const struct resource axp22x_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -793,6 +799,11 @@ static const struct mfd_cell axp813_cells[] = {
>  		.of_compatible	= "x-powers,axp813-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>  		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp803_usb_power_supply_resources),
> +		.resources	= axp803_usb_power_supply_resources,
> +		.of_compatible	= "x-powers,axp813-usb-power-supply",
>  	},
>  };
>  
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
