Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3624994-1525631417-2-2850231567297796214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525631410; b=M4D2JkqB6ercwtFK9gCZwpNwO0AJnFtFG/Dnu1g7LOlmNXZTB8
    oQw9ZYKsNrUAW3vs/mzEFfzlPLWvWq/4BdZ4DPLweaWyZlk9E17MkEKJ5zXXJ7Ge
    0XD+TZp9QNATj2I1mnrC7JhivBULoSvcgJs3ySUa8yBEO8vHmss1HvZR10Knlz6x
    tIApM+EOMlGaaCUTIXs0OGgdTAOChF0Cfvjhq9TnOqgTMXS8DMoAanA9S/zcVxhk
    aFGQHXeHaVl5VIDWMa6/6ZIzAGxKWXk2G9UIZXihUYLLasnAUvXzNztg43ctNaSk
    NhxDMNPmZRBgX+y9vStIeIyV+avX/HD89E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525631410; bh=nXUl3
    T9A+V3EvpY4tw40GCwRHAypCojQp8KS7aB2T+0=; b=Db/HR3VynurY6ApvHf+++
    35VuRP16TI6fpKpG2uuTg+vnAZ2FRG/+gNeS/OpP9GjX//d3wIBqvIfgxcsiDy+2
    4b3wGvAsSo1dDe6wckUniN5qeACOMtxtl8B4/rBgTFdT9S+a4Bo/mgzcxDaOmCkZ
    rWEYYkCS6ypuahZ3V5SdU+RlFkskMQtPzg5xwrNTXODrwPDlkLRmvzyJk0UpClvz
    0wbBuOrT+18uDUBmFwqaSq4xOqkgVeArBcibX4zb0v1AfrNlK9Lb6tWRYtMNe0x4
    qnaXkVbg4uB/jsvQLakoSDrgP9+bCQv8WHAypMBvFQ8BL3/d4Jm/8uxqe21AFiVe
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=W0ouMVvM x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=W0ouMVvM x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLFRebAr2IDwgUQFHcCYOfdtUuX6RDgTbe0KQlcv716WOYlWQRyd7GnCO1iqQoAnd3cBklvRUgt/wYOLhFHch4nw+MK6FaK4B2uEJdpYTLP/ArfLmB91
    6L3efA6vj9DaDPkQme7u4wsqrPeDrWTzERj75LEDJ4l4S+0AxxdFWPc2t1j6muKbcXdygE4lhHvtrLBzf2dELhxNF/2w6aw5DKPu7vGQrgzC44QHw22Z2Odz
    dft+oljyHM1hZeyKs+GbMA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=GlixS5zuAAAA:8
    a=DDOyTI_5AAAA:8 a=Gaz4Tef9Gw1xnck9tXMA:9 a=34GdNL3HhQ87--ts:21
    a=kVAGWW4J-pDB4HI9:21 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=adCy40026U1O_QNtz7Gb:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:29:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 10/11] staging: iio: tsl2x7x: rename driver to tsl2772
Message-ID: <20180506192949.4a664d82@archlinux>
In-Reply-To: <20180504025319.28953-11-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-11-masneyb@onstation.org>
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

