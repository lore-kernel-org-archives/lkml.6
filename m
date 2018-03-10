Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3330179-1520691666-2-13446338338361109069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, TVD_SUBJ_WIPE_DEBT 1.004, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520691666; b=Q+xo8u9pzqO5IOGYMFT26F0nOoPCdDK3Wht24eArS+25Edu
    GJF6lbVULVQxQoVv4xQjgROY35nMHdgHmJHCRBDms73OEdOGy61NG+gU0eyEt73a
    EhomSq3VYMb0tuYw3vZ006Q+e3XWCDxLrUNtZVSa7n3EJLloeNL4qzGtNKbfwdSj
    SR/6QpVCh4/jHiuEiNOEU9CakUpfB2C8Y/+kgha6kJohB4UVVtQBWYtR44Ny6yWK
    3Fa0pCKBoAFs8jITCt/MFdwvpJdkk3f2S/tF1bATAaNjO6z85v6s7I8VJRpG3ndQ
    2d2/8HDcXDCSkCqKmymuKq2Vddc2VSA0KRdhniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520691666; bh=0
    td6LSrusrSMaRvrgmCkdaWn+TFiHzG//CzwgVWcQUY=; b=wWXH0fVrOjOOk8/l+
    1stCSPx6SLAGgSGoAaBW1xJvZByXj/UOEOHORpDxxV+bYevucZsfveNZck903+Qk
    jIGvdkh8IsEUyTYYpe7gJuocEZxlL1nHXyEPlsr/tvU/9uNULXOi+rZt6uMur3zt
    OHoCEydUVvTDhN8s/5AA6GLgStWUAt5/Foewb/FZ7VpR0mqn4P16v5uWWHFCYgk/
    N0VjP+T77zR79lzd4poFeszqmwUSM3Myvxpuume6/ng0SNjnqjoYmI1EuylbG7WI
    KSGAOLET/F68FZbUEWweYFAFpH6f3/3a4HHDbYubITCt354Px3Dg47PfMSblXNpD
    kyI+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F43B208FE
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:20:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 01/12] staging: iio: tsl2x7x: remove power functions
 from tsl2X7X_platform_data
Message-ID: <20180310142057.7f31219d@archlinux>
In-Reply-To: <20180304014942.18727-2-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-2-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:31 -0500
Brian Masney <masneyb@onstation.org> wrote:

> The tsl2X7X_platform_data structure contains the platform_power,
> power_on, and power_off function pointers. These power management
> functions should not be in the platform data. These functions were
> likely used before the regulator framework was put in place. There are
> no users of these functions in the mainline kernel.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 18 ------------------
>  drivers/staging/iio/light/tsl2x7x.h |  4 ----
>  2 files changed, 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 126e11530ce0..b7e3f966c3a6 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -588,9 +588,6 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	u8 reg_val = 0;
>  
> -	if (chip->pdata && chip->pdata->power_on)
> -		chip->pdata->power_on(indio_dev);
> -
>  	/* Non calculated parameters */
>  	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
>  	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
> @@ -736,9 +733,6 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, 0x00);
>  
> -	if (chip->pdata && chip->pdata->power_off)
> -		chip->pdata->power_off(chip->client);
> -
>  	return ret;
>  }
>  
> @@ -1792,12 +1786,6 @@ static int tsl2x7x_suspend(struct device *dev)
>  		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
>  	}
>  
> -	if (chip->pdata && chip->pdata->platform_power) {
> -		pm_message_t pmm = {PM_EVENT_SUSPEND};
> -
> -		chip->pdata->platform_power(dev, pmm);
> -	}
> -
>  	return ret;
>  }
>  
> @@ -1807,12 +1795,6 @@ static int tsl2x7x_resume(struct device *dev)
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int ret = 0;
>  
> -	if (chip->pdata && chip->pdata->platform_power) {
> -		pm_message_t pmm = {PM_EVENT_RESUME};
> -
> -		chip->pdata->platform_power(dev, pmm);
> -	}
> -
>  	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
>  		ret = tsl2x7x_chip_on(indio_dev);
>  
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index df00f2ec1719..6624cbca7a83 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -21,7 +21,6 @@
>  
>  #ifndef __TSL2X7X_H
>  #define __TSL2X7X_H
> -#include <linux/pm.h>
>  
>  struct tsl2x7x_lux {
>  	unsigned int ratio;
> @@ -91,9 +90,6 @@ struct tsl2x7x_settings {
>   *
>   */
>  struct tsl2X7X_platform_data {
> -	int (*platform_power)(struct device *dev, pm_message_t);
> -	int (*power_on)(struct iio_dev *indio_dev);
> -	int (*power_off)(struct i2c_client *dev);
>  	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];
>  	struct tsl2x7x_settings *platform_default_settings;
>  };

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
