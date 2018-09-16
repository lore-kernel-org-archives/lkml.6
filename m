Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A9ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482002087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482002087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeIQB0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47058 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeIQB0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7A3E027DAE6
Received: by earth.universe (Postfix, from userid 1000)
        id C8F9C3C0C51; Sun, 16 Sep 2018 15:48:36 +0200 (CEST)
Date:   Sun, 16 Sep 2018 15:48:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Message-ID: <20180916134836.73lggsydppdhhrpf@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-2-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fynnm6azsqtphcbk"
Content-Disposition: inline
In-Reply-To: <20180614151435.6471-2-ctatlor97@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fynnm6azsqtphcbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

First of all thanks for the patch and big sorry for the long delay
in reviewing this. I did not find enough time to do it properly
until now :(

On Thu, Jun 14, 2018 at 04:14:15PM +0100, Craig Tatlor wrote:
> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then amends the coulomb counter to that to increase the accuracy
> of the estimated capacity.
>=20
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>=20
> * Changes from v5:                                                       =
                                                                           =
                                                                =20
>   Uses select for REGMAP_SPMI.                                           =
                                                                           =
                                                                =20
>                                                                          =
                                                                           =
                                                                =20
> * Changes from v4:                                                       =
                                                                           =
                                                                =20
>   Cleaned up percentage interpolation function,                          =
                                                                           =
                                                                =20
>   uses new fixp interpolation helper,                                    =
                                                                           =
                                                                =20
>   added some more error cases,                                           =
                                                                           =
                                                                =20
>   uses devm_power_supply_register(),                                     =
                                                                           =
                                                                =20
>   uses a DIV_ROUND_CLOSEST for division and                              =
                                                                           =
                                                                =20
>   uses micro(volts / amp hours) instead of                               =
                                                                           =
                                                                =20
>   milli (volts / amp hours). =20
>=20
>  drivers/power/supply/Kconfig    |   9 +
>  drivers/power/supply/Makefile   |   1 +
>  drivers/power/supply/qcom_bms.c | 487 ++++++++++++++++++++++++++++++++
>  3 files changed, 497 insertions(+)
>  create mode 100644 drivers/power/supply/qcom_bms.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426842f4..75f2f375f992 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -82,6 +82,15 @@ config BATTERY_ACT8945A
>  	  Say Y here to enable support for power supply provided by
>  	  Active-semi ActivePath ACT8945A charger.
> =20
> +config BATTERY_BMS
> +	tristate "Qualcomm Battery Monitoring System driver"
> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	depends on OF
> +	select REGMAP_SPMI
> +	help
> +	  Say Y to include support for the Battery Monitoring hardware
> +	  found in some Qualcomm PM series PMICs.
> +
>  config BATTERY_CPCAP
>  	tristate "Motorola CPCAP PMIC battery driver"
>  	depends on MFD_CPCAP && IIO
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index e83aa843bcc6..04204174b047 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_BATTERY_88PM860X)	+=3D 88pm860x_battery.o
>  obj-$(CONFIG_BATTERY_ACT8945A)	+=3D act8945a_charger.o
>  obj-$(CONFIG_BATTERY_AXP20X)	+=3D axp20x_battery.o
>  obj-$(CONFIG_CHARGER_AXP20X)	+=3D axp20x_ac_power.o
> +obj-$(CONFIG_BATTERY_BMS)	+=3D qcom_bms.o
>  obj-$(CONFIG_BATTERY_CPCAP)	+=3D cpcap-battery.o
>  obj-$(CONFIG_BATTERY_DS2760)	+=3D ds2760_battery.o
>  obj-$(CONFIG_BATTERY_DS2780)	+=3D ds2780_battery.o
> diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_=
bms.c
> new file mode 100644
> index 000000000000..718fd745c0f7
> --- /dev/null
> +++ b/drivers/power/supply/qcom_bms.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL
> +
> +/*
> + * Qualcomm Battery Monitoring System driver
> + *
> + * Copyright (C) 2018 Craig Tatlor <ctatlor97@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fixp-arith.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/consumer.h>
> +
> +#define REG_BMS_OCV_FOR_SOC_DATA0	0x90
> +#define REG_BMS_SHDW_CC_DATA0		0xA8
> +#define REG_BMS_CC_DATA_CTL		0x42
> +#define REG_BMS_CC_CLEAR_CTL		0x4
> +
> +#define BMS_HOLD_OREG_DATA		BIT(0)
> +#define BMS_CLEAR_SHDW_CC		BIT(6)
> +
> +#define BMS_CC_READING_RESOLUTION_N	542535
> +#define BMS_CC_READING_RESOLUTION_D	10000
> +#define BMS_CC_READING_TICKS		56
> +#define BMS_SLEEP_CLK_HZ		32764
> +
> +#define SECONDS_PER_HOUR		3600
> +#define TEMPERATURE_COLS		5
> +#define MAX_CAPACITY_ROWS		50
> +
> +/* lookup table for ocv -> capacity conversion */
> +struct bms_ocv_lut {
> +	int rows;
> +	s8 temp_legend[TEMPERATURE_COLS];
> +	u8 capacity_legend[MAX_CAPACITY_ROWS];
> +	u32 lut[MAX_CAPACITY_ROWS][TEMPERATURE_COLS];
> +};
> +
> +/* lookup table for battery temperature -> fcc conversion */
> +struct bms_fcc_lut {
> +	s8 temp_legend[TEMPERATURE_COLS];
> +	u32 lut[TEMPERATURE_COLS];
> +};
> +
> +struct bms_device_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct bms_ocv_lut ocv_lut;
> +	struct power_supply_desc bat_desc;
> +	struct bms_fcc_lut fcc_lut;
> +	struct iio_channel *adc;
> +	struct mutex bms_output_lock;
> +	u32 base_addr;
> +
> +	int ocv_thr_irq;
> +	u32 ocv;
> +};
> +
> +static bool between(int left, int right, int val)
> +{
> +	if (left <=3D val && val <=3D right)
> +		return true;
> +
> +	if (left >=3D val && val >=3D right)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int interpolate_capacity(int temp, u32 ocv,
> +				struct bms_ocv_lut *ocv_lut)
> +{
> +	int pcj_minus_one =3D 0, pcj =3D 0, i2 =3D 0, i3 =3D 0, i, j;
> +
> +	for (j =3D 0; j < TEMPERATURE_COLS; j++)
> +		if (temp <=3D ocv_lut->temp_legend[j])
> +			break;
> +
> +	if (ocv >=3D ocv_lut->lut[0][j])
> +		return ocv_lut->capacity_legend[0];
> +
> +	if (ocv <=3D ocv_lut->lut[ocv_lut->rows-1][j-1])
> +		return ocv_lut->capacity_legend[ocv_lut->rows-1];
> +
> +	for (i =3D 0; i < ocv_lut->rows-1; i++) {
> +		if (between(ocv_lut->lut[i][j],
> +			    ocv_lut->lut[i+1][j], ocv))
> +			i2 =3D i;
> +
> +		if (between(ocv_lut->lut[i][j-1],
> +			    ocv_lut->lut[i+1][j-1], ocv))
> +			i3 =3D i;
> +	}
> +
> +	/* interpolate two capacities */
> +	pcj =3D fixp_linear_interpolate(ocv_lut->lut[i2][j],
> +				      ocv_lut->capacity_legend[i2],
> +				      ocv_lut->lut[i2+1][j],
> +				      ocv_lut->capacity_legend[i2+1],
> +				      ocv);
> +
> +	pcj_minus_one =3D fixp_linear_interpolate(ocv_lut->lut[i3][j-1],
> +						ocv_lut->capacity_legend[i3],
> +						ocv_lut->lut[i3+1][j-1],
> +						ocv_lut->capacity_legend[i3+1],
> +						ocv);
> +
> +	/* interpolate them with the battery temperature */
> +	return fixp_linear_interpolate(ocv_lut->temp_legend[j-1],
> +				       pcj_minus_one,
> +				       ocv_lut->temp_legend[j],
> +				       pcj,
> +				       temp);
> +}
> +
> +static int interpolate_fcc(int temp, struct bms_fcc_lut *fcc_lut)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < TEMPERATURE_COLS; i++)
> +		if (temp <=3D fcc_lut->temp_legend[i])
> +			break;
> +
> +	return fixp_linear_interpolate(fcc_lut->temp_legend[i-1],
> +			     fcc_lut->lut[i-1],
> +			     fcc_lut->temp_legend[i],
> +			     fcc_lut->lut[i],
> +			     temp);
> +}
> +
> +static int bms_lock_output_data(struct bms_device_info *di)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_DATA_CTL,
> +				 BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
> +	if (ret) {
> +		dev_err(di->dev, "failed to lock bms output: %d", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Sleep for at least 100 microseconds here to make sure
> +	 * there has been at least three cycles of the sleep clock
> +	 * so that the registers are correctly locked.
> +	 */
> +	usleep_range(100, 1000);
> +
> +	return 0;
> +}
> +
> +static int bms_unlock_output_data(struct bms_device_info *di)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_DATA_CTL,
> +				 BMS_HOLD_OREG_DATA, 0);
> +	if (ret) {
> +		dev_err(di->dev, "failed to unlock bms output: %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bms_read_ocv(struct bms_device_info *di, u32 *ocv)
> +{
> +	int ret;
> +	u16 read_ocv;
> +
> +	mutex_lock(&di->bms_output_lock);
> +
> +	ret =3D bms_lock_output_data(di);
> +	if (ret)
> +		goto err_lock;
> +
> +	ret =3D regmap_bulk_read(di->regmap, di->base_addr+
> +			       REG_BMS_OCV_FOR_SOC_DATA0, &read_ocv, 2);
> +	if (ret) {
> +		dev_err(di->dev, "open circuit voltage read failed: %d", ret);
> +		goto err_read;
> +	}
> +
> +	dev_dbg(di->dev, "read open circuit voltage of: %d mv", read_ocv);
> +
> +

one empty line is enough.

> +	*ocv =3D read_ocv * 1000;
> +
> +err_read:
> +	bms_unlock_output_data(di);
> +
> +err_lock:
> +	mutex_unlock(&di->bms_output_lock);
> +
> +	return ret;
> +}
> +
> +static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
> +{
> +	int ret;
> +	s64 cc_raw_s36, cc_raw, cc_uv, cc_pvh;
> +
> +	mutex_lock(&di->bms_output_lock);
> +
> +	ret =3D bms_lock_output_data(di);
> +	if (ret)
> +		goto err_lock;
> +
> +	ret =3D regmap_bulk_read(di->regmap, di->base_addr +
> +			       REG_BMS_SHDW_CC_DATA0,
> +			       &cc_raw_s36, 5);
> +	if (ret) {
> +		dev_err(di->dev, "coulomb counter read failed: %d", ret);
> +		goto err_read;
> +	}
> +
> +	ret =3D bms_unlock_output_data(di);
> +	if (ret)
> +		goto err_lock;
> +
> +	mutex_unlock(&di->bms_output_lock);
> +
> +	cc_raw =3D sign_extend32(cc_raw_s36, 28);
> +
> +	/* convert raw to uv */
> +	cc_uv =3D div_s64(cc_raw * BMS_CC_READING_RESOLUTION_N,
> +			BMS_CC_READING_RESOLUTION_D);
> +
> +	/* convert uv to pvh */
> +	cc_pvh =3D div_s64(cc_uv * BMS_CC_READING_TICKS * 100000,
> +			 BMS_SLEEP_CLK_HZ * SECONDS_PER_HOUR);
> +
> +	/* divide by impedance */
> +	*cc_uah =3D div_s64(cc_pvh, 10000);
> +
> +	dev_dbg(di->dev, "read coulomb counter value of: %lld uah", *cc_uah);
> +
> +	return 0;
> +
> +err_read:
> +	bms_unlock_output_data(di);
> +
> +err_lock:
> +	mutex_unlock(&di->bms_output_lock);
> +
> +	return ret;
> +}
> +
> +static void bms_reset_cc(struct bms_device_info *di)
> +{
> +	int ret;
> +
> +	mutex_lock(&di->bms_output_lock);
> +
> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_CLEAR_CTL,
> +				 BMS_CLEAR_SHDW_CC,
> +				 BMS_CLEAR_SHDW_CC);
> +	if (ret) {
> +		dev_err(di->dev, "coulomb counter reset failed: %d", ret);
> +		goto err_lock;
> +	}
> +
> +	/* wait at least three sleep cycles for cc to reset */
> +	usleep_range(100, 1000);
> +
> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
> +				 REG_BMS_CC_CLEAR_CTL,
> +				 BMS_CLEAR_SHDW_CC, 0);
> +	if (ret)
> +		dev_err(di->dev, "coulomb counter re-enable failed: %d", ret);
> +
> +err_lock:
> +	mutex_unlock(&di->bms_output_lock);
> +}
> +
> +static int bms_calculate_capacity(struct bms_device_info *di, int *capac=
ity)
> +{
> +	unsigned long fcc;
> +	int ret, temp, ocv_capacity, temp_degc;
> +	s64 cc =3D 0;
> +
> +	ret =3D iio_read_channel_raw(di->adc, &temp);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to read temperature: %d", ret);
> +		return ret;
> +	}
> +
> +	temp_degc =3D DIV_ROUND_CLOSEST(temp, 1000);
> +
> +	ret =3D bms_read_cc(di, &cc);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to read coulomb counter: %d", ret);
> +		return ret;
> +	}
> +
> +	/* interpolate capacity from open circuit voltage */
> +	ocv_capacity =3D interpolate_capacity(temp_degc, di->ocv,
> +					    &di->ocv_lut);
> +
> +	/* interpolate the full charge capacity from temperature */
> +	fcc =3D interpolate_fcc(temp_degc, &di->fcc_lut);
> +
> +	/* append coloumb counter to capacity */
> +	*capacity =3D DIV_ROUND_CLOSEST(fcc * ocv_capacity, 100);
> +	*capacity =3D div_s64((*capacity - cc) * 100, fcc);
> +
> +	return 0;
> +}
> +
> +
> +

