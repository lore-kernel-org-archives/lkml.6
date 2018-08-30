Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7445C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="JCEnMzuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeH3UjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:39:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:35568 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbeH3UjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:39:10 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2018 16:39:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1535646455; bh=IUGMse/Y2LeSxpVGAb4llLpnSL7MSEBRRTNeAb6thJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCEnMzuFKyG8u5CzStKLnTmE0peXaunHTt/w/CZp0aoRg8VJvikFo84UmbD41SAcS
         eWNrZ9XTSlaHPC7J2fw3X+JG9WOdYJ7WwDytSBUBo104TAm4JMrtVXWqgtcyMXp2wT
         4e0WKE9hJDXJLfGjoRUBkhrdm2EPtzXZPNmcqVF0=
Date:   Thu, 30 Aug 2018 18:27:34 +0200
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
Subject: Re: [linux-sunxi] [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
Message-ID: <20180830162734.uq65l6ox6uwrmulo@core>
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
 <20180830154518.29507-22-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-22-embed3d@gmail.com>
If-You-Cant-Reach-Me-Try: <https://megous.com/mail-form>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 05:45:09PM +0200, Philipp Rossak wrote:
> This patch adds support for the H3 ths sensor.
> 
> The H3 supports interrupts. The interrupt is configured to update the
> the sensor values every second. The calibration data is writen at the
> begin of the init process.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c   | 91 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/adc/sun4i-gpadc.h | 18 ++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index c7b46c82e3e5..d5c7971b2558 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -72,6 +72,7 @@ struct gpadc_data {
>  	u32		temp_data_base;
>  	int		sensor_count;
>  	bool		supports_nvmem;
> +	u32		ths_irq_clear;
>  };
>  
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -79,6 +80,10 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
>  static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
>  static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
>  
> +static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info);
> +static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info);
> +static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data);
> +
>  static const struct gpadc_data sun4i_gpadc_data = {
>  	.temp_offset = -1932,
>  	.temp_scale = 133,
> @@ -137,6 +142,22 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.sensor_count = 1,
>  };
>  
> +static const struct gpadc_data sun8i_h3_ths_data = {
> +	.temp_offset = -1791,
> +	.temp_scale = -121,
> +	.temp_data_base = SUN8I_H3_THS_TDATA0,
> +	.ths_irq_thread = sunx8i_h3_irq_thread,
> +	.support_irq = true,
> +	.has_bus_clk = true,
> +	.has_bus_rst = true,
> +	.has_mod_clk = true,
> +	.sensor_count = 1,
> +	.supports_nvmem = true,
> +	.ths_resume = sun8i_h3_ths_resume,
> +	.ths_suspend = sun8i_h3_ths_suspend,
> +	.ths_irq_clear = SUN8I_H3_THS_INTS_TDATA_IRQ_0,
> +};
> +
>  struct sun4i_sensor_tzd {
>  	struct sun4i_gpadc_iio		*info;
>  	struct thermal_zone_device	*tzd;
> @@ -409,6 +430,31 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data)
> +{
> +	struct sun4i_gpadc_iio *info = data;
> +	int i;
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> +			info->data->ths_irq_clear);
> +
> +	for (i = 0; i < info->data->sensor_count; i++)
> +		thermal_zone_device_update(info->tzds[i].tzd,
> +						THERMAL_EVENT_TEMP_SAMPLE);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
> +{
> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
> +//			info->calibration_data[0]);
> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
> +//			info->calibration_data[1]);

This should probably be implemented, or left out completely.

regards,
  o.

> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
> @@ -428,6 +474,16 @@ static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
>  	return 0;
>  }
>  
> +static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info)
> +{
> +	/* Disable ths interrupt */
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
> +	/* Disable temperature sensor */
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_resume(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
> @@ -454,6 +510,37 @@ static int sun4i_ths_resume(struct sun4i_gpadc_iio *info)
>  	return 0;
>  }
>  
> +static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info)
> +{
> +	u32 value;
> +
> +	sun8i_h3_calibrate(info);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
> +			SUN4I_GPADC_CTRL0_T_ACQ(0xff));
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> +			SUN8I_H3_THS_ACQ1(0x3f));
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
> +			SUN4I_GPADC_CTRL3_FILTER_EN |
> +			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
> +			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
> +			SUN8I_H3_THS_TEMP_PERIOD(0x55));
> +
> +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> +			SUN8I_H3_THS_TEMP_SENSE_EN0 | value);
> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_get_temp(void *data, int *temp)
>  {
>  	struct sun4i_sensor_tzd *tzd = data;
> @@ -497,6 +584,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
>  		.compatible = "allwinner,sun6i-a31-gpadc",
>  		.data = &sun6i_gpadc_data
>  	},
> +	{
> +		.compatible = "allwinner,sun8i-h3-ths",
> +		.data = &sun8i_h3_ths_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  
> diff --git a/include/linux/iio/adc/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
> index 99feeba28105..169b4de9a34d 100644
> --- a/include/linux/iio/adc/sun4i-gpadc.h
> +++ b/include/linux/iio/adc/sun4i-gpadc.h
> @@ -100,6 +100,24 @@
>  }
>  
>  /* SUNXI_THS COMMON REGISTERS + DEFINES */
> +#define SUN8I_H3_THS_CTRL0				0x00
> +
> +#define SUN8I_H3_THS_CTRL2				0x40
> +#define SUN8I_H3_THS_ACQ1(x)			(GENMASK(31, 16) & ((x) << 16))
> +#define SUN8I_H3_THS_TEMP_SENSE_EN0			BIT(0)
> +
> +#define SUN8I_H3_THS_INTC				0x44
> +#define SUN8I_H3_THS_TEMP_PERIOD(x)		(GENMASK(31, 12) & ((x) << 12))
> +#define SUN8I_H3_THS_INTC_TDATA_IRQ_EN0			BIT(8)
> +
> +#define SUN8I_H3_THS_STAT				0x48
> +#define SUN8I_H3_THS_INTS_TDATA_IRQ_0			BIT(8)
> +
> +#define SUN8I_H3_THS_FILTER				0x70
> +#define SUNXI_THS_CDATA_0_1				0x74
> +#define SUNXI_THS_CDATA_2_3				0x78
> +#define SUN8I_H3_THS_TDATA0				0x80
> +
>  #define MAX_SENSOR_COUNT				4
>  
>  #endif
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
