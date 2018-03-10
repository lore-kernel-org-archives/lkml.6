Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520692495-2-767200074729611631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520692494; b=e4642bliCsPoCMCi8d+astFZmlCrlyUis5iNdcgQdyJ7Ddy
    pyiy3fjk/u5wsDkoGtth40yvi+HsL6sOE5RjtpwcjjNB75uYqkkND4dOIgyu7JJE
    v6IhirQ1TaHuMsIgtfyKmiQLGul/jlFWMClBC47sL8UTJlzmPwqfwPtVmNXzzsvz
    WbGnmrYrSQx3RxudyvuhSystJMTVh/gua4uOVwN5abU8F8XVJZfQPXSrRS3chNsx
    0+IrWoTkrqaSQfQGY4i2Ew68H9Jr/pQwYDAkR6yuLBsb6ulwY/jxia7DQWtN0nRP
    5pKQb7DZTSOQHvL0Ku9nbK/U2YPdfVw5VceEW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520692494; bh=P
    aXYGq9JBoXGiYtmdGgmMKaXChs+wR4sgrqXd0JO8ok=; b=eNjhvoSXo3GMVPDi9
    H62VZicTQPP3ZDPfYpuupPbbxAjEjaU/8EWL3hYVpkqJotqU778SiOf2nyBJrjg+
    yEcYvfVMnHkum29IbG+BU1HT4ZTUBrWmTVKlJ9Fvinl27AnESY9Mj7dKZZnZPuc1
    Zxbgq8ZL6PZfq/L3Sc9G3KD57w1R+h+Nt6IYizm5F/vr+Z3F1u+Yx3Pm6euincgo
    n+KD4w07IilVKBu7RA24zlnwKtxNTn0WExyiMlYjQxLf62dmhZDO7DghrkjyY+zX
    ui91roPVc39pS4T1GoiPIES28n9EsNxvVmwGpKaXgQgj8GJ2oqkM4KkwiJoaSwDn
    pgUpw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D3C2133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:34:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 03/12] staging: iio: tsl2x7x: add common function for
 reading chip status
Message-ID: <20180310143442.7d9974f2@archlinux>
In-Reply-To: <20180304014942.18727-4-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-4-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:33 -0500
Brian Masney <masneyb@onstation.org> wrote:

> There were three places where the same chunk of code was used to read
> the chip status. This patch creates a common function
> tsl2x7x_read_status() to reduce duplicate code. This patch also corrects
> tsl2x7x_event_handler() to properly check for an error after reading the
> chip status.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 40 ++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index c02db03ef369..6bb622816660 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -293,6 +293,20 @@ static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
>  	return ret;
>  }
>  
> +static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read STATUS register: %d\n", __func__,
> +			ret);
> +
> +	return ret;
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -332,13 +346,10 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		goto out_unlock;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: Failed to read STATUS Reg\n", __func__);
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
>  		goto out_unlock;
> -	}
> +
>  	/* is data new & valid */
>  	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
>  		dev_err(&chip->client->dev,
> @@ -458,12 +469,9 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  		return -EBUSY;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev, "i2c err=%d\n", ret);
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
>  		goto prox_poll_err;
> -	}
>  
>  	switch (chip->id) {
>  	case tsl2571:
> @@ -1396,13 +1404,13 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
> -	u8 value;
>  
> -	value = i2c_smbus_read_byte_data(chip->client,
> -					 TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* What type of interrupt do we need to process */
> -	if (value & TSL2X7X_STA_PRX_INTR) {
> +	if (ret & TSL2X7X_STA_PRX_INTR) {
>  		tsl2x7x_get_prox(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> @@ -1412,7 +1420,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    timestamp);
>  	}
>  
> -	if (value & TSL2X7X_STA_ALS_INTR) {
> +	if (ret & TSL2X7X_STA_ALS_INTR) {
>  		tsl2x7x_get_lux(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
