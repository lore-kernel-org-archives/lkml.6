Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3062772-1522001120-2-15265555436846708319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522001118; b=WpLaoreslgQgwsy0NBJAALIJSYA46M9P6cg/O2pIeaBaOpG
    BafTkrpeP928hVSpxTxAiU9B2vqh/FGdzvHyDqEtF5+KSAlKMuVsR69+MOcGcUzQ
    gMCioTt9Wt7H93OvJRvSM9zFMoYPgurQuRpAUMps2ojpClmfj3Iskupw3nowfsdp
    ow3ZZwJB7ScL24QioIKxPWNgukHDLt4blhzG8xLSiw0K6ZkXCWoaWux4f8J0nYML
    dLbXJReGotb4AoHJexv4TJAAySJtA9F3ohWQyN4U65r52Bt5UuiXWk+8BOqQEDFA
    FgDV2RHrNEJIY/nQNRe/YB5BcizdU4gyP0LHj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522001118; bh=h
    kaMHWAMRUYttg3aMz+wq5KLFDgQXpFOyHIaOXqTYAQ=; b=Nk1yMYZtGRntCZy1w
    sf7REO8/bP7Jx8EMwVGt8lMcTbmQS7TZrhjagpPEskuYFQ+D86/sxPjmpARKAhq7
    z0j0ros3eeDotKu2XLmxdBHtUIUzoNI2CDiqjllCQREj2fM1KIkHG0eA+gnH6Jle
    AmtxvGAV4TgBw++J3HxnQxsmVv1uCKdliRALTSKhokwyd5OAh8xQEdm2SXreRkz2
    ULboeb2J2mUKANI/ojb1AvAc8wB6q/2Ni75ch7q2MNJol+Sbm4k7uNBEVbJkjG5O
    Bac31/rKN86XUuuvwMNrDVhd6l+YCQ089GHFL4WHRFbkIn1zYDHSoEk9KNa50R+b
    Vgm4w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522B921852
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 19:04:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 4/4] staging: iio: tsl2x7x: move out of staging
Message-ID: <20180325190455.311a10b8@archlinux>
In-Reply-To: <20180324200555.1403-5-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
 <20180324200555.1403-5-masneyb@onstation.org>
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

On Sat, 24 Mar 2018 16:05:55 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Move the tsl2x7x driver out of staging and into mainline.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Various comments inline.

I'm wondering if we should rename the driver before moving it.
The wild cards bother me as we are very likely to see something not
compatible in this namespace at some point..
There are parts already with an extra digit which some might think
match...
tsl25711 for example.  Interestingly some of the links on the AMS
website link back to the 2571 part and it turns out on the current
data sheet that the distinction is around the supported voltages for
i2c.  Hmm. We should probably have these parts listed in the OF
table as well as we will have people writing DT files based on the
part number they fitted, not the generic part number they can figure
out from the datasheet.

What do you think?  Bit of find and replace would deal with this.
Just pick a representative part and name it all after that.

Jonathan

> ---
> Note: I intentionally ran git format-patch with --no-renames since
> Jonathan likes to see the whole files in the email body for staging
> graduation patches.

Thanks.

> 
> The #include "tsl2x7x.h" was changed to #include
> <linux/platform_data/tsl2x7x.h> in tsl2x7x.c during the rename.
> 
>  drivers/iio/light/Kconfig             |    8 +
>  drivers/iio/light/Makefile            |    1 +
>  drivers/iio/light/tsl2x7x.c           | 1784 +++++++++++++++++++++++++++++++++
>  drivers/staging/iio/Kconfig           |    1 -
>  drivers/staging/iio/Makefile          |    1 -
>  drivers/staging/iio/light/Kconfig     |   14 -
>  drivers/staging/iio/light/Makefile    |    5 -
>  drivers/staging/iio/light/tsl2x7x.c   | 1784 ---------------------------------
>  drivers/staging/iio/light/tsl2x7x.h   |  103 --
>  include/linux/platform_data/tsl2x7x.h |  103 ++
>  10 files changed, 1896 insertions(+), 1908 deletions(-)
>  create mode 100644 drivers/iio/light/tsl2x7x.c
>  delete mode 100644 drivers/staging/iio/light/Kconfig
>  delete mode 100644 drivers/staging/iio/light/Makefile
>  delete mode 100644 drivers/staging/iio/light/tsl2x7x.c
>  delete mode 100644 drivers/staging/iio/light/tsl2x7x.h
>  create mode 100644 include/linux/platform_data/tsl2x7x.h
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 074e50657366..8161e3e1ba1b 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -409,6 +409,14 @@ config TSL2583
>  	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
>  	 Access ALS data via iio, sysfs.
>  
> +config TSL2x7x
> +	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
> +	depends on I2C
> +	help
> +	 Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
> +	 tmd2672, tsl2772, tmd2772 devices.
> +	 Provides iio_events and direct access via sysfs.
> +
>  config TSL4531
>  	tristate "TAOS TSL4531 ambient light sensors"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index f1777036d4f8..a20a3662950b 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
>  obj-$(CONFIG_TCS3414)		+= tcs3414.o
>  obj-$(CONFIG_TCS3472)		+= tcs3472.o
>  obj-$(CONFIG_TSL2583)		+= tsl2583.o
> +obj-$(CONFIG_TSL2x7x)		+= tsl2x7x.o
>  obj-$(CONFIG_TSL4531)		+= tsl4531.o
>  obj-$(CONFIG_US5182D)		+= us5182d.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
> diff --git a/drivers/iio/light/tsl2x7x.c b/drivers/iio/light/tsl2x7x.c
> new file mode 100644
> index 000000000000..fffd23ae5c72
> --- /dev/null
> +++ b/drivers/iio/light/tsl2x7x.c
> @@ -0,0 +1,1784 @@
> +/*
> + * Device driver for monitoring ambient light intensity in (lux)
> + * and proximity detection (prox) within the TAOS TSL2X7X family of devices.
> + *
> + * Copyright (c) 2012, TAOS Corporation.
> + * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/platform_data/tsl2x7x.h>
> +
> +/* Cal defs*/

space before */

