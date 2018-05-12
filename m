Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1356340-1526124130-5-6421150146519307289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526124130; b=YVY8WTeljwMjdOJVyxHndujysle+X+jKnYU5z1xpTioibUomg3
    ruhcOlNoKm02wkIST3ZLjL/CQnnlMhgd64sITijmcZWTJqMqtXSmdh9zEqP7ZBu3
    3qsXVB/eWW/+u+LIRgDEbHJnbjCg5KADDb3JeKaayJd//s/WZSstrke7FxGpe2ra
    Th8lQ1wgpag0FIiv+9QGocEcs5ArrUCv9Oa9QXvqTkKDa1dwDw+6hxqOPW6K4hWR
    XI0/8m9CZfmUnxX3uKl4r7btZoJ9ls4/IDJQzlZHrBanUFaO9BFJqzdnwhgCfvQe
    Akox8Jn2py9j5aHQd8vtcUgOwvDUjQ/JLehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526124130; bh=bUT+E
    YO5DrPFNcJCb/1F7naXXjVEBAqjzdLhg99KUgU=; b=MtEt8l9qKxhv7+qgGK1Ks
    uwjbW4LNoxGQHimgUNo+U2lEZ8WFTZ3nkC9f9SUU3J43mxr81esNuJ2ELP5pu4c3
    Ql961fHMyssIWLjJC6Q+HZ4Oc2TQX+rPfLmEGYUGdEu06n7j3acCkGnZLjuVVPI5
    DKlrHWckuRlaoKsZKuDTDX01EnlE0UcWdqAj10TFQP2t2V1VarDYEvHqxK+F3WGB
    6O4sf+KLvi/tdkuEZpaWfXXYY7eFrVLtTse82wnSxO8uM3DSeyfrNxcl+UAUsneC
    TfKI3A3ygzYst5ycw6SUxDoICcet0iB2MXF3EWXsvgUzygBNJ8F1VFN+FhEl8tsd
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=BT51uuEo x-bits=1024
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
      header.d=kernel.org header.i=@kernel.org header.b=BT51uuEo x-bits=1024
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
X-CM-Envelope: MS4wfAJ9Wl+T5gB8flv08rppnc9jEXKXS5ap5HvhHTUxXLFIZm5wTrSQlkEjQsytFwoGx5AgYg09CJd40CkuwyIPIMh3ObVSTwJCc301YD7yGDjnkwpzxV8J
    X3+kaj/kL9/nvWif0oCTNe5UdMrOzd5D21fql67itmDyb8y2C31lcwbrqgPtpUwiU8HZpI/1bal2kDq9dGMTOCvTvRZ9vsCG7OFbUgY0sCOFY8ZVcbR+wv1e
    6mfnn+CGFNyKl5aAUUKd1A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=q6TaLdPZoMfKjZ0-Ho4A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:21:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 6/9] staging: iio: tsl2x7x: correct
 IIO_EV_INFO_PERIOD values
Message-ID: <20180512122155.5836865e@archlinux>
In-Reply-To: <20180511001223.12378-7-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-7-masneyb@onstation.org>
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

On Thu, 10 May 2018 20:12:20 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The thresh periods assumed an integration time of 3ms. This patch adds
> support for the correct integration time (2.72ms or 2.73ms). The code
> had the ALS filter values as going up to 15, however the values actually
> went up to 60 since the values scaled in increments of 5 once the
> persistence value went above 3.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 44 +++++++++++++++++++++----------------
>  drivers/staging/iio/light/tsl2x7x.h |  1 -
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 2d713d3c7c7b..0218eabcd6d7 100644
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
> @@ -984,7 +982,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  				     int val, int val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL, y, z, filter_delay;
> +	int ret = -EINVAL, count, persistence;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1023,15 +1021,20 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		else
>  			time = chip->settings.prox_time;
>  
> -		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> -		z = y * TSL2X7X_MIN_ITIME;
> +		count = 256 - time;
> +		persistence = ((val * 1000000) + val2) /
> +			(count * tsl2x7x_int_time_avail[chip->id][3]);
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
> @@ -1052,7 +1055,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  				    int *val, int *val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int filter_delay, mult;
> +	int filter_delay, persistence;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1084,18 +1087,21 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
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
> +			tsl2x7x_int_time_avail[chip->id][3];
> +
> +		*val = filter_delay / 1000000;
> +		*val2 = filter_delay % 1000000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index db344796fc1b..b86f6b260f9f 100644
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
