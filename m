Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5FEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B3E214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPDBsuQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B3E214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeIQTBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:01:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41048 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeIQTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:01:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so7437776plr.8;
        Mon, 17 Sep 2018 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrStYt/U2Xwc7yzFaN/FBAndeWN9Lipz9fkMVVG3OsM=;
        b=fPDBsuQv4Kb6vdk9ztSeuiwhZavNwHk4m47sD5p9CfP89NEM8Ir+RG1Me0LwLUsQwW
         ZMOya8nh9W38219kCaCRFSX9SjWa66zV/LXp2RlM4sFcDlaNe/wA8edV1mi+SUT1nKgE
         6W7Llv1TA3a6OH8sEss7hymIkqB5xNv66Pptku4ZsaSQe1jzpJZu/3Aeu1rp2njg75o6
         J3LlCTBgPLUN4bU8h4hiBPmyZxsMAQztHYjsX23/48ll4hKe+eL9rZM0HldNY34Iok45
         +UriEx8k6IvnsKcBX1UQOyOma28VHPGBucKMNbayWEeU/YeWBcDft40Yvt+XmQEvGirG
         hSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrStYt/U2Xwc7yzFaN/FBAndeWN9Lipz9fkMVVG3OsM=;
        b=UHqPS8iYRzWRDqxOFm0H6Ejfi5iHaN5WagrAnoPSRXFXAzN4+wxq6beJd53Z38Oyo/
         wQe2qSJ9Co9iWu47ZW9qAhs/2bdHXNnOltV2eOoqKAufZP4I2Ui2fXuO0MeRoMkbWhEN
         vzqXno8XsQrQBaCLPQitQTilhBg+I+/KRAZ9I/iS/UYK49vLrW15PdSwLiT4ORfTpBwz
         UUqnKectc2+gEJ9MtS7x7vDUgigxksjoWiYnlOsIiRtG9iWyKhdnqiM3PZIsDa2M9ME7
         VXPoQ6SfMA67qDo6IjquK/w/k/gPatbVXSOsKahpAtGKyWF2U0h86aXtptMR2bsmLeL0
         v9zw==
X-Gm-Message-State: APzg51AvSywCgSNFdfPM23LKUvEO1tfP3Nx6JZEg0cQjJnNP4vgN8ExD
        WdkYS/Z+jjWM0UTwI3UYpOA=
X-Google-Smtp-Source: ANB0VdZWrP4hFf4KoxCrh6iRn8DEnaM7FKBZKz9nVhDAZrPtW1OZA9Vmpc6iE8HQevjT/POBOjH0kQ==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21-v6mr24975925pls.284.1537191258641;
        Mon, 17 Sep 2018 06:34:18 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id t17-v6sm19490335pfm.138.2018.09.17.06.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 06:34:18 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:33:53 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, tglx@linutronix.de, ak@it-klinger.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, himanshujha199640@gmail.com
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180917133353.GA30737@Eros>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
 <20180916120149.0c68893f@archlinux>
 <20180916133651.GA10179@Eros>
 <20180917092521.000044d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917092521.000044d4@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 09:25:21AM +0100, Jonathan Cameron wrote:
> On Sun, 16 Sep 2018 21:36:51 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > On Sun, Sep 16, 2018 at 12:01:49PM +0100, Jonathan Cameron wrote:
> > > On Sat, 15 Sep 2018 17:57:52 +0800
> > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > >   
> > > > This driver was originally written by ST in 2016 as a misc input device
> > > > driver, and hasn't been maintained for a long time. I grabbed some code
> > > > from it's API and reformed it into an iio proximity device driver.
> > > > This version of driver uses i2c bus to talk to the sensor and
> > > > polling for measuring completes, so no irq line is needed.
> > > > This version of driver supports only one-shot mode, and it can be
> > > > tested with reading from
> > > > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > > > 
> > > > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>  
> > > Hi Song,
> > > 
> > > My first comment was going to be don't use wild cards in a part name
> > > in a driver, but a quick sanity check confirmed that ST were actually
> > > crazy enough to end a part number with an X.  Ah well ;)
> > > 
> > > Otherwise a few minor things, mostly around naming.  There is some
> > > confusion around endian stuff as well
> > > 
> > > Looks pretty good for a first go at upstreaming a driver!
> > > 
> > > Are you planning on adding more features?  Seems like a capable little device
> > > and would be good to have fuller support in the long term if you have time
> > > to look at it!
> > > 
> > > Jonathan
> > >   
> > 
> > Hi Jonathan,
> > 
> > Thanks for spending time with my patch!
> > Since I'm now just a student and intrested in embedded linux very much,
> > there are plenty of free time for me to work on this, and working with
> > the community is not only interesting but helpful to my knowledge.
> > People reviewed my patch gave me a lot helpful suggestions, espacially
> > Himanshu. :)
> Cool.
> 
> > 
> > When I was writing this patch, I thought maybe I should go one step
> > each time, so this driver may seems like a little simple, but I believe
> > it's just for now.
> Agreed. It makes complete sense to start simple and build up.  I was
> just being curious on how far you were planning on going ;)
> 