one empty line is enough.=20

> +/*
> + * Return power_supply property
> + */
> +static int bms_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct bms_device_info *di =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D bms_calculate_capacity(di, &val->intval);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	if (val->intval =3D=3D INT_MAX || val->intval =3D=3D INT_MIN)
> +		ret =3D -EINVAL;
> +
> +	return ret;
> +}
> +
> +static enum power_supply_property bms_props[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +};

Why does the driver not expose the following battery information?

temperature info via POWER_SUPPLY_PROP_TEMP
ocv info via POWER_SUPPLY_PROP_VOLTAGE_OCV
CC info via POWER_SUPPLY_PROP_CHARGE_COUNTER
max current via POWER_SUPPLY_PROP_CURRENT_MAX

> +static irqreturn_t bms_ocv_thr_irq_handler(int irq, void *dev_id)
> +{
> +	struct bms_device_info *di =3D dev_id;
> +
> +	if (bms_read_ocv(di, &di->ocv) < 0)
> +		return IRQ_HANDLED;
> +
> +	bms_reset_cc(di);
> +	return IRQ_HANDLED;
> +}

You want to call power_supply_changed() here to notify userspace.

> +static int bms_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct bms_device_info *di;
> +	struct power_supply *bat;
> +	int ret;
> +
> +	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> +	if (!di)
> +		return -ENOMEM;
> +
> +	di->dev =3D &pdev->dev;
> +
> +	di->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!di->regmap) {
> +		dev_err(di->dev, "Unable to get regmap");
> +		return -EINVAL;
> +	}
> +
> +	di->adc =3D devm_iio_channel_get(&pdev->dev, "temp");
> +	if (IS_ERR(di->adc))
> +		return PTR_ERR(di->adc);
> +
> +	ret =3D of_property_read_u32(di->dev->of_node, "reg", &di->base_addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D of_property_read_u8_array(di->dev->of_node,
> +						 "qcom,ocv-temp-legend-celsius",
> +						 (u8 *)di->ocv_lut.temp_legend,
> +						 TEMPERATURE_COLS);
> +	if (ret < 0) {
> +		dev_err(di->dev, "no open circuit voltage temperature legend found");
> +		return ret;
> +	}
> +
> +	di->ocv_lut.rows =3D of_property_read_variable_u8_array(di->dev->of_nod=
e,
> +						 "qcom,ocv-capacity-legend",
> +						 di->ocv_lut.capacity_legend, 0,
> +						 MAX_CAPACITY_ROWS);
> +	if (di->ocv_lut.rows < 0) {
> +		dev_err(di->dev, "no open circuit voltage capacity legend found");
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_variable_u32_array(di->dev->of_node,
> +						  "qcom,ocv-lut-microvolt",
> +						  (u32 *)di->ocv_lut.lut,
> +						  TEMPERATURE_COLS,
> +						  TEMPERATURE_COLS *
> +						  MAX_CAPACITY_ROWS);
> +	if (ret < 0) {
> +		dev_err(di->dev, "no open circuit voltage lut array found");
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_u8_array(di->dev->of_node,
> +						 "qcom,fcc-temp-legend-celsius",
> +						 (u8 *)di->fcc_lut.temp_legend,
> +						 TEMPERATURE_COLS);
> +	if (ret < 0) {
> +		dev_err(di->dev, "no full charge capacity temperature legend found");
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_u32_array(di->dev->of_node,
> +						  "qcom,fcc-lut-microamp-hours",
> +						  di->fcc_lut.lut,
> +						  TEMPERATURE_COLS);
> +	if (ret < 0) {
> +		dev_err(di->dev, "no full charge capacity lut array found");
> +		return ret;
> +	}
> +
> +	ret =3D bms_read_ocv(di, &di->ocv);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to read initial open circuit voltage: %d",
> +			ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&di->bms_output_lock);
> +
> +	di->ocv_thr_irq =3D platform_get_irq_byname(pdev, "ocv_thr");
> +
> +	ret =3D devm_request_threaded_irq(di->dev, di->ocv_thr_irq, NULL,
> +					bms_ocv_thr_irq_handler,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					pdev->name, di);
> +	if (ret < 0) {
> +		dev_err(di->dev, "failed to request handler for open circuit voltage t=
hreshold IRQ");
> +		return ret;
> +	}
> +
> +

one empty line is enough.

> +	di->bat_desc.name =3D "bms";
> +	di->bat_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	di->bat_desc.properties =3D bms_props;
> +	di->bat_desc.num_properties =3D ARRAY_SIZE(bms_props);
> +	di->bat_desc.get_property =3D bms_get_property;
> +
> +	psy_cfg.drv_data =3D di;

psy_cfg.of_node =3D pdev->dev.of_node;

> +	bat =3D devm_power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
> +
> +	return PTR_ERR_OR_ZERO(bat);
> +}
> +
> +static const struct of_device_id bms_of_match[] =3D {
> +	{.compatible =3D "qcom,pm8941-bms", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bms_of_match);
> +
> +static struct platform_driver bms_driver =3D {
> +	.probe =3D bms_probe,
> +	.driver =3D {
> +		.name =3D "qcom-bms",
> +		.of_match_table =3D of_match_ptr(bms_of_match),
> +	},
> +};
> +module_platform_driver(bms_driver);
> +
> +MODULE_AUTHOR("Craig Tatlor <ctatlor97@gmail.com>");
> +MODULE_DESCRIPTION("Qualcomm BMS driver");
> +MODULE_LICENSE("GPL");

Apart from the things above I would like to see the information
about the battery cell itself being moved to 'struct
power_supply_battery_info', see also my comment in the DT bindings.

-- Sebastian

--fynnm6azsqtphcbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueXyoACgkQ2O7X88g7
+pqyVBAAjxQOxCdhJ0ZF+hLVJBAjrEue23TmIT+RNYSetbxlMfnPt0NQX1wc8J1W
WURBgX7gKXC+r4aARoG2kpmZtgSs39bmxJ54sSZdPmc+m+HU9rSUssdJPr24E3tP
vHGp6NFamSIAHvOESzMBDQgSt5KxeiDhloXU7wx1GyPcELWuio0DyXilX348jisP
iABCBm5CtU5gVNIiGDtLmpbixVxdWs3Opv8jGMqUPDajiGylQqD5ZqPAbjQm/zoZ
zaT3oxLA0Ys97xKJgnEpxMtZI2WhDVEFW6r/0TK8z9gG8fBvuARRp6PGKL0b2cst
RSzIlapncrthkmaMacd7o8ve22WVGUDdh/BHNyTKBAnBS2qS9pGoDTYBAFhIM555
7QnLl2eMK6VCm7DbdYeIR6LupvrTP2ee9G2dCPt5ut81ZTVxKvwPBEDSLITTJRlf
zmy7/dUe9RXn6ATDlbxOZtmIM8P1yx8Pn0RpDvbFpCu7rkr5p6lsW/H4rz6ycQbX
z2KhHELFTTBn5SDD6HnIaoxi76g7HRT/wXoDfiTEUoBMH4r+GpbrK6kRAjW8AcqQ
m6DDvYcN13SQmlirU9KqjuSa8v5Q1Cvooi3N78miSoC3QndOuhqUGl/T0/Roek8J
d9sicBH/SQBJAuktP2yRWow9C+2pTS+E7Jr90ODkicWX0BoKZAY=
=lDGX
-----END PGP SIGNATURE-----

--fynnm6azsqtphcbk--
