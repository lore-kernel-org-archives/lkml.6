Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1356340-1526124227-2-11065262845639775713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526124226; b=PLh7uXpdnkOE1I3Bn2Agtovcox1QsT+WHjmqnLIfBAQnQsGKbv
    vCmT59qGyRieakndIFsSvvUfwpFChu55xPYlVl3sSBbAa5vjAy7TvjGSCqecrH3l
    bPDvm4VHw/7UgFV3GxGRczTI68W422kyBmxF0Ysxs0nrMefeauSdAP6H3oxkt6+x
    ud1Owvow6eq8VK/chgdb5X4HDvRrb+S2XCQGHSxEaRW8me59I3tYU1loXQwUqaeB
    HR4qssWV52pT3kaAI+jWgExHZF9rdunFly/o1LCT05l4/7wRk1BgfWxyMqtFq/c4
    3aI/HFAlaa/et+iY/1BNcKffULN3Ie2xdNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526124226; bh=WTYE1
    BE19I+4drqL88GBhCWM0uQWBHNRWUyLFSvHvNc=; b=TkfzrCVVBt7L5ZuBClG24
    OxwCjDPJW/RhqZOWBtnxmXIjeTAifEPMINKDaxdI0eXyBinS+C8NIhGXbSZjjmMM
    H4b9Q3wOoJ/Sru1G93xwhawsyZBL0zjKbSFnb85SBRgKjhkGxNwILa+A2hPvTdfg
    IUB+VJA7GNql2dn8+HT+QcgoszXEGIkPiFAWKVswZXbKzajU47tKcjEskEatFJM1
    Q15Db0eeWU7xfhOv2rP3DKWd1B2ftd3hMen6a81sc7sDnT0/Ubcnx9IaHxluSvlT
    jk3AjWHMMP1VFKG/IeI8kYV6LHb/4NXzgq3MMfT2SFCt97xmuVwQbZgJYa3+/tRd
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=iLv+0Tg6 x-bits=1024
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=iLv+0Tg6 x-bits=1024
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
X-CM-Envelope: MS4wfEbIs6wI4resHKtRwkzmW2xLNQj7y5peC5WMyyC/neRAblA5S9EZZbN1lnYh2l6yhjgJHbqGhAnF1NFF9CbDQa7tGwlvOQQyCuJy2FL7HEYk5Af8sCHm
    OinIaf3FT+bmB+aNiYJMC6ql4UXZWYiMmBMGuGLS4Tksuzd9CSyB+TxBl5sn930PQz89B+b6eKKNVdSE5TvsB9KS2+fCIoE37KWrkJjFHVPn8QlygcgXUTja
    D7niU8WbBSD9cAbwewtePQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=AdPiJSsXkA684NyzUdkA:9 a=FPexGSlng_er6dUu:21 a=KVBT745Aa1u__eCZ:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:23:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 7/9] staging: iio: tsl2x7x: add range checking to
 tsl2x7x_write_raw
Message-ID: <20180512122334.79c1bd66@archlinux>
In-Reply-To: <20180511001223.12378-8-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-8-masneyb@onstation.org>
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

On Thu, 10 May 2018 20:12:21 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The CALIBBIAS and INT_TIME masks in tsl2x7x_write_raw did not have any
> range checking in place so this patch adds the appropriate range
> checking. The defines TSL2X7X_ALS_GAIN_TRIM_{MIN,MAX} are also
> introduced by this patch.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 0218eabcd6d7..f9500afab30c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -103,6 +103,9 @@
>  #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
>  #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
> +#define TSL2X7X_ALS_GAIN_TRIM_MIN	250
> +#define TSL2X7X_ALS_GAIN_TRIM_MAX	4000
> +
>  /* TAOS txx2x7x Device family members */
>  enum {
>  	tsl2571,
> @@ -581,7 +584,7 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  
>  	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
>  			lux_val;
> -	if (ret < 250 || ret > 4000)
> +	if (ret < TSL2X7X_ALS_GAIN_TRIM_MIN || ret > TSL2X7X_ALS_GAIN_TRIM_MAX)
>  		return -ERANGE;
>  
>  	chip->settings.als_gain_trim = ret;
> @@ -1209,9 +1212,17 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < TSL2X7X_ALS_GAIN_TRIM_MIN ||
> +		    val > TSL2X7X_ALS_GAIN_TRIM_MAX)
> +			return -EINVAL;
> +
>  		chip->settings.als_gain_trim = val;
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0 || val2 < tsl2x7x_int_time_avail[chip->id][1] ||
> +		    val2 > tsl2x7x_int_time_avail[chip->id][5])
> +			return -EINVAL;
> +
>  		chip->settings.als_time = 256 -
>  			(val2 / tsl2x7x_int_time_avail[chip->id][3]);
>  		break;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
