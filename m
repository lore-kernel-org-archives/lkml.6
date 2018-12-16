Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5307C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA10321836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544955573;
	bh=etZPC4UHLixq9MGB2zppWnASy2lHxvC7DvX+H3qfM8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p+hlsASBXaKFZ9VafEb36frtsAftnAEI8cc3QJrBy1yqzyn6hyIv5mhm9nhWnMMjl
	 rpAWuarZO3MNfu4V80TIGPR0sQqsISn/xeaG8SQVt2BnFXqZ8UyUVg8kPv/BMxJfYJ
	 QODfM2OQZZ3RuQDxop/wNnJ+ed6O0Nmzdnh7gVS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeLPKTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbeLPKTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:19:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656A3217FB;
        Sun, 16 Dec 2018 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544955570;
        bh=etZPC4UHLixq9MGB2zppWnASy2lHxvC7DvX+H3qfM8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dJBhz4IoCa2NTPdh+PX8IlSf8vY8IeV0/nqj+fwHQXZu0KsUh7knstMyhKnCAFWu/
         Pe2Z9mAboPs+T8feUVuh0DWhfsRQ+xaZpHF7fNF3x2yPuEw0abXCGEDQS9+tKKKoy5
         KxdmA8AP8ieQc+SFcy+1D+OQhNRcftQ7kOQEfYSI=
Date:   Sun, 16 Dec 2018 10:19:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Message-ID: <20181216101924.3819c916@archlinux>
In-Reply-To: <1544504426-30335-1-git-send-email-Anson.Huang@nxp.com>
References: <1544504426-30335-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 05:06:20 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The magnetometer's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the mag3110's
> power supply is controlled by a GPIO fixed regulator, need to make
> sure the regulator is enabled before any communication with mag3110,
> this patch adds optional vdd/vddio regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

This device currently has documented bindings in trivial-devices.txt
Adding these non trivial elements means that we need to take it out
of there and add a specific binding doc for it.

So please provide a binding doc and drop the entry in trivial-devices.
Remember to cc devicetree list and maintainers for that.

Code looks good, but as we have missed the coming merge window
anyway, we have plenty of time to tidy up those docs.

Thanks,

Jonathan

> ---
> ChangeLog since V3:
> 	- add disabling vdd in vddio error path;
> 	- improve the regulator enable/disable sequence.
> ---
>  drivers/iio/magnetometer/mag3110.c | 96 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 88 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index f063355..328c0c4 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -20,6 +20,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define MAG3110_STATUS 0x00
>  #define MAG3110_OUT_X 0x01 /* MSB first */
> @@ -56,6 +57,8 @@ struct mag3110_data {
>  	struct mutex lock;
>  	u8 ctrl_reg1;
>  	int sleep_val;
> +	struct regulator *vdd_reg;
> +	struct regulator *vddio_reg;
>  };
>  
>  static int mag3110_request(struct mag3110_data *data)
> @@ -469,17 +472,46 @@ static int mag3110_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
> -	if (ret < 0)
> -		return ret;
> -	if (ret != MAG3110_DEVICE_ID)
> -		return -ENODEV;
> -
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +
> +	data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (!IS_ERR(data->vdd_reg)) {
> +		ret = regulator_enable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to enable VDD regulator\n");
> +			return ret;
> +		}
> +	} else {
> +		ret = PTR_ERR(data->vdd_reg);
> +		if (ret != -ENODEV)
> +			return ret;
> +	}
> +
> +	data->vddio_reg = devm_regulator_get_optional(&client->dev, "vddio");
> +	if (!IS_ERR(data->vddio_reg)) {
> +		ret = regulator_enable(data->vddio_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to enable VDDIO regulator\n");
> +			goto disable_regulator_vdd;
> +		}
> +	} else {
> +		ret = PTR_ERR(data->vddio_reg);
> +		if (ret != -ENODEV)
> +			goto disable_regulator_vdd;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
> +	if (ret < 0)
> +		goto disable_regulators;
> +	if (ret != MAG3110_DEVICE_ID) {
> +		ret = -ENODEV;
> +		goto disable_regulators;
> +	}
> +
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> @@ -499,7 +531,7 @@ static int mag3110_probe(struct i2c_client *client,
>  
>  	ret = mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_regulators;
>  
>  	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
>  		MAG3110_CTRL_AUTO_MRST_EN);
> @@ -520,6 +552,13 @@ static int mag3110_probe(struct i2c_client *client,
>  	iio_triggered_buffer_cleanup(indio_dev);
>  standby_on_error:
>  	mag3110_standby(iio_priv(indio_dev));
> +disable_regulators:
> +	if (!IS_ERR(data->vddio_reg))
> +		regulator_disable(data->vddio_reg);
> +disable_regulator_vdd:
> +	if (!IS_ERR(data->vdd_reg))
> +		regulator_disable(data->vdd_reg);
> +
>  	return ret;
>  }
>  
> @@ -537,14 +576,55 @@ static int mag3110_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int mag3110_suspend(struct device *dev)
>  {
> -	return mag3110_standby(iio_priv(i2c_get_clientdata(
> +	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
> +	int ret;
> +
> +	ret = mag3110_standby(iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev))));
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR(data->vddio_reg)) {
> +		ret = regulator_disable(data->vddio_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDDIO regulator\n");
> +			return ret;
> +		}
> +	}
> +	if (!IS_ERR(data->vdd_reg)) {
> +		ret = regulator_disable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDD regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  static int mag3110_resume(struct device *dev)
>  {
>  	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
> +	int ret;
> +
> +	if (!IS_ERR(data->vdd_reg)) {
> +		ret = regulator_enable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to enable VDD regulator\n");
> +			return ret;
> +		}
> +	}
> +	if (!IS_ERR(data->vddio_reg)) {
> +		ret = regulator_enable(data->vddio_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to enable VDDIO regulator\n");
> +			if (!IS_ERR(data->vdd_reg))
> +				regulator_disable(data->vdd_reg);
> +			return ret;
> +		}
> +	}
>  
>  	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
>  		data->ctrl_reg1);

