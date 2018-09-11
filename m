Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965CEC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A13520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l73kLyqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A13520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIKV6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:58:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37466 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeIKV6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:58:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so12535167pfd.4;
        Tue, 11 Sep 2018 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aVguGNc5xs4xr4vSEMVddQFl02FCRLig2KgqUuY82oo=;
        b=l73kLyqvhDcQmjNUQGxDtDGOYB9LTTGObHeWEq8cyLTQMVshLUhnCti1Xk2UUewzET
         OaDVdqmtcBKqzfVIJkzneFHik+GTriK/nOq3GpTJMzCexlJJyeMvlYcBAzYqkGeYk0xe
         MTfHqda4cykuzFJd5OZfYTaUEXRjkckqqNvilYn3aBT/6dA3vXL3+WjbivGZWM303owS
         ETuP4AGcA2Wfr5cTGDBFV5n78mwAOIy/LX2GNA/kqGiIjl3RD56A7OZ40y6OmYSx59My
         t/LKPUPNcG2vfLxCT5ew1AOa2ma/6tjABzdd/3nPggA+KWnAxlb1G3LcXpCG5syvSNDP
         VBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVguGNc5xs4xr4vSEMVddQFl02FCRLig2KgqUuY82oo=;
        b=GRaIE/Q6rICVPCJqTIfOhOcQ4JmfZhT9ShDXiFGco0OND4Qu9nzGKQ7KqVlYGMhtlc
         3dKjdDQYgaEEpBTJzv3VKu8ByLloYn1mZyG/k3BDGBqpRyM2rWF46QffZfwdKmI67+Gd
         dDXHymGoz9G/KWSZqnB/TmStlRmxflfQqVdMC2w2pV+pKGbr6UsBOJ9xOESUEapoKyFX
         mj8K0jp8U7dw/NUtdLGcdQppwRI/N/XGDOlp7CzAg3kSR58VIfd4OYvb78Mqt46VTvY9
         UCr5e7ulFR5zG80M/1JkV9KxFpX/gQRn3IweyIgtH3aERfcx7XT322IRi8JqteizjB0h
         iP1Q==
X-Gm-Message-State: APzg51Czt+qQh1wdZTWNM0CXgiL/9FE+R20F59jQCu93AmerCgsYRLWB
        akbZlYe1W+tI+IUCVir8N8Q=
X-Google-Smtp-Source: ANB0Vdbn4Q/B58jw8uPJomIUPVVTrkyfkM1vAjXGb/gd8khDsNlAS/4CWN/E/cSXRULtAEoWQwJrcg==
X-Received: by 2002:a63:5143:: with SMTP id r3-v6mr29535698pgl.11.1536685068364;
        Tue, 11 Sep 2018 09:57:48 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id n83-v6sm36377322pfk.19.2018.09.11.09.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:57:47 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
Date:   Wed, 12 Sep 2018 00:57:39 +0800
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, robh@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180911165739.GA14524@Eros>
References: <20180911075357.8187-1-songqiang.1304521@gmail.com>
 <20180911160300.GA9212@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911160300.GA9212@himanshu-Vostro-3559>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:33:00PM +0530, Himanshu Jha wrote:
