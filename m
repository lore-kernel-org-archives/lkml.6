Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3584689-1525630073-2-5816109248709625124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525630072; b=GobOlLhtFl2rBgJMWB4xzlHu4Ia9sBpHDF+CByyltJI9aatZbC
    s4CXgZU6d8t+Pqjje/ihLz+0+KC2/Lanf9qlku1Rf95Ix0OmMcQUK0GzGpgqDe4c
    yRh5ueR94lWSJUDVv618uyxofoWS/jeYaoP2lvbM7RH2TQYnnFsWb2PLGhd8LKOO
    ZihLPMdR0HfoFF+QUxek0rjpsquu0yIi4YyUrwn+wv/gZQbrAPIfnX7nKz32VP1z
    LeHuqqcQtradcqdpriJp7jQ5P8jve5W5LmJwk61BdCf55xdPqQIXpzqIeJ9a2qCS
    C9TBF6kE7kx9pbdy/fjdBTyJenRvPNJUlQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525630072; bh=uPOzY
    ao1nQGslX5FRh845REKpDb5tFKz9enGLZ8c4U4=; b=XgTxnQ/73rZU2QzIOkHjF
    TqNIOYcF+L5VaanH3oH+tGV49JYxmeae76XOeffRzH14/WqR2vva+FQvTjswgnpJ
    uHKzkYXLr13vO2qbcXNlBms15nR8kCuCb/FiwUhEQAXhS2ygAb6yJnPpdXPjNw9i
    uFb5zanEFtzW6PoSjc0Zlp4i5DsM03oKWDDT3h6/smR8K8JkCzbt4LjpUKGyiJYL
    lc9FCSLs2SQH2+aCDXucoXmla1WFg/DRgTCCYOpsixGl0NEjAmCp5GLChKdgZaUx
    J1wwXUe/gK+n3vvUWEGVmknZV5yMdejW5zPeISYCgfdCJkyu6ZmppCqd9JmTInXT
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=CACcfUym x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=CACcfUym x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCsTxvBeN2BJVBGlgBKWVUxDGf6e9+GfdoXmyk9lltUWh+gdkbxXautUjstJRDNVGpdcjufxyDwKru82HtvB7jCaw4V111oW6ATeREtdDKAwbxdmZKIH
    82TII36tTIzDZZ6kzceEuEVELDfZiBipzw76YIAebfX+nPskVyWSgqBq9j2L/2aHH1Ph6dXoxz5jhIuiquKD3U0/l6zQtTbMd1ANOmsP8GlOfWj9+7EiCQkZ
    fWzji/BJBaDu2gDvcv4KSQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=WTOAslDOv-5xCtRy7DkA:9 a=CRzyQBbeXNDlVwNG:21 a=vDFPNHmd0fwztZn3:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:05:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 03/11] staging: iio: tsl2x7x: don't setup event
 handlers if interrupts are not configured
Message-ID: <20180506190509.2b8098d8@archlinux>
In-Reply-To: <20180504025319.28953-4-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-4-masneyb@onstation.org>
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

On Thu,  3 May 2018 22:53:11 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The driver would expose to userspace the events directory even if the
> interrupts were not configured. This patch changes the driver so that
> the events directory is not exposed to user space if interrupts are
> not configured. This patch also corrects the indentation of the
> chan_table_elements and info structure members.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 130 +++++++++++++++++++++++++++++++-----
>  1 file changed, 112 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index b4d77f65ca12..7e8db5178a2c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -134,8 +134,9 @@ struct tsl2x7x_als_info {
>  
>  struct tsl2x7x_chip_info {
>  	int chan_table_elements;
> -	struct iio_chan_spec		channel[4];
> -	const struct iio_info		*info;
> +	struct iio_chan_spec channel_with_events[4];
> +	struct iio_chan_spec channel_without_events[4];
> +	const struct iio_info *info;
>  };
>  
>  struct tsl2X7X_chip {
> @@ -1447,7 +1448,7 @@ static const struct iio_event_spec tsl2x7x_events[] = {
>  
>  static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  	[ALS] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
> @@ -1469,11 +1470,31 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 1,
>  			},
>  		},
> -	.chan_table_elements = 3,
> -	.info = &tsl2X7X_device_info[ALS],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			},
> +		},
> +		.chan_table_elements = 3,
> +		.info = &tsl2X7X_device_info[ALS],
>  	},
>  	[PRX] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_PROXIMITY,
>  			.indexed = 1,
> @@ -1483,11 +1504,19 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 1,
> -	.info = &tsl2X7X_device_info[PRX],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			},
> +		},
> +		.chan_table_elements = 1,
> +		.info = &tsl2X7X_device_info[PRX],
>  	},
>  	[ALSPRX] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
> @@ -1517,11 +1546,37 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 4,
> -	.info = &tsl2X7X_device_info[ALSPRX],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			}, {
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			},
> +		},
> +		.chan_table_elements = 4,
> +		.info = &tsl2X7X_device_info[ALSPRX],
>  	},
>  	[PRX2] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_PROXIMITY,
>  			.indexed = 1,
> @@ -1532,11 +1587,20 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 1,
> -	.info = &tsl2X7X_device_info[PRX2],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			},
> +		},
> +		.chan_table_elements = 1,
> +		.info = &tsl2X7X_device_info[PRX2],
>  	},
>  	[ALSPRX2] = {
> -		.channel = {
> +		.channel_with_events = {
>  			{
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
> @@ -1567,8 +1631,35 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			},
>  		},
> -	.chan_table_elements = 4,
> -	.info = &tsl2X7X_device_info[ALSPRX2],
> +		.channel_without_events = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			}, {
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			},
> +		},
> +		.chan_table_elements = 4,
> +		.info = &tsl2X7X_device_info[ALSPRX2],
>  	},
>  };
>  
> @@ -1620,10 +1711,11 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	indio_dev->dev.parent = &clientp->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = chip->client->name;
> -	indio_dev->channels = chip->chip_info->channel;
>  	indio_dev->num_channels = chip->chip_info->chan_table_elements;
>  
>  	if (clientp->irq) {
> +		indio_dev->channels = chip->chip_info->channel_with_events;
> +
>  		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
>  						NULL,
>  						&tsl2x7x_event_handler,
> @@ -1636,6 +1728,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  				"%s: irq request failed\n", __func__);
>  			return ret;
>  		}
> +	} else {
> +		indio_dev->channels = chip->chip_info->channel_without_events;
>  	}
>  
>  	tsl2x7x_defaults(chip);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
