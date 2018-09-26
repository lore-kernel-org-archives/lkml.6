Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12BD2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzI/ggnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12BD2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeIZVnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:43:55 -0400
Received: from earth.universe (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C3E20833;
        Wed, 26 Sep 2018 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537975824;
        bh=c7qbei68w4luu3pVjgCwEfVsUDSC4UCRHv0CLHlRfks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzI/ggnV0gS3mCs1MCPh2HyeXyn4RcfzsKNs5cTyPZnvJ5DMBmvI6IWtyJqUqBkHP
         AeM+6PGWE8j1oqeRbZa9I4f6Zfis+nzOSCLR8z1w91SqURxgTRZYnv6HX020CFG0nx
         9njaNWcPR9rTpgRI439VgOcgy+R+ii206tlAJEuQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 0BB893C09D6; Wed, 26 Sep 2018 17:30:18 +0200 (CEST)
Date:   Wed, 26 Sep 2018 17:30:18 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v2 4/4] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
Message-ID: <20180926153017.twcpqvj5523axtv6@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <707ebff8a188d41de374314414c8bfd927183d33.1537930252.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4cvi4rd3ciwwbr6"
Content-Disposition: inline
In-Reply-To: <707ebff8a188d41de374314414c8bfd927183d33.1537930252.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4cvi4rd3ciwwbr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 26, 2018 at 10:59:14AM +0800, Baolin Wang wrote:
> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
> which is used to calculate the battery capacity.
>=20
> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Use battery standard properties to get internal resistance and ocv tab=
le.
>  - Change devm_gpiod_get_optional() to devm_gpiod_get().
>  - Add power_supply_changed() when detecting battery present change.
>  - Return micro volts for sc27xx_fgu_get_vbat_ocv().
> ---
>  drivers/power/supply/Kconfig             |    7 +
>  drivers/power/supply/Makefile            |    1 +
>  drivers/power/supply/sc27xx_fuel_gauge.c |  691 ++++++++++++++++++++++++=
++++++
>  3 files changed, 699 insertions(+)
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
> index 0000000..d3422cf
> --- /dev/null
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -0,0 +1,691 @@
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
> +static int sc27xx_fgu_ocv_to_capacity(struct sc27xx_fgu_data *data, int =
ocv)
> +{
> +	struct power_supply_battery_ocv_table *tab =3D data->cap_table;
> +	int n =3D data->table_len;
> +	int i, cap, tmp;
> +
> +	/*
> +	 * Find the position in the table for current battery OCV value,
> +	 * then use these two points to calculate battery capacity
> +	 * according to the linear method.
> +	 */
> +	for (i =3D 0; i < n; i++)
> +		if (ocv > tab[i].ocv)
> +			break;
> +
> +	if (i > 0 && i < n) {
> +		tmp =3D (tab[i - 1].capacity - tab[i].capacity) *
> +			(ocv - tab[i].ocv) * 2;
> +		tmp /=3D tab[i - 1].ocv - tab[i].ocv;
> +		tmp =3D (tmp + 1) / 2;
> +		cap =3D tmp + tab[i].capacity;
> +	} else if (i =3D=3D 0) {
> +		cap =3D tab[0].capacity;
> +	} else {
> +		cap =3D tab[n - 1].capacity;
> +	}
> +
> +	return cap;
> +}

We should have a function working on the table(s) from battery_info
instead, which can be shared by drivers. Maybe something like this:

int ocv2cap_simple(struct power_supply_battery_ocv_table *table, int ocv)
{
    // basically your code but working with the common table
}

struct power_supply_battery_ocv_table *find_ocv2cap_table(struct power_supp=
ly_battery_info *info, int temp)
{
    int best_temp_diff, temp_diff =3D INT_MAX;
    int best_index =3D 0;

    for (int i=3D0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
        temp_diff =3D abs(info->ocv_temp[i] - temp);
        if (temp_diff < best_temp_diff) {
            best_temp_diff =3D temp_diff;
            best_index =3D i;
        }
    }

    return &info->ocv_table[i];
}

int batinfo_ocv2cap(struct power_supply_battery_info *info, int ocv, int te=
mp)
{
    struct power_supply_battery_ocv_table *table =3D find_ocv2cap_table(bat=
tery_info, temp);
    return ocv2cap_simple(table, ocv);
}

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
> +	*cap =3D sc27xx_fgu_ocv_to_capacity(data, ocv);
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
> +	data->internal_resist =3D info.internal_resistance_uohm / 1000;
> +	data->table_len =3D info.ocv_table_size[0];
> +
> +	/*
> +	 * For SC27XX fuel gauge device, we only need one ocv-capacity
> +	 * table in normal temperature.
> +	 */
> +	table =3D info.ocv_table[0];
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
> +
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
> +
> +static int sc27xx_fgu_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct power_supply_config fgu_cfg =3D { };
> +	struct sc27xx_fgu_data *data;
> +	int ret, irq;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!data->regmap) {
> +		dev_err(&pdev->dev, "failed to get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D of_property_read_u32(np, "reg", &data->base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to get fgu address\n");
> +		return ret;
> +	}

