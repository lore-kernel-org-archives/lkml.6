Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520692090-2-15840954284863293633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520692090; b=hnmJJP1dKGXW24tBRLs3S2LnyZdnsnBT5bwCiWrEBOpJFv9
    R++gbGrUCCC3IzdmE/Pl9FYCTqIZ5UPPP3emrmZcGPPyojTWR6fMZHHT0+R7VC0N
    C5At8iWVF95cWWWU1BoUopO/B1deBrkVN1HN8x6p99JSS7RZPg9qRNunS4yVgXjw
    NNiz59otLK9+Tgz0hewXft5S4VUVkXRnV+GF000B3Gu0+qi/8GYUSvIWn+LeQbtA
    5JG/6EsMZpAVifbDue8QY80zhyA5aG8YrnAE4dkUUseRX5QKMPV3jGXzDMt/Ib1/
    SIRmh4IsgE4WurCoT2VY32iM1r5dcQ+8VftXFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520692090; bh=S
    bm9BrCwUBqGMbX+ZUu8165AfytAedz+Y/TXmLWfdQQ=; b=l4WIanjmY6lZgKj9r
    njiy02FAq/0tPMZ3StIdm1nKRVKcE0/ZQLryv2ZHZE75zsLGnkGMfJY8Gc2IcWAy
    INmCyxYH1Kpyp5w2MB48X9EQQ3RUWKsEO+GxkzbIrN5qR1uZl7wI29gWp9yGAxo5
    6blufdflj+WqripxlQgbhzpiXp8PMLb0kJ+fnGn7/a86MHKHs0ADiikD6sOgbDzm
    TXUoOBcdBsZY00olebSbVkvPN1khE/KDrnO2oFueWlvC4NI1dt/R7d9cATyvTBxW
    u2Dd92kXQrgrhy8AzpkB8pVnLyyS+lmGyh2/iIzjhrWfCggn+yAox2qGMDWMbREI
    jyq9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47B208FE
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:27:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 02/12] staging: iio: tsl2x7x: add common function for
 clearing interrupts
Message-ID: <20180310142757.1716947b@archlinux>
In-Reply-To: <20180304014942.18727-3-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-3-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:32 -0500
Brian Masney <masneyb@onstation.org> wrote:

> There were three places where the same chunk of code was used to clear
> interrupts. This patch creates a common function
> tsl2x7x_clear_interrupts() to reduce duplicate code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. This one wasn't immediately clear to me but having looked at the datasheet
I see the logic in combining these into one function so fair enough.

The odd addresses being set as bits within a register had me confused.

Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 52 +++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index b7e3f966c3a6..c02db03ef369 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -279,6 +279,20 @@ static const u8 device_channel_config[] = {
>  	ALSPRX2
>  };
>  
> +static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN | reg);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"%s: failed to clear interrupt status %x: %d\n",
> +			__func__, reg, ret);
> +
> +	return ret;
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -346,16 +360,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		buf[i] = ret;
>  	}
>  
> -	/* clear any existing interrupt status */
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG |
> -				   TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_ALS_INT_CLR);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"i2c_write_command failed - err = %d\n", ret);
> -		goto out_unlock; /* have no data, so return failure */
> -	}
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_ALS_INT_CLR);
> +	if (ret < 0)
> +		goto out_unlock;
>  
>  	/* extract ALS/lux data */
>  	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
> @@ -706,17 +713,10 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
>  				__func__);
>  
> -		/* Clear out any initial interrupts  */
> -		ret = i2c_smbus_write_byte(chip->client,
> -					   TSL2X7X_CMD_REG |
> -					   TSL2X7X_CMD_SPL_FN |
> -					   TSL2X7X_CMD_PROXALS_INT_CLR);
> -		if (ret < 0) {
> -			dev_err(&chip->client->dev,
> -				"%s: Failed to clear Int status\n",
> -				__func__);
> -		return ret;
> -		}
> +		ret = tsl2x7x_clear_interrupts(chip,
> +					       TSL2X7X_CMD_PROXALS_INT_CLR);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	return ret;
> @@ -1421,14 +1421,10 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    IIO_EV_DIR_EITHER),
>  			       timestamp);
>  	}
> -	/* Clear interrupt now that we have handled it. */
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
>  	if (ret < 0)
> -		dev_err(&chip->client->dev,
> -			"Failed to clear irq from event handler. err = %d\n",
> -			ret);
> +		return ret;
>  
>  	return IRQ_HANDLED;
>  }

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