> +#define PROX_STAT_CAL			0
> +#define PROX_STAT_SAMP			1
> +#define MAX_SAMPLES_CAL			200
> +
> +/* TSL2X7X Device ID */
> +#define TRITON_ID			0x00
> +#define SWORDFISH_ID			0x30
> +#define HALIBUT_ID			0x20
> +
> +/* Lux calculation constants */
> +#define TSL2X7X_LUX_CALC_OVER_FLOW	65535
> +
> +/* TAOS Register definitions - note:
/*
 * TAOS

> + * depending on device, some of these register are not used and the
> + * register address is benign.
> + */
> +/* 2X7X register offsets */
> +#define TSL2X7X_MAX_CONFIG_REG		16
> +
> +/* Device Registers and Masks */
> +#define TSL2X7X_CNTRL			0x00
> +#define TSL2X7X_ALS_TIME		0X01
> +#define TSL2X7X_PRX_TIME		0x02
> +#define TSL2X7X_WAIT_TIME		0x03
> +#define TSL2X7X_ALS_MINTHRESHLO		0X04
> +#define TSL2X7X_ALS_MINTHRESHHI		0X05
> +#define TSL2X7X_ALS_MAXTHRESHLO		0X06
> +#define TSL2X7X_ALS_MAXTHRESHHI		0X07
> +#define TSL2X7X_PRX_MINTHRESHLO		0X08
> +#define TSL2X7X_PRX_MINTHRESHHI		0X09
> +#define TSL2X7X_PRX_MAXTHRESHLO		0X0A
> +#define TSL2X7X_PRX_MAXTHRESHHI		0X0B
> +#define TSL2X7X_PERSISTENCE		0x0C
> +#define TSL2X7X_PRX_CONFIG		0x0D
> +#define TSL2X7X_PRX_COUNT		0x0E
> +#define TSL2X7X_GAIN			0x0F
> +#define TSL2X7X_NOTUSED			0x10
> +#define TSL2X7X_REVID			0x11
> +#define TSL2X7X_CHIPID			0x12
> +#define TSL2X7X_STATUS			0x13
> +#define TSL2X7X_ALS_CHAN0LO		0x14
> +#define TSL2X7X_ALS_CHAN0HI		0x15
> +#define TSL2X7X_ALS_CHAN1LO		0x16
> +#define TSL2X7X_ALS_CHAN1HI		0x17
> +#define TSL2X7X_PRX_LO			0x18
> +#define TSL2X7X_PRX_HI			0x19
> +
> +/* tsl2X7X cmd reg masks */
> +#define TSL2X7X_CMD_REG			0x80
> +#define TSL2X7X_CMD_SPL_FN		0x60
> +#define TSL2X7X_CMD_REPEAT_PROTO	0x00
> +#define TSL2X7X_CMD_AUTOINC_PROTO	0x20
> +
> +#define TSL2X7X_CMD_PROX_INT_CLR	0X05
> +#define TSL2X7X_CMD_ALS_INT_CLR		0x06
> +#define TSL2X7X_CMD_PROXALS_INT_CLR	0X07
> +
> +/* tsl2X7X cntrl reg masks */
> +#define TSL2X7X_CNTL_ADC_ENBL		0x02
> +#define TSL2X7X_CNTL_PWR_ON		0x01
> +
> +/* tsl2X7X status reg masks */
> +#define TSL2X7X_STA_ADC_VALID		0x01
> +#define TSL2X7X_STA_PRX_VALID		0x02
> +#define TSL2X7X_STA_ADC_PRX_VALID	(TSL2X7X_STA_ADC_VALID | \
> +					 TSL2X7X_STA_PRX_VALID)
> +#define TSL2X7X_STA_ALS_INTR		0x10
> +#define TSL2X7X_STA_PRX_INTR		0x20
> +
> +/* tsl2X7X cntrl reg masks */
> +#define TSL2X7X_CNTL_REG_CLEAR		0x00
> +#define TSL2X7X_CNTL_PROX_INT_ENBL	0X20
> +#define TSL2X7X_CNTL_ALS_INT_ENBL	0X10
> +#define TSL2X7X_CNTL_WAIT_TMR_ENBL	0X08
> +#define TSL2X7X_CNTL_PROX_DET_ENBL	0X04
> +#define TSL2X7X_CNTL_PWRON		0x01
> +#define TSL2X7X_CNTL_ALSPON_ENBL	0x03
> +#define TSL2X7X_CNTL_INTALSPON_ENBL	0x13
> +#define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
> +#define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
> +
> +/*Prox diode to use */
> +#define TSL2X7X_DIODE0			0x01
> +#define TSL2X7X_DIODE1			0x02
> +#define TSL2X7X_DIODE_BOTH		0x03
> +
> +/* LED Power */
> +#define TSL2X7X_100_mA			0x00
> +#define TSL2X7X_50_mA			0x01
> +#define TSL2X7X_25_mA			0x02
> +#define TSL2X7X_13_mA			0x03
> +#define TSL2X7X_MAX_TIMER_CNT		0xFF
> +
> +#define TSL2X7X_MIN_ITIME		3
> +
> +/* TAOS txx2x7x Device family members */
The whole naming convention of this driver always worried me as it seems
far to likely something will hit the name space that isn't compatible..

I wonder if it is worth doing a full rename to tsl2571 or similar and
getting rid of the wild cards before we move it?


