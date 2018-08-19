Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23719C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 21:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539120C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 21:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYBbJi2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539120C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHTBDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 21:03:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36791 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeHTBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 21:03:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so9465662lfa.3;
        Sun, 19 Aug 2018 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zEdHeG/sgY49446rbpV5XqBHVQLbybjDzxeZn9/ebiw=;
        b=UYBbJi2CP6HbcdqJYrFaFnToVkvYOCYok+rsoE4G5VapLpH64SI1VTkwUpM/X4QXLj
         a6iQqEMAX/xPkfSJSJhLJF8tDcjmH9hIbG3DMfyE9OsMejR3pF99D1Z0QMiZ1iBgeymT
         +fbwdNw2VsaLomxZBXSU0JINQWGTRq2mqSFYvDmm9eSpW3NYyENNctFW2E2Lscy5VQCD
         daEkHfstXVAQX9wB6veB3KscKVCvaBbt5UuscP5xHP7RgDPRx7Rl+U5FRy4BljyzNKJ0
         rlpjblEgnmwjuPu3dmKdSLTDWMrfNlzWw+bYSB392Y2NwbwbH/K9vnPJZ2JZoALA0gF5
         6a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEdHeG/sgY49446rbpV5XqBHVQLbybjDzxeZn9/ebiw=;
        b=cF4QEGQJm84wEniwDPLYuhFmCyLz1YX1Oyi+NJzK9aB6YIq1x4P0xpRPA8G7t+aPF9
         cbQTAaEs4kKSyb0chv6PM45zlavzc58QlWhzkwhaVUeYtQtbT4+zn3CWZ/MogcObqTce
         kTjvenBrd0H8nCyX0EICQIM74cxD5PtTgmFfrQ9pumBMJQ/fDvesfTkzcjQ4wu9ZHyhE
         fNKF1+LWGRRV5JUwTkRQicICh+JKRdIMCT2XHTN5OHqMe8JC9nN+K8yefBtehci97ImF
         D7HGfDUIKvc2/R1HzTXbPkds9IpUdo/3CGKBjz9vcIMpDNW7I6PtqcfRR63rsa+H8ax5
         RAtg==
X-Gm-Message-State: AOUpUlEwRn+LipP0a7aZ9QUwGGme7NhLFdVyyfFDT4XW1KQ9sBAelSk9
        s4mfPWVRms0zKrXyS8yTM+Q=
X-Google-Smtp-Source: AA+uWPxDfGgGbBpAk6x2we+s1zX8JuPlzz5Rb/LtO287TwbLUdps5Bkau4adtas7856ZQcmWFKL0bw==
X-Received: by 2002:a19:4f58:: with SMTP id a24-v6mr26623219lfk.140.1534715411890;
        Sun, 19 Aug 2018 14:50:11 -0700 (PDT)
Received: from gmail.com (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id h9-v6sm1469678lfc.47.2018.08.19.14.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 14:50:10 -0700 (PDT)
Date:   Sun, 19 Aug 2018 23:50:33 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v6 1/2] iio: light: Add support for vishay vcnl4035
Message-ID: <20180819215033.GD5217@gmail.com>
References: <20180807102704.1652656-1-pn@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20180807102704.1652656-1-pn@denx.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 07, 2018 at 12:27:03PM +0200, Parthiban Nallathambi wrote:
> Add support for VCNL4035, which is capable of Ambient light
> sensing (ALS) and proximity function. This patch adds support
> only for ALS function
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>=20
> Changelog since v1:
>=20
> 1. Fixed 0-day warning on le16_to_cpu usage
> 2. Persistence value is directly mapped to datasheet's value to
> avoid confusions of usage from sysfs
>=20
> Changelog in v3:
> - Usage of lock is not needed, removed mutex locking
> - ALS threshold and persistence configuration available
> as events and threshold events are notified to userspace
> - Usage of devm_ is re-ordered and exit handling updated
> - Complexity in timestamp calculation is removed and used
> iio_get_time_ns
>=20
> Changelog in v4:
> - New white light index is introduced for getting data from
> white spectrum
> - PM enable/disable is called from read_raw accordingly
> - Probe exit handling re-ordered
>=20
> Changelog in v5:
> - White spectrum is mesaured as "_CLEAR" intesity, so removed
> white spectrum modifier
> - Header re-ordering
> - Trigger init and de-init into separate function
> - Indentation correct and usage of dev_err in place of pr_err
>=20
> Changelog in v6:
> - Usage of devm_ for trigger probing and cleanups
> - pm_runtime re-order and exit patch corrections
> - IIO_INTENSITY to IIO_LIGHT, lux/steps are fixed at IT cycle
> lux can be calculated based on IT sensitivity
> - _CLEAR to _BOTH although measurement is only WHITE spectrum
> for traditional reasons
> ---

