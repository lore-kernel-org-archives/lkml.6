Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E2CC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CCE21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544957208;
	bh=0Bti6L9Z8AwF8FpU9Nxr2tOrnMmZSMVhY8iPqSsS6/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iXJXWMbgCKUXYZTu1oroDaPelwuQ6PCEEL3oEE8Go39zwfnNasbWiFU4j61VLgvjL
	 LOLkmhyerSGJ5/cN1231YoEya+v4PitDCR/heT3z+R3z7mkhy+Cy+NKbjdX49mM8cB
	 s4rJ+LKlkGbm2DNUmYgu9cmy3RWgBvDTlus3TTE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeLPKqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbeLPKqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:46:47 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE3822086C;
        Sun, 16 Dec 2018 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544957205;
        bh=0Bti6L9Z8AwF8FpU9Nxr2tOrnMmZSMVhY8iPqSsS6/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XJnJ6RaeBG6g9d40iYHw+XvZqILTfi0N1PhwbXjC4DAJstzXeGA6Iiy39HuP4gonO
         LuiV330Rc4f5fIr8Wnni3oNvRpW2ioAddqiYd011D4fDqt/b+3JOrUDuNxUgWheml/
         20xSaUc9BZLUHeotMQzKneuUc56LtdwbftvLrOhU=
Date:   Sun, 16 Dec 2018 10:46:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 2/2] iio: accell: mma8452: add optional vdd/vddio
 regulator operation support
Message-ID: <20181216104639.00bb90b6@archlinux>
In-Reply-To: <1544504839-10958-2-git-send-email-Anson.Huang@nxp.com>
References: <1544504839-10958-1-git-send-email-Anson.Huang@nxp.com>
        <1544504839-10958-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 05:13:20 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The accelerometer's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the mma8451's
> power supply is controlled by a GPIO fixed regulator, need to make
> sure the regulator is enabled before any communication with mma8451,
> this patch adds optional vdd/vddio regulator operation support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Martin Kepplinger <martink@posteo.de>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> ChangeLog since V3:
> 	- add disabling vdd regulator in vddio error path;
> 	- improve regulator enable/disable sequence.
> ---
>  drivers/iio/accel/mma8452.c | 186 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 176 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 421a0a8..590a95d 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -31,6 +31,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -107,6 +108,8 @@ struct mma8452_data {
>  	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
>  	int sleep_val;
> +	struct regulator *vdd_reg;
> +	struct regulator *vddio_reg;
>  };
>  
>   /**
> @@ -1533,10 +1536,35 @@ static int mma8452_probe(struct i2c_client *client,
>  	data->client = client;
>  	mutex_init(&data->lock);
>  	data->chip_info = match->data;
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
>  
>  	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_regulators;
>  
>  	switch (ret) {
>  	case MMA8451_DEVICE_ID:
> @@ -1549,7 +1577,8 @@ static int mma8452_probe(struct i2c_client *client,
>  			break;
>  		/* else: fall through */
>  	default:
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto disable_regulators;
>  	}
>  
>  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
> @@ -1566,13 +1595,13 @@ static int mma8452_probe(struct i2c_client *client,
>  
>  	ret = mma8452_reset(client);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_regulators;
>  
>  	data->data_cfg = MMA8452_DATA_CFG_FS_2G;
>  	ret = i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
>  					data->data_cfg);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_regulators;
>  
>  	/*
>  	 * By default set transient threshold to max to avoid events if
> @@ -1581,7 +1610,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	ret = i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
>  					MMA8452_TRANSIENT_THS_MASK);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_regulators;
>  
>  	if (client->irq) {
>  		int irq2;
> @@ -1595,7 +1624,7 @@ static int mma8452_probe(struct i2c_client *client,
>  						MMA8452_CTRL_REG5,
>  						data->chip_info->all_events);
>  			if (ret < 0)
> -				return ret;
> +				goto disable_regulators;
>  
>  			dev_dbg(&client->dev, "using interrupt line INT1\n");
>  		}
> @@ -1604,11 +1633,11 @@ static int mma8452_probe(struct i2c_client *client,
>  					MMA8452_CTRL_REG4,
>  					data->chip_info->enabled_events);
>  		if (ret < 0)
> -			return ret;
> +			goto disable_regulators;
>  
>  		ret = mma8452_trigger_setup(indio_dev);
>  		if (ret < 0)
> -			return ret;
> +			goto disable_regulators;
>  	}
>  
>  	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
> @@ -1661,12 +1690,22 @@ static int mma8452_probe(struct i2c_client *client,
>  trigger_cleanup:
>  	mma8452_trigger_cleanup(indio_dev);
>  
> +disable_regulators:
> +	if (!IS_ERR(data->vddio_reg))
> +		regulator_disable(data->vddio_reg);
> +
> +disable_regulator_vdd:
> +	if (!IS_ERR(data->vdd_reg))
> +		regulator_disable(data->vdd_reg);
> +
>  	return ret;
>  }
>  
>  static int mma8452_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
>  
>  	iio_device_unregister(indio_dev);
>  
> @@ -1678,6 +1717,21 @@ static int mma8452_remove(struct i2c_client *client)
>  	mma8452_trigger_cleanup(indio_dev);
>  	mma8452_standby(iio_priv(indio_dev));
>  
> +	if (!IS_ERR(data->vddio_reg)) {
> +		ret = regulator_disable(data->vddio_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to disable VDDIO regulator\n");
> +			return ret;
> +		}
> +	}
> +	if (!IS_ERR(data->vdd_reg)) {
> +		ret = regulator_disable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to disable VDD regulator\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1696,6 +1750,21 @@ static int mma8452_runtime_suspend(struct device *dev)
>  		return -EAGAIN;
>  	}
>  
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
>  	return 0;
>  }
>  
> @@ -1705,6 +1774,23 @@ static int mma8452_runtime_resume(struct device *dev)
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret, sleep_val;
>  
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
> +
>  	ret = mma8452_active(data);
>  	if (ret < 0)
>  		return ret;
> @@ -1723,14 +1809,94 @@ static int mma8452_runtime_resume(struct device *dev)
>  #ifdef CONFIG_PM_SLEEP
>  static int mma8452_suspend(struct device *dev)
>  {
> -	return mma8452_standby(iio_priv(i2c_get_clientdata(
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mma8452_data *data = iio_priv(indio_dev);
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
> +
> +	ret = mma8452_standby(iio_priv(i2c_get_clientdata(
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
>  static int mma8452_resume(struct device *dev)
>  {
> -	return mma8452_active(iio_priv(i2c_get_clientdata(
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mma8452_data *data = iio_priv(indio_dev);
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
> +
> +	ret = mma8452_active(iio_priv(i2c_get_clientdata(
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
>  #endif
>  

