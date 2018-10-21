Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D2ECDE47
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA42083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmULasJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AA42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeJVDmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbeJVDm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:42:28 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB1920843;
        Sun, 21 Oct 2018 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150027;
        bh=TMpbeFeAUynR4YTZz7H/x2cLa4IHB5iK5lWpCDFnAcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmULasJU7JBH/8OlRAl0RH7xYwuIPIwpTuIa0LiSrv3aDH1jBqihAXfjDZrdj3e/Q
         zaKWbnRXq63zf2PVh0AraQPt7YD0HTSuLPzoX1bvHSTjU5LHQqwBknu+Y1pVa0fSEg
         QW6WkW0O4EumrlePTXwPuBZpVVjMK6k+0vrIJ2VQ=
Received: by earth.universe (Postfix, from userid 1000)
        id A29A33C0998; Sun, 21 Oct 2018 18:52:01 +0200 (CEST)
Date:   Sun, 21 Oct 2018 18:52:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v5 6/6] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
Message-ID: <20181021165201.wob4iar5sd263wkg@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <2983281f449d180d008c2f49133088a12ea4046d.1539915051.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="keomimdhzq2pe2ce"
Content-Disposition: inline
In-Reply-To: <2983281f449d180d008c2f49133088a12ea4046d.1539915051.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--keomimdhzq2pe2ce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:15PM +0800, Baolin Wang wrote:
> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
> which is used to calculate the battery capacity.
>=20
> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Looks mostly good. I have a few comments still. My plan is to merge
this early after the merge window, if the final version is finished
at this point.

