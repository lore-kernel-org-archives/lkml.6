Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42871ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225F2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcQtaedZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C225F2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIVPLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:11:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44628 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIVPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:11:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so7001275pff.11;
        Sat, 22 Sep 2018 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19h1WQ8OOjk7keeggoPWTicmrHeOSraA9ciwBgGbCNg=;
        b=TcQtaedZz8kXkc0+QmuTTPWwdNvOGZsQpuvMAG3jat3jHn+HtWNhLSOs5+/YA4pxNs
         4qsOVkLtN1SJQjtd8du7vgNsFeQNyxWjZG3W1564/46zyoPHYa99xgXwAo8WWe00/Xwo
         PM3mqtAJdRdy+Bv37dFY/J2JR3PUo2TXkjRqGDq2vD9aiyXBR/70pBDlrcWF8DlQVgOQ
         oIMNOv++Ag0nHwRRgoIaB3hiPcCYQnzP8L4SKFCfAx4sL97SFTEvkbYduQ0BfwLiRmuM
         oh2qHxgin4H7/s18941mJ9p0iW/KAFAmOvBOPxKhZ233uMq7UQwJc3wq1edGQs4QOAa8
         9QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=19h1WQ8OOjk7keeggoPWTicmrHeOSraA9ciwBgGbCNg=;
        b=Dl7d7rw7nlr+pRMHckoOYysPT8sihDnYnk6XgMgkQWquZRTysJZ5603apG5YF03t1i
         EFjlDnuDFdsID8J3gMP0+ehHa3sGVxkYmcGnp8Im2uGXOsz39x4le7KZHULs0KsH80z1
         Z90Ul8fL4QpwA1atd2cGr7MgvXti3dxpXYsKj7ptx7Wfg+cf/2gjj9vyMza2jLSBXhCG
         B6hzOIBs9tnY/4OltHUqQfhZKyYX1jd/dI/OiXaIXlxYu14IxawKg5YWViOHQfhD7S0Y
         +EFGHX9y6RGjupFZLNmqrWrRfygqpnpaUt9zf/9J/Gmxv+F7igrt5l25suxIgq9PoA/S
         pvdw==
X-Gm-Message-State: ABuFfoiDnSxhKlcD+9+xq930o0R0fLLjjXHAxQ9DxoafOvSQOANRt1Iu
        fWG+QHBTM+0gMQHepDuwAXs=
X-Google-Smtp-Source: ACcGV63/mSyc8wspVYuLVd0MxIcaPU61q79VTLdAPhE05qWbFzSIBPDVftrwbllnYLPa9zFz9zvGtg==
X-Received: by 2002:a63:2b4d:: with SMTP id r74-v6mr1583570pgr.406.1537607902255;
        Sat, 22 Sep 2018 02:18:22 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id g21-v6sm60423689pfe.41.2018.09.22.02.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 02:18:21 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:18:14 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Phil Reid <preid@electromag.com.au>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180922091814.GA25150@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
 <alpine.DEB.2.21.1809201522370.1482@vps.pmeerw.net>
 <5a4d3868-902c-494e-76e4-4141ff5ec855@electromag.com.au>
 <20180921112954.GA4639@Eros>
 <20180921132012.00007061@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921132012.00007061@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:20:12PM +0100, Jonathan Cameron wrote:
> Hi Song,
> 
> ...
> 
> Please crop emails down to the relevant section when replying.  Lots of scrolling
> for everyone otherwise and sometimes things get missed when doing that.
> 

Hi Jonathan,

Sorryi for this, won't happen again.
I was intended to give a simple question, but it reminds me of a lot
unrelated stuff, next time I'll make it another email.