> +enum {
> +	tsl2571,
> +	tsl2671,
> +	tmd2671,
> +	tsl2771,
> +	tmd2771,
> +	tsl2572,
> +	tsl2672,
> +	tmd2672,
> +	tsl2772,
> +	tmd2772
> +};
> +
> +enum {
> +	TSL2X7X_CHIP_UNKNOWN = 0,
> +	TSL2X7X_CHIP_WORKING = 1,
> +	TSL2X7X_CHIP_SUSPENDED = 2
> +};
> +
> +/* Per-device data */
> +struct tsl2x7x_als_info {
> +	u16 als_ch0;
> +	u16 als_ch1;
> +	u16 lux;
> +};
> +
> +struct tsl2x7x_chip_info {
> +	int chan_table_elements;
> +	struct iio_chan_spec		channel[4];
> +	const struct iio_info		*info;
> +};
> +
> +struct tsl2X7X_chip {
Need to clean up the mixture in prefixes
between tsl2x7x and tsl2X7X that I'm seeing in here.

> +	kernel_ulong_t id;
> +	struct mutex prox_mutex;
> +	struct mutex als_mutex;
> +	struct i2c_client *client;
> +	u16 prox_data;
> +	struct tsl2x7x_als_info als_cur_info;
> +	struct tsl2x7x_settings settings;
> +	struct tsl2X7X_platform_data *pdata;
> +	int als_time_scale;
> +	int als_saturation;
> +	int tsl2x7x_chip_status;
> +	u8 tsl2x7x_config[TSL2X7X_MAX_CONFIG_REG];
> +	const struct tsl2x7x_chip_info	*chip_info;
> +	const struct iio_info *info;
> +	s64 event_timestamp;
> +	/*
> +	 * This structure is intentionally large to accommodate
> +	 * updates via sysfs.
> +	 * Sized to 9 = max 8 segments + 1 termination segment
> +	 */
> +	struct tsl2x7x_lux tsl2x7x_device_lux[TSL2X7X_MAX_LUX_TABLE_SIZE];
> +};
> +
> +/* Different devices require different coefficents */
> +static const struct tsl2x7x_lux tsl2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +	{ 14461,   611,   1211 },
> +	{ 18540,   352,    623 },
> +	{     0,     0,      0 },
> +};
> +
> +static const struct tsl2x7x_lux tmd2x71_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +	{ 11635,   115,    256 },
> +	{ 15536,    87,    179 },
> +	{     0,     0,      0 },
> +};
> +
> +static const struct tsl2x7x_lux tsl2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +	{ 14013,   466,   917 },
> +	{ 18222,   310,   552 },
> +	{     0,     0,     0 },
> +};
> +
> +static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
> +	{ 13218,   130,   262 },
> +	{ 17592,   92,    169 },
> +	{     0,     0,     0 },
> +};
> +
> +static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
> +	[tsl2571] =	tsl2x71_lux_table,
> +	[tsl2671] =	tsl2x71_lux_table,
> +	[tmd2671] =	tmd2x71_lux_table,
> +	[tsl2771] =	tsl2x71_lux_table,
> +	[tmd2771] =	tmd2x71_lux_table,
> +	[tsl2572] =	tsl2x72_lux_table,
> +	[tsl2672] =	tsl2x72_lux_table,
> +	[tmd2672] =	tmd2x72_lux_table,
> +	[tsl2772] =	tsl2x72_lux_table,
> +	[tmd2772] =	tmd2x72_lux_table,
> +};
> +
> +static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> +	.als_time = 219, /* 101 ms */
> +	.als_gain = 0,
> +	.prx_time = 254, /* 5.4 ms */
> +	.prox_gain = 0,
> +	.wait_time = 245,
> +	.prox_config = 0,
> +	.als_gain_trim = 1000,
> +	.als_cal_target = 150,
> +	.als_persistence = 1,
> +	.als_interrupt_en = false,
> +	.als_thresh_low = 200,
> +	.als_thresh_high = 256,
> +	.prox_persistence = 1,
> +	.prox_interrupt_en = false,
> +	.prox_thres_low  = 0,
> +	.prox_thres_high = 512,
> +	.prox_max_samples_cal = 30,
> +	.prox_pulse_count = 8,
> +	.prox_diode = TSL2X7X_DIODE1,
> +	.prox_power = TSL2X7X_100_mA
> +};
> +
> +static const s16 tsl2x7x_als_gain[] = {
> +	1,
> +	8,
> +	16,
> +	120
> +};
> +
> +static const s16 tsl2x7x_prx_gain[] = {
> +	1,
> +	2,
> +	4,
> +	8
> +};
> +
> +/* Channel variations */
> +enum {
> +	ALS,
> +	PRX,
> +	ALSPRX,
> +	PRX2,
> +	ALSPRX2,
> +};
> +
> +static const u8 device_channel_config[] = {
> +	ALS,
> +	PRX,
> +	PRX,
> +	ALSPRX,
> +	ALSPRX,
> +	ALS,
> +	PRX2,
> +	PRX2,
> +	ALSPRX2,
> +	ALSPRX2
> +};
> +
> +static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
Why does this take a reg?  It seems to be always the same...

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
> +/**
> + * tsl2x7x_get_lux() - Reads and calculates current lux value.
> + * @indio_dev:	pointer to IIO device
> + *
> + * The raw ch0 and ch1 values of the ambient light sensed in the last
> + * integration cycle are read from the device.
> + * Time scale factor array values are adjusted based on the integration time.
> + * The raw values are multiplied by a scale factor, and device gain is obtained
> + * using gain index. Limit checks are done next, then the ratio of a multiple
> + * of ch1 value, to the ch0 value, is calculated. Array tsl2x7x_device_lux[]
> + * is then scanned to find the first ratio value that is just above the ratio
> + * we just calculated. The ch0 and ch1 multiplier constants in the array are
> + * then used along with the time scale factor array values, to calculate the
> + * lux.
> + */
> +static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2x7x_lux *p;
> +	u32 lux, ratio;
> +	u64 lux64;
> +	int ret;
> +
> +	mutex_lock(&chip->als_mutex);
> +
> +	if (chip->tsl2x7x_chip_status != TSL2X7X_CHIP_WORKING) {
> +		/* device is not enabled */
> +		dev_err(&chip->client->dev, "%s: device is not enabled\n",
> +			__func__);
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	/* is data new & valid */
> +	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
> +		dev_err(&chip->client->dev,
> +			"%s: data not valid yet\n", __func__);
> +		ret = chip->als_cur_info.lux; /* return LAST VALUE */
> +		goto out_unlock;
> +	}
> +
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN0LO,
> +					TSL2X7X_ALS_CHAN0HI);
> +	if (ret < 0)
> +		goto out_unlock;
> +	chip->als_cur_info.als_ch0 = ret;
> +
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN1LO,
> +					TSL2X7X_ALS_CHAN1HI);
> +	if (ret < 0)
> +		goto out_unlock;
> +	chip->als_cur_info.als_ch1 = ret;
> +
> +	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
> +	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
> +		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
> +		goto return_max;
> +	}
> +
> +	if (!chip->als_cur_info.als_ch0) {
> +		/* have no data, so return LAST VALUE */
> +		ret = chip->als_cur_info.lux;
> +		goto out_unlock;
> +	}
> +
> +	/* calculate ratio */
> +	ratio = (chip->als_cur_info.als_ch1 << 15) / chip->als_cur_info.als_ch0;
> +
> +	/* convert to unscaled lux using the pointer to the table */
> +	p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux;
> +	while (p->ratio != 0 && p->ratio < ratio)
> +		p++;
> +
> +	if (p->ratio == 0) {
> +		lux = 0;
> +	} else {
> +		lux = DIV_ROUND_UP(chip->als_cur_info.als_ch0 * p->ch0,
> +				   tsl2x7x_als_gain[chip->settings.als_gain]) -
> +		      DIV_ROUND_UP(chip->als_cur_info.als_ch1 * p->ch1,
> +				   tsl2x7x_als_gain[chip->settings.als_gain]);
> +	}
> +
> +	/* adjust for active time scale */
> +	if (chip->als_time_scale == 0)
> +		lux = 0;
> +	else
> +		lux = (lux + (chip->als_time_scale >> 1)) /
> +			chip->als_time_scale;
> +
> +	/* adjust for active gain scale
> +	 * The tsl2x7x_device_lux tables have a factor of 256 built-in.
> +	 * User-specified gain provides a multiplier.
> +	 * Apply user-specified gain before shifting right to retain precision.
> +	 * Use 64 bits to avoid overflow on multiplication.
> +	 * Then go back to 32 bits before division to avoid using div_u64().
> +	 */
> +
> +	lux64 = lux;
> +	lux64 = lux64 * chip->settings.als_gain_trim;
> +	lux64 >>= 8;
> +	lux = lux64;
> +	lux = (lux + 500) / 1000;
> +
> +	if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) /* check for overflow */
> +		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
> +
> +	/* Update the structure with the latest lux. */
> +return_max:
> +	chip->als_cur_info.lux = lux;
> +	ret = lux;
> +
> +out_unlock:
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * tsl2x7x_get_prox() - Reads proximity data registers and updates
> + *                      chip->prox_data.
> + *
> + * @indio_dev:	pointer to IIO device
> + */
> +static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->prox_mutex);
> +
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
> +		goto prox_poll_err;
> +
> +	switch (chip->id) {
> +	case tsl2571:
> +	case tsl2671:
> +	case tmd2671:
> +	case tsl2771:
> +	case tmd2771:
> +		if (!(ret & TSL2X7X_STA_ADC_VALID)) {
> +			ret = -EINVAL;
> +			goto prox_poll_err;
> +		}
> +		break;
> +	case tsl2572:
> +	case tsl2672:
> +	case tmd2672:
> +	case tsl2772:
> +	case tmd2772:
> +		if (!(ret & TSL2X7X_STA_PRX_VALID)) {
> +			ret = -EINVAL;
> +			goto prox_poll_err;
> +		}
> +		break;
> +	}
> +
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_PRX_LO, TSL2X7X_PRX_HI);
> +	if (ret < 0)
> +		goto prox_poll_err;
> +	chip->prox_data = ret;
> +
> +prox_poll_err:
> +	mutex_unlock(&chip->prox_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * tsl2x7x_defaults() - Populates the device nominal operating parameters
> + *                      with those provided by a 'platform' data struct or
> + *                      with prefined defaults.
> + *
> + * @chip:               pointer to device structure.
> + */
> +static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
> +{
> +	/* If Operational settings defined elsewhere.. */
> +	if (chip->pdata && chip->pdata->platform_default_settings)
> +		memcpy(&chip->settings, chip->pdata->platform_default_settings,
> +		       sizeof(tsl2x7x_default_settings));
> +	else
> +		memcpy(&chip->settings, &tsl2x7x_default_settings,
> +		       sizeof(tsl2x7x_default_settings));
> +
> +	/* Load up the proper lux table. */
> +	if (chip->pdata && chip->pdata->platform_lux_table[0].ratio != 0)
> +		memcpy(chip->tsl2x7x_device_lux,
> +		       chip->pdata->platform_lux_table,
> +		       sizeof(chip->pdata->platform_lux_table));
> +	else
> +		memcpy(chip->tsl2x7x_device_lux,
> +		       tsl2x7x_default_lux_table_group[chip->id],
> +		       TSL2X7X_DEFAULT_TABLE_BYTES);
> +}
> +
> +/**
> + * tsl2x7x_als_calibrate() -	Obtain single reading and calculate
> + *                              the als_gain_trim.
> + *
> + * @indio_dev:	pointer to IIO device
> + */
> +static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret, lux_val;
> +
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read from the CNTRL register\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	if ((ret & (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON))
> +			!= (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON)) {
> +		dev_err(&chip->client->dev,
> +			"%s: Device is not powered on and/or ADC is not enabled\n",
> +			__func__);
> +		return -EINVAL;
> +	} else if ((ret & TSL2X7X_STA_ADC_VALID) != TSL2X7X_STA_ADC_VALID) {
> +		dev_err(&chip->client->dev,
> +			"%s: The two ADC channels have not completed an integration cycle\n",
> +			__func__);
> +		return -ENODATA;
> +	}
> +
> +	lux_val = tsl2x7x_get_lux(indio_dev);
> +	if (lux_val < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to get lux\n", __func__);
> +		return lux_val;
> +	}
> +
> +	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
> +			lux_val;
> +	if (ret < 250 || ret > 4000)
> +		return -ERANGE;
> +
> +	chip->settings.als_gain_trim = ret;
> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret, i, als_count, als_time;
> +	u8 *dev_reg, reg_val;
> +
> +	/* Non calculated parameters */
> +	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
> +	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
> +
> +	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHLO] =
> +		(chip->settings.als_thresh_low) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHHI] =
> +		(chip->settings.als_thresh_low >> 8) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHLO] =
> +		(chip->settings.als_thresh_high) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHHI] =
> +		(chip->settings.als_thresh_high >> 8) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] =
> +		(chip->settings.prox_persistence & 0xFF) << 4 |
> +		(chip->settings.als_persistence & 0xFF);
> +
> +	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
> +			chip->settings.prox_pulse_count;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHLO] =
> +			(chip->settings.prox_thres_low) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHHI] =
> +			(chip->settings.prox_thres_low >> 8) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHLO] =
> +			(chip->settings.prox_thres_high) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHHI] =
> +			(chip->settings.prox_thres_high >> 8) & 0xFF;
> +
> +	/* and make sure we're not already on */
> +	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> +		/* if forcing a register update - turn off, then on */
> +		dev_info(&chip->client->dev, "device is already enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	/* determine als integration register */
> +	als_count = (chip->settings.als_time * 100 + 135) / 270;
> +	if (!als_count)
> +		als_count = 1; /* ensure at least one cycle */
> +
> +	/* convert back to time (encompasses overrides) */
> +	als_time = (als_count * 27 + 5) / 10;
> +	chip->tsl2x7x_config[TSL2X7X_ALS_TIME] = 256 - als_count;
> +
> +	/* Set the gain based on tsl2x7x_settings struct */
> +	chip->tsl2x7x_config[TSL2X7X_GAIN] =
> +		(chip->settings.als_gain & 0xFF) |
> +		((chip->settings.prox_gain & 0xFF) << 2) |
> +		(chip->settings.prox_diode << 4) |
> +		(chip->settings.prox_power << 6);
> +
> +	/* set chip struct re scaling and saturation */
> +	chip->als_saturation = als_count * 922; /* 90% of full scale */
> +	chip->als_time_scale = (als_time + 25) / 50;
> +
> +	/*
> +	 * TSL2X7X Specific power-on / adc enable sequence
> +	 * Power on the device 1st.
> +	 */
> +	ret = tsl2x7x_write_control_reg(chip, TSL2X7X_CNTL_PWR_ON);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Use the following shadow copy for our delay before enabling ADC.
> +	 * Write all the registers.
> +	 */
> +	for (i = 0, dev_reg = chip->tsl2x7x_config;
> +			i < TSL2X7X_MAX_CONFIG_REG; i++) {
> +		int reg = TSL2X7X_CMD_REG + i;
> +
> +		ret = i2c_smbus_write_byte_data(chip->client, reg,
> +						*dev_reg++);
> +		if (ret < 0) {
> +			dev_err(&chip->client->dev,
> +				"%s: failed to write to register %x: %d\n",
> +				__func__, reg, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Power-on settling time */
> +	usleep_range(3000, 3500);
> +
> +	reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL |
> +		  TSL2X7X_CNTL_PROX_DET_ENBL;
> +	if (chip->settings.als_interrupt_en)
> +		reg_val |= TSL2X7X_CNTL_ALS_INT_ENBL;
> +	if (chip->settings.prox_interrupt_en)
> +		reg_val |= TSL2X7X_CNTL_PROX_INT_ENBL;
> +
> +	ret = tsl2x7x_write_control_reg(chip, reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +
> +	/* turn device off */
> +	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
> +	return tsl2x7x_write_control_reg(chip, 0x00);
> +}
> +
> +/**
> + * tsl2x7x_invoke_change

This is nearly correct kernel-doc.  Would be nice to make it completely correct.
Wrapping is a bit short as well compared to normal levels.

> + * @indio_dev:	pointer to IIO device
> + *
> + * Obtain and lock both ALS and PROX resources,
> + * determine and save device state (On/Off),
> + * cycle device to implement updated parameter,
> + * put device back into proper state, and unlock
> + * resource.
> + */
> +static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int device_status = chip->tsl2x7x_chip_status;
> +	int ret;
> +
> +	mutex_lock(&chip->als_mutex);
> +	mutex_lock(&chip->prox_mutex);
> +
> +	if (device_status == TSL2X7X_CHIP_WORKING) {
> +		ret = tsl2x7x_chip_off(indio_dev);
> +		if (ret < 0)
> +			goto unlock;
> +	}
> +
> +	ret = tsl2x7x_chip_on(indio_dev);
So we enable even if we weren't previously on?

This is only relevant around racing with resume, (I think) but
still seems a little odd.
> +
> +unlock:
> +	mutex_unlock(&chip->prox_mutex);
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int prox_history[MAX_SAMPLES_CAL + 1];
> +	int i, ret, mean, max, sample_sum;
> +
> +	if (chip->settings.prox_max_samples_cal < 1 ||
> +	    chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL)
> +		return -EINVAL;
> +
> +	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
> +		usleep_range(15000, 17500);
> +		ret = tsl2x7x_get_prox(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		prox_history[i] = chip->prox_data;
> +	}
> +
> +	sample_sum = 0;
> +	max = INT_MIN;
> +	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
> +		sample_sum += prox_history[i];
> +		max = max(max, prox_history[i]);
> +	}
> +	mean = sample_sum / chip->settings.prox_max_samples_cal;
> +
> +	chip->settings.prox_thres_high = (max << 1) - mean;
> +
> +	return tsl2x7x_invoke_change(indio_dev);
> +}
> +
> +static ssize_t
> +in_illuminance0_calibscale_available_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +
> +	switch (chip->id) {
> +	case tsl2571:
> +	case tsl2671:
> +	case tmd2671:
> +	case tsl2771:
> +	case tmd2771:
> +		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
> +}
> +
> +static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
> +
> +static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
> +		".00272 - .696");
> +
> +static ssize_t in_illuminance0_target_input_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", chip->settings.als_cal_target);
> +}
> +
> +static ssize_t in_illuminance0_target_input_store(struct device *dev,
> +						  struct device_attribute *attr,
> +						  const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	unsigned long value;
> +	int ret;
> +
> +	if (kstrtoul(buf, 0, &value))
> +		return -EINVAL;
This feels like it should have full range checking.  Right now we allow
anything that is not 0.  Is this valid?

> +
> +	if (value)
> +		chip->settings.als_cal_target = value;
> +
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t in_illuminance0_calibrate_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	bool value;
> +	int ret;
> +
> +	if (strtobool(buf, &value))
> +		return -EINVAL;
Same argument as for similar case below.  Doesn't make sense
to do anything at all if value is false so check that and return
immediately if it is.

> +
> +	if (value) {
> +		ret = tsl2x7x_als_calibrate(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t in_illuminance0_lux_table_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +	int i = 0;
> +	int offset = 0;
> +
> +	while (i < TSL2X7X_MAX_LUX_TABLE_SIZE) {
> +		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
> +			chip->tsl2x7x_device_lux[i].ratio,
> +			chip->tsl2x7x_device_lux[i].ch0,
> +			chip->tsl2x7x_device_lux[i].ch1);
> +		if (chip->tsl2x7x_device_lux[i].ratio == 0) {
> +			/*
> +			 * We just printed the first "0" entry.
> +			 * Now get rid of the extra "," and break.
> +			 */
> +			offset--;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
> +	return offset;
> +}
> +
> +static ssize_t in_illuminance0_lux_table_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int value[ARRAY_SIZE(chip->tsl2x7x_device_lux) * 3 + 1];
> +	int n, ret;
> +
> +	get_options(buf, ARRAY_SIZE(value), value);
> +
> +	/* We now have an array of ints starting at value[1], and
> +	 * enumerated by value[0].
> +	 * We expect each group of three ints is one table entry,
> +	 * and the last table entry is all 0.
> +	 */
> +	n = value[0];
> +	if ((n % 3) || n < 6 ||
> +	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3))
> +		return -EINVAL;
> +
> +	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0)
> +		return -EINVAL;
> +
> +	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> +		ret = tsl2x7x_chip_off(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Zero out the table */
> +	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));
> +	memcpy(chip->tsl2x7x_device_lux, &value[1], (value[0] * 4));
> +
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t in_proximity0_calibrate_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	bool value;
> +	int ret;
> +
> +	if (strtobool(buf, &value))
> +		return -EINVAL;
> +
> +	if (value) {
> +		ret = tsl2x7x_prox_cal(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = tsl2x7x_invoke_change(indio_dev);
does it make sense to do this if someone writes false to the attribute?
I would check for that and return directly if they do.
(would be very odd)

> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +
> +	if (chan->type == IIO_INTENSITY)
> +		return chip->settings.als_interrupt_en;
> +	else
> +		return chip->settings.prox_interrupt_en;
> +}
> +
> +static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  int val)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type == IIO_INTENSITY)
> +		chip->settings.als_interrupt_en = val ? true : false;
> +	else
> +		chip->settings.prox_interrupt_en = val ? true : false;
> +
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;

