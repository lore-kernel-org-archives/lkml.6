Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9392C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B989E21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544962496;
	bh=nV45ih3Fxj/l8uY5JtLA1jU8xDeRSYXLwNtzlg9lV5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pCE36B8YXsUMdCLFuPDaFjxdRrck4WIy1rmknFdqRT5FTT2JZJpxVkFsCH9pamkqJ
	 GtFny9qUJJ9KHNDQEMlX+7NY7MMKNq6klhxTFpIyQRsH8q+x53gcJSdjZtYG059MAR
	 M0S4rzVL6wvjoaiM8/cLsi2/0AgyLFXbRc8QB3/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeLPMOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPMOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:14:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0152086C;
        Sun, 16 Dec 2018 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544962494;
        bh=nV45ih3Fxj/l8uY5JtLA1jU8xDeRSYXLwNtzlg9lV5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E8X79GxV5IRMxPIS7hJ8DeyOcUr2EcIS1roxRnbDa2O9jC/LN47RqiiEDsx+EwP3R
         N2Y8Ydy+3vkLfPH2WYA+mwtL90aoz6ODB00Yb2V8bF54m062diqrf95o6wJntjUF14
         DtKSkfOc1wR96v8GMYePD20ZLcFA7cPetl2LQqLQ=
Date:   Sun, 16 Dec 2018 12:14:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 2/3] staging: iio: ad5933: use clock framework for clock
 reference
Message-ID: <20181216121448.69a11744@archlinux>
In-Reply-To: <2e60aac1f824d421b355e0df8b4a564fb422202b.1544292845.git.marcelo.schmitt1@gmail.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
        <2e60aac1f824d421b355e0df8b4a564fb422202b.1544292845.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 16:19:38 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add the option to specify the external clock (MCLK) using the clock
> framework.
> Also remove the old platform data structure.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 43 ++++++++++---------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 730bc397a26b..3134295f014f 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/clk.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -82,20 +83,10 @@
>  #define AD5933_POLL_TIME_ms		10
>  #define AD5933_INIT_EXCITATION_TIME_ms	100
>  
> -/**
> - * struct ad5933_platform_data - platform specific data
> - * @ext_clk_hz:		the external clock frequency in Hz, if not set
> - *			the driver uses the internal clock (16.776 MHz)
> - * @vref_mv:		the external reference voltage in millivolt
> - */
> -
> -struct ad5933_platform_data {
> -	unsigned long			ext_clk_hz;
> -};
> -
>  struct ad5933_state {
>  	struct i2c_client		*client;
>  	struct regulator		*reg;
> +	struct clk			*mclk;
>  	struct delayed_work		work;
>  	struct mutex			lock; /* Protect sensor state */
>  	unsigned long			mclk_hz;
> @@ -111,9 +102,6 @@ struct ad5933_state {
>  	unsigned int			poll_time_jiffies;
>  };
>  
> -static struct ad5933_platform_data ad5933_default_pdata  = {
> -};
> -
>  #define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
>  		_scan_index, _realbits) { \
>  	.type = (_type), \
> @@ -690,9 +678,9 @@ static int ad5933_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	int ret;
> -	struct ad5933_platform_data *pdata = dev_get_platdata(&client->dev);
>  	struct ad5933_state *st;
>  	struct iio_dev *indio_dev;
> +	unsigned long ext_clk_hz = 0;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -704,9 +692,6 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  	mutex_init(&st->lock);
>  
> -	if (!pdata)
> -		pdata = &ad5933_default_pdata;
> -
>  	st->reg = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(st->reg))
>  		return PTR_ERR(st->reg);
> @@ -723,8 +708,21 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  	st->vref_mv = ret / 1000;
>  
> -	if (pdata->ext_clk_hz) {
> -		st->mclk_hz = pdata->ext_clk_hz;
> +	st->mclk = devm_clk_get(&client->dev, "mclk");
> +	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
> +		ret = PTR_ERR(st->mclk);
> +		goto error_disable_reg;
> +	}
> +
> +	if (!IS_ERR(st->mclk)) {
> +		ret = clk_prepare_enable(st->mclk);
> +		if (ret < 0)
> +			goto error_disable_reg;
> +		ext_clk_hz = clk_get_rate(st->mclk);
> +	}
> +
> +	if (ext_clk_hz) {
> +		st->mclk_hz = ext_clk_hz;
>  		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
>  	} else {
>  		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
> @@ -744,7 +742,7 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  	ret = ad5933_register_ring_funcs_and_init(indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_mclk;
>  
>  	ret = ad5933_setup(st);
>  	if (ret)
> @@ -758,6 +756,8 @@ static int ad5933_probe(struct i2c_client *client,
>  
>  error_unreg_ring:
>  	iio_kfifo_free(indio_dev->buffer);
> +error_disable_mclk:
> +	clk_disable_unprepare(st->mclk);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -772,6 +772,7 @@ static int ad5933_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	iio_kfifo_free(indio_dev->buffer);
>  	regulator_disable(st->reg);
> +	clk_disable_unprepare(st->mclk);
>  
>  	return 0;
>  }