> > > > > +	if (!buffer)
> > > > > +		goto done;
> > > > > +
> > > > > +	mutex_lock(&data->lock);
> > > > > +	ret = rm3100_wait_measurement(data);
> > > > > +	if (ret < 0) {
> > > > > +		mutex_unlock(&data->lock);
> > > > > +		goto done;
> > > > > +	}
> > > > > +
> > > > > +	for (i = 0; i < 3; i++) {
> > > > > +		ret = regmap_bulk_read(regmap, RM_REG_MX2 + 3 * i,
> > > > > +				buffer + 4 * i, 3);
> > > > > +		if (ret < 0)
> > > > > +			return ret;
> > > > > +	}  
> > > 
> > > Wouldn't it be better to read the 3 axis with one transaction here.
> > > And if required shuffle the data into the iio buffer.
> > > 
> > >   
> > 
> > Hi Phil,
> > 
> > That's surely something will make this code better!
> > 
> > But also, there is something worth discussing,
> > When triggered buffer is triggered here, I should push all the data into
> > userspace, and every time the buffer is enabled, the iio subsystem
> > automatically computes the alignment of my data. This sensor has 3
> > 24bits channels, and my original thought of data alignment should be
> > like this because my machine is 32bits:
> > +----------+----+----+----+----+----+----+
> > | 3b(ytes) | 1b | 3b | 1b | 3b | 1b | 8b |
> > +----------+----+----+----+----+----+----+
> > 3 bytes data and 1 byte for alignment, last 8 bytes for the timestamp.
> > Aligned to 4 bytes. 
> > But the actual layout is like this:
> > +----------+----+----+----+----+----+----+----+
> > | 3b(ytes) | 1b | 3b | 1b | 3b | 1b | 4b | 8b |
> > +----------+----+----+----+----+----+----+----+
> > Soon after I debugged the code of industrial io core I found that in the
> > iio_compute_scanbytes() in industialio-buffer.c, alignment was computed
> > each channel a time, and was aligned with the length of next channel. (eg:
> > In the last case, before the timestamp channel was appended, there are
> > 12 bytes already in the buffer, to align to the timetamp which is 8 
> > bytes, it injected 4 bytes to make it 16, and then append timestamp. )
> > This leads to two questions:
> > 
> > 1. I thought computer systems align their data in the memory for least
> > time access, shouldn't this always align to the bits of architecture,
> > like for a 32bits machine align to 4?? I'm a little confused here.
> > Jonathan must have considered something, Hoping to get some
> > explanations!
> 
> A couple of reasons for this:
> 
> 1. It's much nicer to have the same spacing independent of the architecture
> as it saves having to have userspace code do different things depending on
> what the kernel is running at, which may not be the same as userspace.
> 
> 2. The size of a memory read is not the only scale that makes sense for
> alignment.  In theory at least you can have fun and games like crossing of
> cacheline boundaries if you do 64 bit access only at 32bits aligned on a
> 32 bit platform.  Won't hit all that often with typically 64 byte cachelines
> but it is the sort of subtle effect you get when you don't go with
> 'naturally' aligned. (which is what aligning to an elements own size is
> normally called IIRC).
> 

I see, architecture independent surely should be the principle of the
Linux kernel, this makes sense, I think I should learn more stuff about
natural alignment. I googled something about it and understand what it
is, but still find it difficult to fully understand its benefits. I think
I'll learn more about it after. 

> > 
> > 2. In this case I have 4 channels including the timetamp one, and I
> > thought it should be aligned like the first one. But actually it's
> > aligned like the second one, when I was testing the buffer, I got
> > confused, because the in_magn_x_type returned 24/32, 24/32, 24/32
> > and 64/64. If the iio core injected some empty bytes, shouldn't it
> > notify me? Or at least change the timestamp type in scan_bytes to
> > 64/96>>0?? And when I only enabled two of three channels, the data  
> > alignment in the buffer looks like this:
> > +----------+----+----+----+----+
> > | 3b(ytes) | 1b | 3b | 1b | 8b |
> > +----------+----+----+----+----+
> > Notice that 4 bytes have gone due to data of two channels have already
> > aligned to 8 bytes.
> > Hoping to get some answers, I'm very curious and interested about this!
> 
> Nope it shouldn't do the 64/96 need to tell you because it uses
> the rules of natural alignment which are easy for userspace to predict.
> So in this second case there is no need to pad so it doesn't - whereas the
> 4 bytes are needed in the first case.
> 
> We could have explicitly output the offsets and kept things more flexible
> but that would have prevented some general optimizations on the userspace
> side for common cases.  If you are reading a 3 axis accelerometer for
> example with timestamp then you can probably safely prebake optimized handling
> for,
> 
> 1B (x), 1B (y), 1B(z), 5B(pad), 8B(ts)
> 
> 2B (x), 2B (y), 2B(z), 2B(pad), 8B(ts)
> 
> in reality no one ever goes higher than this because accelerometers aren't
> accurate enough...
> 
> If we did anything more complex we'd need to describe to userspace in some
> sense what was happening beyond the static data currently provided (when
> combined with the ordering and enables) and that makes for a complex ABI
> we don't need.
> 
> Also we'd have to do unaligned puts of the u64 timestamp in kernel which
> is nasty.
> 
> Jonathan

