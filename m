Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524328447-2-13658753827979444272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524328446; b=SkOHLVfbzPeHXp0H1fVHaOLZLzMeb6ItOtI8PyESwGtcP8aVQY
    alWw0UYwAuFj097LzVGAwz0aArbieZYEI+B6Y/lkqiv/T0rRUpXjsphSIVf626v7
    tULvLFyMI/VzB21EyewzpO7Ko2tSgaGfiMtV66eF2lAIWDkrYcja2+Jol/DZVgRd
    DrJ8IRD02XaiTdtJAS6S5e9MWry/piN1wTN+mtHZNEzUSfHcdHIGOGDmZDDxs0+z
    y22Yme2YyMg7cDoFHEGbXCIIWcoCm41Ime0vTI9WkpYrcsBfTDT3S+rl0dkAXq/p
    /MzHizv8jHFYUoQVMd0SYPQU9GlXUAMBHA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328446; bh=QPsp0
    Qx4RXrX2KrLvMCOsBrtF9Q9YqzIgII4Jk7QPxw=; b=lpI60pkcW0UiKLfkXOtRW
    MLau7jk9PmnK1kKgQ7JWOMOdyrdQ0+xKhulfMMOvH9HsJSAjL3kBz896iQPxaUjL
    mCohVPXj8uXJD6SHFVGk2ipUYa6aFCiSMvfr0QKqfgp/c3ADHhQp68BFoZGDNV+e
    GTgDDd9am8+ulyET6arJ/fRu9ZNDQm1Ko9bBBMEtFOHp17yYMrHMtJZvb9gLqcY7
    my+R8lP02tPxeqll1YYu44rZTpW5SqJcBr4AXOXvFn7hzUTYfIKDjF4uzbXpSVj4
    knoM4qCy5sQLOmVROFOfwsPf0GHiuIvl5hcRFtB94j5fxx42olNhkoorG862qobO
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBDro9oP4hxgXfJupUnk98hD8sLEI7B3sgVyO6fB8pp5JSuzvgQa3utfQ5ZbdfMYHCMZsQIuYvcnV7CPdpOvhbfGeKFZtrhfIA397bXsQC/IGMC9ZdWn
    xUkaVV1CA7Q2AQZ6/yunhkkziAFaFx2Dkx423wjTfSy+W9l4JT3Lx7gmIdT1Eti2PfYpRWKukdwXtylgN9gBufxGlSq+BYZ+44k0aEuD4qf1Y+/qnLhSlqqp
    IHZ5ZkdWCt4leaySG+S8bQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=KeWZb-x_QC3Fg8QLGioA:9 a=HLLgNjBQGeFHIPFP:21 a=nFMBZlkNt5bunEcl:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C9921742
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 10/13] staging: iio: tsl2x7x: rename prx to prox for
 consistency
Message-ID: <20180421173354.6a8ae0c1@archlinux>
In-Reply-To: <20180421004153.19073-11-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-11-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:50 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The driver mostly uses the 'prox' naming convention for most of the
> proximity settings, however prx_time and tsl2x7x_prx_gain was present.
> This patch renames these to prox_time and tsl2x7x_prox_gain for
> consistency with everything else in the driver.
> 
> The kernel documentation for prx_gain is corrected to prox_gain so that
> it matches what is actually in the structure.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 12 ++++++------
>  drivers/staging/iio/light/tsl2x7x.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 87b99deef7a8..a7b4fcba7935 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -203,7 +203,7 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.als_time = 219, /* 101 ms */
>  	.als_gain = 0,
> -	.prx_time = 254, /* 5.4 ms */
> +	.prox_time = 254, /* 5.4 ms */
>  	.prox_gain = 0,
>  	.wait_time = 245,
>  	.prox_config = 0,
> @@ -230,7 +230,7 @@ static const s16 tsl2x7x_als_gain[] = {
>  	120
>  };
>  
> -static const s16 tsl2x7x_prx_gain[] = {
> +static const s16 tsl2x7x_prox_gain[] = {
>  	1,
>  	2,
>  	4,
> @@ -594,7 +594,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	u8 *dev_reg, reg_val;
>  
>  	/* Non calculated parameters */
> -	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
>  	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
>  	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
>  
> @@ -1021,7 +1021,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_INTENSITY)
>  			time = chip->settings.als_time;
>  		else
> -			time = chip->settings.prx_time;
> +			time = chip->settings.prox_time;
>  
>  		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
>  		z = y * TSL2X7X_MIN_ITIME;
> @@ -1090,7 +1090,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  			time = chip->settings.als_time;
>  			mult = chip->settings.als_persistence;
>  		} else {
> -			time = chip->settings.prx_time;
> +			time = chip->settings.prox_time;
>  			mult = chip->settings.prox_persistence;
>  		}
>  
> @@ -1153,7 +1153,7 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_LIGHT)
>  			*val = tsl2x7x_als_gain[chip->settings.als_gain];
>  		else
> -			*val = tsl2x7x_prx_gain[chip->settings.prox_gain];
> +			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 2c96f0b39b1e..408e5a89edb1 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -44,9 +44,9 @@ struct tsl2x7x_lux {
>   *                          aperture effects.
>   *  @wait_time:             Time between PRX and ALS cycles
>   *                          in 2.7 periods
> - *  @prx_time:              5.2ms prox integration time -
> + *  @prox_time:             5.2ms prox integration time -
>   *                          decrease in 2.7ms periods
> - *  @prx_gain:              Proximity gain index
> + *  @prox_gain:             Proximity gain index
>   *  @prox_config:           Prox configuration filters.
>   *  @als_cal_target:        Known external ALS reading for
>   *                          calibration.
> @@ -68,7 +68,7 @@ struct tsl2x7x_settings {
>  	int als_gain;
>  	int als_gain_trim;
>  	int wait_time;
> -	int prx_time;
> +	int prox_time;
>  	int prox_gain;
>  	int prox_config;
>  	int als_cal_target;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
