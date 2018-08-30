Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9FAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EDA20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="YG/q4GFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EDA20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeH3UnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:43:20 -0400
Received: from vps.xff.cz ([195.181.215.36]:35696 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbeH3UnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1535647218; bh=h4ibOMxQl4CVlR0QB3eMgqhl7VypoEdSb9ku3ReK7vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YG/q4GFLmz0fhj/WJzkR/JmEFfaJS/Qp1L36sUcuHVMCn/gmTqMCi7rdSxX0lOlnC
         OLDWajbBRdgtDGsCcO6qkK9XknFI31Gr4v4dD9dm+CmjTaA++9Ajf8v/vyKaDtepcZ
         O6syaKdaTNEniYzUhVYA3x5ZWv3YNPgfXlOWTpFI=
Date:   Thu, 30 Aug 2018 18:40:17 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v3 09/30] iio: adc: Threat A33 as thermal
 sensor and remove non thermal sun4i channel
Message-ID: <20180830164017.n7rcxcy2jj4mijpr@core>
Mail-Followup-To: Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de, broonie@kernel.org,
        arnaud.pouliquen@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-10-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-10-embed3d@gmail.com>
If-You-Cant-Reach-Me-Try: <https://megous.com/mail-form>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:44:57PM +0200, Philipp Rossak wrote:
> We want to use this driver mostly as thermal sensor, that still supports
> the adc for the older chips, thus we threat the A33 as thermal sensor.
> We also remove the adc channel without thermal support.

Threat -> treat (in the title and in the message body too)

> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index ab474ce86fb6..658a7e3e3370 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -123,23 +123,6 @@ static const struct iio_chan_spec sun4i_gpadc_channels[] = {
>  	},
>  };
>  
> -static const struct iio_chan_spec sun4i_gpadc_channels_no_temp[] = {
> -	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
> -	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
> -	SUN4I_GPADC_ADC_CHANNEL(2, "adc_chan2"),
> -	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
> -};
> -
> -static const struct iio_chan_spec sun8i_a33_gpadc_channels[] = {
> -	{
> -		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				      BIT(IIO_CHAN_INFO_SCALE) |
> -				      BIT(IIO_CHAN_INFO_OFFSET),
> -		.datasheet_name = "temp_adc",
> -	},
> -};
> -
>  static const struct regmap_config sun4i_gpadc_regmap_config = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
> @@ -444,8 +427,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  		return -ENODEV;
>  
>  	info->no_irq = true;
> -	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
> -	indio_dev->channels = sun8i_a33_gpadc_channels;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, mem);
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
