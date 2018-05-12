Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1362021-1526123774-2-1258751589446050922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526123773; b=mjkNuVycaEdZHNJIq96S9btYpklR5NY3Cb3X/Fo3Fc9lwSBTe1
    YRz77Um9fkefOWGhswp1J+Z78/Ddd6nvxWcZ6baSjiRhxhcGNfxofWC0agB+067/
    6oHwsPdp0ekjw0I4Oro8cYxWVJMzsIBK5myIuy6OgI3BMsQt812BrqtBBEQO5j2y
    z4p0wOXcOl5fhvukRR4mXk52CSLG+Dz39PIieVpxMKFSB25rsS6o0Z+dlgK8H3YU
    E3mJbZG8rgKB8le+3k+lO96EXeg62bnStvyoF16ZCiWCuAJekGu6vQ+tYT8Hv3Q4
    7Jb8Pe6vh9Fr4bYRXXv6mNsp2ON4Es9hPGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526123773; bh=N5mnU
    MZmvbFCYT87zx/okjtsd0C2Zzy2wNUUHerlq8o=; b=OliYeIR4o2JNhMHJrEYl7
    6lmFxy3NzMdBk1Hc6zNjb9EwsVulq/lSD3WSwLvDnBUl+7a0CJfEYE+gJEl+ap7G
    NebTmaROQFUOrJ89+zwA2Qfmu/pd7zAI4tDUbWtBDlOSQdmH0nztW9KrYncW1bUU
    OGGHXm4LaV0H9ym9zJb3taZM/XeJu/tkodhIrS8MHN5VkNKnGcRq7T97o8y9cOGf
    Jrd7HRSGadCJQy63jP/vFfApukmnWgNlD53SYNyDqJpDCPxpqRFfHLiRCPXkCXoB
    GYqCNyGlxLY/w9OIu2Qd4s887PxbDwSJQaZGR1JjTKSnPkoOYHfxEakZwOz1Uo4d
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=OK6VANby x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=OK6VANby x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBXmYWo86FOGWfwllru6ukd3j/Mo3UogdJ5lposfXJqHKG4Pv09OEhB/pj7ejymKpT0UDuXY0UZqhuOiUQw9hFJMsQ1xTWOcpDn8BMd13q25mbYHKePr
    ZkqvQKPxDlHXR/uCB0gwiSeniZuWnsSLrQSsdtrJeYHCl5DGODaEs5SU8EAay06lP32xoGDNl4KdtTef4zRWbli3DL4JzXwbJhNz6EJrxFmEkzYt83ZVWktL
    k3UD4i/VT8bezxyMagrgtg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=k640k6r-7tPjNoMWl40A:9 a=ueX3zXoEFdrQWQ0Y:21 a=P85_kELgzubw84jv:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:16:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 2/9] staging: iio: tsl2x7x: use direct returns
Message-ID: <20180512121601.4e849815@archlinux>
In-Reply-To: <20180511001223.12378-3-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-3-masneyb@onstation.org>
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

On Thu, 10 May 2018 20:12:16 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch changes the functions tsl2x7x_read_event_value() and
> tsl2x7x_read_raw() to use direct returns to simplify the code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied, thanks

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 49 ++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 3ae2fd19ae9c..c1e726fc87b7 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1014,7 +1014,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  				    int *val, int *val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL, filter_delay, mult;
> +	int filter_delay, mult;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1023,27 +1023,23 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
>  				*val = chip->settings.als_thresh_high;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			case IIO_EV_DIR_FALLING:
>  				*val = chip->settings.als_thresh_low;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			default:
> -				break;
> +				return -EINVAL;
>  			}
>  		} else {
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
>  				*val = chip->settings.prox_thres_high;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			case IIO_EV_DIR_FALLING:
>  				*val = chip->settings.prox_thres_low;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			default:
> -				break;
> +				return -EINVAL;
>  			}
>  		}
>  		break;
> @@ -1062,13 +1058,10 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  		filter_delay = *val2 * mult;
>  		*val = filter_delay / 1000;
>  		*val2 = filter_delay % 1000;
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
> @@ -1078,7 +1071,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -1086,12 +1078,10 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		case IIO_LIGHT:
>  			tsl2x7x_get_lux(indio_dev);
>  			*val = chip->als_cur_info.lux;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
> @@ -1100,13 +1090,11 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  				*val = chip->als_cur_info.als_ch0;
>  			else
>  				*val = chip->als_cur_info.als_ch1;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_PROXIMITY:
>  			tsl2x7x_get_prox(indio_dev);
>  			*val = chip->prox_data;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1116,22 +1104,17 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			*val = tsl2x7x_als_gain[chip->settings.als_gain];
>  		else
>  			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		*val = chip->settings.als_gain_trim;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = 0;
>  		*val2 = (256 - chip->settings.als_time) * 2720;
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static int tsl2x7x_write_raw(struct iio_dev *indio_dev,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