I was just working on the interrupt. I think I'll submit the second
patch to make interrupt working tommorow.

> > 
> > Actually there is a question, ST released a new version of this device
> > called VL53L1X in June, which still has no support for linux drivers,
> > but compitable with VL53L0X. Do you have any suggestions for my
> > driver's name? The first one came to my mind would be VL53LxX, which is
> > a little crazy I think. ;)
> Yes. Wild cards are almost always a bad idea. Just go with the name
> of the first part you support.
> 
> If you want example of this see the max1363 ADC driver.  That supports
> lots of seemingly unconnected part numbers so a wild card approach would
> have caused all sorts of mess.
> 

I see, that's a good idea.

> > 
> >
> ...
> 
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Support for ST VL53L0X FlightSense ToF Ranging Sensor on a i2c bus.
> > > > + *
> > > > + * Copyright (C) 2016 STMicroelectronics Imaging Division.
> > > > + * Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
> > > > + *
> > > > + * Datasheet available at
> > > > + * <https://www.st.com/resource/en/datasheet/vl53l0x.pdf>
> > > > + *
> > > > + * Default 7-bit i2c slave address 0x29.
> > > > + *
> > > > + * TODO: FIFO buffer, continuous mode, interrupts, range selection,
> > > > + * sensor ID check.
> > > > + */
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/delay.h>
> > > > +
> > > > +#include <linux/iio/iio.h>
> > > > +
> > > > +#define VL53L0X_DRV_NAME				"vl53l0x-i2c"  
> > > 
> > > A quick google suggests this only has an i2c interface.  Hence I'd argue
> > > there is no point in having -i2c in the driver name.  Lots of other
> > > i2c only parts don't on the basis it doesn't add anything.  In fact
> > > the only time we tend to do this is if we have a driver that splits
> > > into a shared core and two or more bus specific drivers.
> > >   
> > 
> > Actually this device do has a CCI(Camera Control Interface) for
> > communication and it's original API has two kinds of ways for accessing
> > this device. 
> Hmm. That one is a bit of a surprise.
> 
> OK.  Fine to do the driver name as *-i2c but don't have it in the
> iio_dev.name field as it's not really useful to pass on.  That
> usually just contains the part number. Userspace doesn't care about the
> interface.
> 

I'll remove that.

