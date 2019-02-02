Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C86C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A9120869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549127249;
	bh=q/euZewoBMI2znalJw56r1iBo1LaVcAj1xBxz+wGRVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fMfXPqs5ALnVJ7ACGFoD08TinNl0+A1uq1b1ZQJah1jOFv097fbU22Ttb6y3eIRh9
	 YfvWJiNSBLNHTWobea5WTPFelMYPremi0H/cO8ZWXZ0ikuWeok8q9ue7tNq/ipqa/+
	 c+CF+PBXx9v9jpHsOKkiObysbL1JN84qU5Sa3AQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfBBRH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfBBRH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:07:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84FD20856;
        Sat,  2 Feb 2019 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549127246;
        bh=q/euZewoBMI2znalJw56r1iBo1LaVcAj1xBxz+wGRVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xFGzq1a6Lj7/vF0v/W4QGWb523ou0Vsnhm4U9F81jM6cIQLT3dqTJeOFhQADQarD4
         sbp0LLJGEuQHzlAeYO0gcDgOk4jKV3LMgUMzmHz6yKNdL/7rFjFcCPJOPbn3b1x9O/
         Eq3PWHxM/j/urBw7/CSXOjp7aFEmv+4kq8IMPlHA=
Date:   Sat, 2 Feb 2019 17:07:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <biabeniamin@outlook.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Beniamin Bia <biabeniamin@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH v2 2/2] staging: iio: frequency: ad9833: Load clock
 using clock framework
Message-ID: <20190202170720.20dd9e4b@archlinux>
In-Reply-To: <20190201150138.31481-2-biabeniamin@outlook.com>
References: <20190201150138.31481-1-biabeniamin@outlook.com>
        <20190201150138.31481-2-biabeniamin@outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 17:01:38 +0200
Beniamin Bia <biabeniamin@outlook.com> wrote:

> From: Beniamin Bia <biabeniamin@gmail.com>
> 
> The clock frequency is loaded from device-tree using clock framework
> instead of statically value. The change allow configuration of
> the device via device-trees and better initialization sequence.
> This is part of broader effort to add device-tree support to this driver
> and take it out from staging.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>         -the intermidiate clk variable was replaced by the variable in
> 	 device state
>         -st variable may be uninitialized warning was fixed by adding a new
> 	 error label
>  drivers/staging/iio/frequency/ad9834.c | 35 ++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f4f5eaa15e30..f036f75d1f22 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -6,6 +6,7 @@
>   * Licensed under the GPL-2.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/interrupt.h>
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
> @@ -71,7 +72,7 @@
>  struct ad9834_state {
>  	struct spi_device		*spi;
>  	struct regulator		*reg;
> -	unsigned int			mclk;
> +	struct clk			*mclk;
>  	unsigned short			control;
>  	unsigned short			devid;
>  	struct spi_transfer		xfer;
> @@ -110,12 +111,15 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  static int ad9834_write_frequency(struct ad9834_state *st,
>  				  unsigned long addr, unsigned long fout)
>  {
> +	unsigned long clk_freq;
>  	unsigned long regval;
>  
> -	if (fout > (st->mclk / 2))
> +	clk_freq = clk_get_rate(st->mclk);
> +
> +	if (fout > (clk_freq / 2))
>  		return -EINVAL;
>  
> -	regval = ad9834_calc_freqreg(st->mclk, fout);
> +	regval = ad9834_calc_freqreg(clk_freq, fout);
>  
>  	st->freq_data[0] = cpu_to_be16(addr | (regval &
>  				       RES_MASK(AD9834_FREQ_BITS / 2)));
> @@ -415,7 +419,14 @@ static int ad9834_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
> -	st->mclk = 25000000;
> +	st->mclk = devm_clk_get(&spi->dev, NULL);
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable master clock\n");
> +		goto error_disable_reg;
> +	}
> +
>  	st->spi = spi;
>  	st->devid = spi_get_device_id(spi)->driver_data;
>  	st->reg = reg;
> @@ -460,31 +471,32 @@ static int ad9834_probe(struct spi_device *spi)
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret) {
>  		dev_err(&spi->dev, "device init failed\n");
> -		goto error_disable_reg;
> +		goto error_clock_unprepare;
>  	}
>  
>  	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_clock_unprepare;
>  
>  	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_clock_unprepare;
>  
>  	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_clock_unprepare;
>  
>  	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_clock_unprepare;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_clock_unprepare;
>  
>  	return 0;
> -
> +error_clock_unprepare:
> +	clk_disable_unprepare(st->mclk);
>  error_disable_reg:
>  	regulator_disable(reg);
>  
> @@ -497,6 +509,7 @@ static int ad9834_remove(struct spi_device *spi)
>  	struct ad9834_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	clk_disable_unprepare(st->mclk);
>  	regulator_disable(st->reg);
>  
>  	return 0;