As Jonathan already pointed out, the changelog should go here.
A tip is to use notes (see `man git-notes`) to add a changelog and then
generate the patches with `git format-patch --notes <SHA>`.

I find it really neat.

>  drivers/iio/light/Kconfig    |  12 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/vcnl4035.c | 686 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 699 insertions(+)
>  create mode 100644 drivers/iio/light/vcnl4035.c
>=20
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index c7ef8d1862d6..b7069a4c28a2 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -447,6 +447,18 @@ config VCNL4000
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called vcnl4000.
> =20
> +config VCNL4035
> +	tristate "VCNL4035 combined ALS and proximity sensor"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	 Say Y here if you want to build a driver for the Vishay VCNL4035,
> +	 combined ambient light (ALS) and proximity sensor. Currently only ALS
> +	 function is available.
> +
> +	 To compile this driver as a module, choose M here: the
> +	 module will be called vcnl4035.
> +
>  config VEML6070
>  	tristate "VEML6070 UV A light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 80943af5d627..dce98511a59b 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_TSL2772)		+=3D tsl2772.o
>  obj-$(CONFIG_TSL4531)		+=3D tsl4531.o
>  obj-$(CONFIG_US5182D)		+=3D us5182d.o
>  obj-$(CONFIG_VCNL4000)		+=3D vcnl4000.o
> +obj-$(CONFIG_VCNL4035)		+=3D vcnl4035.o
>  obj-$(CONFIG_VEML6070)		+=3D veml6070.o
>  obj-$(CONFIG_VL6180)		+=3D vl6180.o
>  obj-$(CONFIG_ZOPT2201)		+=3D zopt2201.o
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> new file mode 100644
> index 000000000000..e9f471d93a15
> --- /dev/null
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -0,0 +1,686 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VCNL4035 Ambient Light and Proximity Sensor - 7-bit I2C slave address=
 0x60
