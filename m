Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2899236-1521997768-2-18187949863720801092
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
    t=1521997767; b=gGtBDPMl6FcFUg0LROhJp49D9l4g3KQcllPt3858ggQ9Avx
    pkXKnb40MvTu6z3BMhKdLywRDsjHcrZOMcU0wtQzYJjiek5lOIhlxLHVij4zOvrY
    iLTm3e7Gi6zDZtpigazm7dqRt+xEWqiS2cODsvrgQE2b6rwZ650PrSJRi+H6thMO
    0sW/I2G7OBL3X6Thx3MY2XUFIQ0Q+MaWnbtZMgw417soE3fwyd4QpX7SoX51NGk6
    WxhreFnhGDg5WvC8+9DpHk/TyVNAN93io3IozI5+sdF0KFGtoYKFEBNvjRC8RCdA
    pFPeh5onALT/Z/KK8qFpoxSUNNWB4Sq3q9JzU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521997767; bh=z
    TBOBbHG7VHlenxIEhWo56FcFOW/BvIfGX75VRsnXnI=; b=ezMheTczCa4mIHhLg
    puIC5PMb8tFX3PTpox384K29ZGmb7/plmJNwlPCxOtstrXX7LJ0XzNkXt2sxhKH0
    qRSPLT56jLJ3spNv9L9ktbOOFNS43YaJYDiM0IJBRLNYV0H4IA38cdkJGW8DxXoM
    IWu+N2E9OfNJsHr+ha/PgHOpZmJX/2GHPT+IMJ22zFZhfA/Wbwnf9YLX/WjrYWBU
    PrO68T3SOjDl4cQztIavEJN4qer/Qh4DzmL71lA+KID6paP/z7BrPEklXyugQEDj
    GIJ7fNHKmxuVU58hJ9oSH08nhNuO4FjLL4Vy0bqIlFCIhC2134MTf0Eg0ONxkfQ5
    iVnoA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80FE21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 18:09:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 1/4] staging: iio: tsl2x7x: use auto increment I2C protocol
Message-ID: <20180325180911.58350c6c@archlinux>
In-Reply-To: <20180324200555.1403-2-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
 <20180324200555.1403-2-masneyb@onstation.org>
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

On Sat, 24 Mar 2018 16:05:52 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The hardware supports 16-bit ALS and proximity readings, however the
> datasheet recommends using the I2C auto increment protocol so that the
> correct high and low bytes are read even if the integration cycle ends
> between reading the lower and upper registers. More information about
> this protocol can be found at https://www.i2c-bus.org/auto-increment/.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This isn't what I'd normally expect to see when autoincrement is going on.
You normally have to keep the transfer from ending.
See below

However looking at the datasheet it seems to be doing exactly what
you have here so that wins the 'odd' award for the day.
Ah well. All I'm going to do is delete the reference to the standard
from this patch as it isn't complying with it...

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/staging/iio/light/tsl2x7x.c | 100 ++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 77a81d75af4f..8530bccdb317 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -80,6 +80,8 @@
>  /* tsl2X7X cmd reg masks */
>  #define TSL2X7X_CMD_REG			0x80
>  #define TSL2X7X_CMD_SPL_FN		0x60
> +#define TSL2X7X_CMD_REPEAT_PROTO	0x00
> +#define TSL2X7X_CMD_AUTOINC_PROTO	0x20
>  
>  #define TSL2X7X_CMD_PROX_INT_CLR	0X05
>  #define TSL2X7X_CMD_ALS_INT_CLR		0x06
> @@ -320,6 +322,55 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
>  	return ret;
>  }
>  
> +static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
> +				     int upper_reg)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_AUTOINC_PROTO |
> +				   lower_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to enable auto increment protocol: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | lower_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read from register %x: %d\n", __func__,
> +			lower_reg, ret);
> +		return ret;
> +	}
> +	buf[0] = ret;
> +
The description you link to implies we can't hae a stop between these.
That would mean you need to do them in one go.
i2c_smbus_read_block_data would do that...

> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | upper_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read from register %x: %d\n", __func__,
> +			upper_reg, ret);
> +		return ret;
> +	}
> +	buf[1] = ret;
> +
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_REPEAT_PROTO |
> +				   lower_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to enable repeated byte protocol: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	return le16_to_cpup((const __le16 *)&buf[0]);
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -340,9 +391,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	struct tsl2x7x_lux *p;
>  	u32 lux, ratio;
> -	int i, ret;
>  	u64 lux64;
> -	u8 buf[4];
> +	int ret;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -366,23 +416,17 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		goto out_unlock;
>  	}
>  
> -	for (i = 0; i < 4; i++) {
> -		int reg = TSL2X7X_CMD_REG | (TSL2X7X_ALS_CHAN0LO + i);
> -
> -		ret = i2c_smbus_read_byte_data(chip->client, reg);
> -		if (ret < 0) {
> -			dev_err(&chip->client->dev,
> -				"%s: failed to read from register %x: %d\n",
> -				__func__, reg, ret);
> -			goto out_unlock;
> -		}
> -
> -		buf[i] = ret;
> -	}
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN0LO,
> +					TSL2X7X_ALS_CHAN0HI);
> +	if (ret < 0)
> +		goto out_unlock;
> +	chip->als_cur_info.als_ch0 = ret;
>  
> -	/* extract ALS/lux data */
> -	chip->als_cur_info.als_ch0 = le16_to_cpup((const __le16 *)&buf[0]);
> -	chip->als_cur_info.als_ch1 = le16_to_cpup((const __le16 *)&buf[2]);
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN1LO,
> +					TSL2X7X_ALS_CHAN1HI);
> +	if (ret < 0)
> +		goto out_unlock;
> +	chip->als_cur_info.als_ch1 = ret;
>  
>  	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
>  	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
> @@ -456,10 +500,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>   */
>  static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  {
> -	int i;
> -	int ret;
> -	u8 chdata[2];
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret;
>  
>  	mutex_lock(&chip->prox_mutex);
>  
> @@ -490,18 +532,10 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  		break;
>  	}
>  
> -	for (i = 0; i < 2; i++) {
> -		int reg = TSL2X7X_CMD_REG | (TSL2X7X_PRX_LO + i);
> -
> -		ret = i2c_smbus_read_byte_data(chip->client, reg);
> -		if (ret < 0)
> -			goto prox_poll_err;
> -
> -		chdata[i] = ret;
> -	}
> -
> -	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
> -	ret = chip->prox_data;
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_PRX_LO, TSL2X7X_PRX_HI);
> +	if (ret < 0)
> +		goto prox_poll_err;
> +	chip->prox_data = ret;
>  
>  prox_poll_err:
>  	mutex_unlock(&chip->prox_mutex);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
