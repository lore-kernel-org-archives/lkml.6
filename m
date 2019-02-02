Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C346C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD93320869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549127156;
	bh=ltdsQ97rX+B1cAZdXPDtI7ROMUaekFX/HBtjwDFyJUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NEcyJmMbMiDEyETyatBYxWTARjU9Q+GYBoG4vbJjYlpdg0aNH+cLw5XWgB+yel/Ep
	 iaAJ+Ky5sSXn+9JNwguCel32yaKdX/jcPHnEER/Uime6P6DZhweP3H/5j8Zu20iNLU
	 ktg3ndMrIq5/OF7m3jHkJTAWwearAjeaYq4HjQVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfBBRFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:05:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2923420856;
        Sat,  2 Feb 2019 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549127153;
        bh=ltdsQ97rX+B1cAZdXPDtI7ROMUaekFX/HBtjwDFyJUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TD66Z1cXjxn+NQI5OEPfsBVDiLbSRxn1Uow9XICQtLuL+i3hFFgnTjs2vD/u1Uobq
         7g48FMQ80VV3/PsLGoVMOQMKrZFy0uQMaFel0KYPM0lGv0xwQDIaZpMdbbo/8xuDxG
         WQwtUVL/2FN7+rPM7uA/A+FuC83L0ZkjIzZ4V6po=
Date:   Sat, 2 Feb 2019 17:05:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <biabeniamin@outlook.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Beniamin Bia <biabeniamin@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH v2 1/2] staging: iio: frequency: ad9833: Get frequency
 value statically
Message-ID: <20190202170547.586078d7@archlinux>
In-Reply-To: <20190201150138.31481-1-biabeniamin@outlook.com>
References: <20190201150138.31481-1-biabeniamin@outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 17:01:37 +0200
Beniamin Bia <biabeniamin@outlook.com> wrote:

> From: Beniamin Bia <biabeniamin@gmail.com>
> 
> The values from platform data were replaced by statically values.
> This was just a intermediate step of taking this driver out of staging and
> load data from device tree.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
>         - The platform data structure was removed and the values are
>           written directly
>  drivers/staging/iio/frequency/ad9834.c | 21 +++++++------------
>  drivers/staging/iio/frequency/ad9834.h | 28 --------------------------
>  2 files changed, 7 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 995acdd7c942..f4f5eaa15e30 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -391,16 +391,11 @@ static const struct iio_info ad9833_info = {
>  
>  static int ad9834_probe(struct spi_device *spi)
>  {
> -	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad9834_state *st;
>  	struct iio_dev *indio_dev;
>  	struct regulator *reg;
>  	int ret;
>  
> -	if (!pdata) {
> -		dev_dbg(&spi->dev, "no platform data?\n");
> -		return -ENODEV;
> -	}
>  
>  	reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(reg))
> @@ -420,7 +415,7 @@ static int ad9834_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
> -	st->mclk = pdata->mclk;
> +	st->mclk = 25000000;
>  	st->spi = spi;
>  	st->devid = spi_get_device_id(spi)->driver_data;
>  	st->reg = reg;
> @@ -456,11 +451,9 @@ static int ad9834_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->freq_xfer[1], &st->freq_msg);
>  
>  	st->control = AD9834_B28 | AD9834_RESET;
> +	st->control |= AD9834_DIV2;
>  
> -	if (!pdata->en_div2)
> -		st->control |= AD9834_DIV2;
> -
> -	if (!pdata->en_signbit_msb_out && (st->devid == ID_AD9834))
> +	if (st->devid == ID_AD9834)
>  		st->control |= AD9834_SIGN_PIB;
>  
>  	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> @@ -470,19 +463,19 @@ static int ad9834_probe(struct spi_device *spi)
>  		goto error_disable_reg;
>  	}
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, pdata->freq0);
> +	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, pdata->freq1);
> +	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, pdata->phase0);
> +	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, pdata->phase1);
> +	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
>  	if (ret)
>  		goto error_disable_reg;
>  
> diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
> index ae620f38eb49..da7e83ceedad 100644
> --- a/drivers/staging/iio/frequency/ad9834.h
> +++ b/drivers/staging/iio/frequency/ad9834.h
> @@ -8,32 +8,4 @@
>  #ifndef IIO_DDS_AD9834_H_
>  #define IIO_DDS_AD9834_H_
>  
> -/*
> - * TODO: struct ad7887_platform_data needs to go into include/linux/iio
> - */
> -
> -/**
> - * struct ad9834_platform_data - platform specific information
> - * @mclk:		master clock in Hz
> - * @freq0:		power up freq0 tuning word in Hz
> - * @freq1:		power up freq1 tuning word in Hz
> - * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
> - * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
> - * @en_div2:		digital output/2 is passed to the SIGN BIT OUT pin
> - * @en_signbit_msb_out:	the MSB (or MSB/2) of the DAC data is connected to the
> - *			SIGN BIT OUT pin. en_div2 controls whether it is the MSB
> - *			or MSB/2 that is output. if en_signbit_msb_out=false,
> - *			the on-board comparator is connected to SIGN BIT OUT
> - */
> -
> -struct ad9834_platform_data {
> -	unsigned int		mclk;
> -	unsigned int		freq0;
> -	unsigned int		freq1;
> -	unsigned short		phase0;
> -	unsigned short		phase1;
> -	bool			en_div2;
> -	bool			en_signbit_msb_out;
> -};
> -
>  #endif /* IIO_DDS_AD9834_H_ */

