Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3330179-1520693086-2-14669802201206832711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520693086; b=nFveZ2PaqCFOb02YFZYlkNQ8X3/OXSKdCSMcQG7Cb9Rzj+s
    tJj2GUyKwrjXFSmbaMqGeCPeRUYVfYSV0WBc/vLFpdnmx7dg/5m1uGP/YhWC/sji
    OgPmaTojyUpOzXTHLkdeb6E6aQaUd0jmQjtrUeWDxu/bMdfnEYac3J1FGnoWjbUz
    ppxVJLYt/pgv8GKk55rcdVLt/+6sjaIZBygTJlgDFxese1X5sM6d07wDuxdK7hox
    xf/LO0ONmT8Y8llhfiA0+cjvfIzNwjXZqjclumnxTAnLKaker/YEJ/GbMVR9TbfA
    83AkLfsqkl2L/B/HlZhUhvvW2sAeLRqw6rkde4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520693086; bh=C
    KtV96Mok8Pk5j2n58KiZAPNu8CuoVLnG76a2RHqLgc=; b=h6ojWxDO0Rrtf2CKg
    SoPUKJsRkNTwMLIedXnShHIxQ/RYDbFiK7SDfHWog7a2+gQurqTAxrH1lzwUDYcJ
    iikhXyyetk/DLeKKvaJqFvk9keVMbMuDJklAlUgY8JRkAWgb6unYIkukoGLG3Kur
    xe66dL1zyGi/xWch99vKsY24AMBPLAr3fxH/ogjGcX7Ep4riwTb8LTAAdjfWQKQh
    nC6GP7lT9QJ+sqaKsQEeqN5Tp/NEv1OPba1KCf5ZgZRX1NJ8wtsKCMBrapxfS02m
    hocmzMMYkWWc2xh2ibOHFA0t7bxy7RCX29+PzBmNJx3A+pA1o+KS2g2A8rkOdK5D
    mjK7g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F133A2178C
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:44:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 08/12] staging: iio: tsl2x7x: add error handling to
 tsl2x7x_prox_cal()
Message-ID: <20180310144434.1cd58941@archlinux>
In-Reply-To: <20180304014942.18727-9-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-9-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:38 -0500
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_prox_cal() did not have any error checks. This patch adds
> the missing error handling and ensures that any errors are reported to
> user space via in_proximity0_calibrate_store().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 380a6c96a69a..8adc6db44790 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -807,10 +807,10 @@ static void tsl2x7x_prox_calculate(int *data, int length,
>   * Calculates a standard deviation based on the samples,
>   * and sets the threshold accordingly.
>   */
> -static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
> +static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  {
>  	int prox_history[MAX_SAMPLES_CAL + 1];
> -	int i;
> +	int i, ret;
>  	struct tsl2x7x_prox_stat prox_stat_data[2];
>  	struct tsl2x7x_prox_stat *cal;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> @@ -825,25 +825,33 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	}
>  
>  	/* have to stop to change settings */
> -	tsl2x7x_chip_off(indio_dev);
> +	ret = tsl2x7x_chip_off(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Enable proximity detection save just in case prox not wanted yet*/
>  	tmp_irq_settings = chip->settings.interrupts_en;
>  	chip->settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
>  
>  	/*turn on device if not already on*/
> -	tsl2x7x_chip_on(indio_dev);
> +	ret = tsl2x7x_chip_on(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	/*gather the samples*/
>  	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
>  		usleep_range(15000, 17500);
> -		tsl2x7x_get_prox(indio_dev);
> +		ret = tsl2x7x_get_prox(indio_dev);
> +		if (ret < 0)
> +			return ret;
>  		prox_history[i] = chip->prox_data;
>  		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
>  			 i, chip->prox_data);
>  	}
>  
> -	tsl2x7x_chip_off(indio_dev);
> +	ret = tsl2x7x_chip_off(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  	cal = &prox_stat_data[PROX_STAT_CAL];
>  	tsl2x7x_prox_calculate(prox_history,
>  			       chip->settings.prox_max_samples_cal, cal);
> @@ -857,8 +865,13 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  
>  	/* back to the way they were */
>  	chip->settings.interrupts_en = tmp_irq_settings;
> -	if (current_state == TSL2X7X_CHIP_WORKING)
> -		tsl2x7x_chip_on(indio_dev);
> +	if (current_state == TSL2X7X_CHIP_WORKING) {
> +		ret = tsl2x7x_chip_on(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static ssize_t
> @@ -1018,8 +1031,11 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  	if (strtobool(buf, &value))
>  		return -EINVAL;
>  
> -	if (value)
> -		tsl2x7x_prox_cal(indio_dev);
> +	if (value) {
> +		ret = tsl2x7x_prox_cal(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