On Thu,  3 May 2018 22:53:18 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch renames this driver from tsl2x7x to tsl2772 since it is
> highly likely that additional devices will be added to this driver that
> do not match that wildcard. The tsl2772 driver name was selected since
> that is currently the device with the most features that are supported
> by this driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Good change to make.  Normally changing Kconfig symbols etc can
cause problems, but I think for a staging driver we are probably
fine.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/Kconfig                  |   2 +-
>  drivers/staging/iio/light/Makefile                 |   2 +-
>  drivers/staging/iio/light/{tsl2x7x.c => tsl2772.c} | 691 +++++++++++----------
>  drivers/staging/iio/light/{tsl2x7x.h => tsl2772.h} |  48 +-
>  4 files changed, 372 insertions(+), 371 deletions(-)
>  rename drivers/staging/iio/light/{tsl2x7x.c => tsl2772.c} (66%)
>  rename drivers/staging/iio/light/{tsl2x7x.h => tsl2772.h} (71%)
> 
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
> index aacb0ae58c0e..dfa37386ad2c 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  menu "Light sensors"
>  
> -config TSL2x7x
> +config TSL2772
>  	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
>  	depends on I2C
>  	help
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
> index ab8dc3a3d10b..e7e77a11f02a 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -2,4 +2,4 @@
>  # Makefile for industrial I/O Light sensors
>  #
>  
> -obj-$(CONFIG_TSL2x7x)	+= tsl2x7x.o
> +obj-$(CONFIG_TSL2772)	+= tsl2772.o
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2772.c
> similarity index 66%
> rename from drivers/staging/iio/light/tsl2x7x.c
> rename to drivers/staging/iio/light/tsl2772.c
> index f912f4bc61c4..146527e41969 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2772.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Device driver for monitoring ambient light intensity in (lux) and proximity
> - * detection (prox) within the TAOS TSL2X7X family of devices.
> + * detection (prox) for the TAOS TSL2571, TSL2671, TMD2671, TSL2771, TMD2771,
> + * TSL2572, TSL2672, TMD2672, TSL2772, and TMD2772 devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
>   * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> @@ -18,92 +19,92 @@
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "tsl2x7x.h"
> +#include "tsl2772.h"
>  
>  /* Cal defs */
>  #define PROX_STAT_CAL			0
>  #define PROX_STAT_SAMP			1
>  #define MAX_SAMPLES_CAL			200
>  
> -/* TSL2X7X Device ID */
> +/* TSL2772 Device ID */
>  #define TRITON_ID			0x00
>  #define SWORDFISH_ID			0x30
>  #define HALIBUT_ID			0x20
>  
>  /* Lux calculation constants */
> -#define TSL2X7X_LUX_CALC_OVER_FLOW	65535
> +#define TSL2772_LUX_CALC_OVER_FLOW	65535
>  
>  /*
>   * TAOS Register definitions - Note: depending on device, some of these register
>   * are not used and the register address is benign.
>   */
>  
> -/* 2X7X register offsets */
> -#define TSL2X7X_MAX_CONFIG_REG		16
> +/* Register offsets */
> +#define TSL2772_MAX_CONFIG_REG		16
>  
>  /* Device Registers and Masks */
> -#define TSL2X7X_CNTRL			0x00
> -#define TSL2X7X_ALS_TIME		0X01
> -#define TSL2X7X_PRX_TIME		0x02
> -#define TSL2X7X_WAIT_TIME		0x03
> -#define TSL2X7X_ALS_MINTHRESHLO		0X04
> -#define TSL2X7X_ALS_MINTHRESHHI		0X05
> -#define TSL2X7X_ALS_MAXTHRESHLO		0X06
> -#define TSL2X7X_ALS_MAXTHRESHHI		0X07
> -#define TSL2X7X_PRX_MINTHRESHLO		0X08
> -#define TSL2X7X_PRX_MINTHRESHHI		0X09
> -#define TSL2X7X_PRX_MAXTHRESHLO		0X0A
> -#define TSL2X7X_PRX_MAXTHRESHHI		0X0B
> -#define TSL2X7X_PERSISTENCE		0x0C
> -#define TSL2X7X_ALS_PRX_CONFIG		0x0D
> -#define TSL2X7X_PRX_COUNT		0x0E
> -#define TSL2X7X_GAIN			0x0F
> -#define TSL2X7X_NOTUSED			0x10
> -#define TSL2X7X_REVID			0x11
> -#define TSL2X7X_CHIPID			0x12
> -#define TSL2X7X_STATUS			0x13
> -#define TSL2X7X_ALS_CHAN0LO		0x14
> -#define TSL2X7X_ALS_CHAN0HI		0x15
> -#define TSL2X7X_ALS_CHAN1LO		0x16
> -#define TSL2X7X_ALS_CHAN1HI		0x17
> -#define TSL2X7X_PRX_LO			0x18
> -#define TSL2X7X_PRX_HI			0x19
> -
> -/* tsl2X7X cmd reg masks */
> -#define TSL2X7X_CMD_REG			0x80
> -#define TSL2X7X_CMD_SPL_FN		0x60
> -#define TSL2X7X_CMD_REPEAT_PROTO	0x00
> -#define TSL2X7X_CMD_AUTOINC_PROTO	0x20
> -
> -#define TSL2X7X_CMD_PROX_INT_CLR	0X05
> -#define TSL2X7X_CMD_ALS_INT_CLR		0x06
> -#define TSL2X7X_CMD_PROXALS_INT_CLR	0X07
> -
> -/* tsl2X7X cntrl reg masks */
> -#define TSL2X7X_CNTL_ADC_ENBL		0x02
> -#define TSL2X7X_CNTL_PWR_ON		0x01
> -
> -/* tsl2X7X status reg masks */
> -#define TSL2X7X_STA_ADC_VALID		0x01
> -#define TSL2X7X_STA_PRX_VALID		0x02
> -#define TSL2X7X_STA_ADC_PRX_VALID	(TSL2X7X_STA_ADC_VALID | \
> -					 TSL2X7X_STA_PRX_VALID)
> -#define TSL2X7X_STA_ALS_INTR		0x10
> -#define TSL2X7X_STA_PRX_INTR		0x20
> -
> -/* tsl2X7X cntrl reg masks */
> -#define TSL2X7X_CNTL_REG_CLEAR		0x00
> -#define TSL2X7X_CNTL_PROX_INT_ENBL	0X20
> -#define TSL2X7X_CNTL_ALS_INT_ENBL	0X10
> -#define TSL2X7X_CNTL_WAIT_TMR_ENBL	0X08
> -#define TSL2X7X_CNTL_PROX_DET_ENBL	0X04
> -#define TSL2X7X_CNTL_PWRON		0x01
> -#define TSL2X7X_CNTL_ALSPON_ENBL	0x03
> -#define TSL2X7X_CNTL_INTALSPON_ENBL	0x13
> -#define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
> -#define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
> -
> -/* TAOS txx2x7x Device family members */
> +#define TSL2772_CNTRL			0x00
> +#define TSL2772_ALS_TIME		0X01
> +#define TSL2772_PRX_TIME		0x02
> +#define TSL2772_WAIT_TIME		0x03
> +#define TSL2772_ALS_MINTHRESHLO		0X04
> +#define TSL2772_ALS_MINTHRESHHI		0X05
> +#define TSL2772_ALS_MAXTHRESHLO		0X06
> +#define TSL2772_ALS_MAXTHRESHHI		0X07
> +#define TSL2772_PRX_MINTHRESHLO		0X08
> +#define TSL2772_PRX_MINTHRESHHI		0X09
> +#define TSL2772_PRX_MAXTHRESHLO		0X0A
> +#define TSL2772_PRX_MAXTHRESHHI		0X0B
> +#define TSL2772_PERSISTENCE		0x0C
> +#define TSL2772_ALS_PRX_CONFIG		0x0D
> +#define TSL2772_PRX_COUNT		0x0E
> +#define TSL2772_GAIN			0x0F
> +#define TSL2772_NOTUSED			0x10
> +#define TSL2772_REVID			0x11
> +#define TSL2772_CHIPID			0x12
> +#define TSL2772_STATUS			0x13
> +#define TSL2772_ALS_CHAN0LO		0x14
> +#define TSL2772_ALS_CHAN0HI		0x15
> +#define TSL2772_ALS_CHAN1LO		0x16
> +#define TSL2772_ALS_CHAN1HI		0x17
> +#define TSL2772_PRX_LO			0x18
> +#define TSL2772_PRX_HI			0x19
> +
> +/* tsl2772 cmd reg masks */
> +#define TSL2772_CMD_REG			0x80
> +#define TSL2772_CMD_SPL_FN		0x60
> +#define TSL2772_CMD_REPEAT_PROTO	0x00
> +#define TSL2772_CMD_AUTOINC_PROTO	0x20
> +
> +#define TSL2772_CMD_PROX_INT_CLR	0X05
> +#define TSL2772_CMD_ALS_INT_CLR		0x06
> +#define TSL2772_CMD_PROXALS_INT_CLR	0X07
> +
> +/* tsl2772 cntrl reg masks */
> +#define TSL2772_CNTL_ADC_ENBL		0x02
> +#define TSL2772_CNTL_PWR_ON		0x01
> +
> +/* tsl2772 status reg masks */
> +#define TSL2772_STA_ADC_VALID		0x01
> +#define TSL2772_STA_PRX_VALID		0x02
> +#define TSL2772_STA_ADC_PRX_VALID	(TSL2772_STA_ADC_VALID | \
> +					 TSL2772_STA_PRX_VALID)
> +#define TSL2772_STA_ALS_INTR		0x10
> +#define TSL2772_STA_PRX_INTR		0x20
> +
> +/* tsl2772 cntrl reg masks */
> +#define TSL2772_CNTL_REG_CLEAR		0x00
> +#define TSL2772_CNTL_PROX_INT_ENBL	0X20
> +#define TSL2772_CNTL_ALS_INT_ENBL	0X10
> +#define TSL2772_CNTL_WAIT_TMR_ENBL	0X08
> +#define TSL2772_CNTL_PROX_DET_ENBL	0X04
> +#define TSL2772_CNTL_PWRON		0x01
> +#define TSL2772_CNTL_ALSPON_ENBL	0x03
> +#define TSL2772_CNTL_INTALSPON_ENBL	0x13
> +#define TSL2772_CNTL_PROXPON_ENBL	0x0F
> +#define TSL2772_CNTL_INTPROXPON_ENBL	0x2F
> +
> +/* TAOS Device family members */
>  enum {
>  	tsl2571,
>  	tsl2671,
> @@ -118,39 +119,39 @@ enum {
>  };
>  
>  enum {
> -	TSL2X7X_CHIP_UNKNOWN = 0,
> -	TSL2X7X_CHIP_WORKING = 1,
> -	TSL2X7X_CHIP_SUSPENDED = 2
> +	TSL2772_CHIP_UNKNOWN = 0,
> +	TSL2772_CHIP_WORKING = 1,
> +	TSL2772_CHIP_SUSPENDED = 2
>  };
>  
>  /* Per-device data */
> -struct tsl2x7x_als_info {
> +struct tsl2772_als_info {
>  	u16 als_ch0;
>  	u16 als_ch1;
>  	u16 lux;
>  };
>  
> -struct tsl2x7x_chip_info {
> +struct tsl2772_chip_info {
>  	int chan_table_elements;
>  	struct iio_chan_spec channel_with_events[4];
>  	struct iio_chan_spec channel_without_events[4];
>  	const struct iio_info *info;
>  };
>  
> -struct tsl2X7X_chip {
> +struct tsl2772_chip {
>  	kernel_ulong_t id;
>  	struct mutex prox_mutex;
>  	struct mutex als_mutex;
>  	struct i2c_client *client;
>  	u16 prox_data;
> -	struct tsl2x7x_als_info als_cur_info;
> -	struct tsl2x7x_settings settings;
> -	struct tsl2X7X_platform_data *pdata;
> +	struct tsl2772_als_info als_cur_info;
> +	struct tsl2772_settings settings;
> +	struct tsl2772_platform_data *pdata;
>  	int als_gain_time_scale;
>  	int als_saturation;
> -	int tsl2x7x_chip_status;
> -	u8 tsl2x7x_config[TSL2X7X_MAX_CONFIG_REG];
> -	const struct tsl2x7x_chip_info	*chip_info;
> +	int tsl2772_chip_status;
> +	u8 tsl2772_config[TSL2772_MAX_CONFIG_REG];
> +	const struct tsl2772_chip_info	*chip_info;
>  	const struct iio_info *info;
>  	s64 event_timestamp;
>  	/*
> @@ -158,7 +159,7 @@ struct tsl2X7X_chip {
>  	 * updates via sysfs.
>  	 * Sized to 9 = max 8 segments + 1 termination segment
>  	 */
> -	struct tsl2x7x_lux tsl2x7x_device_lux[TSL2X7X_MAX_LUX_TABLE_SIZE];
> +	struct tsl2772_lux tsl2772_device_lux[TSL2772_MAX_LUX_TABLE_SIZE];
>  };
>  
>  /*
> @@ -169,31 +170,31 @@ struct tsl2X7X_chip {
>   * The two rows in each table correspond to the Lux1 and Lux2 equations from
>   * the datasheets.
>   */
> -static const struct tsl2x7x_lux tsl2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +static const struct tsl2772_lux tsl2x71_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
>  	{ 53000, 106000 },
>  	{ 31800,  53000 },
>  	{ 0,          0 },
>  };
>  
> -static const struct tsl2x7x_lux tmd2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +static const struct tsl2772_lux tmd2x71_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
>  	{ 24000,  48000 },
>  	{ 14400,  24000 },
>  	{ 0,          0 },
>  };
>  
> -static const struct tsl2x7x_lux tsl2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +static const struct tsl2772_lux tsl2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
>  	{ 60000, 112200 },
>  	{ 37800,  60000 },
>  	{     0,      0 },
>  };
>  
> -static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +static const struct tsl2772_lux tmd2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
>  	{ 20000,  35000 },
>  	{ 12600,  20000 },
>  	{     0,      0 },
>  };
>  
> -static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
> +static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
>  	[tsl2571] =	tsl2x71_lux_table,
>  	[tsl2671] =	tsl2x71_lux_table,
>  	[tmd2671] =	tmd2x71_lux_table,
> @@ -206,7 +207,7 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  	[tmd2772] =	tmd2x72_lux_table,
>  };
>  
> -static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> +static const struct tsl2772_settings tsl2772_default_settings = {
>  	.als_time = 255, /* 2.72 / 2.73 ms */
>  	.als_gain = 0,
>  	.prox_time = 255, /* 2.72 / 2.73 ms */
> @@ -225,30 +226,30 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.prox_thres_high = 512,
>  	.prox_max_samples_cal = 30,
>  	.prox_pulse_count = 8,
> -	.prox_diode = TSL2X7X_DIODE1,
> -	.prox_power = TSL2X7X_100_mA
> +	.prox_diode = TSL2772_DIODE1,
> +	.prox_power = TSL2772_100_mA
>  };
>  
> -static const s16 tsl2x7x_als_gain[] = {
> +static const s16 tsl2772_als_gain[] = {
>  	1,
>  	8,
>  	16,
>  	120
>  };
>  
> -static const s16 tsl2x7x_prox_gain[] = {
> +static const s16 tsl2772_prox_gain[] = {
>  	1,
>  	2,
>  	4,
>  	8
>  };
>  
> -struct tsl2x7x_int_time {
> +struct tsl2772_int_time {
>  	int increment_us;
>  	char *display_range;
>  };
>  
> -static const struct tsl2x7x_int_time tsl2x7x_int_time[] = {
> +static const struct tsl2772_int_time tsl2772_int_time[] = {
>  	[tsl2571] = { 2720, "0.00272 - 0.696" },
>  	[tsl2671] = { 2720, "0.00272 - 0.696" },
>  	[tmd2671] = { 2720, "0.00272 - 0.696" },
> @@ -283,12 +284,12 @@ static const u8 device_channel_config[] = {
>  	[tmd2772] = ALSPRX2
>  };
>  
> -static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
> +static int tsl2772_read_status(struct tsl2772_chip *chip)
>  {
>  	int ret;
>  
>  	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> +				       TSL2772_CMD_REG | TSL2772_STATUS);
>  	if (ret < 0)
>  		dev_err(&chip->client->dev,
>  			"%s: failed to read STATUS register: %d\n", __func__,
> @@ -297,12 +298,12 @@ static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
>  	return ret;
>  }
>  
> -static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
> +static int tsl2772_write_control_reg(struct tsl2772_chip *chip, u8 data)
>  {
>  	int ret;
>  
>  	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, data);
> +					TSL2772_CMD_REG | TSL2772_CNTRL, data);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
>  			"%s: failed to write to control register %x: %d\n",
> @@ -312,14 +313,14 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
>  	return ret;
>  }
>  
> -static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
> +static int tsl2772_read_autoinc_regs(struct tsl2772_chip *chip, int lower_reg,
>  				     int upper_reg)
>  {
>  	u8 buf[2];
>  	int ret;
>  
>  	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_AUTOINC_PROTO |
> +				   TSL2772_CMD_REG | TSL2772_CMD_AUTOINC_PROTO |
>  				   lower_reg);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
> @@ -329,7 +330,7 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
>  	}
>  
>  	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | lower_reg);
> +				       TSL2772_CMD_REG | lower_reg);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
>  			"%s: failed to read from register %x: %d\n", __func__,
> @@ -339,7 +340,7 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
>  	buf[0] = ret;
>  
>  	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | upper_reg);
> +				       TSL2772_CMD_REG | upper_reg);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
>  			"%s: failed to read from register %x: %d\n", __func__,
> @@ -349,7 +350,7 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
>  	buf[1] = ret;
>  
>  	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_REPEAT_PROTO |
> +				   TSL2772_CMD_REG | TSL2772_CMD_REPEAT_PROTO |
>  				   lower_reg);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
> @@ -362,7 +363,7 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
>  }
>  
>  /**
> - * tsl2x7x_get_lux() - Reads and calculates current lux value.
> + * tsl2772_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
>   *
>   * The raw ch0 and ch1 values of the ambient light sensed in the last
> @@ -372,47 +373,47 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
>   * coefficients. A lux gain trim is applied to each lux equation, and then the
>   * maximum lux within the interval 0..65535 is selected.
>   */
> -static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
> +static int tsl2772_get_lux(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	struct tsl2x7x_lux *p;
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_lux *p;
>  	int max_lux, ret;
>  	bool overflow;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->tsl2x7x_chip_status != TSL2X7X_CHIP_WORKING) {
> +	if (chip->tsl2772_chip_status != TSL2772_CHIP_WORKING) {
>  		dev_err(&chip->client->dev, "%s: device is not enabled\n",
>  			__func__);
>  		ret = -EBUSY;
>  		goto out_unlock;
>  	}
>  
> -	ret = tsl2x7x_read_status(chip);
> +	ret = tsl2772_read_status(chip);
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
> +	if (!(ret & TSL2772_STA_ADC_VALID)) {
>  		dev_err(&chip->client->dev,
>  			"%s: data not valid yet\n", __func__);
>  		ret = chip->als_cur_info.lux; /* return LAST VALUE */
>  		goto out_unlock;
>  	}
>  
> -	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN0LO,
> -					TSL2X7X_ALS_CHAN0HI);
> +	ret = tsl2772_read_autoinc_regs(chip, TSL2772_ALS_CHAN0LO,
> +					TSL2772_ALS_CHAN0HI);
>  	if (ret < 0)
>  		goto out_unlock;
>  	chip->als_cur_info.als_ch0 = ret;
>  
> -	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN1LO,
> -					TSL2X7X_ALS_CHAN1HI);
> +	ret = tsl2772_read_autoinc_regs(chip, TSL2772_ALS_CHAN1LO,
> +					TSL2772_ALS_CHAN1HI);
>  	if (ret < 0)
>  		goto out_unlock;
>  	chip->als_cur_info.als_ch1 = ret;
>  
>  	if (chip->als_cur_info.als_ch0 >= chip->als_saturation) {
> -		max_lux = TSL2X7X_LUX_CALC_OVER_FLOW;
> +		max_lux = TSL2772_LUX_CALC_OVER_FLOW;
>  		goto update_struct_with_max_lux;
>  	}
>  
> @@ -424,7 +425,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  
>  	max_lux = 0;
>  	overflow = false;
> -	for (p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux; p->ch0 != 0;
> +	for (p = (struct tsl2772_lux *)chip->tsl2772_device_lux; p->ch0 != 0;
>  	     p++) {
>  		int lux;
>  
> @@ -440,7 +441,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		 */
>  		lux = (lux * chip->settings.als_gain_trim) / 1000;
>  
> -		if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) {
> +		if (lux > TSL2772_LUX_CALC_OVER_FLOW) {
>  			overflow = true;
>  			continue;
>  		}
> @@ -449,7 +450,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	}
>  
>  	if (overflow && max_lux == 0)
> -		max_lux = TSL2X7X_LUX_CALC_OVER_FLOW;
> +		max_lux = TSL2772_LUX_CALC_OVER_FLOW;
>  
>  update_struct_with_max_lux:
>  	chip->als_cur_info.lux = max_lux;
> @@ -462,19 +463,19 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  }
>  
>  /**
> - * tsl2x7x_get_prox() - Reads proximity data registers and updates
> + * tsl2772_get_prox() - Reads proximity data registers and updates
>   *                      chip->prox_data.
>   *
>   * @indio_dev:	pointer to IIO device
>   */
> -static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
> +static int tsl2772_get_prox(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret;
>  
>  	mutex_lock(&chip->prox_mutex);
>  
> -	ret = tsl2x7x_read_status(chip);
> +	ret = tsl2772_read_status(chip);
>  	if (ret < 0)
>  		goto prox_poll_err;
>  
> @@ -484,7 +485,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	case tmd2671:
>  	case tsl2771:
>  	case tmd2771:
> -		if (!(ret & TSL2X7X_STA_ADC_VALID)) {
> +		if (!(ret & TSL2772_STA_ADC_VALID)) {
>  			ret = -EINVAL;
>  			goto prox_poll_err;
>  		}
> @@ -494,14 +495,14 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	case tmd2672:
>  	case tsl2772:
>  	case tmd2772:
> -		if (!(ret & TSL2X7X_STA_PRX_VALID)) {
> +		if (!(ret & TSL2772_STA_PRX_VALID)) {
>  			ret = -EINVAL;
>  			goto prox_poll_err;
>  		}
>  		break;
>  	}
>  
> -	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_PRX_LO, TSL2X7X_PRX_HI);
> +	ret = tsl2772_read_autoinc_regs(chip, TSL2772_PRX_LO, TSL2772_PRX_HI);
>  	if (ret < 0)
>  		goto prox_poll_err;
>  	chip->prox_data = ret;
> @@ -513,46 +514,46 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  }
>  
>  /**
> - * tsl2x7x_defaults() - Populates the device nominal operating parameters
> + * tsl2772_defaults() - Populates the device nominal operating parameters
>   *                      with those provided by a 'platform' data struct or
>   *                      with prefined defaults.
>   *
>   * @chip:               pointer to device structure.
>   */
> -static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
> +static void tsl2772_defaults(struct tsl2772_chip *chip)
>  {
>  	/* If Operational settings defined elsewhere.. */
>  	if (chip->pdata && chip->pdata->platform_default_settings)
>  		memcpy(&chip->settings, chip->pdata->platform_default_settings,
> -		       sizeof(tsl2x7x_default_settings));
> +		       sizeof(tsl2772_default_settings));
>  	else
> -		memcpy(&chip->settings, &tsl2x7x_default_settings,
> -		       sizeof(tsl2x7x_default_settings));
> +		memcpy(&chip->settings, &tsl2772_default_settings,
> +		       sizeof(tsl2772_default_settings));
>  
>  	/* Load up the proper lux table. */
>  	if (chip->pdata && chip->pdata->platform_lux_table[0].ch0 != 0)
> -		memcpy(chip->tsl2x7x_device_lux,
> +		memcpy(chip->tsl2772_device_lux,
>  		       chip->pdata->platform_lux_table,
>  		       sizeof(chip->pdata->platform_lux_table));
>  	else
> -		memcpy(chip->tsl2x7x_device_lux,
> -		       tsl2x7x_default_lux_table_group[chip->id],
> -		       TSL2X7X_DEFAULT_TABLE_BYTES);
> +		memcpy(chip->tsl2772_device_lux,
> +		       tsl2772_default_lux_table_group[chip->id],
> +		       TSL2772_DEFAULT_TABLE_BYTES);
>  }
>  
>  /**
> - * tsl2x7x_als_calibrate() -	Obtain single reading and calculate
> + * tsl2772_als_calibrate() -	Obtain single reading and calculate
>   *                              the als_gain_trim.
>   *
>   * @indio_dev:	pointer to IIO device
>   */
> -static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
> +static int tsl2772_als_calibrate(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret, lux_val;
>  
>  	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
> +				       TSL2772_CMD_REG | TSL2772_CNTRL);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
>  			"%s: failed to read from the CNTRL register\n",
> @@ -560,20 +561,20 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	if ((ret & (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON))
> -			!= (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON)) {
> +	if ((ret & (TSL2772_CNTL_ADC_ENBL | TSL2772_CNTL_PWR_ON))
> +			!= (TSL2772_CNTL_ADC_ENBL | TSL2772_CNTL_PWR_ON)) {
>  		dev_err(&chip->client->dev,
>  			"%s: Device is not powered on and/or ADC is not enabled\n",
>  			__func__);
>  		return -EINVAL;
> -	} else if ((ret & TSL2X7X_STA_ADC_VALID) != TSL2X7X_STA_ADC_VALID) {
> +	} else if ((ret & TSL2772_STA_ADC_VALID) != TSL2772_STA_ADC_VALID) {
>  		dev_err(&chip->client->dev,
>  			"%s: The two ADC channels have not completed an integration cycle\n",
>  			__func__);
>  		return -ENODATA;
>  	}
>  
> -	lux_val = tsl2x7x_get_lux(indio_dev);
> +	lux_val = tsl2772_get_lux(indio_dev);
>  	if (lux_val < 0) {
>  		dev_err(&chip->client->dev,
>  			"%s: failed to get lux\n", __func__);
> @@ -590,51 +591,51 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> +static int tsl2772_chip_on(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret, i, als_count, als_time_us;
>  	u8 *dev_reg, reg_val;
>  
>  	/* Non calculated parameters */
> -	chip->tsl2x7x_config[TSL2X7X_ALS_TIME] = chip->settings.als_time;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
> -	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
> -	chip->tsl2x7x_config[TSL2X7X_ALS_PRX_CONFIG] =
> +	chip->tsl2772_config[TSL2772_ALS_TIME] = chip->settings.als_time;
> +	chip->tsl2772_config[TSL2772_PRX_TIME] = chip->settings.prox_time;
> +	chip->tsl2772_config[TSL2772_WAIT_TIME] = chip->settings.wait_time;
> +	chip->tsl2772_config[TSL2772_ALS_PRX_CONFIG] =
>  		chip->settings.als_prox_config;
>  
> -	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHLO] =
> +	chip->tsl2772_config[TSL2772_ALS_MINTHRESHLO] =
>  		(chip->settings.als_thresh_low) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHHI] =
> +	chip->tsl2772_config[TSL2772_ALS_MINTHRESHHI] =
>  		(chip->settings.als_thresh_low >> 8) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHLO] =
> +	chip->tsl2772_config[TSL2772_ALS_MAXTHRESHLO] =
>  		(chip->settings.als_thresh_high) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHHI] =
> +	chip->tsl2772_config[TSL2772_ALS_MAXTHRESHHI] =
>  		(chip->settings.als_thresh_high >> 8) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] =
> +	chip->tsl2772_config[TSL2772_PERSISTENCE] =
>  		(chip->settings.prox_persistence & 0xFF) << 4 |
>  		(chip->settings.als_persistence & 0xFF);
>  
> -	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
> +	chip->tsl2772_config[TSL2772_PRX_COUNT] =
>  			chip->settings.prox_pulse_count;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHLO] =
> +	chip->tsl2772_config[TSL2772_PRX_MINTHRESHLO] =
>  			(chip->settings.prox_thres_low) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHHI] =
> +	chip->tsl2772_config[TSL2772_PRX_MINTHRESHHI] =
>  			(chip->settings.prox_thres_low >> 8) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHLO] =
> +	chip->tsl2772_config[TSL2772_PRX_MAXTHRESHLO] =
>  			(chip->settings.prox_thres_high) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHHI] =
> +	chip->tsl2772_config[TSL2772_PRX_MAXTHRESHHI] =
>  			(chip->settings.prox_thres_high >> 8) & 0xFF;
>  
>  	/* and make sure we're not already on */
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> +	if (chip->tsl2772_chip_status == TSL2772_CHIP_WORKING) {
>  		/* if forcing a register update - turn off, then on */
>  		dev_info(&chip->client->dev, "device is already enabled\n");
>  		return -EINVAL;
>  	}
>  
> -	/* Set the gain based on tsl2x7x_settings struct */
> -	chip->tsl2x7x_config[TSL2X7X_GAIN] =
> +	/* Set the gain based on tsl2772_settings struct */
> +	chip->tsl2772_config[TSL2772_GAIN] =
>  		(chip->settings.als_gain & 0xFF) |
>  		((chip->settings.prox_gain & 0xFF) << 2) |
>  		(chip->settings.prox_diode << 4) |
> @@ -642,16 +643,16 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  	/* set chip time scaling and saturation */
>  	als_count = 256 - chip->settings.als_time;
> -	als_time_us = als_count * tsl2x7x_int_time[chip->id].increment_us;
> +	als_time_us = als_count * tsl2772_int_time[chip->id].increment_us;
>  	chip->als_saturation = als_count * 768; /* 75% of full scale */
>  	chip->als_gain_time_scale = als_time_us *
> -		tsl2x7x_als_gain[chip->settings.als_gain];
> +		tsl2772_als_gain[chip->settings.als_gain];
>  
>  	/*
> -	 * TSL2X7X Specific power-on / adc enable sequence
> +	 * TSL2772 Specific power-on / adc enable sequence
>  	 * Power on the device 1st.
>  	 */
> -	ret = tsl2x7x_write_control_reg(chip, TSL2X7X_CNTL_PWR_ON);
> +	ret = tsl2772_write_control_reg(chip, TSL2772_CNTL_PWR_ON);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -659,9 +660,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	 * Use the following shadow copy for our delay before enabling ADC.
>  	 * Write all the registers.
>  	 */
> -	for (i = 0, dev_reg = chip->tsl2x7x_config;
> -			i < TSL2X7X_MAX_CONFIG_REG; i++) {
> -		int reg = TSL2X7X_CMD_REG + i;
> +	for (i = 0, dev_reg = chip->tsl2772_config;
> +			i < TSL2772_MAX_CONFIG_REG; i++) {
> +		int reg = TSL2772_CMD_REG + i;
>  
>  		ret = i2c_smbus_write_byte_data(chip->client, reg,
>  						*dev_reg++);
> @@ -676,20 +677,20 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	/* Power-on settling time */
>  	usleep_range(3000, 3500);
>  
> -	reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL |
> -		  TSL2X7X_CNTL_PROX_DET_ENBL;
> +	reg_val = TSL2772_CNTL_PWR_ON | TSL2772_CNTL_ADC_ENBL |
> +		  TSL2772_CNTL_PROX_DET_ENBL;
>  	if (chip->settings.als_interrupt_en)
> -		reg_val |= TSL2X7X_CNTL_ALS_INT_ENBL;
> +		reg_val |= TSL2772_CNTL_ALS_INT_ENBL;
>  	if (chip->settings.prox_interrupt_en)
> -		reg_val |= TSL2X7X_CNTL_PROX_INT_ENBL;
> +		reg_val |= TSL2772_CNTL_PROX_INT_ENBL;
>  
> -	ret = tsl2x7x_write_control_reg(chip, reg_val);
> +	ret = tsl2772_write_control_reg(chip, reg_val);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +				   TSL2772_CMD_REG | TSL2772_CMD_SPL_FN |
> +				   TSL2772_CMD_PROXALS_INT_CLR);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
>  			"%s: failed to clear interrupt status: %d\n",
> @@ -697,22 +698,22 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
> +	chip->tsl2772_chip_status = TSL2772_CHIP_WORKING;
>  
>  	return ret;
>  }
>  
> -static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
> +static int tsl2772_chip_off(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  
>  	/* turn device off */
> -	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
> -	return tsl2x7x_write_control_reg(chip, 0x00);
> +	chip->tsl2772_chip_status = TSL2772_CHIP_SUSPENDED;
> +	return tsl2772_write_control_reg(chip, 0x00);
>  }
>  
>  /**
> - * tsl2x7x_invoke_change - power cycle the device to implement the user
> + * tsl2772_invoke_change - power cycle the device to implement the user
>   *                         parameters
>   * @indio_dev:	pointer to IIO device
>   *
> @@ -720,22 +721,22 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
>   * (On/Off), cycle device to implement updated parameter, put device back into
>   * proper state, and unlock resource.
>   */
> -static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
> +static int tsl2772_invoke_change(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int device_status = chip->tsl2x7x_chip_status;
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
> +	int device_status = chip->tsl2772_chip_status;
>  	int ret;
>  
>  	mutex_lock(&chip->als_mutex);
>  	mutex_lock(&chip->prox_mutex);
>  
> -	if (device_status == TSL2X7X_CHIP_WORKING) {
> -		ret = tsl2x7x_chip_off(indio_dev);
> +	if (device_status == TSL2772_CHIP_WORKING) {
> +		ret = tsl2772_chip_off(indio_dev);
>  		if (ret < 0)
>  			goto unlock;
>  	}
>  
> -	ret = tsl2x7x_chip_on(indio_dev);
> +	ret = tsl2772_chip_on(indio_dev);
>  
>  unlock:
>  	mutex_unlock(&chip->prox_mutex);
> @@ -744,9 +745,9 @@ static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
> +static int tsl2772_prox_cal(struct iio_dev *indio_dev)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int prox_history[MAX_SAMPLES_CAL + 1];
>  	int i, ret, mean, max, sample_sum;
>  
> @@ -756,7 +757,7 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  
>  	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
>  		usleep_range(15000, 17500);
> -		ret = tsl2x7x_get_prox(indio_dev);
> +		ret = tsl2772_get_prox(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -773,7 +774,7 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  
>  	chip->settings.prox_thres_high = (max << 1) - mean;
>  
> -	return tsl2x7x_invoke_change(indio_dev);
> +	return tsl2772_invoke_change(indio_dev);
>  }
>  
>  static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
> @@ -785,17 +786,17 @@ in_intensity0_integration_time_available_show(struct device *dev,
>  					      struct device_attribute *attr,
>  					      char *buf)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +	struct tsl2772_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  
>  	return snprintf(buf, PAGE_SIZE, "%s\n",
> -			tsl2x7x_int_time[chip->id].display_range);
> +			tsl2772_int_time[chip->id].display_range);
>  }
>  
>  static ssize_t in_illuminance0_target_input_show(struct device *dev,
>  						 struct device_attribute *attr,
>  						 char *buf)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +	struct tsl2772_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  
>  	return snprintf(buf, PAGE_SIZE, "%d\n", chip->settings.als_cal_target);
>  }
> @@ -805,7 +806,7 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  						  const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	u16 value;
>  	int ret;
>  
> @@ -813,7 +814,7 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  		return -EINVAL;
>  
>  	chip->settings.als_cal_target = value;
> -	ret = tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2772_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -831,11 +832,11 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	ret = tsl2x7x_als_calibrate(indio_dev);
> +	ret = tsl2772_als_calibrate(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2772_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -846,15 +847,15 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
>  					      struct device_attribute *attr,
>  					      char *buf)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +	struct tsl2772_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  	int i = 0;
>  	int offset = 0;
>  
> -	while (i < TSL2X7X_MAX_LUX_TABLE_SIZE) {
> +	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
>  		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> -			chip->tsl2x7x_device_lux[i].ch0,
> -			chip->tsl2x7x_device_lux[i].ch1);
> -		if (chip->tsl2x7x_device_lux[i].ch0 == 0) {
> +			chip->tsl2772_device_lux[i].ch0,
> +			chip->tsl2772_device_lux[i].ch1);
> +		if (chip->tsl2772_device_lux[i].ch0 == 0) {
>  			/*
>  			 * We just printed the first "0" entry.
>  			 * Now get rid of the extra "," and break.
> @@ -874,8 +875,8 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  					       const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int value[ARRAY_SIZE(chip->tsl2x7x_device_lux) * 2 + 1];
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
> +	int value[ARRAY_SIZE(chip->tsl2772_device_lux) * 2 + 1];
>  	int n, ret;
>  
>  	get_options(buf, ARRAY_SIZE(value), value);
> @@ -888,23 +889,23 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  	 */
>  	n = value[0];
>  	if ((n % 2) || n < 4 ||
> -	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 2))
> +	    n > ((ARRAY_SIZE(chip->tsl2772_device_lux) - 1) * 2))
>  		return -EINVAL;
>  
>  	if ((value[(n - 1)] | value[n]) != 0)
>  		return -EINVAL;
>  
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> -		ret = tsl2x7x_chip_off(indio_dev);
> +	if (chip->tsl2772_chip_status == TSL2772_CHIP_WORKING) {
> +		ret = tsl2772_chip_off(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  	}
>  
>  	/* Zero out the table */
> -	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));
> -	memcpy(chip->tsl2x7x_device_lux, &value[1], (value[0] * 4));
> +	memset(chip->tsl2772_device_lux, 0, sizeof(chip->tsl2772_device_lux));
> +	memcpy(chip->tsl2772_device_lux, &value[1], (value[0] * 4));
>  
> -	ret = tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2772_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -922,23 +923,23 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	ret = tsl2x7x_prox_cal(indio_dev);
> +	ret = tsl2772_prox_cal(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2772_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
>  	return len;
>  }
>  
> -static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
> +static int tsl2772_read_interrupt_config(struct iio_dev *indio_dev,
>  					 const struct iio_chan_spec *chan,
>  					 enum iio_event_type type,
>  					 enum iio_event_direction dir)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  
>  	if (chan->type == IIO_INTENSITY)
>  		return chip->settings.als_interrupt_en;
> @@ -946,30 +947,30 @@ static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
>  		return chip->settings.prox_interrupt_en;
>  }
>  
> -static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
> +static int tsl2772_write_interrupt_config(struct iio_dev *indio_dev,
>  					  const struct iio_chan_spec *chan,
>  					  enum iio_event_type type,
>  					  enum iio_event_direction dir,
>  					  int val)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  
>  	if (chan->type == IIO_INTENSITY)
>  		chip->settings.als_interrupt_en = val ? true : false;
>  	else
>  		chip->settings.prox_interrupt_en = val ? true : false;
>  
> -	return tsl2x7x_invoke_change(indio_dev);
> +	return tsl2772_invoke_change(indio_dev);
>  }
>  
> -static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
> +static int tsl2772_write_event_value(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,
>  				     enum iio_event_direction dir,
>  				     enum iio_event_info info,
>  				     int val, int val2)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret = -EINVAL, count, persistence;
>  	u8 time;
>  
> @@ -1011,7 +1012,7 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  
>  		count = 256 - time;
>  		persistence = ((val * 1000000) + val2) /
> -			(count * tsl2x7x_int_time[chip->id].increment_us);
> +			(count * tsl2772_int_time[chip->id].increment_us);
>  
>  		if (chan->type == IIO_INTENSITY) {
>  			/* ALS filter values are 1, 2, 3, 5, 10, 15, ..., 60 */
> @@ -1032,17 +1033,17 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return tsl2x7x_invoke_change(indio_dev);
> +	return tsl2772_invoke_change(indio_dev);
>  }
>  
> -static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
> +static int tsl2772_read_event_value(struct iio_dev *indio_dev,
>  				    const struct iio_chan_spec *chan,
>  				    enum iio_event_type type,
>  				    enum iio_event_direction dir,
>  				    enum iio_event_info info,
>  				    int *val, int *val2)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret = -EINVAL, filter_delay, persistence;
>  	u8 time;
>  
> @@ -1090,7 +1091,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  		}
>  
>  		filter_delay = persistence * (256 - time) *
> -			tsl2x7x_int_time[chip->id].increment_us;
> +			tsl2772_int_time[chip->id].increment_us;
>  
>  		*val = filter_delay / 1000000;
>  		*val2 = filter_delay % 1000000;
> @@ -1103,20 +1104,20 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
> +static int tsl2772_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val,
>  			    int *val2,
>  			    long mask)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_LIGHT:
> -			tsl2x7x_get_lux(indio_dev);
> +			tsl2772_get_lux(indio_dev);
>  			*val = chip->als_cur_info.lux;
>  			ret = IIO_VAL_INT;
>  			break;
> @@ -1127,7 +1128,7 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
> -			tsl2x7x_get_lux(indio_dev);
> +			tsl2772_get_lux(indio_dev);
>  			if (chan->channel == 0)
>  				*val = chip->als_cur_info.als_ch0;
>  			else
> @@ -1135,7 +1136,7 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_PROXIMITY:
> -			tsl2x7x_get_prox(indio_dev);
> +			tsl2772_get_prox(indio_dev);
>  			*val = chip->prox_data;
>  			ret = IIO_VAL_INT;
>  			break;
> @@ -1145,9 +1146,9 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		if (chan->type == IIO_LIGHT)
> -			*val = tsl2x7x_als_gain[chip->settings.als_gain];
> +			*val = tsl2772_als_gain[chip->settings.als_gain];
>  		else
> -			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
> +			*val = tsl2772_prox_gain[chip->settings.prox_gain];
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -1157,7 +1158,7 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = 0;
>  		*val2 = (256 - chip->settings.als_time) *
> -			tsl2x7x_int_time[chip->id].increment_us;
> +			tsl2772_int_time[chip->id].increment_us;
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	default:
> @@ -1167,13 +1168,13 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
> +static int tsl2772_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val,
>  			     int val2,
>  			     long mask)
>  {
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBSCALE:
> @@ -1218,13 +1219,13 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		chip->settings.als_time = 256 -
> -			(val2 / tsl2x7x_int_time[chip->id].increment_us);
> +			(val2 / tsl2772_int_time[chip->id].increment_us);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return tsl2x7x_invoke_change(indio_dev);
> +	return tsl2772_invoke_change(indio_dev);
>  }
>  
>  static DEVICE_ATTR_RO(in_intensity0_integration_time_available);
> @@ -1238,7 +1239,7 @@ static DEVICE_ATTR_WO(in_proximity0_calibrate);
>  static DEVICE_ATTR_RW(in_illuminance0_lux_table);
>  
>  /* Use the default register values to identify the Taos device */
> -static int tsl2x7x_device_id_verif(int id, int target)
> +static int tsl2772_device_id_verif(int id, int target)
>  {
>  	switch (target) {
>  	case tsl2571:
> @@ -1259,19 +1260,19 @@ static int tsl2x7x_device_id_verif(int id, int target)
>  	return -EINVAL;
>  }
>  
> -static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
> +static irqreturn_t tsl2772_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  
> -	ret = tsl2x7x_read_status(chip);
> +	ret = tsl2772_read_status(chip);
>  	if (ret < 0)
>  		return IRQ_HANDLED;
>  
>  	/* What type of interrupt do we need to process */
> -	if (ret & TSL2X7X_STA_PRX_INTR) {
> +	if (ret & TSL2772_STA_PRX_INTR) {
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
>  						    0,
> @@ -1280,7 +1281,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    timestamp);
>  	}
>  
> -	if (ret & TSL2X7X_STA_ALS_INTR) {
> +	if (ret & TSL2772_STA_ALS_INTR) {
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>  						    0,
> @@ -1290,8 +1291,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  	}
>  
>  	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +				   TSL2772_CMD_REG | TSL2772_CMD_SPL_FN |
> +				   TSL2772_CMD_PROXALS_INT_CLR);
>  	if (ret < 0)
>  		dev_err(&chip->client->dev,
>  			"%s: failed to clear interrupt status: %d\n",
> @@ -1300,7 +1301,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> +static struct attribute *tsl2772_ALS_device_attrs[] = {
>  	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&dev_attr_in_intensity0_integration_time_available.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
> @@ -1309,12 +1310,12 @@ static struct attribute *tsl2x7x_ALS_device_attrs[] = {
>  	NULL
>  };
>  
> -static struct attribute *tsl2x7x_PRX_device_attrs[] = {
> +static struct attribute *tsl2772_PRX_device_attrs[] = {
>  	&dev_attr_in_proximity0_calibrate.attr,
>  	NULL
>  };
>  
> -static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> +static struct attribute *tsl2772_ALSPRX_device_attrs[] = {
>  	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&dev_attr_in_intensity0_integration_time_available.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
> @@ -1323,13 +1324,13 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  	NULL
>  };
>  
> -static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
> +static struct attribute *tsl2772_PRX2_device_attrs[] = {
>  	&dev_attr_in_proximity0_calibrate.attr,
>  	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  
> -static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> +static struct attribute *tsl2772_ALSPRX2_device_attrs[] = {
>  	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&dev_attr_in_intensity0_integration_time_available.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
> @@ -1340,73 +1341,73 @@ static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
>  	NULL
>  };
>  
> -static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
> +static const struct attribute_group tsl2772_device_attr_group_tbl[] = {
>  	[ALS] = {
> -		.attrs = tsl2x7x_ALS_device_attrs,
> +		.attrs = tsl2772_ALS_device_attrs,
>  	},
>  	[PRX] = {
> -		.attrs = tsl2x7x_PRX_device_attrs,
> +		.attrs = tsl2772_PRX_device_attrs,
>  	},
>  	[ALSPRX] = {
> -		.attrs = tsl2x7x_ALSPRX_device_attrs,
> +		.attrs = tsl2772_ALSPRX_device_attrs,
>  	},
>  	[PRX2] = {
> -		.attrs = tsl2x7x_PRX2_device_attrs,
> +		.attrs = tsl2772_PRX2_device_attrs,
>  	},
>  	[ALSPRX2] = {
> -		.attrs = tsl2x7x_ALSPRX2_device_attrs,
> +		.attrs = tsl2772_ALSPRX2_device_attrs,
>  	},
>  };
>  
> -static const struct iio_info tsl2X7X_device_info[] = {
> +static const struct iio_info tsl2772_device_info[] = {
>  	[ALS] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> +		.attrs = &tsl2772_device_attr_group_tbl[ALS],
> +		.read_raw = &tsl2772_read_raw,
> +		.write_raw = &tsl2772_write_raw,
> +		.read_event_value = &tsl2772_read_event_value,
> +		.write_event_value = &tsl2772_write_event_value,
> +		.read_event_config = &tsl2772_read_interrupt_config,
> +		.write_event_config = &tsl2772_write_interrupt_config,
>  	},
>  	[PRX] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> +		.attrs = &tsl2772_device_attr_group_tbl[PRX],
> +		.read_raw = &tsl2772_read_raw,
> +		.write_raw = &tsl2772_write_raw,
> +		.read_event_value = &tsl2772_read_event_value,
> +		.write_event_value = &tsl2772_write_event_value,
> +		.read_event_config = &tsl2772_read_interrupt_config,
> +		.write_event_config = &tsl2772_write_interrupt_config,
>  	},
>  	[ALSPRX] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> +		.attrs = &tsl2772_device_attr_group_tbl[ALSPRX],
> +		.read_raw = &tsl2772_read_raw,
> +		.write_raw = &tsl2772_write_raw,
> +		.read_event_value = &tsl2772_read_event_value,
> +		.write_event_value = &tsl2772_write_event_value,
> +		.read_event_config = &tsl2772_read_interrupt_config,
> +		.write_event_config = &tsl2772_write_interrupt_config,
>  	},
>  	[PRX2] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> +		.attrs = &tsl2772_device_attr_group_tbl[PRX2],
> +		.read_raw = &tsl2772_read_raw,
> +		.write_raw = &tsl2772_write_raw,
> +		.read_event_value = &tsl2772_read_event_value,
> +		.write_event_value = &tsl2772_write_event_value,
> +		.read_event_config = &tsl2772_read_interrupt_config,
> +		.write_event_config = &tsl2772_write_interrupt_config,
>  	},
>  	[ALSPRX2] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> +		.attrs = &tsl2772_device_attr_group_tbl[ALSPRX2],
> +		.read_raw = &tsl2772_read_raw,
> +		.write_raw = &tsl2772_write_raw,
> +		.read_event_value = &tsl2772_read_event_value,
> +		.write_event_value = &tsl2772_write_event_value,
> +		.read_event_config = &tsl2772_read_interrupt_config,
> +		.write_event_config = &tsl2772_write_interrupt_config,
>  	},
>  };
>  
> -static const struct iio_event_spec tsl2x7x_events[] = {
> +static const struct iio_event_spec tsl2772_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_RISING,
> @@ -1423,7 +1424,7 @@ static const struct iio_event_spec tsl2x7x_events[] = {
>  	},
>  };
>  
> -static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
> +static const struct tsl2772_chip_info tsl2772_chip_info_tbl[] = {
>  	[ALS] = {
>  		.channel_with_events = {
>  			{
> @@ -1439,8 +1440,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1468,7 +1469,7 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			},
>  		},
>  		.chan_table_elements = 3,
> -		.info = &tsl2X7X_device_info[ALS],
> +		.info = &tsl2772_device_info[ALS],
>  	},
>  	[PRX] = {
>  		.channel_with_events = {
> @@ -1477,8 +1478,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			},
>  		},
>  		.channel_without_events = {
> @@ -1490,7 +1491,7 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			},
>  		},
>  		.chan_table_elements = 1,
> -		.info = &tsl2X7X_device_info[PRX],
> +		.info = &tsl2772_device_info[PRX],
>  	},
>  	[ALSPRX] = {
>  		.channel_with_events = {
> @@ -1507,8 +1508,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1519,8 +1520,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			},
>  		},
>  		.channel_without_events = {
> @@ -1550,7 +1551,7 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			},
>  		},
>  		.chan_table_elements = 4,
> -		.info = &tsl2X7X_device_info[ALSPRX],
> +		.info = &tsl2772_device_info[ALSPRX],
>  	},
>  	[PRX2] = {
>  		.channel_with_events = {
> @@ -1560,8 +1561,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			},
>  		},
>  		.channel_without_events = {
> @@ -1574,7 +1575,7 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			},
>  		},
>  		.chan_table_elements = 1,
> -		.info = &tsl2X7X_device_info[PRX2],
> +		.info = &tsl2772_device_info[PRX2],
>  	},
>  	[ALSPRX2] = {
>  		.channel_with_events = {
> @@ -1591,8 +1592,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  				BIT(IIO_CHAN_INFO_INT_TIME) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				BIT(IIO_CHAN_INFO_CALIBBIAS),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
> @@ -1604,8 +1605,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_CALIBSCALE),
> -			.event_spec = tsl2x7x_events,
> -			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			.event_spec = tsl2772_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2772_events),
>  			},
>  		},
>  		.channel_without_events = {
> @@ -1636,15 +1637,15 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			},
>  		},
>  		.chan_table_elements = 4,
> -		.info = &tsl2X7X_device_info[ALSPRX2],
> +		.info = &tsl2772_device_info[ALSPRX2],
>  	},
>  };
>  
> -static int tsl2x7x_probe(struct i2c_client *clientp,
> +static int tsl2772_probe(struct i2c_client *clientp,
>  			 const struct i2c_device_id *id)
>  {
>  	struct iio_dev *indio_dev;
> -	struct tsl2X7X_chip *chip;
> +	struct tsl2772_chip *chip;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
> @@ -1656,18 +1657,18 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	i2c_set_clientdata(clientp, indio_dev);
>  
>  	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_CHIPID);
> +				       TSL2772_CMD_REG | TSL2772_CHIPID);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (tsl2x7x_device_id_verif(ret, id->driver_data) <= 0) {
> +	if (tsl2772_device_id_verif(ret, id->driver_data) <= 0) {
>  		dev_info(&chip->client->dev,
>  			 "%s: i2c device found does not match expected id\n",
>  				__func__);
>  		return -EINVAL;
>  	}
>  
> -	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
> +	ret = i2c_smbus_write_byte(clientp, TSL2772_CMD_REG | TSL2772_CNTRL);
>  	if (ret < 0) {
>  		dev_err(&clientp->dev,
>  			"%s: Failed to write to CMD register: %d\n",
> @@ -1678,11 +1679,11 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	mutex_init(&chip->als_mutex);
>  	mutex_init(&chip->prox_mutex);
>  
> -	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_UNKNOWN;
> +	chip->tsl2772_chip_status = TSL2772_CHIP_UNKNOWN;
>  	chip->pdata = dev_get_platdata(&clientp->dev);
>  	chip->id = id->driver_data;
>  	chip->chip_info =
> -		&tsl2x7x_chip_info_tbl[device_channel_config[id->driver_data]];
> +		&tsl2772_chip_info_tbl[device_channel_config[id->driver_data]];
>  
>  	indio_dev->info = chip->chip_info->info;
>  	indio_dev->dev.parent = &clientp->dev;
> @@ -1695,10 +1696,10 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  
>  		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
>  						NULL,
> -						&tsl2x7x_event_handler,
> +						&tsl2772_event_handler,
>  						IRQF_TRIGGER_FALLING |
>  						IRQF_ONESHOT,
> -						"TSL2X7X_event",
> +						"TSL2772_event",
>  						indio_dev);
>  		if (ret) {
>  			dev_err(&clientp->dev,
> @@ -1709,8 +1710,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		indio_dev->channels = chip->chip_info->channel_without_events;
>  	}
>  
> -	tsl2x7x_defaults(chip);
> -	tsl2x7x_chip_on(indio_dev);
> +	tsl2772_defaults(chip);
> +	tsl2772_chip_on(indio_dev);
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> @@ -1722,32 +1723,32 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	return 0;
>  }
>  
> -static int tsl2x7x_suspend(struct device *dev)
> +static int tsl2772_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  
> -	return tsl2x7x_chip_off(indio_dev);
> +	return tsl2772_chip_off(indio_dev);
>  }
>  
> -static int tsl2x7x_resume(struct device *dev)
> +static int tsl2772_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  
> -	return tsl2x7x_chip_on(indio_dev);
> +	return tsl2772_chip_on(indio_dev);
>  }
>  
> -static int tsl2x7x_remove(struct i2c_client *client)
> +static int tsl2772_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
> -	tsl2x7x_chip_off(indio_dev);
> +	tsl2772_chip_off(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  
>  	return 0;
>  }
>  
> -static const struct i2c_device_id tsl2x7x_idtable[] = {
> +static const struct i2c_device_id tsl2772_idtable[] = {
>  	{ "tsl2571", tsl2571 },
>  	{ "tsl2671", tsl2671 },
>  	{ "tmd2671", tmd2671 },
> @@ -1761,9 +1762,9 @@ static const struct i2c_device_id tsl2x7x_idtable[] = {
>  	{}
>  };
>  
> -MODULE_DEVICE_TABLE(i2c, tsl2x7x_idtable);
> +MODULE_DEVICE_TABLE(i2c, tsl2772_idtable);
>  
> -static const struct of_device_id tsl2x7x_of_match[] = {
> +static const struct of_device_id tsl2772_of_match[] = {
>  	{ .compatible = "amstaos,tsl2571" },
>  	{ .compatible = "amstaos,tsl2671" },
>  	{ .compatible = "amstaos,tmd2671" },
> @@ -1776,27 +1777,27 @@ static const struct of_device_id tsl2x7x_of_match[] = {
>  	{ .compatible = "amstaos,tmd2772" },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(of, tsl2x7x_of_match);
> +MODULE_DEVICE_TABLE(of, tsl2772_of_match);
>  
> -static const struct dev_pm_ops tsl2x7x_pm_ops = {
> -	.suspend = tsl2x7x_suspend,
> -	.resume  = tsl2x7x_resume,
> +static const struct dev_pm_ops tsl2772_pm_ops = {
> +	.suspend = tsl2772_suspend,
> +	.resume  = tsl2772_resume,
>  };
>  
> -static struct i2c_driver tsl2x7x_driver = {
> +static struct i2c_driver tsl2772_driver = {
>  	.driver = {
> -		.name = "tsl2x7x",
> -		.of_match_table = tsl2x7x_of_match,
> -		.pm = &tsl2x7x_pm_ops,
> +		.name = "tsl2772",
> +		.of_match_table = tsl2772_of_match,
> +		.pm = &tsl2772_pm_ops,
>  	},
> -	.id_table = tsl2x7x_idtable,
> -	.probe = tsl2x7x_probe,
> -	.remove = tsl2x7x_remove,
> +	.id_table = tsl2772_idtable,
> +	.probe = tsl2772_probe,
> +	.remove = tsl2772_remove,
>  };
>  
> -module_i2c_driver(tsl2x7x_driver);
> +module_i2c_driver(tsl2772_driver);
>  
>  MODULE_AUTHOR("J. August Brenner <Jon.Brenner@ams.com>");
>  MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
> -MODULE_DESCRIPTION("TAOS tsl2x7x ambient and proximity light sensor driver");
> +MODULE_DESCRIPTION("TAOS tsl2772 ambient and proximity light sensor driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2772.h
> similarity index 71%
> rename from drivers/staging/iio/light/tsl2x7x.h
> rename to drivers/staging/iio/light/tsl2772.h
> index f74427f4ab6e..cc14422f85a6 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2772.h
> @@ -1,50 +1,50 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Device driver for monitoring ambient light intensity (lux)
> - * and proximity (prox) within the TAOS TSL2X7X family of devices.
> + * and proximity (prox) within the TAOS TSL2772 family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
>   */
>  
> -#ifndef __TSL2X7X_H
> -#define __TSL2X7X_H
> +#ifndef __TSL2772_H
> +#define __TSL2772_H
>  
> -struct tsl2x7x_lux {
> +struct tsl2772_lux {
>  	unsigned int ch0;
>  	unsigned int ch1;
>  };
>  
>  /* Max number of segments allowable in LUX table */
> -#define TSL2X7X_MAX_LUX_TABLE_SIZE		6
> +#define TSL2772_MAX_LUX_TABLE_SIZE		6
>  /* The default LUX tables all have 3 elements.  */
> -#define TSL2X7X_DEF_LUX_TABLE_SZ		3
> -#define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
> -				     TSL2X7X_DEF_LUX_TABLE_SZ)
> +#define TSL2772_DEF_LUX_TABLE_SZ		3
> +#define TSL2772_DEFAULT_TABLE_BYTES (sizeof(struct tsl2772_lux) * \
> +				     TSL2772_DEF_LUX_TABLE_SZ)
>  
>  /* Proximity diode to use */
> -#define TSL2X7X_DIODE0                  0x01
> -#define TSL2X7X_DIODE1                  0x02
> -#define TSL2X7X_DIODE_BOTH              0x03
> +#define TSL2772_DIODE0                  0x01
> +#define TSL2772_DIODE1                  0x02
> +#define TSL2772_DIODE_BOTH              0x03
>  
>  /* LED Power */
> -#define TSL2X7X_100_mA                  0x00
> -#define TSL2X7X_50_mA                   0x01
> -#define TSL2X7X_25_mA                   0x02
> -#define TSL2X7X_13_mA                   0x03
> +#define TSL2772_100_mA                  0x00
> +#define TSL2772_50_mA                   0x01
> +#define TSL2772_25_mA                   0x02
> +#define TSL2772_13_mA                   0x03
>  
>  /**
> - * struct tsl2x7x_settings - Settings for the tsl2x7x driver
> + * struct tsl2772_settings - Settings for the tsl2772 driver
>   *  @als_time:              Integration time of the ALS channel ADCs in 2.73 ms
>   *                          increments. Total integration time is
>   *                          (256 - als_time) * 2.73.
> - *  @als_gain:              Index into the tsl2x7x_als_gain array.
> + *  @als_gain:              Index into the tsl2772_als_gain array.
>   *  @als_gain_trim:         Default gain trim to account for aperture effects.
>   *  @wait_time:             Time between proximity and ALS cycles in 2.73
>   *                          periods.
>   *  @prox_time:             Integration time of the proximity ADC in 2.73 ms
>   *                          increments. Total integration time is
>   *                          (256 - prx_time) * 2.73.
> - *  @prox_gain:             Index into the tsl2x7x_prx_gain array.
> + *  @prox_gain:             Index into the tsl2772_prx_gain array.
>   *  @als_prox_config:       The value of the ALS / Proximity configuration
>   *                          register.
>   *  @als_cal_target:        Known external ALS reading for calibration.
> @@ -64,7 +64,7 @@ struct tsl2x7x_lux {
>   *                          LED(s) for proximity sensing.
>   *  @prox_power             The amount of power to use for the external LED(s).
>   */
> -struct tsl2x7x_settings {
> +struct tsl2772_settings {
>  	int als_time;
>  	int als_gain;
>  	int als_gain_trim;
> @@ -88,14 +88,14 @@ struct tsl2x7x_settings {
>  };
>  
>  /**
> - * struct tsl2X7X_platform_data - Platform callback, glass and defaults
> + * struct tsl2772_platform_data - Platform callback, glass and defaults
>   * @platform_lux_table:        Device specific glass coefficents
>   * @platform_default_settings: Device specific power on defaults
>   *
>   */
> -struct tsl2X7X_platform_data {
> -	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];
> -	struct tsl2x7x_settings *platform_default_settings;
> +struct tsl2772_platform_data {
> +	struct tsl2772_lux platform_lux_table[TSL2772_MAX_LUX_TABLE_SIZE];
> +	struct tsl2772_settings *platform_default_settings;
>  };
>  
> -#endif /* __TSL2X7X_H */
> +#endif /* __TSL2772_H */

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
