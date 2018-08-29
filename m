Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B02084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="iFjlBOCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeH2Kjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:39:40 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21385 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2Kjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1535525031; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=YkA5K7a3dkq7S7tBY3gSeNCj9mQrBObPbCAZsMmXreUqzqHefRPw9UFPL0PK2Ars2F6wIEIau/xoed4S0fOcL1JKz+D+vVQnnr7/Rza/0souBhzk840AwC+48KD9plDsYjmr3s2SUXHw1UOIPsDYVUKPSM9we5aNDVhaDH2XzFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1535525031; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=r2fqLVg/1Vlo01ObBBRukiZ65tvYbwtEDKVR299e7Qc=; 
        b=SArasVwyQNOKkxc23d8KLvM1CIjNNRaUc0VKiYFwQBSrpOjy2uzOBOEzZ3VHZRbt0NeBEmFxtS3pXKqgJSAPq1J9PnLDGKupjOy+1Nh2IE6l8dOpwEco0Bq3y3h0lNHMp3a292X0uUArKB0kDLZP++Jf8jQfIv7SdqXOr0815d4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1535525031;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        l=7866; bh=r2fqLVg/1Vlo01ObBBRukiZ65tvYbwtEDKVR299e7Qc=;
        b=iFjlBOCj6sHrrxLP9WgAUUnQav65iDgxlW1bqpDrIgn8lGnbKeBz4EtRycVyweRZ
        Xh3rsY45OiFYRBQgSaES6Z3cweWHy7+G3gnDnRB6FHTBxU6kMGXhZ953+eWt0LVeKea
        WK4SpfWGGPDCn3nPyg0ld8paOV21Fz1r9+rbAxx4=
Received: from AYYLMAO-H (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1535525030142965.4630352508661; Tue, 28 Aug 2018 23:43:50 -0700 (PDT)
Message-ID: <d6c71f8699a0ee8eb09417381e301246b864e69e.camel@az8.co>
Subject: Re: [PATCH 1/4] iio: gyro: add support for fxas21002c
From:   Afonso Bordado <afonsobordado@az8.co>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 29 Aug 2018 07:43:48 +0100
In-Reply-To: <20180827180805.7d4b9f4e@archlinux>
References: <20180825211910.22929-1-afonsobordado@az8.co>
         <20180827180805.7d4b9f4e@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 18:08 +0100, Jonathan Cameron wrote:
> On Sat, 25 Aug 2018 22:19:07 +0100
> Afonso Bordado <afonsobordado@az8.co> wrote:
> 
> > FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
> > 
> > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> 
> Hi,
> 
> Driver is pretty clean so only a few minor comments inline.
> If we were late in a cycle I'd probably just have taken it and fixed
> up
> but as we have lots of time and I'm inherently lazy I'll let you do a
> v2 :)
> 
> Good job, thanks!
> 
> Jonathan

Great!


> > +
> > +static const struct regmap_access_table fxas21002c_volatile_table
> > = {
> > +	.yes_ranges = fxas21002c_volatile_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_volatile_ranges),
> > +};
> > +
> > +const struct regmap_config fxas21002c_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +
> > +	.max_register = FXAS21002C_REG_CTRL_REG3,
> > +	// We don't specify a .rd_table because everything is readable
> 
> /* ... */
> 
> Please run checkpatch as IIRC it complains about this.

I've replaced all instances of C99 comments with ANSI comments.
However, has Joe Perches mentioned. Checkpatch did not warn me about
this.