> Changes from v4:
>  - None.
>=20
> Changes from v3:
>  - None.
>=20
> Changes from v2:
>  - Use core helper functions to look up OCV capacity table.
>  - Use device_property_read_u32() instead of of_property_read_u32().
>  - Add acked tag from Linus.
>=20
> Changes from v1:
>  - Use battery standard properties to get internal resistance and ocv tab=
le.
>  - Change devm_gpiod_get_optional() to devm_gpiod_get().
>  - Add power_supply_changed() when detecting battery present change.
>  - Return micro volts for sc27xx_fgu_get_vbat_ocv().
> ---
>  drivers/power/supply/Kconfig             |    7 +
>  drivers/power/supply/Makefile            |    1 +
>  drivers/power/supply/sc27xx_fuel_gauge.c |  661 ++++++++++++++++++++++++=
++++++
>  3 files changed, 669 insertions(+)
>  create mode 100644 drivers/power/supply/sc27xx_fuel_gauge.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f27cf07..917f4b7 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -652,4 +652,11 @@ config CHARGER_SC2731
>  	 Say Y here to enable support for battery charging with SC2731
>  	 PMIC chips.
> =20
> +config FUEL_GAUGE_SC27XX
> +	tristate "Spreadtrum SC27XX fuel gauge driver"
> +	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +	help
> +	 Say Y here to enable support for fuel gauge with SC27XX
> +	 PMIC chips.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 767105b..b731c2a 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -86,3 +86,4 @@ obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
> +obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> new file mode 100644
> index 0000000..1c0b856
> --- /dev/null
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -0,0 +1,661 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Spreadtrum Communications Inc.
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +/* PMIC global control registers definition */
> +#define SC27XX_MODULE_EN0		0xc08
> +#define SC27XX_CLK_EN0			0xc18
> +#define SC27XX_FGU_EN			BIT(7)
> +#define SC27XX_FGU_RTC_EN		BIT(6)
> +
> +/* FGU registers definition */
> +#define SC27XX_FGU_START		0x0
> +#define SC27XX_FGU_CONFIG		0x4
> +#define SC27XX_FGU_ADC_CONFIG		0x8
> +#define SC27XX_FGU_STATUS		0xc
> +#define SC27XX_FGU_INT_EN		0x10
> +#define SC27XX_FGU_INT_CLR		0x14
> +#define SC27XX_FGU_INT_STS		0x1c
> +#define SC27XX_FGU_VOLTAGE		0x20
> +#define SC27XX_FGU_OCV			0x24
> +#define SC27XX_FGU_POCV			0x28
> +#define SC27XX_FGU_CURRENT		0x2c
> +#define SC27XX_FGU_CLBCNT_SETH		0x50
> +#define SC27XX_FGU_CLBCNT_SETL		0x54
> +#define SC27XX_FGU_CLBCNT_VALH		0x68
> +#define SC27XX_FGU_CLBCNT_VALL		0x6c
> +#define SC27XX_FGU_CLBCNT_QMAXL		0x74
> +
> +#define SC27XX_WRITE_SELCLB_EN		BIT(0)
> +#define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
> +#define SC27XX_FGU_CLBCNT_SHIFT		16
> +
> +#define SC27XX_FGU_1000MV_ADC		686
> +#define SC27XX_FGU_1000MA_ADC		1372
> +#define SC27XX_FGU_CUR_BASIC_ADC	8192
> +#define SC27XX_FGU_SAMPLE_HZ		2
> +
> +/*
> + * struct sc27xx_fgu_data: describe the FGU device
> + * @regmap: regmap for register access
> + * @dev: platform device
> + * @battery: battery power supply
> + * @base: the base offset for the controller
> + * @lock: protect the structure
> + * @gpiod: GPIO for battery detection
> + * @channel: IIO channel to get battery temperature
> + * @internal_resist: the battery internal resistance in mOhm
> + * @total_cap: the total capacity of the battery in mAh
> + * @init_cap: the initial capacity of the battery in mAh
> + * @init_clbcnt: the initial coulomb counter
> + * @max_volt: the maximum constant input voltage in millivolt
> + * @table_len: the capacity table length
> + * @cap_table: capacity table with corresponding ocv
> + */
> +struct sc27xx_fgu_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct power_supply *battery;
> +	u32 base;
> +	struct mutex lock;
> +	struct gpio_desc *gpiod;
> +	struct iio_channel *channel;
> +	bool bat_present;
> +	int internal_resist;
> +	int total_cap;
> +	int init_cap;
> +	int init_clbcnt;
> +	int max_volt;
> +	int table_len;
> +	struct power_supply_battery_ocv_table *cap_table;
> +};
> +
> +static const char * const sc27xx_charger_supply_name[] =3D {
> +	"sc2731_charger",
> +	"sc2720_charger",
> +	"sc2721_charger",
> +	"sc2723_charger",
> +};
> +
> +static int sc27xx_fgu_adc_to_current(int adc)
> +{
> +	return (adc * 1000) / SC27XX_FGU_1000MA_ADC;
> +}
> +
> +static int sc27xx_fgu_adc_to_voltage(int adc)
> +{
> +	return (adc * 1000) / SC27XX_FGU_1000MV_ADC;
> +}
> +
> +/*
> + * When system boots on, we can not read battery capacity from coulomb
> + * registers, since now the coulomb registers are invalid. So we should
> + * calculate the battery open circuit voltage, and get current battery
> + * capacity according to the capacity table.
> + */
> +static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, in=
t *cap)
> +{
> +	int volt, cur, oci, ocv, ret;
> +
> +	/*
> +	 * After system booting on, the SC27XX_FGU_CLBCNT_QMAXL register saved
> +	 * the first sampled open circuit current.
> +	 */
> +	ret =3D regmap_read(data->regmap, data->base + SC27XX_FGU_CLBCNT_QMAXL,
> +			  &cur);
> +	if (ret)
> +		return ret;
> +
> +	cur <<=3D 1;
> +	oci =3D sc27xx_fgu_adc_to_current(cur - SC27XX_FGU_CUR_BASIC_ADC);
> +
> +	/*
> +	 * Should get the OCV from SC27XX_FGU_POCV register at the system
> +	 * beginning. It is ADC values reading from registers which need to
> +	 * convert the corresponding voltage.
> +	 */
> +	ret =3D regmap_read(data->regmap, data->base + SC27XX_FGU_POCV, &volt);
> +	if (ret)
> +		return ret;
> +
> +	volt =3D sc27xx_fgu_adc_to_voltage(volt);
> +	ocv =3D volt - (oci * data->internal_resist) / 1000;
> +
> +	/*
> +	 * Parse the capacity table to look up the correct capacity percent
> +	 * according to current battery's corresponding OCV values.
> +	 */
> +	*cap =3D power_supply_ocv2cap_simple(data->cap_table, data->table_len,
> +					   ocv);
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcn=
t)
> +{
> +	int ret;
> +
> +	clbcnt *=3D SC27XX_FGU_SAMPLE_HZ;
> +
> +	ret =3D regmap_update_bits(data->regmap,
> +				 data->base + SC27XX_FGU_CLBCNT_SETL,
> +				 SC27XX_FGU_CLBCNT_MASK, clbcnt);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(data->regmap,
> +				 data->base + SC27XX_FGU_CLBCNT_SETH,
> +				 SC27XX_FGU_CLBCNT_MASK,
> +				 clbcnt >> SC27XX_FGU_CLBCNT_SHIFT);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, data->base + SC27XX_FGU_START,
> +				 SC27XX_WRITE_SELCLB_EN,
> +				 SC27XX_WRITE_SELCLB_EN);
> +}
> +
> +static int sc27xx_fgu_get_clbcnt(struct sc27xx_fgu_data *data, int *clb_=
cnt)
> +{
> +	int ccl, cch, ret;
> +
> +	ret =3D regmap_read(data->regmap, data->base + SC27XX_FGU_CLBCNT_VALL,
> +			  &ccl);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap, data->base + SC27XX_FGU_CLBCNT_VALH,
> +			  &cch);
> +	if (ret)
> +		return ret;
> +
> +	*clb_cnt =3D ccl & SC27XX_FGU_CLBCNT_MASK;
> +	*clb_cnt |=3D (cch & SC27XX_FGU_CLBCNT_MASK) << SC27XX_FGU_CLBCNT_SHIFT;
> +	*clb_cnt /=3D SC27XX_FGU_SAMPLE_HZ;
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *ca=
p)
> +{
> +	int ret, cur_clbcnt, delta_clbcnt, delta_cap, temp;
> +
> +	/* Get current coulomb counters firstly */
> +	ret =3D sc27xx_fgu_get_clbcnt(data, &cur_clbcnt);
> +	if (ret)
> +		return ret;
> +
> +	delta_clbcnt =3D cur_clbcnt - data->init_clbcnt;
> +
> +	/*
> +	 * Convert coulomb counter to delta capacity (mAh), and set multiplier
> +	 * as 100 to improve the precision.
> +	 */
> +	temp =3D DIV_ROUND_CLOSEST(delta_clbcnt, 360);
> +	temp =3D sc27xx_fgu_adc_to_current(temp);
> +
> +	/*
> +	 * Convert to capacity percent of the battery total capacity,
> +	 * and multiplier is 100 too.
> +	 */
> +	delta_cap =3D DIV_ROUND_CLOSEST(temp * 100, data->total_cap);
> +	*cap =3D delta_cap + data->init_cap;
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_get_vbat_vol(struct sc27xx_fgu_data *data, int *va=
l)
> +{
> +	int ret, vol;
> +
> +	ret =3D regmap_read(data->regmap, data->base + SC27XX_FGU_VOLTAGE, &vol=
);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * It is ADC values reading from registers which need to convert to
> +	 * corresponding voltage values.
> +	 */
> +	*val =3D sc27xx_fgu_adc_to_voltage(vol);
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_get_current(struct sc27xx_fgu_data *data, int *val)
> +{
> +	int ret, cur;
> +
> +	ret =3D regmap_read(data->regmap, data->base + SC27XX_FGU_CURRENT, &cur=
);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * It is ADC values reading from registers which need to convert to
> +	 * corresponding current values.
> +	 */
> +	*val =3D sc27xx_fgu_adc_to_current(cur - SC27XX_FGU_CUR_BASIC_ADC);
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *va=
l)
> +{
> +	int vol, cur, ret;
> +
> +	ret =3D sc27xx_fgu_get_vbat_vol(data, &vol);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sc27xx_fgu_get_current(data, &cur);
> +	if (ret)
> +		return ret;
> +
> +	/* Return the battery OCV in micro volts. */
> +	*val =3D vol * 1000 - cur * data->internal_resist;
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_get_temp(struct sc27xx_fgu_data *data, int *temp)
> +{
> +	return iio_read_channel_processed(data->channel, temp);
> +}
> +
> +static int sc27xx_fgu_get_health(struct sc27xx_fgu_data *data, int *heal=
th)
> +{
> +	int ret, vol;
> +
> +	ret =3D sc27xx_fgu_get_vbat_vol(data, &vol);
> +	if (ret)
> +		return ret;
> +
> +	if (vol > data->max_volt)
> +		*health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	else
> +		*health =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +	return 0;
> +}
> +
> +static int sc27xx_fgu_get_status(struct sc27xx_fgu_data *data, int *stat=
us)
> +{
> +	union power_supply_propval val;
> +	struct power_supply *psy;
> +	int i, ret =3D -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sc27xx_charger_supply_name); i++) {
> +		psy =3D power_supply_get_by_name(sc27xx_charger_supply_name[i]);
> +		if (!psy)
> +			continue;
> +
> +		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS,
> +						&val);
> +		power_supply_put(psy);
> +		if (ret)
> +			return ret;
> +
> +		*status =3D val.intval;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sc27xx_fgu_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct sc27xx_fgu_data *data =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +	int value;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D sc27xx_fgu_get_status(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D sc27xx_fgu_get_health(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D data->bat_present;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D sc27xx_fgu_get_temp(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D sc27xx_fgu_get_capacity(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D sc27xx_fgu_get_vbat_vol(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		ret =3D sc27xx_fgu_get_vbat_ocv(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D sc27xx_fgu_get_current(data, &value);
> +		if (ret)
> +			goto error;
> +
> +		val->intval =3D value * 1000;
> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +error:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
> +{
> +	struct sc27xx_fgu_data *data =3D power_supply_get_drvdata(psy);
> +
> +	power_supply_changed(data->battery);
> +}
> +
> +static enum power_supply_property sc27xx_fgu_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +};
> +
> +static const struct power_supply_desc sc27xx_fgu_desc =3D {
> +	.name			=3D "sc27xx-fgu",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties		=3D sc27xx_fgu_props,
> +	.num_properties		=3D ARRAY_SIZE(sc27xx_fgu_props),
> +	.get_property		=3D sc27xx_fgu_get_property,
> +	.external_power_changed	=3D sc27xx_fgu_external_power_changed,
> +};
> +
> +static irqreturn_t sc27xx_fgu_bat_detection(int irq, void *dev_id)
> +{
> +	struct sc27xx_fgu_data *data =3D dev_id;
> +	int state;
> +
> +	mutex_lock(&data->lock);
> +
> +	state =3D gpiod_get_value_cansleep(data->gpiod);
> +	if (state < 0) {
> +		dev_err(data->dev, "failed to get gpio state\n");
> +		mutex_unlock(&data->lock);
> +		return IRQ_RETVAL(state);
> +	}
> +
> +	data->bat_present =3D !!state;
> +
> +	mutex_unlock(&data->lock);
> +
> +	power_supply_changed(data->battery);
> +	return IRQ_HANDLED;
> +}
> +
> +static void sc27xx_fgu_disable(void *_data)
> +{
> +	struct sc27xx_fgu_data *data =3D _data;
> +
> +	regmap_update_bits(data->regmap, SC27XX_CLK_EN0, SC27XX_FGU_RTC_EN, 0);
> +	regmap_update_bits(data->regmap, SC27XX_MODULE_EN0, SC27XX_FGU_EN, 0);
> +}
> +
> +static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int ca=
pacity)
> +{
> +	/*
> +	 * Get current capacity (mAh) =3D battery total capacity (mAh) *
> +	 * current capacity percent (capacity / 100).
> +	 */
> +	int cur_cap =3D DIV_ROUND_CLOSEST(data->total_cap * capacity, 100);
> +
> +	/*
> +	 * Convert current capacity (mAh) to coulomb counter according to the
> +	 * formula: 1 mAh =3D3.6 coulomb.
> +	 */
> +	return DIV_ROUND_CLOSEST(cur_cap * 36, 10);
> +}
> +
> +static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
> +{
> +	struct power_supply_battery_info info =3D { };
> +	struct power_supply_battery_ocv_table *table;
> +	int ret, i;
> +
> +	ret =3D power_supply_get_battery_info(data->battery, &info);
> +	if (ret) {
> +		dev_err(data->dev, "failed to get battery information\n");
> +		return ret;
> +	}
> +
> +	data->total_cap =3D info.charge_full_design_uah / 1000;
> +	data->max_volt =3D info.constant_charge_voltage_max_uv / 1000;
> +	data->internal_resist =3D info.factory_internal_resistance_uohm / 1000;
> +
> +	/*
> +	 * For SC27XX fuel gauge device, we only use one ocv-capacity
> +	 * table in normal temperature 20 Celsius.
> +	 */
> +	table =3D power_supply_find_ocv2cap_table(&info, 20, &data->table_len);
> +	if (!table)
> +		return -EINVAL;
> +
> +	data->cap_table =3D devm_kzalloc(data->dev,
> +				       data->table_len * sizeof(*table),
> +				       GFP_KERNEL);
> +	if (!data->cap_table) {
> +		power_supply_put_battery_info(data->battery, &info);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < data->table_len; i++) {
> +		data->cap_table[i].ocv =3D table[i].ocv / 1000;
> +		data->cap_table[i].capacity =3D table[i].capacity;
> +	}

Don't divide the OCV by 1000. You feed this table into the
generic power-supply function later, which should always
get uV. Instead multiply the ocv parameter in your
power_supply_ocv2cap_simple() call with 1000. This
means you can just use devm_kmemdup() here.

Some ideas for later (I'm fine with merging the driver
without these changes):

 * Store battery_info directly in private driver data
   instead of doing a copy of the temperature table.
 * Call power_supply_ocv2cap() with current battery
   temperature and let the power-supply core figure
   out which ocv-to-capacity curve should be used.

Thanks for your patience :)

-- Sebastian

> +	power_supply_put_battery_info(data->battery, &info);
> +
> +	/* Enable the FGU module */
> +	ret =3D regmap_update_bits(data->regmap, SC27XX_MODULE_EN0,
> +				 SC27XX_FGU_EN, SC27XX_FGU_EN);
> +	if (ret) {
> +		dev_err(data->dev, "failed to enable fgu\n");
> +		return ret;
> +	}
> +
> +	/* Enable the FGU RTC clock to make it work */
> +	ret =3D regmap_update_bits(data->regmap, SC27XX_CLK_EN0,
> +				 SC27XX_FGU_RTC_EN, SC27XX_FGU_RTC_EN);
> +	if (ret) {
> +		dev_err(data->dev, "failed to enable fgu RTC clock\n");
> +		goto disable_fgu;
> +	}
> +
> +	/*
> +	 * Get the boot battery capacity when system powers on, which is used to
> +	 * initialize the coulomb counter. After that, we can read the coulomb
> +	 * counter to measure the battery capacity.
> +	 */
> +	ret =3D sc27xx_fgu_get_boot_capacity(data, &data->init_cap);
> +	if (ret) {
> +		dev_err(data->dev, "failed to get boot capacity\n");
> +		goto disable_clk;
> +	}
> +
> +	/*
> +	 * Convert battery capacity to the corresponding initial coulomb counter
> +	 * and set into coulomb counter registers.
> +	 */
> +	data->init_clbcnt =3D sc27xx_fgu_cap_to_clbcnt(data, data->init_cap);
> +	ret =3D sc27xx_fgu_set_clbcnt(data, data->init_clbcnt);
> +	if (ret) {
> +		dev_err(data->dev, "failed to initialize coulomb counter\n");
> +		goto disable_clk;
> +	}
> +
> +	return 0;
> +
> +disable_clk:
> +	regmap_update_bits(data->regmap, SC27XX_CLK_EN0, SC27XX_FGU_RTC_EN, 0);
> +disable_fgu:
> +	regmap_update_bits(data->regmap, SC27XX_MODULE_EN0, SC27XX_FGU_EN, 0);
> +
> +	return ret;
> +}

--keomimdhzq2pe2ce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMrq4ACgkQ2O7X88g7
+pr7fxAAkbdqP5zaSxa1ArdX8DvK7kJ+vZUdWnYlsELD10LLduxDCkiQcxbxgh4N
N9bonbAhLVQfIHTFzwAktWZblYWUDUEEsc4EccSah2DNz1fGrd4F73nOTlC5qrNr
ajfI7IYlz6IT3BflQI/ffyYqrhAJTZMLeC29RMmvJkAaEovzS8sLaaTgauHzh5eQ
fAGYFVjKRxzZHF+nE8zrLjzS1e/o2J6JUNFVdALQFpsSKpqdhjyfAUoQ4TypWpGP
FGU9Tc5BLg56f2QuZeWa7mkPKzf6A96SXdFagKzkH5Wv0dYE0jQvCXRloBnDig0r
jyEtArCUFGpvXCpmMKutpynTKKNpZlqQBYB4EtuWgPyA+//OgQsKjw9vbdE6XCfC
C3CaNWP+AcgLCQotV/Ea6DKB6rW8eI7PS6eEOACBxCCeGSStfHSopK4Jf7IthvLv
Ua2Zi/HDTfAi888tYxDDAQN2GxxwWkUad7d+PwLM6Mdgx20akbN/wLUMIjzp0+BX
HE68LLVz02jhJpvuppIFB/Xj43kCawF2dwsiFTCmQSdQm8D1QvavDPIaQsJW9g6f
355ZnK3LeqVrl4//4UCgzaYMV7VOGS1SJRHoEx+4Q38s6zGd+ApjlgQmWD39MFJU
NnyYMzecE+jG/e9BIAHA8G5S0gQ0i8zmsPGlF0GotY2f5DQvQ/I=
=LuAl
-----END PGP SIGNATURE-----

--keomimdhzq2pe2ce--