Yes, you make the point, since natural alignment is a generic rule for a
lot circumstances, surely it would be easy for userspace to predict. I 
think libiio should have done these kind stuff, shouldn't be a problem
for userspace!
Thanks for the explanation!

yours,
Song Qiang

> > 
> > yours,
> > Song Qiang
> > 
> > > > > +	mutex_unlock(&data->lock);
> > > > > +
> > > > > +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> > > > > +			iio_get_time_ns(indio_dev));
> > > > > +done:
> > > > > +	iio_trigger_notify_done(indio_dev->trig);
> > > > > +
> > > > > +	return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> > > > > +{
> > > > > +	struct iio_dev *indio_dev;
> > > > > +	struct rm3100_data *data;
> > > > > +	int tmp;
> > > > > +	int ret;
> > > > > +
> > > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > > > +	if (!indio_dev)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	data = iio_priv(indio_dev);
> > > > > +	dev_set_drvdata(dev, indio_dev);
> > > > > +	data->dev = dev;
> > > > > +	data->regmap = regmap;
> > > > > +
> > > > > +	mutex_init(&data->lock);
> > > > > +
> > > > > +	indio_dev->dev.parent = dev;
> > > > > +	indio_dev->name = "rm3100";
> > > > > +	indio_dev->info = &rm3100_info;
> > > > > +	indio_dev->channels = rm3100_channels;
> > > > > +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> > > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > +	indio_dev->available_scan_masks = rm3100_scan_masks;
> > > > > +
> > > > > +	if (!irq)
> > > > > +		data->use_interrupt = false;
> > > > > +	else {
> > > > > +		data->use_interrupt = true;
> > > > > +		ret = devm_request_irq(dev,
> > > > > +			irq,
> > > > > +			rm3100_measurement_irq_handler,
> > > > > +			IRQF_TRIGGER_RISING,
> > > > > +			indio_dev->name,
> > > > > +			data);
> > > > > +		if (ret < 0) {
> > > > > +			dev_err(dev,
> > > > > +			"request irq line failed.");  
> > > > 
> > > > \n
> > > >   
> > > > > +			return -ret;
> > > > > +		}
> > > > > +		init_completion(&data->measuring_done);
> > > > > +	}
> > > > > +
> > > > > +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > > > > +					rm3100_trigger_handler, NULL);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	/* 3sec more wait time. */
> > > > > +	ret = regmap_read(data->regmap, RM_REG_TMRC, &tmp);  
> > > > 
> > > > check ret
> > > >   
> > > > > +	data->conversion_time = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][2] + 3000;
> > > > > +
> > > > > +	/* Starting all channels' conversion. */
> > > > > +	ret = regmap_write(regmap, RM_REG_CMM,
> > > > > +		RM_CMM_PMX | RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	return devm_iio_device_register(dev, indio_dev);
> > > > > +}
> > > > > +EXPORT_SYMBOL(rm3100_common_probe);
> > > > > +
> > > > > +int rm3100_common_remove(struct device *dev)
> > > > > +{
> > > > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > > > +	struct regmap *regmap = data->regmap;
> > > > > +
> > > > > +	regmap_write(regmap, RM_REG_CMM, 0x00);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(rm3100_common_remove);
> > > > > +
> > > > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > > > +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer i2c driver");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
> > > > > new file mode 100644
> > > > > index 000000000000..b50dc5b1b30b
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/magnetometer/rm3100-i2c.c
> > > > > @@ -0,0 +1,66 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Support for PNI RM3100 9-axis geomagnetic sensor a i2c bus.
> > > > > + *
> > > > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > > > + *
> > > > > + * User Manual available at
> > > > > + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> > > > > + *
> > > > > + * i2c slave address 0x20 + SA1 << 1 + SA0.
> > > > > + */
> > > > > +
> > > > > +#include <linux/i2c.h>
> > > > > +
> > > > > +#include "rm3100.h"
> > > > > +
> > > > > +static const struct regmap_config rm3100_regmap_config = {
> > > > > +		.reg_bits = 8,
> > > > > +		.val_bits = 8,
> > > > > +
> > > > > +		.rd_table = &rm3100_readable_table,
> > > > > +		.wr_table = &rm3100_writable_table,
> > > > > +		.volatile_table = &rm3100_volatile_table,
> > > > > +
> > > > > +		.cache_type = REGCACHE_RBTREE,
> > > > > +};
> > > > > +
> > > > > +static int rm3100_probe(struct i2c_client *client)
> > > > > +{
> > > > > +	struct regmap *regmap;
> > > > > +
> > > > > +	if (!i2c_check_functionality(client->adapter,
> > > > > +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > > +	regmap =  devm_regmap_init_i2c(client, &rm3100_regmap_config);
> > > > > +	if (IS_ERR(regmap))
> > > > > +		return PTR_ERR(regmap);
> > > > > +
> > > > > +	return rm3100_common_probe(&client->dev, regmap, client->irq);
> > > > > +}
> > > > > +
> > > > > +static int rm3100_remove(struct i2c_client *client)
> > > > > +{
> > > > > +	return rm3100_common_remove(&client->dev);
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id rm3100_dt_match[] = {
> > > > > +	{ .compatible = "pni,rm3100-i2c", },
> > > > > +	{ }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> > > > > +
> > > > > +static struct i2c_driver rm3100_driver = {
> > > > > +	.driver = {
> > > > > +		.name = "rm3100-i2c",
> > > > > +		.of_match_table = rm3100_dt_match,
> > > > > +	},
> > > > > +	.probe_new = rm3100_probe,
> > > > > +	.remove = rm3100_remove,
> > > > > +};
> > > > > +module_i2c_driver(rm3100_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > > > +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer i2c driver");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
> > > > > new file mode 100644
> > > > > index 000000000000..2c7dd9e3a1a2
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/magnetometer/rm3100-spi.c
> > > > > @@ -0,0 +1,72 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Support for PNI RM3100 9-axis geomagnetic sensor a spi bus.
> > > > > + *
> > > > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > > > + *
> > > > > + * User Manual available at
> > > > > + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> > > > > + */
> > > > > +
> > > > > +#include <linux/spi/spi.h>
> > > > > +
> > > > > +#include "rm3100.h"
> > > > > +
> > > > > +static const struct regmap_config rm3100_regmap_config = {
> > > > > +		.reg_bits = 8,
> > > > > +		.val_bits = 8,
> > > > > +
> > > > > +		.rd_table = &rm3100_readable_table,
> > > > > +		.wr_table = &rm3100_writable_table,
> > > > > +		.volatile_table = &rm3100_volatile_table,
> > > > > +
> > > > > +		.read_flag_mask = 0x80,
> > > > > +
> > > > > +		.cache_type = REGCACHE_RBTREE,
> > > > > +};
> > > > > +
> > > > > +static int rm3100_probe(struct spi_device *spi)
> > > > > +{
> > > > > +	struct regmap *regmap;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* Actually this device supports both mode 0 and mode 3. */
> > > > > +	spi->mode = SPI_MODE_0;
> > > > > +	/* data rates cannot exceeds 1Mbits. */  
> > > > 
> > > > exceed
> > > >   
> > > > > +	spi->max_speed_hz = 1000000;
> > > > > +	spi->bits_per_word = 8;
> > > > > +	ret = spi_setup(spi);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	regmap =  devm_regmap_init_spi(spi, &rm3100_regmap_config);
> > > > > +	if (IS_ERR(regmap))
> > > > > +		return PTR_ERR(regmap);
> > > > > +
> > > > > +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
> > > > > +}
> > > > > +
> > > > > +static int rm3100_remove(struct spi_device *spi)
> > > > > +{
> > > > > +	return rm3100_common_remove(&spi->dev);
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id rm3100_dt_match[] = {
> > > > > +	{ .compatible = "pni,rm3100-spi", },
> > > > > +	{ }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> > > > > +
> > > > > +static struct spi_driver rm3100_driver = {
> > > > > +		.driver = {
> > > > > +				.name = "rm3100-spi",
> > > > > +				.of_match_table = rm3100_dt_match,
> > > > > +		},
> > > > > +		.probe = rm3100_probe,
> > > > > +		.remove = rm3100_remove,
> > > > > +};
> > > > > +module_spi_driver(rm3100_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > > > +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer spi driver");
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetometer/rm3100.h
> > > > > new file mode 100644
> > > > > index 000000000000..5e30bc0f5149
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/magnetometer/rm3100.h
> > > > > @@ -0,0 +1,90 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > > > +/*
> > > > > + * Header file for PNI RM3100 driver
> > > > > + *
> > > > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > > > + */
> > > > > +
> > > > > +#ifndef RM3100_CORE_H
> > > > > +#define RM3100_CORE_H
> > > > > +
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/regmap.h>
> > > > > +
> > > > > +#define RM_REG_REV_ID		0x36
> > > > > +
> > > > > +/* Cycle Count Registers MSBs and LSBs. */
> > > > > +#define RM_REG_CCXM		0x04
> > > > > +#define RM_REG_CCXL		0x05
> > > > > +#define RM_REG_CCYM		0x06
> > > > > +#define RM_REG_CCYL		0x07
> > > > > +#define RM_REG_CCZM		0x08
> > > > > +#define RM_REG_CCZL		0x09
> > > > > +
> > > > > +/* Single Measurement Mode register. */
> > > > > +#define RM_REG_POLL		0x00
> > > > > +#define RM_POLL_PMX		BIT(4)
> > > > > +#define RM_POLL_PMY		BIT(5)
> > > > > +#define RM_POLL_PMZ		BIT(6)
> > > > > +
> > > > > +/* Continues Measurement Mode register. */
> > > > > +#define RM_REG_CMM		0x01
> > > > > +#define RM_CMM_START		BIT(0)
> > > > > +#define RM_CMM_DRDM		BIT(2)
> > > > > +#define RM_CMM_PMX		BIT(4)
> > > > > +#define RM_CMM_PMY		BIT(5)
> > > > > +#define RM_CMM_PMZ		BIT(6)
> > > > > +
> > > > > +/* TiMe Rate Configuration register. */
> > > > > +#define RM_REG_TMRC		0x0B
> > > > > +#define RM_TMRC_OFFSET		0x92
> > > > > +
> > > > > +/* Result Status register. */
> > > > > +#define RM_REG_STATUS		0x34
> > > > > +#define RM_STATUS_DRDY		BIT(7)
> > > > > +
> > > > > +/* Measurement result registers. */
> > > > > +#define RM_REG_MX2		0x24
> > > > > +#define RM_REG_MX1		0x25
> > > > > +#define RM_REG_MX0		0x26
> > > > > +#define RM_REG_MY2		0x27
> > > > > +#define RM_REG_MY1		0x28
> > > > > +#define RM_REG_MY0		0x29
> > > > > +#define RM_REG_MZ2		0x2a
> > > > > +#define RM_REG_MZ1		0x2b
> > > > > +#define RM_REG_MZ0		0x2c
> > > > > +
> > > > > +#define RM_REG_HSHAKE		0x35
> > > > > +
> > > > > +#define RM_W_REG_START		RM_REG_POLL
> > > > > +#define RM_W_REG_END		RM_REG_REV_ID
> > > > > +#define RM_R_REG_START		RM_REG_POLL
> > > > > +#define RM_R_REG_END		RM_REG_HSHAKE
> > > > > +#define RM_V_REG_START		RM_REG_MX2
> > > > > +#define RM_V_REG_END		RM_REG_HSHAKE
> > > > > +
> > > > > +/* Built-In Self Test reigister. */
> > > > > +#define RM_REG_BIST		0x33
> > > > > +
> > > > > +struct rm3100_data {
> > > > > +	struct device *dev;
> > > > > +	struct regmap *regmap;
> > > > > +	struct completion measuring_done;
> > > > > +	bool use_interrupt;
> > > > > +
> > > > > +	int conversion_time;
> > > > > +
> > > > > +	/* To protect consistency of every measurement and sampling
> > > > > +	 * frequency change operations.
> > > > > +	 */
> > > > > +	struct mutex lock;
> > > > > +};
> > > > > +
> > > > > +extern const struct regmap_access_table rm3100_readable_table;
> > > > > +extern const struct regmap_access_table rm3100_writable_table;
> > > > > +extern const struct regmap_access_table rm3100_volatile_table;
> > > > > +
> > > > > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> > > > > +int rm3100_common_remove(struct device *dev);
> > > > > +
> > > > > +#endif /* RM3100_CORE_H */
> > > > >   
> > > >   
> > > 
> > > 
> > > -- 
> > > Regards
> > > Phil Reid
> > >   
> 
> 
