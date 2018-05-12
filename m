Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1356340-1526124046-2-9589059411295081230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526124046; b=ckMbQjMT0kgkB2q6FqxUwYheeLzmT9GVxo0t23A9hH7cKlBx4i
    czPqGGhUE1rfs1+2JgGAzxTnJPUAX564IXXv9IMKTSaNBotVQJtQKPHnwXH3IpQp
    wFSsNngKtsEFRQDRV32XYs+vQ4xKH7aSbaCbWZr+4Zroq4XAV68WY1ZiLq90ZV5F
    KL4VhRYD2AsU2LUVPMxVNttaH2gc1vbPoN1YemldbZ9TYj38naTLxgiO1OaHQtJw
    GXAOpJtTHBw44dywCWDQoUr9oKs4SAIGBRINT1zYaRFGB5kxEV+B5kcQEcRtExb/
    77Rp34hWH72ZBN2tD5KVmMP2/5e0IivET+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526124046; bh=/fmW9
    lfSIQeh8SSQRTk6wE9vRu5PL4rFi+ovVQVww2M=; b=XZV8tnQ86wWb4nAOxBunO
    /J/d/O1s7JvgopB6yDzsf7r2Tc7Z2zld6v1AQvGCCajLCER0SziN+sntl/rqia9M
    XaFapBp89LlxHdU8VZFpRm1RaCT1puXXXvKrZje+8p2XTvTpsrvUH/iNRyzFv499
    KUrsu8VdJbIhQoAQpJtV8iVe+s0bfMf7rlYPNNow7u595wdFJ9/sIajuSvF8mS65
    DPfUcJLd/FpAlFZFGUu6AdaiK+DTGT6EzO2FB+yLt5CVjoIvisE6YvNTJSw0Pseh
    OHcu8jd8tDXfnBGIvT6JHFbcq4Uf3MxkWm1EhqP60Fx3E8Rs9omuhHdjqLFl5x9u
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=DKwZAGFK x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=DKwZAGFK x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHf9KCIuEI/o06unELgZLiYXcOdo4PUa1+ootYoSE2HjHL//XCn5esRtEHOuhNsEimrPDY5ILKHRBXYWFcamV57Ixtx8+J8GxKW0O65JV/nqkYy1EYV6
    vSIqheUWvO5rGDj0syqJnK5okXR56b/P0+l49Hv+KzZ2jkCnCgbniXGt/Z9WDXEnQOMxu2/4J3nOqFgMSURsdA85CcHcwY+IZQx+fKrJEFwhKjuY+M88oajT
    GbqD1+jqeXUWuJRAatz4qw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=WLoDCMrLxlQQnxjQalEA:9 a=gy-2AqWyNObWuakb:21 a=CexCXr1NYTaR0tAZ:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:20:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 5/9] staging: iio: tsl2x7x: convert to use read_avail
