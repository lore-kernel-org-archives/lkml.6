Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBAF21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTk0HbAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBAF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIZHoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:44:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIZHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:44:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so12882771pgv.1;
        Tue, 25 Sep 2018 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0PWseoF7GMEyiBQBQADgYiyXwnPtQe+XqULuu2vy1PI=;
        b=gTk0HbAW8CZp/DW4bRk5kNrlHjevipCnBx30h9ZzZNB1PtJhSCJWzgkdZ7NptXiLeQ
         mKAzVVBP+Zf5/MWjmKP1+GuulS0q1fEIj4T8ei0NEKx+0y/DvFbNeGBiDEwLMl4AtePr
         vpkDoolyVoaTfszSeBed2CyC93tCatfJ6RfBd/nJwhyfTwJ0xN/dqzFmFwv1M0V3Nkll
         H5K+oB/YlKj1V3BZGoNYpDWf7Dc7K7VLhlfw+dcbqru9gwBjrUgiGzOc0Cy4IJsk4cJK
         eBUpyxzWYSpUzrmklZVbrvFuTniwCJeM6PVmneL6MgJgGxLpRAIDx736wpy+0ROGG2VN
         uvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0PWseoF7GMEyiBQBQADgYiyXwnPtQe+XqULuu2vy1PI=;
        b=oUHu+wuyaORIgRuaBXdnPk/vkb0HHGqYvJtA7+czPPcwgfD9tDLDfB/ihLB1I0CSCX
         tMLfYKZFiAGqzJyQTg7Aeh/YJgWWfyQp5ywuqI5TQXUASDEr93aQDI7kx1H+xwAzxyrF
         uJZ/GNrKDAXnZadBUV9nMirwCUUEamGUbFypSM21UWRu4Wk9Ct2UBdsMTbsrrpL7ifRQ
         IySP2qBOx3I/6RyYffyVihWH65X7f3tDIpjGZKa6ctb6sJAnlbb/dDZGACVFlOlCrFiy
         RYwXIhGM57jy0bOXkQk9qvGrljuE+L1qXF7qKhJT76PSE0Ke6tOoos6Y6qomgnu956xD
         rwxQ==
X-Gm-Message-State: ABuFfojyn1Y6JhEhUiVxDlMmA7anLwEWe6jmEhmEbXdLLidcI4/XbDhZ
        K5jNHBvPKST+aUH7BwpyEwc=
X-Google-Smtp-Source: ACcGV63lOua51YhwBPI+3zvDGBIT7keufo+Q+omaSVLq4lrS0Qb851Ad9bHO0JVw3CQfwrVREsBBUQ==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr3760937pfa.96.1537925641073;
        Tue, 25 Sep 2018 18:34:01 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id x77-v6sm6680888pff.37.2018.09.25.18.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:34:00 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:33:53 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, rtresidd@electromag.com.au,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
Message-ID: <20180926013353.GA6152@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925143054.00007fcb@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:30:54PM +0100, Jonathan Cameron wrote:
> On Tue, 25 Sep 2018 11:17:24 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > PNI RM3100 is a high resolution, large signal immunity magnetometer,
> > composed of 3 single sensors and a processing chip with MagI2C Interface.
> > 
> > Following functions are available:
> > - Single-shot measurement from
> >   /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> > - Triggerd buffer measurement.
> > - Both i2c and spi interface are supported.
> > - Both interrupt and polling measurement is supported, depands on if
> >   the 'interrupts' in DT is declared.
> > 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> Various minor comments inline.  Definitely heading in the right direction.
> 
> Good work.
> 
> Thanks,
> 
> Jonathan
> 

...