> + *
> + * Copyright (c) 2018, DENX Software Engineering GmbH
> + * Author: Parthiban Nallathambi <pn@denx.de>
> + *
> + *
> + * TODO: Proximity
> + */
> +#include <linux/bitops.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define VCNL4035_DRV_NAME	"vcnl4035"
> +#define VCNL4035_IRQ_NAME	"vcnl4035_event"
> +#define VCNL4035_REGMAP_NAME	"vcnl4035_regmap"
> +
> +/* Device registers */
> +#define VCNL4035_ALS_CONF	0x00
> +#define VCNL4035_ALS_THDH	0x01
> +#define VCNL4035_ALS_THDL	0x02
> +#define VCNL4035_ALS_DATA	0x0B
> +#define VCNL4035_WHITE_DATA	0x0C
> +#define VCNL4035_INT_FLAG	0x0D
> +#define VCNL4035_DEV_ID		0x0E
> +
> +/* Register masks */
> +#define VCNL4035_MODE_ALS_MASK		BIT(0)
> +#define VCNL4035_MODE_ALS_WHITE_CHAN	BIT(8)
> +#define VCNL4035_MODE_ALS_INT_MASK	BIT(1)
> +#define VCNL4035_ALS_IT_MASK		GENMASK(7, 5)
> +#define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
> +#define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
> +#define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
> +
> +/* Default values */
> +#define VCNL4035_MODE_ALS_ENABLE	BIT(0)
> +#define VCNL4035_MODE_ALS_DISABLE	0x00
> +#define VCNL4035_MODE_ALS_INT_ENABLE	BIT(1)
> +#define VCNL4035_MODE_ALS_INT_DISABLE	0
> +#define VCNL4035_DEV_ID_VAL		0x80
> +#define VCNL4035_ALS_IT_DEFAULT		0x01
> +#define VCNL4035_ALS_PERS_DEFAULT	0x00
> +#define VCNL4035_ALS_THDH_DEFAULT	5000
> +#define VCNL4035_ALS_THDL_DEFAULT	100
> +#define VCNL4035_SLEEP_DELAY_MS		2000
> +
> +struct vcnl4035_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	unsigned int als_it_val;
> +	unsigned int als_persistence:4;
> +	unsigned int als_thresh_low;
> +	unsigned int als_thresh_high;
> +	struct iio_trigger *drdy_trigger0;
> +};
> +
> +static inline bool vcnl4035_is_triggered(struct vcnl4035_data *data)
> +{
> +	int ret;
> +	int reg;
> +
> +	ret =3D regmap_read(data->regmap, VCNL4035_INT_FLAG, &reg);
> +	if (ret < 0)
> +		return false;
> +
> +	return !!(reg &
> +		(VCNL4035_INT_ALS_IF_H_MASK | VCNL4035_INT_ALS_IF_L_MASK));
> +}
> +
> +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +
> +	if (vcnl4035_is_triggered(data)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +							0,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_EITHER),
> +				iio_get_time_ns(indio_dev));
> +		iio_trigger_poll_chained(data->drdy_trigger0);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +/* Triggered buffer */
> +static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)];
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Trigger consumer can't read from sensor.\n");
> +		goto fail_read;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					iio_get_time_ns(indio_dev));
> +
> +fail_read:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vcnl4035_als_drdy_set_state(struct iio_trigger *trigger,
> +					bool enable_drdy)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trigger);
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +	int val =3D enable_drdy ? VCNL4035_MODE_ALS_INT_ENABLE :
> +					VCNL4035_MODE_ALS_INT_DISABLE;
> +
> +	return regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +				 VCNL4035_MODE_ALS_INT_MASK,
> +				 val);
> +}
> +
> +static const struct iio_trigger_ops vcnl4035_trigger_ops =3D {
> +	.validate_device =3D iio_trigger_validate_own_device,
> +	.set_trigger_state =3D vcnl4035_als_drdy_set_state,
> +};
> +
> +static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, boo=
l on)
> +{
> +	int ret;
> +	struct device *dev =3D &data->client->dev;
> +
> +	if (on) {
> +		ret =3D pm_runtime_get_sync(dev);
> +		if (ret < 0)
> +			pm_runtime_put_noidle(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret =3D pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + *	Device IT	INT Time (ms)	Scale (lux/step)
> + *	000		50		0.064
> + *	001		100		0.032
> + *	010		200		0.016
> + *	100		400		0.008
> + *	101 - 111	800		0.004
> + * Values are proportional, so ALS INT is selected for input due to
> + * simplicity reason. Integration time value and scaling is
> + * calculated based on device INT value
> + *
> + * Raw value needs to be scaled using ALS steps
> + */
> +static int vcnl4035_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +	int raw_data;
> +	unsigned int reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D vcnl4035_set_pm_runtime_state(data, true);
> +		if  (ret < 0)
> +			return ret;
> +
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (!ret) {
> +			if (chan->channel)
> +				reg =3D VCNL4035_ALS_DATA;
> +			else
> +				reg =3D VCNL4035_WHITE_DATA;
> +			ret =3D regmap_read(data->regmap, reg, &raw_data);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (!ret) {
> +				*val =3D raw_data;
> +				ret =3D IIO_VAL_INT;
> +			}
> +		}
> +		vcnl4035_set_pm_runtime_state(data, false);
> +		return ret;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val =3D 50;
> +		if (data->als_it_val)
> +			*val =3D data->als_it_val * 100;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 64;
> +		if (!data->als_it_val)
> +			*val2 =3D 1000;
> +		else
> +			*val2 =3D data->als_it_val * 2 * 1000;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl4035_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	int ret;
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:

Should we check that val2 is 0?

> +		if (val <=3D 0 || val > 800)
> +			return -EINVAL;
> +
> +		ret =3D vcnl4035_set_pm_runtime_state(data, true);
> +		if  (ret < 0)
> +			return ret;
> +
> +		ret =3D regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +					 VCNL4035_ALS_IT_MASK,
> +					 val / 100);
> +		if (!ret)
> +			data->als_it_val =3D val / 100;
> +
> +		vcnl4035_set_pm_runtime_state(data, false);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/* No direct ABI for persistence and threshold, so eventing */
> +static int vcnl4035_read_thresh(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info,
> +		int *val, int *val2)
> +{
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val =3D data->als_thresh_high;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val =3D data->als_thresh_low;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		*val =3D data->als_persistence;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +}
> +
> +static int vcnl4035_write_thresh(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info, int val,
> +		int val2)
> +{
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +

Should we check that val2 is 0?

> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		/* 16 bit threshold range 0 - 65535 */
> +		if (val < 0 || val > 65535)
> +			return -EINVAL;
> +		if (dir =3D=3D IIO_EV_DIR_RISING) {
> +			if (val < data->als_thresh_low)
> +				return -EINVAL;
> +			ret =3D regmap_write(data->regmap, VCNL4035_ALS_THDH,
> +					   val);
> +			if (!ret)
> +				data->als_thresh_high =3D val;
> +		} else {
> +			if (val > data->als_thresh_high)
> +				return -EINVAL;
> +			ret =3D regmap_write(data->regmap, VCNL4035_ALS_THDL,
> +					   val);
> +			if (!ret)
> +				data->als_thresh_low =3D val;
> +		}
> +		return ret;
> +	case IIO_EV_INFO_PERIOD:
> +		/* allow only 1 2 4 8 as persistence value */
> +		if (val < 0 || val > 8 || __sw_hweight8(val) !=3D 1)
> +			return -EINVAL;
> +		ret =3D regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +					 VCNL4035_ALS_PERS_MASK, val);
> +		if (!ret)
> +			data->als_persistence =3D val;
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("50 100 200 400 800");
> +
> +static struct attribute *vcnl4035_attributes[] =3D {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group vcnl4035_attribute_group =3D {
> +	.attrs =3D vcnl4035_attributes,
> +};
> +
> +static const struct iio_info vcnl4035_info =3D {
> +	.read_raw		=3D vcnl4035_read_raw,
> +	.write_raw		=3D vcnl4035_write_raw,
> +	.read_event_value	=3D vcnl4035_read_thresh,
> +	.write_event_value	=3D vcnl4035_write_thresh,
> +	.attrs			=3D &vcnl4035_attribute_group,
> +};
> +
> +static const struct iio_event_spec vcnl4035_event_spec[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
> +enum vcnl4035_scan_index_order {
> +	VCNL4035_CHAN_INDEX_LIGHT,
> +	VCNL4035_CHAN_INDEX_WHITE_LED,
> +};
> +
> +static const unsigned long vcnl4035_available_scan_masks[] =3D {
> +	BIT(VCNL4035_CHAN_INDEX_LIGHT),
> +	BIT(VCNL4035_CHAN_INDEX_WHITE_LED),
> +	0
> +};
> +
> +static const struct iio_chan_spec vcnl4035_channels[] =3D {
> +	{
> +		.type =3D IIO_LIGHT,
> +		.channel =3D 0,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec =3D vcnl4035_event_spec,
> +		.num_event_specs =3D ARRAY_SIZE(vcnl4035_event_spec),
> +		.scan_index =3D VCNL4035_CHAN_INDEX_LIGHT,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 16,
> +			.storagebits =3D 16,
> +			.endianness =3D IIO_LE,
> +		},
> +	},
> +	{
> +		.type =3D IIO_LIGHT,
> +		.channel =3D 1,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_LIGHT_BOTH,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.scan_index =3D VCNL4035_CHAN_INDEX_WHITE_LED,
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 16,
> +			.storagebits =3D 16,
> +			.endianness =3D IIO_LE,
> +		},
> +	},
> +};
> +
> +static int vcnl4035_set_als_power_state(struct vcnl4035_data *data, u8 s=
tatus)
> +{
> +	return regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +					VCNL4035_MODE_ALS_MASK,
> +					status);
> +}
> +
> +static int vcnl4035_init(struct vcnl4035_data *data)
> +{
> +	int ret;
> +	int id;
> +
> +	ret =3D regmap_read(data->regmap, VCNL4035_DEV_ID, &id);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to read DEV_ID register\n");
> +		return ret;
> +	}
> +
> +	if (id !=3D VCNL4035_DEV_ID_VAL) {
> +		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
> +			id, VCNL4035_DEV_ID_VAL);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* ALS white channel enable */
> +	ret =3D regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +				 VCNL4035_MODE_ALS_WHITE_CHAN,
> +				 1);
> +	if (ret) {
> +		dev_err(&data->client->dev, "set white channel enable %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* set default integration time - 100 ms for ALS */
> +	ret =3D regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +				 VCNL4035_ALS_IT_MASK,
> +				 VCNL4035_ALS_IT_DEFAULT);
> +	if (ret) {
> +		dev_err(&data->client->dev, "set default ALS IT returned %d\n",
> +			ret);
> +		return ret;
> +	}
> +	data->als_it_val =3D VCNL4035_ALS_IT_DEFAULT;
> +
> +	/* set default persistence time - 1 for ALS */
> +	ret =3D regmap_update_bits(data->regmap, VCNL4035_ALS_CONF,
> +				 VCNL4035_ALS_PERS_MASK,
> +				 VCNL4035_ALS_PERS_DEFAULT);
> +	if (ret) {
> +		dev_err(&data->client->dev, "set default PERS returned %d\n",
> +			ret);
> +		return ret;
> +	}
> +	data->als_persistence =3D VCNL4035_ALS_PERS_DEFAULT;
> +
> +	/* set default HIGH threshold for ALS */
> +	ret =3D regmap_write(data->regmap, VCNL4035_ALS_THDH,
> +				VCNL4035_ALS_THDH_DEFAULT);
> +	if (ret) {
> +		dev_err(&data->client->dev, "set default THDH returned %d\n",
> +			ret);
> +		return ret;
> +	}
> +	data->als_thresh_high =3D VCNL4035_ALS_THDH_DEFAULT;
> +
> +	/* set default LOW threshold for ALS */
> +	ret =3D regmap_write(data->regmap, VCNL4035_ALS_THDL,
> +				VCNL4035_ALS_THDL_DEFAULT);
> +	if (ret) {
> +		dev_err(&data->client->dev, "set default THDL returned %d\n",
> +			ret);
> +		return ret;
> +	}
> +	data->als_thresh_low =3D VCNL4035_ALS_THDL_DEFAULT;
> +
> +	return 0;
> +}
> +
> +static bool vcnl4035_is_volatile_reg(struct device *dev, unsigned int re=
g)
> +{
> +	switch (reg) {
> +	case VCNL4035_ALS_CONF:
> +	case VCNL4035_DEV_ID:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config vcnl4035_regmap_config =3D {
> +	.name		=3D VCNL4035_REGMAP_NAME,
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 16,
> +	.max_register	=3D VCNL4035_DEV_ID,
> +	.cache_type	=3D REGCACHE_RBTREE,
> +	.volatile_reg	=3D vcnl4035_is_volatile_reg,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +
> +	data->drdy_trigger0 =3D devm_iio_trigger_alloc(
> +			indio_dev->dev.parent,
> +			"%s-dev%d", indio_dev->name, indio_dev->id);
> +	if (!data->drdy_trigger0)
> +		return -ENOMEM;
> +
> +	data->drdy_trigger0->dev.parent =3D indio_dev->dev.parent;
> +	data->drdy_trigger0->ops =3D &vcnl4035_trigger_ops;
> +	iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> +	ret =3D devm_iio_trigger_register(indio_dev->dev.parent,
> +					data->drdy_trigger0);
> +	if (ret) {
> +		dev_err(&data->client->dev, "iio trigger register failed\n");
> +		return ret;
> +	}
> +
> +	/* Trigger setup */
> +	ret =3D devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_de=
v,
> +					NULL, vcnl4035_trigger_consumer_handler,
> +					NULL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	/* IRQ to trigger mapping */
> +	ret =3D devm_request_threaded_irq(&data->client->dev, data->client->irq,
> +			NULL, vcnl4035_drdy_irq_thread,
> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +			VCNL4035_IRQ_NAME, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "request irq %d for trigger0 failed\n",
> +				data->client->irq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vcnl4035_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct vcnl4035_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &vcnl4035_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "regmap_init failed!\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	data =3D iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client =3D client;
> +	data->regmap =3D regmap;
> +
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->info =3D &vcnl4035_info;
> +	indio_dev->name =3D VCNL4035_DRV_NAME;
> +	indio_dev->channels =3D vcnl4035_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(vcnl4035_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D vcnl4035_init(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "vcnl4035 chip init failed\n");
> +		return ret;
> +	}
> +
> +	if (client->irq > 0) {
> +		ret =3D vcnl4035_probe_trigger(indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "vcnl4035 unable init trigger\n");
> +			goto fail_poweroff;
> +		}
> +	}
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret)
> +		goto fail_poweroff;
> +
> +	ret =3D pm_runtime_set_active(&client->dev);
> +	if (ret < 0)
> +		goto fail_unregister;
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4035_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
> +	return 0;
> +
> +fail_unregister:
> +	iio_device_unregister(indio_dev);
> +fail_poweroff:
> +	vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_DISABLE);
> +	return ret;
> +}
> +
> +static int vcnl4035_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +
> +	return vcnl4035_set_als_power_state(iio_priv(indio_dev),
> +					VCNL4035_MODE_ALS_DISABLE);
> +}
> +
> +#ifdef CONFIG_PM
> +static int __maybe_unused vcnl4035_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_DISABLE);
> +	regcache_mark_dirty(data->regmap);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused vcnl4035_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	struct vcnl4035_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	regcache_sync(data->regmap);
> +	ret =3D vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* wait for 1 ALS integration cycle */
> +	msleep(data->als_it_val * 100);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops vcnl4035_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(vcnl4035_runtime_suspend,
> +			   vcnl4035_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id vcnl4035_of_match[] =3D {
> +	{ .compatible =3D "vishay,vcnl4035", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, vcnl4035_of_match);
> +
> +static struct i2c_driver vcnl4035_driver =3D {
> +	.driver =3D {
> +		.name   =3D VCNL4035_DRV_NAME,
> +		.pm	=3D &vcnl4035_pm_ops,
> +		.of_match_table =3D of_match_ptr(vcnl4035_of_match),

Please correct me if I'm wrong here.

Use of_match_ptr() and not provide an ACPI match table will not make
this driver work on ACPI systems.

The reason is that the ACPI match function will fall back on
of_match_table if no acpi_match_table is provided, and the=20
of_match_ptr() macro will simple evaluate to NULL if not CONFIG_OF
is set.

In other words, I think we should change this to just
		.of_match_table =3D &vcnl4035_of_match,

> +	},
> +	.probe  =3D vcnl4035_probe,
> +	.remove	=3D vcnl4035_remove,
> +};
> +
> +module_i2c_driver(vcnl4035_driver);
> +
> +MODULE_AUTHOR("Parthiban Nallathambi <pn@denx.de>");
> +MODULE_DESCRIPTION("VCNL4035 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.14.4
>=20

Best regards
Marcus Folkesson

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt55iIACgkQiIBOb1ld
UjJUdg//VAzwJ8CbWN2QOUCcLjOWE10hmk8mjOtiiSdbjun8cBajXkp4Cw4meQ+Y
aaKkQXoxo6FE9EZATrxpI4jReu3C/I3EE3OlcVc/mh3lo7A8MfWz0FkktM5JIyE+
UWhIibNwHQNxKfvyB0NBDxZtCmW87FuGbyFzdAVquRQE9l4T77gFa+fuTlrcitEN
7BjUamDzYqW0FVGby4XXWf5g9rIRaBR1apTyqfvVu56ht1vZwmYajkVw0spxuo4X
ytQ1uRU2nLx/rHuszvkGQEa9J2p4t3o52VWiHjc3ZG1Castvd/Utoy9ITRo85n5k
1KNO/pCuJd3w9ZCWE0ekWSmNurRJcD0O6YpkWrx/paf08Y1BiIpZ8KdgKNFkjHt3
EbVLx/b6K4r5EfUzenXXuDfrmYty3VPMFKjtJFtWaI5s85w6n7D6K1flaxbSeMGV
A2yCAjK7AktVTxExDYcyMF6CtmwC83tommkHfh9nTVtHtR0GlzYTYbOCDbm5nx0o
gz/Lz5mSSWFNi642xMngwcRGE+ZjrbrqyEZu/4SuNfo2msAxux78FIcsn9vjtwvu
lt95Det7Vx+eGwAEmlKenikQWSwJOkShhnp6w5q0zT3S9s0Wbm81tBdmT1GXBcKw
o5wpLHgCYIu8iHeD9aexrXgQoWo3rI11FU5LpHjT8qJft+1Gw3w=
=FvAn
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