> > 
> > > > +
> > > > +#define VL_REG_SYSRANGE_START				0x00
> > > > +
> > > > +#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
> > > > +#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
> > > > +#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
> > > > +#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
> > > > +#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
> > > > +#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
> > > > +
> > > > +#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
> > > > +#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
> > > > +#define VL_REG_SYS_RANGE_CFG				0x09
> > > > +#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
> > > > +#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
> > > > +#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
> > > > +#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
> > > > +#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
> > > > +#define VL_REG_SYS_INT_CFG_GPIO				0x0A
> > > > +#define VL_REG_SYS_INT_CLEAR				0x0B
> > > > +#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
> > > > +
> > > > +#define VL_REG_RESULT_INT_STATUS			0x13
> > > > +#define VL_REG_RESULT_RANGE_STATUS			0x14
> > > > +#define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
> > > > +
> > > > +/* Check contents of these registers to verify the device. */
> > > > +#define VL_REG_IDENTIFICATION_MODEL_ID			0xC0
> > > > +#define VL_REG_IDENTIFICATION_REVISION_ID		0xC2
> > > > +
> > > > +struct vl53l0x_data {
> > > > +	struct i2c_client *client;
> > > > +};
> > > > +
> > > > +static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> > > > +				  const struct iio_chan_spec *chan,
> > > > +				  int *val)
> > > > +{
> > > > +	struct i2c_client *client = data->client;
> > > > +	unsigned int tries = 20;
> > > > +	u8 buffer[12];
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_write_byte_data(client,
> > > > +		VL_REG_SYSRANGE_START, 1);  
> > > 
> > > Looks like the above would fit on one line.  Please do a quick check
> > > through the driver for other cases of this.
> > >   
> > 
> > Oops, I'll change that. 
> > 
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	do {
> > > > +		ret = i2c_smbus_read_byte_data(client,
> > > > +			VL_REG_RESULT_RANGE_STATUS);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
> > > > +			break;
> > > > +
> > > > +		usleep_range(1000, 5000);
> > > > +	} while (--tries);
> > > > +	if (!tries)
> > > > +		return -ETIMEDOUT;
> > > > +
> > > > +	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
> > > > +		12, buffer);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +	else if (ret != 12)
> > > > +		return -EREMOTEIO;
> > > > +
> > > > +	/* Values should be between 30~1200. */
> > > > +	*val = le16_to_cpu((buffer[10] << 8) + buffer[11]);  
> > > This worries me as a conversion.  The shift and addition is
> > > unwinding the endianness already. You then do it again with le16_to_cpu
> > > 
> > > As it's aligned you could have done
> > > *val = le16_to_cpu(*(le16 *)(&buffer[10]));  That's obviously
> > > a bit ugly though, mainly because we are handling the buffer as
> > > a u8.  Is there a reason to not directly handle it as an le16 array?
> > > 
> > > I'm having trouble finding the relevant section of the manual to actually
> > > figure out what is in the first 10 bytes!
> > > 
> > > 
> > >   
> > 
> > Sorry for this insanity, actually, I was writing this driver without a
> > full memory layout. I tried to look for one, but then I found the poor ST
> > support seems like doesn't want to release one at all! Have a look at
> > this thread on Soren Karlsen's reply:
> > <https://community.st.com/s/question/0D50X00009XkYTtSAN/request-of-vl53l0x>
> > All those documents on ST's support websites mentioned only several
> > registers for connection check.
> > 
> > I can't say this is a very big deal because at least ST released a full
> > API source with documentation. I analyzed their API source and also
> > looked up some usage examples on google to get this device working.
> > The protocal in the datasheet P19-20 shows that this device has to read
> > consecutive bytes stream to get all data. I tried to access these
> > registers one by one but it's not working. 
> > Datasheet:
> > <https://www.st.com/resource/en/datasheet/vl53l0x.pdf> P19-20
> > 
> > Something I know from arduino's example code is that the 11th and 12th
> > bytes hold distance, the 9th and 10th bytes hold signal countdown
> > value and 7th and 8th bytes hold ambient countdown value. 
> 
> Hmm. One of 'those' parts.  They give almost but not quite enough information
> to use it in a sane fashion...  Oh well, we work with what we have and good
> there is at least some example code to get things going!
> 
> > 
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct iio_chan_spec vl53l0x_channels[] = {
> > > > +	{
> > > > +		.type = IIO_DISTANCE,
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),  
> > > 
> > > This is a time of flight sensor?  As such I would kind of assume it is possible
> > > to get to a real world distance?  Adding scale and offset to do this can
> > > of course be a follow up patch,  but it would be good to have!
> > >   
> > 
> > That's right, there was a scale channel, but since this device returns
> > value in millimeters I thought there isn't a need for that channel, so
> > I just return raw value.
> 
> If it's already in mm then you should use _PROCESSED not _RAW
> to indicate that to userspace.  Right now userspace would think that there
> was no known scaling.
> 

That's something I didn't know, seems like more documents should to
read.

> > Usually in our production, we do some linear calibration for it's return
> > values, but I think this may should be left with userspace to do.
> 
> That's normal.  We give as much information as possible, but if you want any 
> really precise values off a sensor then it's up to you to calibrate it offline.
> 
> > 
> > > > +	},
> > > > +};
> > > > +
> ...
> 
> Jonathan
> 
> 

yours,
Song Qiang