Message-ID: <20180512122028.31205986@archlinux>
In-Reply-To: <20180511001223.12378-6-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-6-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, drew.paterson@ams.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 10 May 2018 20:12:19 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Make the sysfs attributes in_proximity0_calibscale_available, and
> in_intensity0_{calibscale,integration_time}_available be created
> using info_mask_separate_available on the channel configuration.
> 
> The driver assumed that the ALS increment was 2.72 ms, and the upper
> range was 696 ms. Some other supported devices use 2.73 ms - 699 ms.
> This patch adds support for the multiple ranges.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Nice thank you.

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 93 ++++++++++++++++++++++++++++++-------
>  1 file changed, 76 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 51c1a90cb592..2d713d3c7c7b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -209,9 +209,9 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  };
>  
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> -	.als_time = 255, /* 2.73 ms */
> +	.als_time = 255, /* 2.72 / 2.73 ms */
>  	.als_gain = 0,
> -	.prox_time = 255, /* 2.73 ms */
> +	.prox_time = 255, /* 2.72 / 2.73 ms */
>  	.prox_gain = 0,
>  	.wait_time = 255,
>  	.als_prox_config = 0,
> @@ -245,6 +245,23 @@ static const s16 tsl2x7x_prox_gain[] = {
>  	8
>  };
>  
> +static const int tsl2x7x_int_time_avail[][6] = {
> +	[tsl2571] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tsl2671] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tmd2671] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tsl2771] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tmd2771] = { 0, 2720, 0, 2720, 0, 696000 },
> +	[tsl2572] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tsl2672] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
> +};
> +
> +static int tsl2x7x_int_calibscale_avail[] = { 1, 8, 16, 120 };
> +
> +static int tsl2x7x_prox_calibscale_avail[] = { 1, 2, 4, 8 };
> +
>  /* Channel variations */
>  enum {
>  	ALS,
> @@ -626,7 +643,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  	/* set chip time scaling and saturation */
>  	als_count = 256 - chip->settings.als_time;
> -	als_time_us = als_count * 2720;
> +	als_time_us = als_count * tsl2x7x_int_time_avail[chip->id][3];
>  	chip->als_saturation = als_count * 768; /* 75% of full scale */
>  	chip->als_gain_time_scale = als_time_us *
>  		tsl2x7x_als_gain[chip->settings.als_gain];
> @@ -760,12 +777,33 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
> +static int tsl2x7x_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  
> -static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_INTENSITY) {
> +			*length = ARRAY_SIZE(tsl2x7x_int_calibscale_avail);
> +			*vals = tsl2x7x_int_calibscale_avail;
> +		} else {
> +			*length = ARRAY_SIZE(tsl2x7x_prox_calibscale_avail);
> +			*vals = tsl2x7x_prox_calibscale_avail;
> +		}
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(tsl2x7x_int_time_avail[chip->id]);
> +		*vals = tsl2x7x_int_time_avail[chip->id];
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_RANGE;
> +	}
>  
> -static IIO_CONST_ATTR(in_intensity0_integration_time_available,
> -		".00272 - .696");
> +	return -EINVAL;
> +}
>  
>  static ssize_t in_illuminance0_target_input_show(struct device *dev,
>  						 struct device_attribute *attr,
> @@ -1110,7 +1148,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = 0;
> -		*val2 = (256 - chip->settings.als_time) * 2720;
> +		*val2 = (256 - chip->settings.als_time) *
> +			tsl2x7x_int_time_avail[chip->id][3];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> @@ -1167,7 +1206,8 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		chip->settings.als_gain_trim = val;
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
> -		chip->settings.als_time = 256 - (val2 / 2720);
> +		chip->settings.als_time = 256 -
> +			(val2 / tsl2x7x_int_time_avail[chip->id][3]);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1248,8 +1288,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1262,8 +1300,6 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1272,18 +1308,14 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  
>  static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  	&dev_attr_in_proximity0_calibrate.attr,
> -	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
>  	&dev_attr_in_proximity0_calibrate.attr,
> -	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -1309,6 +1341,7 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
>  	{ \
>  		.attrs = &tsl2X7X_device_attr_group_tbl[type], \
>  		.read_raw = &tsl2x7x_read_raw, \
> +		.read_avail = &tsl2x7x_read_avail, \
>  		.write_raw = &tsl2x7x_write_raw, \
>  		.read_event_value = &tsl2x7x_read_event_value, \
>  		.write_event_value = &tsl2x7x_write_event_value, \
> @@ -1357,6 +1390,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1379,6 +1415,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1425,6 +1464,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1455,6 +1497,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1478,6 +1523,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
> @@ -1489,6 +1536,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			},
>  		},
>  		.chan_table_elements = 1,
> @@ -1509,6 +1558,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1522,6 +1574,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
> @@ -1540,6 +1594,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1551,6 +1608,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
>  			},
>  		},
>  		.chan_table_elements = 4,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