> Hi Song,
> 
> On Tue, Sep 11, 2018 at 03:53:57PM +0800, Song Qiang wrote:
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into a iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > This version of driver supports only one-shot mode, and it can be
> > tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > 
> > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> > ---
> >  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
> >  drivers/iio/proximity/Kconfig                 |  11 +
> >  drivers/iio/proximity/Makefile                |   2 +
> >  drivers/iio/proximity/vl53l0x-i2c.c           | 196 ++++++++++++++++++
> >  4 files changed, 221 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> >  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > new file mode 100644
> > index 000000000000..64b69442f08e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > @@ -0,0 +1,12 @@
> > +ST's VL53L0X ToF ranging sensor
> > +
> > +Required properties:
> > +	- compatible: must be "st,vl53l0x-i2c"
> > +	- reg: i2c address where to find the device
> > +
> > +Example:
> > +
> > +vl53l0x@29 {
> > +	compatible = "st,vl53l0x-i2c";
> > +	reg = <0x29>;
> > +};
> > diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> > index f726f9427602..5f421cbd37f3 100644
> > --- a/drivers/iio/proximity/Kconfig
> > +++ b/drivers/iio/proximity/Kconfig
> > @@ -79,4 +79,15 @@ config SRF08
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called srf08.
> >  
> > +config VL53L0X_I2C
> > +	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
> > +	depends on I2C
> > +	help
> > +	  Say Y here to build a driver for STMicroelectronics VL53L0X
> > +	  ToF ranger sensors with i2c interface.
> > +	  This driver can be used to measure the distance of objects.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called vl53l0x-i2c.
> > +
> >  endmenu
> > diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> > index 4f4ed45e87ef..dedfb5bf3475 100644
> > --- a/drivers/iio/proximity/Makefile
> > +++ b/drivers/iio/proximity/Makefile
> > @@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
> >  obj-$(CONFIG_SRF04)		+= srf04.o
> >  obj-$(CONFIG_SRF08)		+= srf08.o
> >  obj-$(CONFIG_SX9500)		+= sx9500.o
> > +obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> > +
> > diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> > new file mode 100644
> > index 000000000000..4eac40353494
> > --- /dev/null
> > +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + *  Support for ST's VL53L0X FlightSense ToF Ranger Sensor on a i2c bus.
> > + *
> > + *  Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
> > + *
> 
> Andy suggested to remove this emty line and not ST copyright.
> 
> So, be careful or .... "Better Call Saul" ;)
> 

Hi Himanshu,

Sorry for that, this is so embarrassing. I will be more carefull with
things I'm not very sure...

> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +
> > +#define VL53L0X_DRV_NAME				"vl53l0x-i2c"
> > +
> > +#define VL_REG_SYSRANGE_START				0x00
> > +#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
> > +#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
> > +#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
> > +#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
> > +#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
> > +#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
> > +
> > +#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
> > +#define VL_REG_SYS_RANGE_CFG				0x09
> > +#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
> > +
> > +#define VL_REG_SYS_INT_CFG_GPIO				0x0A
> > +#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
> > +#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
> > +#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
> > +#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
> > +#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
> > +#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
> > +#define VL_REG_SYS_INT_CLEAR				0x0B
> > +
> > +#define VL_REG_RESULT_INT_STATUS			0x13
> > +#define VL_REG_RESULT_RANGE_STATUS			0x14
> > +#define VL_REG_RESULT_RANGE_SATTUS_COMPLETE		BIT(0)
> > +
> > +#define VL_REG_I2C_SLAVE_DEVICE_ADDRESS			0x8a
> > +
> > +#define VL_REG_IDENTIFICATION_MODEL_ID			0xc0
> > +#define VL_REG_IDENTIFICATION_REVISION_ID		0xc2
> > +
> > +struct vl53l0x_data {
> > +	struct i2c_client *client;
> > +	struct iio_dev *indio_dev;
> 
> This is not required in this private struct.
> Not sure though...
> 

There was some code related to this when I was using printk to test,
I'll remove it. 

> > +};
> > +
> > +static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> > +				  const struct iio_chan_spec *chan,
> > +				  int *val)
> > +{
> > +	u8 write_command = VL_REG_RESULT_RANGE_STATUS;
> > +	struct i2c_client *client = data->client;
> > +	unsigned int tries = 20;
> > +	struct i2c_msg msg[2];
> > +	u8 buffer[12];
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client,
> > +					VL_REG_SYSRANGE_START, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	do {
> > +		ret = i2c_smbus_read_byte_data(data->client,
> > +					       VL_REG_RESULT_RANGE_STATUS);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (ret & VL_REG_RESULT_RANGE_SATTUS_COMPLETE)
> > +			break;
> > +
> > +		usleep_range(1000, 5000);
> > +	} while (tries--);
> > +	if (!tries)
> > +		return -ETIMEDOUT;
> > +
> > +	msg[0].addr = client->addr;
> > +	msg[0].buf = &write_command;
> > +	msg[0].len = 1;
> > +	msg[0].flags = client->flags | I2C_M_STOP;
> > +
> > +	msg[1].addr = client->addr;
> > +	msg[1].buf = buffer;
> > +	msg[1].len = 12;
> > +	msg[1].flags = client->flags | I2C_M_RD;
> > +
> > +	ret = i2c_transfer(client->adapter, msg, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +	else if (ret != 2)
> > +		dev_err(&data->client->dev, "vl53l0x: consecutively read error. ");
> > +
> > +	*val = __le16_to_cpu((buffer[10] << 8) + buffer[11]);
> 
> IIRC  __le/be _* shouldn't be directly used and instead use
> le16_to_cpu(). Let it decide the byte order unwrapping to
> be done.
> 

I'll replace it.

> > +	return 0;
> > +}
> > +
> > +static const struct iio_chan_spec vl53l0x_channels[] = {
> > +	{
> > +		.type = IIO_DISTANCE,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> > +static int vl53l0x_read_raw(struct iio_dev *indio_dev,
> > +			    const struct iio_chan_spec *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct vl53l0x_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (chan->type != IIO_DISTANCE) {
> > +		dev_err(&data->client->dev, "vl53l0x: iio type error");
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> 
> You don't have any other buffer/trigger support for now and I believe
> there is no need to claim direct mode.
> 

Yep, I'll clean it up.

> > +		if (ret)
> > +			return ret;
> > +		ret = vl53l0x_read_proximity(data, chan, val);
> > +		if (ret < 0)
> > +			dev_err(&data->client->dev,
> > +				"vl53l0x: raw value read error with %d", ret);
> > +
> > +		ret = IIO_VAL_INT;
> > +		iio_device_release_direct_mode(indio_dev);
> > +		return ret;
> > +	default:
> > +		dev_err(&data->client->dev, "vl53l0x: IIO_CHAN_* not recognzed.");
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info vl53l0x_info = {
> > +	.read_raw = vl53l0x_read_raw,
> > +};
> > +
> > +static int vl53l0x_probe(struct i2c_client *client)
> > +{
> > +	struct vl53l0x_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +	data->indio_dev = indio_dev;
> 
> Is this required ?
> 

You're right, not required.

> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_I2C))
> > +		return -EOPNOTSUPP;
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->name = VL53L0X_DRV_NAME;
> > +	indio_dev->info = &vl53l0x_info;
> > +	indio_dev->channels = vl53l0x_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = devm_iio_device_register(&client->dev, indio_dev);
> 
> 	return devm_iio_device_register(&client->dev, indio_dev);
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Do you have the sensor and are these patches tested ?
> Just curious!

Yes, I have some of this sensors and they are working very well and we have
already put it into one of our products. But we are using it with STM32,
a cortex-M controller, and that's not hard to programm. While one of our
teachers attended a meeting in Italy last month, and this sensor was
presented by some folks, saying that it's still a very good option for
ranging detections. Since my major is about linux, I wanted to use it on
linux, then I found out the poor ST support. The latest driver for this
device is in 2016 for kernel 3.10 as I remember, and as a misc input device
driver as I mentioned when the first time I was submitting this patch. So
this is also the first time of me submitting a real device driver rather than
some document issues. :)
Everytime I change lines in this code I rebuild it and test it on my
personal cortex-A8 development board with kernel v4.18.5 on it, even
for the coding style changes. After all, I'm not going to submit
something useless and waiting for blames to come. I know I'm responsible for
it.

Thanks for you and Andy pointing out the problems in my patch. I think
me and my patches will be better and better with your helps. And hopefully
someday this patch can be merged so me and some people can use this sensor
in mainline kernels. :)

> 
> Thanks
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology

yours,
Song Qiang