> > +	.wr_table = &fxas21002c_writable_table,
> > +	.volatile_table = &fxas21002c_volatile_table,
> > +};
> > +EXPORT_SYMBOL(fxas21002c_regmap_config);
> > +
> > +#define FXAS21002C_GYRO_CHAN(_axis) {				
> > 	\
> > +	.type = IIO_ANGL_VEL,						
> > \
> > +	.modified = 1,							
> > \
> > +	.channel2 = IIO_MOD_ ## _axis,					
> > \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			
> > \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		
> > \
> > +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > +	.address = FXAS21002C_REG_OUT_ ## _axis ## _MSB,		\
> > +}
> > +
> > +static const struct iio_chan_spec fxas21002c_channels[] = {
> > +	{
> > +		.type = IIO_TEMP,
> > +		.address = FXAS21002C_REG_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> 
> As it currently stands it is IIO_CHAN_PROCESSED but I'd prefer you
> provided
> the scale and kept it as _RAW.

Changed in v2. I'll provide scale + raw.

> > +	},
> > +	FXAS21002C_GYRO_CHAN(X),
> > +	FXAS21002C_GYRO_CHAN(Y),
> > +	FXAS21002C_GYRO_CHAN(Z),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +static int fxas21002c_set_operating_mode(struct fxas21002c_data
> > *data,
> > +					 enum fxas21002c_operating_mode
> > om)
> > +{
> > +	int ret;
> > +	int mask = 0;
> 
> Might be clearer to not set this here and...
> > +
> > +	switch (om) {
> > +	case FXAS21002C_OM_STANDBY:
> 
> 		mask = 0;
> > +		break;
> > +	case FXAS21002C_OM_READY:
> > +		mask |= FXAS21002C_READY_BIT;
> 
> 		mask = FXA210002C_READY_BIT;
> > +		break;
> > +	case FXAS21002C_OM_ACTIVE:
> > +		mask |= FXAS21002C_ACTIVE_BIT;
> 
> 		mask = FXA21002C_ACTIVE_BIT;
> 
> Slightly more readable I think...

I Agree.

> > +static int fxas21002c_read_oneshot(struct fxas21002c_data *data,
> > +				   struct iio_chan_spec const *chan,
> > int *val)
> > +{
> > +	int ret;
> > +	int raw;
> > +	__be16 bulk_raw;
> > +
> > +	switch (chan->type) {
> > +	case IIO_ANGL_VEL:
> > +		ret = regmap_bulk_read(data->regmap, chan->address,
> > +				       &bulk_raw, sizeof(bulk_raw));
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = sign_extend32(be16_to_cpu(bulk_raw), 15);
> > +		break;
> 
> return IIO_VAL_INT directly here.

Sure

> > +	case IIO_TEMP:
> > +		ret = regmap_read(data->regmap, chan->address, &raw);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = raw * 1000; // Convert to millicelsius
> 
> Don't use c++ style comments in kernel code please.
> 
> Also I wouldn't do this multiplier in here, I'd provide the scale
> attribute.
> The reason is that we may later have support for buffered reads from
> this
> device - at that point we will want to have nice 8 bit data rather
> than having
> a scaled value that isn't quite a whole number of bits.

This makes sense, I'll put in the SCALE bit for temp.

> > +		break;
> 
> return IIO_VAL_INT; directly here.
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> 
> With the above two changes in place this return is never reached.

Changed in v2.

> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int fxas21002c_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan, int
> > *val,
> > +			       int *val2, long mask)
> > +{
> > +	struct fxas21002c_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		return fxas21002c_read_oneshot(data, chan, val);
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (chan->type != IIO_ANGL_VEL)
> > +			return -EINVAL;
> 
> This check is a bit over paranoid given there is no way
> this would be called in with a different type.
> 
> Doesn't do any real harm though.

This no longer applies with the temp changes included in v2.
However, i'd still like to leave it for IIO_CHAN_INFO_SAMP_FREQ.

> > +
> > +		*val = 0;
> > +		*val2 = FXAS21002C_DEFAULT_SENSITIVITY;
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (chan->type != IIO_ANGL_VEL)
> > +			return -EINVAL;
> > +
> > +		*val = FXAS21002C_DEFAULT_ODR_HZ;
> > +
> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info fxas21002c_info = {
> > +	.read_raw		= fxas21002c_read_raw,
> > +};
> > +
> > +static int fxas21002c_probe(struct i2c_client *client,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	int ret;
> > +	struct iio_dev *indio_dev;
> > +	struct fxas21002c_data *data;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +
> > +	data->regmap = devm_regmap_init_i2c(client,
> > &fxas21002c_regmap_config);
> > +	if (IS_ERR(data->regmap)) {
> > +		ret = PTR_ERR(data->regmap);
> > +		dev_err(&client->dev,
> > +			"Failed to allocate regmap, err: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->channels = fxas21002c_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(fxas21002c_channels);
> > +	indio_dev->name = id->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &fxas21002c_info;
> > +
> > +	ret = fxas21002c_verify_chip(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = fxas21002c_reset(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = fxas21002c_set_operating_mode(data,
> > FXAS21002C_OM_ACTIVE);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to register iio
> > device\n");
> > +		fxas21002c_set_operating_mode(data,
> > FXAS21002C_OM_STANDBY);
> > +		return ret;
> 
> We may potentially get a patch as one of the static analysis tools
> will point
> out that return ret could be dropped out of the brackets without
> changing the
> code (ret is 0 in this case as iio_device_register never returns
> positive)
> 
> Really minor though!

Will be fixed in V2.


> > +
> > +static int fxas21002c_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct fxas21002c_data *data = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	fxas21002c_set_operating_mode(data, FXAS21002C_OM_STANDBY);
> 
> You could have used the devm_add_action to allow the managed cleanup
> to handle
> this and hence gotten rid of the remove function.
> 
> (minor suggestion and somewhat a matter of personal taste).

I didn't know this existed! Changed in v2.