return tsl2x7x_invoke_change(indio_dev);

> +
> +	return 0;
> +}
> +
> +static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL, y, z, filter_delay;
> +	u8 time;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (chan->type == IIO_INTENSITY) {
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				chip->settings.als_thresh_high = val;
> +				ret = 0;
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				chip->settings.als_thresh_low = val;
> +				ret = 0;
> +				break;
> +			default:
> +				break;
> +			}
> +		} else {
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				chip->settings.prox_thres_high = val;
> +				ret = 0;
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				chip->settings.prox_thres_low = val;
> +				ret = 0;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		if (chan->type == IIO_INTENSITY)
> +			time = chip->settings.als_time;
> +		else
> +			time = chip->settings.prx_time;
> +
> +		y = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> +		z = y * TSL2X7X_MIN_ITIME;
> +
> +		filter_delay = DIV_ROUND_UP((val * 1000) + val2, z);
> +
> +		if (chan->type == IIO_INTENSITY)
> +			chip->settings.als_persistence = filter_delay;
> +		else
> +			chip->settings.prox_persistence = filter_delay;
> +		ret = 0;
Would actually be fewer lines to default to ret = 0 and set it to
EINVAL in the bad paths.  Can't say I care much though so leave
it as it is if you prefer.

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return tsl2x7x_invoke_change(indio_dev);
> +}
> +
> +static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL, filter_delay, mult;
> +	u8 time;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (chan->type == IIO_INTENSITY) {
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = chip->settings.als_thresh_high;
> +				ret = IIO_VAL_INT;
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				*val = chip->settings.als_thresh_low;
> +				ret = IIO_VAL_INT;
> +				break;
> +			default:
> +				break;
> +			}
> +		} else {
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = chip->settings.prox_thres_high;
> +				ret = IIO_VAL_INT;
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				*val = chip->settings.prox_thres_low;
> +				ret = IIO_VAL_INT;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		if (chan->type == IIO_INTENSITY) {
> +			time = chip->settings.als_time;
> +			mult = chip->settings.als_persistence;
> +		} else {
> +			time = chip->settings.prx_time;
> +			mult = chip->settings.prox_persistence;
> +		}
> +
> +		/* Determine integration time */
> +		*val = (TSL2X7X_MAX_TIMER_CNT - time) + 1;
> +		*val2 = *val * TSL2X7X_MIN_ITIME;
> +		filter_delay = *val2 * mult;
> +		*val = filter_delay / 1000;
> +		*val2 = filter_delay % 1000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			tsl2x7x_get_lux(indio_dev);
> +			*val = chip->als_cur_info.lux;
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			tsl2x7x_get_lux(indio_dev);
> +			if (chan->channel == 0)
> +				*val = chip->als_cur_info.als_ch0;
> +			else
> +				*val = chip->als_cur_info.als_ch1;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_PROXIMITY:
> +			tsl2x7x_get_prox(indio_dev);
> +			*val = chip->prox_data;
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_LIGHT)
> +			*val = tsl2x7x_als_gain[chip->settings.als_gain];
> +		else
> +			*val = tsl2x7x_prx_gain[chip->settings.prox_gain];
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = chip->settings.als_gain_trim;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = (TSL2X7X_MAX_TIMER_CNT - chip->settings.als_time) + 1;
> +		*val2 = ((*val * TSL2X7X_MIN_ITIME) % 1000) / 1000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_INTENSITY) {
> +			switch (val) {
> +			case 1:
> +				chip->settings.als_gain = 0;
> +				break;
> +			case 8:
> +				chip->settings.als_gain = 1;
> +				break;
> +			case 16:
> +				chip->settings.als_gain = 2;
> +				break;
> +			case 120:
> +				switch (chip->id) {
> +				case tsl2572:
> +				case tsl2672:
> +				case tmd2672:
> +				case tsl2772:
> +				case tmd2772:
> +					return -EINVAL;
> +				}
> +				chip->settings.als_gain = 3;
> +				break;
> +			case 128:
> +				switch (chip->id) {
> +				case tsl2571:
> +				case tsl2671:
> +				case tmd2671:
> +				case tsl2771:
> +				case tmd2771:
> +					return -EINVAL;
> +				}
> +				chip->settings.als_gain = 3;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		} else {
> +			switch (val) {
> +			case 1:
> +				chip->settings.prox_gain = 0;
> +				break;
> +			case 2:
> +				chip->settings.prox_gain = 1;
> +				break;
> +			case 4:
> +				chip->settings.prox_gain = 2;
> +				break;
> +			case 8:
> +				chip->settings.prox_gain = 3;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		chip->settings.als_gain_trim = val;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		chip->settings.als_time =
> +			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return tsl2x7x_invoke_change(indio_dev);
> +}
> +
> +static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
> +
> +static DEVICE_ATTR_RW(in_illuminance0_target_input);
> +
> +static DEVICE_ATTR_WO(in_illuminance0_calibrate);
> +
> +static DEVICE_ATTR_WO(in_proximity0_calibrate);
> +
> +static DEVICE_ATTR_RW(in_illuminance0_lux_table);
> +
> +/* Use the default register values to identify the Taos device */
> +static int tsl2x7x_device_id(int *id, int target)
Why is id passed by address?

Also seems missnamed
tsl2x7x_device_id_verif perhaps?

> +{
> +	switch (target) {
> +	case tsl2571:
> +	case tsl2671:
> +	case tsl2771:
> +		return (*id & 0xf0) == TRITON_ID;
> +	case tmd2671:
> +	case tmd2771:
> +		return (*id & 0xf0) == HALIBUT_ID;
> +	case tsl2572:
> +	case tsl2672:
> +	case tmd2672:
> +	case tsl2772:
> +	case tmd2772:
> +		return (*id & 0xf0) == SWORDFISH_ID;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	int ret;
> +
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* What type of interrupt do we need to process */
> +	if (ret & TSL2X7X_STA_PRX_INTR) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> +						    0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +						    timestamp);
> +	}
> +
> +	if (ret & TSL2X7X_STA_ALS_INTR) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +						    0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       timestamp);
> +	}
> +
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0)
> +		return ret;
Even in event of an error it is usually a bad idea to return ret from
an interrupt handler.  Tends to lead to permanent lock up as the
interrupt is left masked.

