Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3330179-1520692627-5-16332668386941864297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520692626; b=eQelYNb2+1Tu6O09nuTqk0LBRaxB4Ut/9/8ykcllTWi8ksj
    wj95ZR/YcCiPfuWH95xOD+vaPNvecFxmkNdWU/U8GW++LQ7UYI2hWboHjbc3El2d
    w9CsxGDE0MBc0ZVAxTDkLQlMo+Xp3XOka5JpfWPsROc2neiiyVkN0+6eN5MKJCiM
    HSJ20X83anDxtvwp49mJKcUYWv+KN5R1sN7rAvA8rykKN0kuS7txrvkNwRia4Qqj
    dLZaH69r9T7gd4JLaZWfPJKG9gfS2xbeEotM9XJlPZyis1ZWDKc1SSmx0lKtwl09
    4nSI60uPP2twRR25QhmPX7GzbQe7Vv18VzIUaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520692626; bh=M
    ahu3+tMRy123eoQumtF0+2URDtgj2CrFEKUBVQgCpc=; b=sFxbYJrefAM37pCer
    NgrnR1ZsQvSSCNTvkRfZl1Tghcgt2SQXVQWomigvokHwbL72x7QBsJtqGzv4yI8j
    TK+OhwrxaQRJ0StntFjlXuyhSITgJjdV6+CAFRfo2Pfc8n9EQzQYPRYyWrBP6xjV
    AblWcj6ByeV9J5TRxc/Lfs5ZpTULcgW0oXG0qxvfPyQ+fLrzcIeX+ZS63S+900s8
    ZE5Wqx+MmK0CMhoSPFxxCFeqULHYQ6iXIedduyGAK3/hku5oIv7Gz3XFda6r7A3p
    9Rj7jWTURK5sOfAnrr8X/j/sCWtOLheQWlnt66M6L7krnQfw+Nr1xVKzdYmNi66X
    j5RPw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EABE21787
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:36:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 04/12] staging: iio: tsl2x7x: add common function for
 writing to the control register
Message-ID: <20180310143655.480655f5@archlinux>
In-Reply-To: <20180304014942.18727-5-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-5-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:34 -0500
Brian Masney <masneyb@onstation.org> wrote:

> There were four places where the same chunk of code was used to write
> to the control register. This patch creates a common function
> tsl2x7x_write_control_reg() to reduce duplicate code.
> 
> The function tsl2x7x_chip_off() did not correctly return an error
> code so this patch also corrects that issue.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. These are getting a bit marginal in benefit but this one just makes
it over the barrier.

The reduction in complexity is really very small...

Applied.

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 54 +++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 6bb622816660..cf16dd206c0b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -307,6 +307,21 @@ static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
>  	return ret;
>  }
>  
> +static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(chip->client,
> +					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, data);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to write to control register %x: %d\n",
> +			__func__, data, ret);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -597,7 +612,6 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	int i;
>  	int ret = 0;
>  	u8 *dev_reg;
> -	u8 utmp;
>  	int als_count;
>  	int als_time;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> @@ -659,14 +673,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	 * TSL2X7X Specific power-on / adc enable sequence
>  	 * Power on the device 1st.
>  	 */
> -	utmp = TSL2X7X_CNTL_PWR_ON;
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, utmp);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: failed on CNTRL reg.\n", __func__);
> +	ret = tsl2x7x_write_control_reg(chip, TSL2X7X_CNTL_PWR_ON);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	/*
>  	 * Use the following shadow copy for our delay before enabling ADC.
> @@ -691,16 +700,12 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	 * NOW enable the ADC
>  	 * initialize the desired mode of operation
>  	 */
> -	utmp = TSL2X7X_CNTL_PWR_ON |
> -			TSL2X7X_CNTL_ADC_ENBL |
> -			TSL2X7X_CNTL_PROX_DET_ENBL;
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, utmp);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: failed on 2nd CTRL reg.\n", __func__);
> +	ret = tsl2x7x_write_control_reg(chip,
> +					TSL2X7X_CNTL_PWR_ON |
> +					TSL2X7X_CNTL_ADC_ENBL |
> +					TSL2X7X_CNTL_PROX_DET_ENBL);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
> @@ -713,13 +718,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
>  
>  		reg_val |= chip->settings.interrupts_en;
> -		ret = i2c_smbus_write_byte_data(chip->client,
> -						TSL2X7X_CMD_REG | TSL2X7X_CNTRL,
> -						reg_val);
> +		ret = tsl2x7x_write_control_reg(chip, reg_val);
>  		if (ret < 0)
> -			dev_err(&chip->client->dev,
> -				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
> -				__func__);
> +			return ret;
>  
>  		ret = tsl2x7x_clear_interrupts(chip,
>  					       TSL2X7X_CMD_PROXALS_INT_CLR);
> @@ -732,16 +733,11 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
>  {
> -	int ret;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  
>  	/* turn device off */
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
> -
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, 0x00);
> -
> -	return ret;
> +	return tsl2x7x_write_control_reg(chip, 0x00);
>  }
>  
>  /**

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