> > +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
> > +{
> > +	int ret;
> > +	int tmp;
> > +
> > +	mutex_lock(&data->lock);
> > +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> > +	mutex_unlock(&data->lock);
> > +	if (ret < 0)
> > +		return ret;
> > +	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> > +	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
> > +{
> > +	int ret;
> > +	u8 i;
> > +
> > +	for (i = 0; i < 3; i++) {
> > +		ret = regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, 100);
> 
> Does this write it to the same value irrespective of the value of val?
> Seems odd.
> 
Hi Jonathan,

Sometimes I see these mistakes I couldn't stop laughing at my stupiness.
Should be val, my mistake submitting without a throughout functional
check, I think I'll write a script to prevent this from happening again.

> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +	if (val == 50)
> 
> Switch would be nicer.  Also why have all other values call back to
> 2 rather than generating an error?
> 
I could have given it an error path, but I checked the code, 'val' in
this function is always given by my code. I think this leads no
possibility for val to go wrong. Do I still need an error path in this
circumstance?

> > +		data->cycle_count_index = 0;
> > +	else if (val == 100)
> > +		data->cycle_count_index = 1;
> > +	else
> > +		data->cycle_count_index = 2;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
> > +{
> > +	struct regmap *regmap = data->regmap;
> > +	int cycle_count;
> > +	int ret;
> > +	int i;
> > +
> > +	mutex_lock(&data->lock);
> 
> Why are you taking this lock? It's not well documented what it protects
> so it's not clear in this path why it is taken.
> (hint add a comment to the definition of the lock to make it clear!)
> - note I'm not saying it shouldn't be taken here, just that there is no
> comment to justify it..
> 
When I was considering the lock, I read Robert Love's 'Linux Kernel
Development', whose chapter 9 talks about how to understand the lock.
It was talking about protecting data, but in here, my purpose is to
protect the i2c execution consistency. I think it may be possible that
one person is extracting the data while another person is planning set
the frequency. Setting the frequency within queuing data will causing
CMM(Continuous Measurement Mode) register reset, breaking the measurement
process. That's why I added lock to callbacks where a i2c sequence can
happen. I referred code from hmc5843, which did the similar lock stuff,
am I understanding about lock right?

> > +	/* All cycle count registers use the same value. */
> > +	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
> > +	if (ret < 0)
> > +		goto unlock_return;
> > +
> > +	for (i = 0; i < RM3100_SAMP_NUM; i++) {
> > +		if (val == rm3100_samp_rates[i][0] &&
> > +		    val2 == rm3100_samp_rates[i][1])
> > +			break;
> > +	}
> > +	if (i == RM3100_SAMP_NUM) {
> > +		ret = -EINVAL;
> > +		goto unlock_return;
> > +	}
> > +
> > +	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
> > +	if (ret < 0)
> > +		goto unlock_return;

...

> > +	if (ret < 0)
> > +		goto done;
> > +
> > +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> > +	for (i = 0; i < 3; i++)
> > +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
> 
> Firstly X doesn't need copying.
> Secondly the copy of Y actually overwrites the value of Z
> XXXYYYZZZxxx
> XXXxYYYZZxxx
> XXXxYYYxYZZx
> 
> I think...
> 
They are in different memories, buffer is a temporary memory for data
reading out, data->buffer is for pushing to the userspace.

> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > +			iio_get_time_ns(indio_dev));
> 
> Align with opening bracket. 
> 
> > +
> > +done:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void rm3100_remove(void *dh)
> > +{
> > +	struct rm3100_data *data = (struct rm3100_data *)dh;
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap, RM3100_REG_CMM, 0x00);
> > +	if (ret < 0)
> > +		dev_err(data->dev, "failed to stop device.\n");
> > +}
> > +
> > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct rm3100_data *data;
> > +	int tmp;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->dev = dev;
> > +	data->regmap = regmap;
> > +	data->buffer = devm_kzalloc(dev, RM3100_SCAN_BYTES, GFP_KERNEL);
> > +	if (!data->buffer)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->name = "rm3100";
> > +	indio_dev->info = &rm3100_info;
> > +	indio_dev->channels = rm3100_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = rm3100_scan_masks;
> > +
> > +	if (!irq)
> > +		data->use_interrupt = false;
> > +	else {
> > +		data->use_interrupt = true;
> > +		ret = devm_request_irq(dev,
> > +				       irq,
> > +				       rm3100_irq_handler,
> > +				       IRQF_TRIGGER_RISING,
> > +				       indio_dev->name,
> > +				       data);
> > +		if (ret < 0) {
> > +			dev_err(dev, "request irq line failed.\n");
> > +			return ret;
> > +		}
> > +		init_completion(&data->measuring_done);
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      rm3100_trigger_handler, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* 3sec more wait time. */
> 
> I have no idea what this comment is referring to..
> Not seeing any waiting here...
> 
The thing is, measurement time of this sensor span from ~1.7ms to ~13
seconds. I'll need a wait time for *_wait_measurement(), and I use
measurement time + 3 seconds for waiting time. This is an initialization.
Usage of this is in *_wait_measurement.

yours,
Song Qiang

> > +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> > +	if (ret < 0)
> > +		return ret;
> > +	data->conversion_time =
> > +		rm3100_samp_rates[tmp-RM3100_TMRC_OFFSET][2] + 3000;
> 
> spacing around -  
> Please check this throughout.

...