Normal trick is to just print error messages if you get issues in
an interrupt handler.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> +	&dev_attr_in_illuminance0_calibscale_available.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,
> +	&dev_attr_in_illuminance0_target_input.attr,
> +	&dev_attr_in_illuminance0_calibrate.attr,
> +	&dev_attr_in_illuminance0_lux_table.attr,
> +	NULL
> +};
> +
> +static struct attribute *tsl2x7x_PRX_device_attrs[] = {
> +	&dev_attr_in_proximity0_calibrate.attr,
> +	NULL
> +};
> +
> +static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> +	&dev_attr_in_illuminance0_calibscale_available.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,
> +	&dev_attr_in_illuminance0_target_input.attr,
> +	&dev_attr_in_illuminance0_calibrate.attr,
> +	&dev_attr_in_illuminance0_lux_table.attr,
> +	NULL
> +};
> +
> +static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
> +	&dev_attr_in_proximity0_calibrate.attr,
> +	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> +	&dev_attr_in_illuminance0_calibscale_available.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,
> +	&dev_attr_in_illuminance0_target_input.attr,
> +	&dev_attr_in_illuminance0_calibrate.attr,
> +	&dev_attr_in_illuminance0_lux_table.attr,
> +	&dev_attr_in_proximity0_calibrate.attr,
> +	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
> +	[ALS] = {
> +		.attrs = tsl2x7x_ALS_device_attrs,
> +	},
> +	[PRX] = {
> +		.attrs = tsl2x7x_PRX_device_attrs,
> +	},
> +	[ALSPRX] = {
> +		.attrs = tsl2x7x_ALSPRX_device_attrs,
> +	},
> +	[PRX2] = {
> +		.attrs = tsl2x7x_PRX2_device_attrs,
> +	},
> +	[ALSPRX2] = {
> +		.attrs = tsl2x7x_ALSPRX2_device_attrs,
> +	},
> +};
> +
> +static const struct iio_info tsl2X7X_device_info[] = {
> +	[ALS] = {
> +		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
> +		.read_raw = &tsl2x7x_read_raw,
> +		.write_raw = &tsl2x7x_write_raw,
> +		.read_event_value = &tsl2x7x_read_event_value,
> +		.write_event_value = &tsl2x7x_write_event_value,
> +		.read_event_config = &tsl2x7x_read_interrupt_config,
> +		.write_event_config = &tsl2x7x_write_interrupt_config,
> +	},
> +	[PRX] = {
> +		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
> +		.read_raw = &tsl2x7x_read_raw,
> +		.write_raw = &tsl2x7x_write_raw,
> +		.read_event_value = &tsl2x7x_read_event_value,
> +		.write_event_value = &tsl2x7x_write_event_value,
> +		.read_event_config = &tsl2x7x_read_interrupt_config,
> +		.write_event_config = &tsl2x7x_write_interrupt_config,
> +	},
> +	[ALSPRX] = {
> +		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
> +		.read_raw = &tsl2x7x_read_raw,
> +		.write_raw = &tsl2x7x_write_raw,
> +		.read_event_value = &tsl2x7x_read_event_value,
> +		.write_event_value = &tsl2x7x_write_event_value,
> +		.read_event_config = &tsl2x7x_read_interrupt_config,
> +		.write_event_config = &tsl2x7x_write_interrupt_config,
> +	},
> +	[PRX2] = {
> +		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
> +		.read_raw = &tsl2x7x_read_raw,
> +		.write_raw = &tsl2x7x_write_raw,
> +		.read_event_value = &tsl2x7x_read_event_value,
> +		.write_event_value = &tsl2x7x_write_event_value,
> +		.read_event_config = &tsl2x7x_read_interrupt_config,
> +		.write_event_config = &tsl2x7x_write_interrupt_config,
> +	},
> +	[ALSPRX2] = {
> +		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
> +		.read_raw = &tsl2x7x_read_raw,
> +		.write_raw = &tsl2x7x_write_raw,
> +		.read_event_value = &tsl2x7x_read_event_value,
> +		.write_event_value = &tsl2x7x_write_event_value,
> +		.read_event_config = &tsl2x7x_read_interrupt_config,
> +		.write_event_config = &tsl2x7x_write_interrupt_config,
> +	},
> +};
> +
> +static const struct iio_event_spec tsl2x7x_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
> +	[ALS] = {
> +		.channel = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
As per patch 2 discussion... I'm not sure about this..

> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			},
> +		},
> +	.chan_table_elements = 3,
> +	.info = &tsl2X7X_device_info[ALS],
> +	},
> +	[PRX] = {
> +		.channel = {
> +			{
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			},
> +		},
> +	.chan_table_elements = 1,
> +	.info = &tsl2X7X_device_info[PRX],
> +	},
> +	[ALSPRX] = {
> +		.channel = {
> +			{
> +			.type = IIO_LIGHT,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			}, {
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			},
> +		},
> +	.chan_table_elements = 4,
> +	.info = &tsl2X7X_device_info[ALSPRX],
> +	},
> +	[PRX2] = {
> +		.channel = {
> +			{
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			},
> +		},
> +	.chan_table_elements = 1,
> +	.info = &tsl2X7X_device_info[PRX2],
> +	},
> +	[ALSPRX2] = {
> +		.channel = {
> +			{
> +			.type = IIO_LIGHT,
Indenting isn't ideal, but not much space.  Hmm. can't see a clean
solution so I guess keep it as it is.

> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			}, {
> +			.type = IIO_INTENSITY,
> +			.indexed = 1,
> +			.channel = 1,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +			}, {
> +			.type = IIO_PROXIMITY,
> +			.indexed = 1,
> +			.channel = 0,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),
> +			.event_spec = tsl2x7x_events,
> +			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
> +			},
> +		},
> +	.chan_table_elements = 4,
> +	.info = &tsl2X7X_device_info[ALSPRX2],
> +	},
> +};
> +
> +static int tsl2x7x_probe(struct i2c_client *clientp,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct tsl2X7X_chip *chip;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +	chip->client = clientp;
> +	i2c_set_clientdata(clientp, indio_dev);
> +
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | TSL2X7X_CHIPID);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((!tsl2x7x_device_id(&ret, id->driver_data)) ||
> +	    (tsl2x7x_device_id(&ret, id->driver_data) == -EINVAL)) {
What other errors can occur that we should muddle on with?
I'm not seeing any which means this is the same as 
tsl2x7x_device_id(..) <= 0

> +		dev_info(&chip->client->dev,
> +			 "%s: i2c device found does not match expected id\n",
> +				__func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
> +	if (ret < 0) {
> +		dev_err(&clientp->dev,
> +			"%s: Failed to write to CMD register: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&chip->als_mutex);
> +	mutex_init(&chip->prox_mutex);
> +
> +	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_UNKNOWN;
> +	chip->pdata = dev_get_platdata(&clientp->dev);
> +	chip->id = id->driver_data;
> +	chip->chip_info =
> +		&tsl2x7x_chip_info_tbl[device_channel_config[id->driver_data]];
> +
> +	indio_dev->info = chip->chip_info->info;
> +	indio_dev->dev.parent = &clientp->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = chip->client->name;
> +	indio_dev->channels = chip->chip_info->channel;
> +	indio_dev->num_channels = chip->chip_info->chan_table_elements;
> +
> +	if (clientp->irq) {
> +		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
> +						NULL,
> +						&tsl2x7x_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"TSL2X7X_event",
> +						indio_dev);
> +		if (ret) {
> +			dev_err(&clientp->dev,
> +				"%s: irq request failed\n", __func__);
> +			return ret;
> +		}
So in the no irq case we register all the event sysfs stuff but never
see an event?  That's somewhat nasty and misleading to userspace.
The standard way around this is to pick from two versions of the
chan spec, with and without events.


> +	}
> +
> +	/* Load up the defaults */
> +	tsl2x7x_defaults(chip);
> +	/* Make sure the chip is on */
> +	tsl2x7x_chip_on(indio_dev);
The two comments above both feel pretty obvious.  Not sure they
add any info.  What do you think?
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&clientp->dev,
> +			"%s: iio registration failed\n", __func__);
There is a strong argument that there is no point in putting
func in here as you can get a back trace from dynamic debug anyway
which would include it...  I don't feel strongly about it though
so leave it for now, but beware that others may!

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tsl2x7x_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> +		ret = tsl2x7x_chip_off(indio_dev);
> +		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;

Suspended is set by chip off.

> +	}
> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
> +		ret = tsl2x7x_chip_on(indio_dev);
Hmm. I was trying to work out if there are other paths to it
being suspended than suspend.  There are but I don't think
any of them will cause us to wake up here when we didn't get
into this state in suspend.

> +
> +	return ret;
> +}
> +
> +static int tsl2x7x_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	tsl2x7x_chip_off(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id tsl2x7x_idtable[] = {
> +	{ "tsl2571", tsl2571 },
> +	{ "tsl2671", tsl2671 },
> +	{ "tmd2671", tmd2671 },
> +	{ "tsl2771", tsl2771 },
> +	{ "tmd2771", tmd2771 },
> +	{ "tsl2572", tsl2572 },
> +	{ "tsl2672", tsl2672 },
> +	{ "tmd2672", tmd2672 },
> +	{ "tsl2772", tsl2772 },
> +	{ "tmd2772", tmd2772 },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tsl2x7x_idtable);
> +
> +static const struct of_device_id tsl2x7x_of_match[] = {
> +	{ .compatible = "amstaos,tsl2571" },
> +	{ .compatible = "amstaos,tsl2671" },
> +	{ .compatible = "amstaos,tmd2671" },
> +	{ .compatible = "amstaos,tsl2771" },
> +	{ .compatible = "amstaos,tmd2771" },
> +	{ .compatible = "amstaos,tsl2572" },
> +	{ .compatible = "amstaos,tsl2672" },
> +	{ .compatible = "amstaos,tmd2672" },
> +	{ .compatible = "amstaos,tsl2772" },
> +	{ .compatible = "amstaos,tmd2772" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tsl2x7x_of_match);
> +
> +static const struct dev_pm_ops tsl2x7x_pm_ops = {
> +	.suspend = tsl2x7x_suspend,
> +	.resume  = tsl2x7x_resume,
> +};
> +
> +/* Driver definition */
> +static struct i2c_driver tsl2x7x_driver = {
> +	.driver = {
> +		.name = "tsl2x7x",
> +		.of_match_table = tsl2x7x_of_match,
> +		.pm = &tsl2x7x_pm_ops,
> +	},
> +	.id_table = tsl2x7x_idtable,
> +	.probe = tsl2x7x_probe,
> +	.remove = tsl2x7x_remove,
> +};
> +
> +module_i2c_driver(tsl2x7x_driver);
> +
> +MODULE_AUTHOR("J. August Brenner <Jon.Brenner@ams.com>");
> +MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
> +MODULE_DESCRIPTION("TAOS tsl2x7x ambient and proximity light sensor driver");
> +MODULE_LICENSE("GPL");

... Removed files...

> diff --git a/include/linux/platform_data/tsl2x7x.h b/include/linux/platform_data/tsl2x7x.h
> new file mode 100644
> index 000000000000..d382cdbb976e
> --- /dev/null
> +++ b/include/linux/platform_data/tsl2x7x.h
> @@ -0,0 +1,103 @@
> +/*
> + * Device driver for monitoring ambient light intensity (lux)
> + * and proximity (prox) within the TAOS TSL2X7X family of devices.
> + *
> + * Copyright (c) 2012, TAOS Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.

Worth checking if AMS and Jon are happy with SPDX?  If they are it
would be nice to clear this out now.


> + */
> +
> +#ifndef __TSL2X7X_H
> +#define __TSL2X7X_H
> +
> +struct tsl2x7x_lux {
> +	unsigned int ratio;
> +	unsigned int ch0;
> +	unsigned int ch1;
> +};
> +
> +/* Max number of segments allowable in LUX table */
> +#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
> +/* The default LUX tables all have 3 elements.  */
> +#define TSL2X7X_DEF_LUX_TABLE_SZ		3
> +#define TSL2X7X_DEFAULT_TABLE_BYTES (sizeof(struct tsl2x7x_lux) * \
> +				     TSL2X7X_DEF_LUX_TABLE_SZ)
> +
> +/**
> + * struct tsl2x7x_default_settings - power on defaults unless
> + *                                   overridden by platform data.

Docs don't match against the structure - this one isn't the default
Also, oddly short wrapping well before 80 chars.


> + *  @als_time:              ALS Integration time - multiple of 50mS
> + *  @als_gain:              Index into the ALS gain table.
> + *  @als_gain_trim:         default gain trim to account for
> + *                          aperture effects.

Inconsistent capitalization at the start of descriptions.  I don't
care which one is chosen but should be consistent.

> + *  @wait_time:             Time between PRX and ALS cycles
> + *                          in 2.7 periods
> + *  @prx_time:              5.2ms prox integration time -
> + *                          decrease in 2.7ms periods
> + *  @prx_gain:              Proximity gain index
> + *  @prox_config:           Prox configuration filters.
> + *  @als_cal_target:        Known external ALS reading for
> + *                          calibration.
> + *  @als_persistence:       H/W Filters, Number of 'out of limits'
> + *                          ALS readings.
> + *  @als_interrupt_en:      Enable/Disable ALS interrupts
> + *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
> + *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
> + *  @prox_persistence:      H/W Filters, Number of 'out of limits'
> + *                          proximity readings.
> + *  @prox_interrupt_en:     Enable/Disable proximity interrupts
> + *  @prox_thres_low:        Low threshold proximity detection.
> + *  @prox_thres_high:       High threshold proximity detection
> + *  @prox_pulse_count:      Number if proximity emitter pulses
> + *  @prox_max_samples_cal:  Used for prox cal.
> + */
> +struct tsl2x7x_settings {
> +	int als_time;
> +	int als_gain;
> +	int als_gain_trim;
> +	int wait_time;
> +	int prx_time;
> +	int prox_gain;
> +	int prox_config;
> +	int als_cal_target;
> +	u8 als_persistence;
> +	bool als_interrupt_en;
> +	int als_thresh_low;
> +	int als_thresh_high;
> +	u8 prox_persistence;
> +	bool prox_interrupt_en;
> +	int prox_thres_low;
> +	int prox_thres_high;
> +	int prox_pulse_count;
> +	int prox_max_samples_cal;

Next few aren't in the docs and should be.

> +	int prox_diode;
> +	int prox_power;
> +};
> +
> +/**
> + * struct tsl2X7X_platform_data - Platform callback, glass and defaults
> + * @platform_power:            Suspend/resume platform callback
> + * @power_on:                  Power on callback
> + * @power_off:                 Power off callback

These seem to have gotten left behind (oops I missed the docs in the earlier
patch when reviewing).

> + * @platform_lux_table:        Device specific glass coefficents
> + * @platform_default_settings: Device specific power on defaults
> + *
> + */
> +struct tsl2X7X_platform_data {
> +	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];
> +	struct tsl2x7x_settings *platform_default_settings;
> +};
> +
> +#endif /* __TSL2X7X_H */

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
