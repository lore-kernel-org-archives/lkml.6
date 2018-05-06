Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3624995-1525631264-2-10783235807571166975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525631264; b=RyxUkVsf5PligG1ttTM4Hrh9+sVD+LoybGhcusvv9/Sm59+uIy
    2IO/JKt4EFSzsKGJ3Pl3uLfy0bWd8KcF3JYUGBQT4m+bAGRyStxysM3QDb9M3Rx9
    sn2E75a5a6AO1KmVTwtLS99DGdAYYvZLuhS4/moME18PhxnEnjWzrpXfgLU1jKl8
    22vDDJmccwlpXnHKxOTMM9685b4W50hIhLKxasCz7mY/IGkvD+PydMK8fSoNXCV6
    8BsqZI7JgwrBJ13dlrWFsdhveJeRoQEFmDLXyIKtH9MVB0jCOS2PIH8rQLNL9yX1
    AREMAdZ251sxNWfJNAHMnR8dqnfPpVQ8uKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525631264; bh=kvLOK
    hNA+NFNhW7FxA6Y81OrVFzj+ScT3Do3mRIUx5U=; b=Qsf/dSKYb7GYoPpyJdtVk
    0hEWPBSPBG1hisJUxviQz146iViDFXTc02YL4ZAXwTAOgAzNjhy2QPgze14TSeT1
    xnmF3evk4e8ZBZJgJZm62QVIf56aIpqMP5roKXfWdaOexnIWRaIgr90IdZN4yw0H
    M3qIfA9ug327KbYPhby21psKOb0rE3JbhUlMSWVmjP2cR584EtRcvaggoloJX9mB
    nPKR9PZD9FmDB1oFeY4oWLopnCjyQOkLx1LMWmlrQgzzZkiglKt/T1gkR+SZ9LyS
    e2oY6xdV/YKId7KLoKw+Ng4KrhX6/Csn8oRDcCwRSThezCN8eAu+AY6kayQFqNU3
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=XPQCj6zn x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=XPQCj6zn x-bits=1024
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
X-CM-Envelope: MS4wfCkBQQT4+feITBg/kdLYFdBMGqpOXwuFsORaZjn7T4/GHwxMWibFpSOwJgMod6nAitjThdyT5okk2CD+bXdNO8DMD+tPBZUs4tpZHdHP4fwinjX5NYAw
    rJZcHeB7O3tEh/H4EShsYM6pwiaBcTIL3potwW1KAFpV98pQPJbyDyvsJRHSAjw4+iFOJHsrJyQv/xjtOf77XtLQKJuiCrGxdwWjCXqHGkjYUuA/VDomyVME
    yerjPXzVVf3C5h3cgn4D5g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=m_XUjyPcqPfBfQJ_A-4A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:27:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 09/11] staging: iio: tsl2x7x: correct
 IIO_EV_INFO_PERIOD values
Message-ID: <20180506192731.665432e0@archlinux>
In-Reply-To: <20180504025319.28953-10-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-10-masneyb@onstation.org>
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

On Thu,  3 May 2018 22:53:17 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The thresh periods assumed an integration time of 3ms. This patch adds
> support for the correct integration time (2.72ms or 2.73ms). The code
> had the ALS filter values as going up to 15, however the values actually
> went up to 60 since the values scaled in increments of 5 once the
> persistence value went above 3.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Looks fine, but dependent on earlier patch so I can't take it yet.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 44 +++++++++++++++++++++----------------
>  drivers/staging/iio/light/tsl2x7x.h |  1 -
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 39de5e60fd33..f912f4bc61c4 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -103,8 +103,6 @@
>  #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
>  #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
> -#define TSL2X7X_MIN_ITIME		3
> -
>  /* TAOS txx2x7x Device family members */
>  enum {
>  	tsl2571,
> @@ -972,7 +970,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  				     int val, int val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL, y, z, filter_delay;
> +	int ret = -EINVAL, count, persistence;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1011,15 +1009,20 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		else
>  			time = chip->settings.prox_time;
>  
> -		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> -		z = y * TSL2X7X_MIN_ITIME;
> +		count = 256 - time;
> +		persistence = ((val * 1000000) + val2) /
> +			(count * tsl2x7x_int_time[chip->id].increment_us);
>  
> -		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
> +		if (chan->type == IIO_INTENSITY) {
> +			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
> +			if (persistence > 3)
> +				persistence = (persistence / 5) + 3;
> +
> +			chip->settings.als_persistence = persistence;
> +		} else {
> +			chip->settings.prox_persistence = persistence;
> +		}
>  
> -		if (chan->type == IIO_INTENSITY)
> -			chip->settings.als_persistence = filter_delay;
> -		else
> -			chip->settings.prox_persistence = filter_delay;
>  		ret = 0;
>  		break;
>  	default:
> @@ -1040,7 +1043,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  				    int *val, int *val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL, filter_delay, mult;
> +	int ret = -EINVAL, filter_delay, persistence;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1076,18 +1079,21 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  	case IIO_EV_INFO_PERIOD:
>  		if (chan->type == IIO_INTENSITY) {
>  			time = chip->settings.als_time;
> -			mult = chip->settings.als_persistence;
> +			persistence = chip->settings.als_persistence;
> +
> +			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
> +			if (persistence > 3)
> +				persistence = (persistence - 3) * 5;
>  		} else {
>  			time = chip->settings.prox_time;
> -			mult = chip->settings.prox_persistence;
> +			persistence = chip->settings.prox_persistence;
>  		}
>  
> -		/* Determine integration time */
> -		*val = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> -		*val2 = *val * TSL2X7X_MIN_ITIME;
> -		filter_delay = *val2 * mult;
> -		*val = filter_delay / 1000;
> -		*val2 = filter_delay % 1000;
> +		filter_delay = persistence * (256 - time) *
> +			tsl2x7x_int_time[chip->id].increment_us;
> +
> +		*val = filter_delay / 1000000;
> +		*val2 = filter_delay % 1000000;
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	default:
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 1097ee890ce2..f74427f4ab6e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -31,7 +31,6 @@ struct tsl2x7x_lux {
>  #define TSL2X7X_50_mA                   0x01
>  #define TSL2X7X_25_mA                   0x02
>  #define TSL2X7X_13_mA                   0x03
> -#define TSL2X7X_MAX_TIMER_CNT           0xFF
>  
>  /**
>   * struct tsl2x7x_settings - Settings for the tsl2x7x driver

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
