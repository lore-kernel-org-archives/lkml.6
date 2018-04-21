Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524327202-2-544339597449662663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524327201; b=eyLCNGTaR0z22we1SCy6MXLMqcVOh69P9faToboPvrBzFNawKj
    R94+yJHRjwSzfho08D4Wryb8/70FbdyblI8Db9mm99eezywGTUgcdqnMICok9miY
    VlGtLj7oNeDy1jWy6Zzs3u+aCEv7hCXA7Sxh2uytIFSxYa1q6tcsNxWS3ty9HbzJ
    FYrz4dIXm+jy3ApnyMyCpjF7jQ0JOIK1q1F4CoUIFBy0Wky4bCpg5MqXDmBDEyiG
    S9F7FuIZNNfS5rOopx9tUR80qTR6v8nY4MrQelhg7JBJ1m/M8sEJcYXTsxZBy8GB
    vFzA79wNJXKJLiGRkhptgeh9TnA9bH0y6puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327201; bh=ZchSo
    JEZOnoZwfbnKH2jSkUliUwDglX1s0DeWxxHBn4=; b=c328pgCuGZxCcf0d0AAJs
    KCoxu2Xv4R7wCX8TzhA3vBQ5sMiHC7wMYmC77CbCt/N1kXSJ/3FAtAxObOh+hybC
    G7YWqM7t/xrSHVZj7xhhel5Hg4rZia3+pwKtCJDDw3Fp8r1eEyYbeiF7xP4LOYXK
    z8HZ4sfhZwgFHL80vzP/YyvWMlKKp0yO3zndL57GnCi+klxqkKVnE5MHswTFJlSb
    Go0eoCCQTE7xAdHKOyJ1RwDFIcojMdppBJpYgyccngJb8IvWDK8Bo251pnW20zpx
    pUsRSFjkUizhbzPEQ+TQ3dig8xo4W/gbPMRnCKD+D6CRs+07Z+Hkfm6vVl72WVJM
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBy5uUVtw54ErE8ret8cerGKicZTHwu2Zza6UEcZWBRxFOEzMzSG/tXYtCbxG+22I97H6qGtKKIOkVYavbA0btYifilu8Q1S1fYrkHwya0eXWUv8LKFI
    zRsD6hMaDns28pDNcg2Lx9Zk2oAoo4HY7bx6Dt57+tBo6zj/RrRmhPfsceTV7wcOwpjR8RUMhoqTg+h3634Q51as0Q3fIgB0RM9RDioGyaUZ+8Qh0oshXvHt
    XT58PdKAiprUBNg0ZQW7nw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=-1Da9mCGOl95vYkPrEUA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B2F20C09
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:13:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 01/13] staging: iio: tsl2x7x: move integration_time*
 attributes to IIO_INTENSITY channel
Message-ID: <20180421171308.3f67c3f8@archlinux>
In-Reply-To: <20180421004153.19073-2-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-2-masneyb@onstation.org>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 20:41:41 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The integration_time* attributes are currently associated with the
> IIO_LIGHT channel but should be associated with the IIO_INTENSITY
> channel. Directory listing of the sysfs attributes for a TSL2772
> with this patch applied:
> 
> dev
> events
> in_illuminance0_calibrate
> in_illuminance0_calibscale_available
> in_illuminance0_input
> in_illuminance0_lux_table
> in_illuminance0_target_input
> in_intensity0_calibbias
> in_intensity0_calibscale
> in_intensity0_integration_time
> in_intensity0_integration_time_available
> in_intensity0_raw
> in_intensity1_raw
> in_proximity0_calibrate
> in_proximity0_calibscale
> in_proximity0_calibscale_available
> in_proximity0_raw
> name
> of_node
> power
> subsystem
> uevent
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 9991b0483956..eeccfbb0eb1f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -827,7 +827,7 @@ in_illuminance0_calibscale_available_show(struct device *dev,
>  
>  static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
>  
> -static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
> +static IIO_CONST_ATTR(in_intensity0_integration_time_available,
>  		".00272 - .696");
>  
>  static ssize_t in_illuminance0_target_input_show(struct device *dev,
> @@ -1358,7 +1358,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available
> +	&iio_const_attr_in_intensity0_integration_time_available
>  		.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1373,7 +1373,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available
> +	&iio_const_attr_in_intensity0_integration_time_available
>  		.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1389,7 +1389,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available
> +	&iio_const_attr_in_intensity0_integration_time_available
>  		.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1489,13 +1489,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			.event_spec = tsl2x7x_events,
> @@ -1529,13 +1529,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			.event_spec = tsl2x7x_events,
> @@ -1578,13 +1578,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.type = IIO_LIGHT,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			.event_spec = tsl2x7x_events,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