Can you please use device_property_read_u32() instead.
If I didn't miss anything you can drop #include <linux/of.h> afterwards.

-- Sebastian

> +	data->channel =3D devm_iio_channel_get(&pdev->dev, "bat-temp");
> +	if (IS_ERR(data->channel)) {
> +		dev_err(&pdev->dev, "failed to get IIO channel\n");
> +		return PTR_ERR(data->channel);
> +	}
> +
> +	data->gpiod =3D devm_gpiod_get(&pdev->dev, "bat-detect", GPIOD_IN);
> +	if (IS_ERR(data->gpiod)) {
> +		dev_err(&pdev->dev, "failed to get battery detection GPIO\n");
> +		return PTR_ERR(data->gpiod);
> +	}
> +
> +	ret =3D gpiod_get_value_cansleep(data->gpiod);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get gpio state\n");
> +		return ret;
> +	}
> +
> +	data->bat_present =3D !!ret;
> +	mutex_init(&data->lock);
> +	data->dev =3D &pdev->dev;
> +
> +	fgu_cfg.drv_data =3D data;
> +	fgu_cfg.of_node =3D np;
> +	data->battery =3D devm_power_supply_register(&pdev->dev, &sc27xx_fgu_de=
sc,
> +						   &fgu_cfg);
> +	if (IS_ERR(data->battery)) {
> +		dev_err(&pdev->dev, "failed to register power supply\n");
> +		return PTR_ERR(data->battery);
> +	}
> +
> +	ret =3D sc27xx_fgu_hw_init(data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize fgu hardware\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action(&pdev->dev, sc27xx_fgu_disable, data);
> +	if (ret) {
> +		sc27xx_fgu_disable(data);
> +		dev_err(&pdev->dev, "failed to add fgu disable action\n");
> +		return ret;
> +	}
> +
> +	irq =3D gpiod_to_irq(data->gpiod);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "failed to translate GPIO to IRQ\n");
> +		return irq;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					sc27xx_fgu_bat_detection,
> +					IRQF_ONESHOT | IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING,
> +					pdev->name, data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sc27xx_fgu_of_match[] =3D {
> +	{ .compatible =3D "sprd,sc2731-fgu", },
> +	{ }
> +};
> +
> +static struct platform_driver sc27xx_fgu_driver =3D {
> +	.probe =3D sc27xx_fgu_probe,
> +	.driver =3D {
> +		.name =3D "sc27xx-fgu",
> +		.of_match_table =3D sc27xx_fgu_of_match,
> +	}
> +};
> +
> +module_platform_driver(sc27xx_fgu_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum SC27XX PMICs Fual Gauge Unit Driver");
> +MODULE_LICENSE("GPL v2");

--b4cvi4rd3ciwwbr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlurpgQACgkQ2O7X88g7
+poephAAhGyqnDRMF4PtEwvS4ZXi8oSmisnVV1noeo/JDdU0OOfbJ+oGtmY9a8nY
02SYav4eoURXi9mkhwVvU4leqWXkUVPdtgIspETI6DteaICcaIbhmlJN3CUo7+xo
5rvEfHJEO4IbDz4pi2zl861X3ZKh2vmwGKZx52f8HAiqgF9LVI4mjCZJBDlCP6NM
AQ32B/eQhHlDo1DsEF7rsEBMUkVvz/bYzsiv65a7pILWBOGs0K6gZ1Kd7OUjLgVY
KwbRnczkKx9cT1mFlHotShFbJyIrVWLok7lDpYKO8L3PKFsf/X20eARVXyiwR542
7zhd9p1nmZ78p6rOfdXefiS/hzPGm8fAugRWUw74eiFLKF3rMieLYX9pDdUPZNKp
cAUpEp/jMJRXRGvKiJq0HyRdk5w2k7escLk7VDcQaNjevErl7YhJosoOncX42TUL
VVvaUlWdx0dsJj6VClfzzpl6/zc36kbx4TNxwmiyBC5S/nQArwLMwnJTZLA4OvMA
BvcD8W3HJD8NWRXg8INUjHOZHgSclVLxRXi7XeRk6veRP+HvqNHn0oSB7MPj7ulO
VVvq5RbVCHdDg8xZOlrdetBEhrAmL/4OnQDP1Giml19mNLOtf3YXagYRhKr0t+Ml
Jj/OF/VwiiF7w1DReM4UP9xeT99+njvjaj/7kDsjMdYjwrYHyK0=
=+dVa
-----END PGP SIGNATURE-----

--b4cvi4rd3ciwwbr6--
