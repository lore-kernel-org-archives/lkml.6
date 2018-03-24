Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521898979-2-15341370388790915099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898978; b=lO4qlZfDcffNceBbTBC6cx1ZgF7gwA3EaKsC4NGOEu/s21u
    87+Y+uIFacmOh71EXnlmIY3/uMGhWRUoROvoYApbw+lQYuNcsBaCPFhqIWWthRAm
    DOz1KYZiE3uNW5RP7lhJ6bxLfkHH8UuHtdAA5RwXdDNgn8ykLs6+XwYEaSkB/MK8
    2OOuTYxTsuSBeYT1NL0ggqVOr6t7aogS29gKWUnCeOh6p3ntFCVA8veBcv/xZn3S
    7+yMhoZ9SoslIWEatuxxsKwImHFiSf911UpoThagzsZ0cb18gdtBqRQrY79Thbih
    4ErCupPD0LNjk0FSHSQ2EMXrGyZ0EaZ59cWeOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898978; bh=E
    IgQNeVJndbz+S/zMklKRayodMcZJN5X9aWtYrwj+KY=; b=LZ8Ajw5m9xqR2EPo0
    Bilo6IGwr2ODmLK0IxG65fy4ut8Nksdd5ANTCyT24/Up9etQg9+LFJymiyfVdTrm
    0IFH6Qcfl9HKPqBJxHgfxEdLirZU16BCqv0CIX6g684GoxDKxtIV6M9gD6HsHezh
    nhL8eLqszzhLdFOijlcejdHkJHDqBJeWsboMYn+MbyrCYiLB+FhHpdrIDgViN8+a
    5a09+oQfEeJS3hzC3xyF4pjV+Il4j/REfwky1WwzhUvi8m+7ujt25J6ORGjEGEH/
    OMgG/OICGzYL9S3IAdchey9jVfDDopnpDbXZR3NabEaai70lUkH25EBBUV9l0ia7
    rx0Jw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2774921772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:42:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 09/11] staging: iio: tsl2x7x: remove ch0 and ch1
 variables from tsl2x7x_get_lux()
Message-ID: <20180324134248.1faeb2ff@archlinux>
In-Reply-To: <20180321102912.5130-10-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-10-masneyb@onstation.org>
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

On Wed, 21 Mar 2018 06:29:10 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Remove the ch0 and ch1 variables from tsl2x7x_get_lux() and
> write those values directly into the chip->als_cur_info.als_ch0
> and chip->als_cur_info.als_ch01 variables.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. A marginal improvement in readability I suppose, but not a big one.
This I wouldn't have bothered changing but fair enough.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 1e38e8449f9e..65b7fbca8c5d 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -336,7 +336,6 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
>   */
>  static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  {
> -	u16 ch0, ch1; /* separated ch0/ch1 data from device */
>  	u32 lux; /* raw lux calculated from device data */
>  	u64 lux64;
>  	u32 ratio;
> @@ -382,24 +381,24 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	}
>  
>  	/* extract ALS/lux data */
> -	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
> -	ch1 = le16_to_cpup((const __le16 *)&buf[2]);
> +	chip->als_cur_info.als_ch0 = le16_to_cpup((const __le16 *)&buf[0]);
> +	chip->als_cur_info.als_ch1 = le16_to_cpup((const __le16 *)&buf[2]);
>  
> -	chip->als_cur_info.als_ch0 = ch0;
> -	chip->als_cur_info.als_ch1 = ch1;
> -
> -	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation) {
> +	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
> +	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
>  		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
>  		goto return_max;
>  	}
>  
> -	if (!ch0) {
> +	if (!chip->als_cur_info.als_ch0) {
>  		/* have no data, so return LAST VALUE */
>  		ret = chip->als_cur_info.lux;
>  		goto out_unlock;
>  	}
> +
>  	/* calculate ratio */
> -	ratio = (ch1 << 15) / ch0;
> +	ratio = (chip->als_cur_info.als_ch1 << 15) / chip->als_cur_info.als_ch0;
> +
>  	/* convert to unscaled lux using the pointer to the table */
>  	p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux;
>  	while (p->ratio != 0 && p->ratio < ratio)
> @@ -408,9 +407,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	if (p->ratio == 0) {
>  		lux = 0;
>  	} else {
> -		lux = DIV_ROUND_UP(ch0 * p->ch0,
> +		lux = DIV_ROUND_UP(chip->als_cur_info.als_ch0 * p->ch0,
>  				   tsl2x7x_als_gain[chip->settings.als_gain]) -
> -		      DIV_ROUND_UP(ch1 * p->ch1,
> +		      DIV_ROUND_UP(chip->als_cur_info.als_ch1 * p->ch1,
>  				   tsl2x7x_als_gain[chip->settings.als_gain]);
>  	}
>  

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
