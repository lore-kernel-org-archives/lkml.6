Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492CE20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsaM/4/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492CE20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJVOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:11:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38594 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJVOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:11:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so13611141lfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 22:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fbOYDlWEAtHkr+Lv5rUhJ7L8LehH9g4nxatJzAy85Gw=;
        b=EsaM/4/v8FfkWSmiCH1SDFfRJzIqIv4qE7o3bZ0syUc1qT0fSltMFnP1w+k5y83RNW
         h5bmH6ZLNk+WnsR2CRLwuGxHvuC3LLWX7m1K6UR/CcNYZbsQGpy6hjcvfTo6OGebRhe8
         ilmNb2EMvdLFisMRRm5ySgVDf9fxZyNBmIDJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fbOYDlWEAtHkr+Lv5rUhJ7L8LehH9g4nxatJzAy85Gw=;
        b=WFjbb+vSyJVgp85ajDxT6IrVY8VX2EWpJEdgT9cQTb4u8bfFv+nqh+nXsdO8cAIVWm
         yXAG5wQ6oCTtetizT60Wz+dgOdwilFwpK81vY6SXVAqOgHNCZKDUUDsAJbasUCnozsx9
         X4QrEeSmZQAoD++PcAkWlSKikENlNpiirjUsWMRWBDIXfif1DEW6kySwnayw3g+nQo/n
         0n3qc1lp9mFnQ/5exJxeabU9+sIS+lC48IBbC7e285rJDLyB0wDhm14zHmUMIIi48URI
         DJv0z6QeUSK/flR3m3QiVIUZ83sXJ/++Fs7LEH/hiqZ3QwWFlSUGLbIRY5YNkQUSJtqg
         kbVQ==
X-Gm-Message-State: ABuFfoiFlIsoijO5zvLSfVqpiKKVCQynwEwMS07lgd1M48GfqKggGRJd
        hKpCKrOPBnzutU+Nczrfm5b8ryfDM9VOcSnWEd/ySw==
X-Google-Smtp-Source: ACcGV63g+E0Kj8LpuKFfOvlnJULfoofuNFYu1bVQxTar0+sh44aM1oa2RhH6G7VPUuoNWyEwAtmuU1//GZx+SinRQac=
X-Received: by 2002:a19:2203:: with SMTP id i3mr7809207lfi.2.1540187690602;
 Sun, 21 Oct 2018 22:54:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Sun, 21 Oct 2018 22:54:50
 -0700 (PDT)
In-Reply-To: <20181021165201.wob4iar5sd263wkg@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <2983281f449d180d008c2f49133088a12ea4046d.1539915051.git.baolin.wang@linaro.org>
 <20181021165201.wob4iar5sd263wkg@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 22 Oct 2018 13:54:50 +0800
Message-ID: <CAMz4kuKt-=TGZGEr+n9d1yALhaRe1-_Da23QYojk_ZPmhzz9Vg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 22 October 2018 at 00:52, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Fri, Oct 19, 2018 at 06:53:15PM +0800, Baolin Wang wrote:
>> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
>> which is used to calculate the battery capacity.
>>
>> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>
> Looks mostly good. I have a few comments still. My plan is to merge
> this early after the merge window, if the final version is finished
> at this point.
>
>> Changes from v4:
>>  - None.
>>
>> Changes from v3:
>>  - None.
>>
>> Changes from v2:
>>  - Use core helper functions to look up OCV capacity table.
>>  - Use device_property_read_u32() instead of of_property_read_u32().
>>  - Add acked tag from Linus.
>>
>> Changes from v1:
>>  - Use battery standard properties to get internal resistance and ocv table.
>>  - Change devm_gpiod_get_optional() to devm_gpiod_get().
>>  - Add power_supply_changed() when detecting battery present change.
>>  - Return micro volts for sc27xx_fgu_get_vbat_ocv().
>> ---
>>  drivers/power/supply/Kconfig             |    7 +
>>  drivers/power/supply/Makefile            |    1 +
>>  drivers/power/supply/sc27xx_fuel_gauge.c |  661 ++++++++++++++++++++++++++++++
>>  3 files changed, 669 insertions(+)
>>  create mode 100644 drivers/power/supply/sc27xx_fuel_gauge.c
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index f27cf07..917f4b7 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -652,4 +652,11 @@ config CHARGER_SC2731
>>        Say Y here to enable support for battery charging with SC2731
>>        PMIC chips.
>>
>> +config FUEL_GAUGE_SC27XX
>> +     tristate "Spreadtrum SC27XX fuel gauge driver"
>> +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
>> +     help
>> +      Say Y here to enable support for fuel gauge with SC27XX
>> +      PMIC chips.
>> +
>>  endif # POWER_SUPPLY
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index 767105b..b731c2a 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -86,3 +86,4 @@ obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
>>  obj-$(CONFIG_AXP288_CHARGER) += axp288_charger.o
>>  obj-$(CONFIG_CHARGER_CROS_USBPD)     += cros_usbpd-charger.o
>>  obj-$(CONFIG_CHARGER_SC2731) += sc2731_charger.o
>> +obj-$(CONFIG_FUEL_GAUGE_SC27XX)      += sc27xx_fuel_gauge.o
>> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
>> new file mode 100644
>> index 0000000..1c0b856
>> --- /dev/null
>> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
>> @@ -0,0 +1,661 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2018 Spreadtrum Communications Inc.
>> +
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/iio/consumer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/regmap.h>
>> +
>> +/* PMIC global control registers definition */
>> +#define SC27XX_MODULE_EN0            0xc08
>> +#define SC27XX_CLK_EN0                       0xc18
>> +#define SC27XX_FGU_EN                        BIT(7)
>> +#define SC27XX_FGU_RTC_EN            BIT(6)
>> +
>> +/* FGU registers definition */
>> +#define SC27XX_FGU_START             0x0
>> +#define SC27XX_FGU_CONFIG            0x4
>> +#define SC27XX_FGU_ADC_CONFIG                0x8
>> +#define SC27XX_FGU_STATUS            0xc
>> +#define SC27XX_FGU_INT_EN            0x10
>> +#define SC27XX_FGU_INT_CLR           0x14
>> +#define SC27XX_FGU_INT_STS           0x1c
>> +#define SC27XX_FGU_VOLTAGE           0x20
>> +#define SC27XX_FGU_OCV                       0x24
>> +#define SC27XX_FGU_POCV                      0x28
>> +#define SC27XX_FGU_CURRENT           0x2c
>> +#define SC27XX_FGU_CLBCNT_SETH               0x50
>> +#define SC27XX_FGU_CLBCNT_SETL               0x54
>> +#define SC27XX_FGU_CLBCNT_VALH               0x68
>> +#define SC27XX_FGU_CLBCNT_VALL               0x6c
>> +#define SC27XX_FGU_CLBCNT_QMAXL              0x74
>> +
>> +#define SC27XX_WRITE_SELCLB_EN               BIT(0)
>> +#define SC27XX_FGU_CLBCNT_MASK               GENMASK(15, 0)
>> +#define SC27XX_FGU_CLBCNT_SHIFT              16
>> +
>> +#define SC27XX_FGU_1000MV_ADC                686
>> +#define SC27XX_FGU_1000MA_ADC                1372
>> +#define SC27XX_FGU_CUR_BASIC_ADC     8192
>> +#define SC27XX_FGU_SAMPLE_HZ         2
>> +
>> +/*
>> + * struct sc27xx_fgu_data: describe the FGU device
>> + * @regmap: regmap for register access
>> + * @dev: platform device
>> + * @battery: battery power supply
>> + * @base: the base offset for the controller
>> + * @lock: protect the structure
>> + * @gpiod: GPIO for battery detection
>> + * @channel: IIO channel to get battery temperature
>> + * @internal_resist: the battery internal resistance in mOhm
>> + * @total_cap: the total capacity of the battery in mAh
>> + * @init_cap: the initial capacity of the battery in mAh
>> + * @init_clbcnt: the initial coulomb counter
>> + * @max_volt: the maximum constant input voltage in millivolt
>> + * @table_len: the capacity table length
>> + * @cap_table: capacity table with corresponding ocv
>> + */
>> +struct sc27xx_fgu_data {
>> +     struct regmap *regmap;
>> +     struct device *dev;
>> +     struct power_supply *battery;
>> +     u32 base;
>> +     struct mutex lock;
>> +     struct gpio_desc *gpiod;
>> +     struct iio_channel *channel;
>> +     bool bat_present;
>> +     int internal_resist;
>> +     int total_cap;
>> +     int init_cap;
>> +     int init_clbcnt;
>> +     int max_volt;
>> +     int table_len;
>> +     struct power_supply_battery_ocv_table *cap_table;
>> +};
>> +
>> +static const char * const sc27xx_charger_supply_name[] = {
>> +     "sc2731_charger",
>> +     "sc2720_charger",
>> +     "sc2721_charger",
>> +     "sc2723_charger",
>> +};
>> +
>> +static int sc27xx_fgu_adc_to_current(int adc)
>> +{
>> +     return (adc * 1000) / SC27XX_FGU_1000MA_ADC;
>> +}
>> +
>> +static int sc27xx_fgu_adc_to_voltage(int adc)
>> +{
>> +     return (adc * 1000) / SC27XX_FGU_1000MV_ADC;
>> +}
>> +
>> +/*
>> + * When system boots on, we can not read battery capacity from coulomb
>> + * registers, since now the coulomb registers are invalid. So we should
>> + * calculate the battery open circuit voltage, and get current battery
>> + * capacity according to the capacity table.
>> + */
>> +static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
>> +{
>> +     int volt, cur, oci, ocv, ret;
>> +
>> +     /*
>> +      * After system booting on, the SC27XX_FGU_CLBCNT_QMAXL register saved
>> +      * the first sampled open circuit current.
>> +      */
>> +     ret = regmap_read(data->regmap, data->base + SC27XX_FGU_CLBCNT_QMAXL,
>> +                       &cur);
>> +     if (ret)
>> +             return ret;
>> +
>> +     cur <<= 1;
>> +     oci = sc27xx_fgu_adc_to_current(cur - SC27XX_FGU_CUR_BASIC_ADC);
>> +
>> +     /*
>> +      * Should get the OCV from SC27XX_FGU_POCV register at the system
>> +      * beginning. It is ADC values reading from registers which need to
>> +      * convert the corresponding voltage.
>> +      */
>> +     ret = regmap_read(data->regmap, data->base + SC27XX_FGU_POCV, &volt);
>> +     if (ret)
>> +             return ret;
>> +
>> +     volt = sc27xx_fgu_adc_to_voltage(volt);
>> +     ocv = volt - (oci * data->internal_resist) / 1000;
>> +
>> +     /*
>> +      * Parse the capacity table to look up the correct capacity percent
>> +      * according to current battery's corresponding OCV values.
>> +      */
>> +     *cap = power_supply_ocv2cap_simple(data->cap_table, data->table_len,
>> +                                        ocv);
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcnt)
>> +{
>> +     int ret;
>> +
>> +     clbcnt *= SC27XX_FGU_SAMPLE_HZ;
>> +
>> +     ret = regmap_update_bits(data->regmap,
>> +                              data->base + SC27XX_FGU_CLBCNT_SETL,
>> +                              SC27XX_FGU_CLBCNT_MASK, clbcnt);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_update_bits(data->regmap,
>> +                              data->base + SC27XX_FGU_CLBCNT_SETH,
>> +                              SC27XX_FGU_CLBCNT_MASK,
>> +                              clbcnt >> SC27XX_FGU_CLBCNT_SHIFT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return regmap_update_bits(data->regmap, data->base + SC27XX_FGU_START,
>> +                              SC27XX_WRITE_SELCLB_EN,
>> +                              SC27XX_WRITE_SELCLB_EN);
>> +}
>> +
>> +static int sc27xx_fgu_get_clbcnt(struct sc27xx_fgu_data *data, int *clb_cnt)
>> +{
>> +     int ccl, cch, ret;
>> +
>> +     ret = regmap_read(data->regmap, data->base + SC27XX_FGU_CLBCNT_VALL,
>> +                       &ccl);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_read(data->regmap, data->base + SC27XX_FGU_CLBCNT_VALH,
>> +                       &cch);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *clb_cnt = ccl & SC27XX_FGU_CLBCNT_MASK;
>> +     *clb_cnt |= (cch & SC27XX_FGU_CLBCNT_MASK) << SC27XX_FGU_CLBCNT_SHIFT;
>> +     *clb_cnt /= SC27XX_FGU_SAMPLE_HZ;
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *cap)
>> +{
>> +     int ret, cur_clbcnt, delta_clbcnt, delta_cap, temp;
>> +
>> +     /* Get current coulomb counters firstly */
>> +     ret = sc27xx_fgu_get_clbcnt(data, &cur_clbcnt);
>> +     if (ret)
>> +             return ret;
>> +
>> +     delta_clbcnt = cur_clbcnt - data->init_clbcnt;
>> +
>> +     /*
>> +      * Convert coulomb counter to delta capacity (mAh), and set multiplier
>> +      * as 100 to improve the precision.
>> +      */
>> +     temp = DIV_ROUND_CLOSEST(delta_clbcnt, 360);
>> +     temp = sc27xx_fgu_adc_to_current(temp);
>> +
>> +     /*
>> +      * Convert to capacity percent of the battery total capacity,
>> +      * and multiplier is 100 too.
>> +      */
>> +     delta_cap = DIV_ROUND_CLOSEST(temp * 100, data->total_cap);
>> +     *cap = delta_cap + data->init_cap;
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_get_vbat_vol(struct sc27xx_fgu_data *data, int *val)
>> +{
>> +     int ret, vol;
>> +
>> +     ret = regmap_read(data->regmap, data->base + SC27XX_FGU_VOLTAGE, &vol);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * It is ADC values reading from registers which need to convert to
>> +      * corresponding voltage values.
>> +      */
>> +     *val = sc27xx_fgu_adc_to_voltage(vol);
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_get_current(struct sc27xx_fgu_data *data, int *val)
>> +{
>> +     int ret, cur;
>> +
>> +     ret = regmap_read(data->regmap, data->base + SC27XX_FGU_CURRENT, &cur);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * It is ADC values reading from registers which need to convert to
>> +      * corresponding current values.
>> +      */
>> +     *val = sc27xx_fgu_adc_to_current(cur - SC27XX_FGU_CUR_BASIC_ADC);
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
>> +{
>> +     int vol, cur, ret;
>> +
>> +     ret = sc27xx_fgu_get_vbat_vol(data, &vol);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = sc27xx_fgu_get_current(data, &cur);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Return the battery OCV in micro volts. */
>> +     *val = vol * 1000 - cur * data->internal_resist;
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_get_temp(struct sc27xx_fgu_data *data, int *temp)
>> +{
>> +     return iio_read_channel_processed(data->channel, temp);
>> +}
>> +
>> +static int sc27xx_fgu_get_health(struct sc27xx_fgu_data *data, int *health)
>> +{
>> +     int ret, vol;
>> +
>> +     ret = sc27xx_fgu_get_vbat_vol(data, &vol);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (vol > data->max_volt)
>> +             *health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>> +     else
>> +             *health = POWER_SUPPLY_HEALTH_GOOD;
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_get_status(struct sc27xx_fgu_data *data, int *status)
>> +{
>> +     union power_supply_propval val;
>> +     struct power_supply *psy;
>> +     int i, ret = -EINVAL;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(sc27xx_charger_supply_name); i++) {
>> +             psy = power_supply_get_by_name(sc27xx_charger_supply_name[i]);
>> +             if (!psy)
>> +                     continue;
>> +
>> +             ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS,
>> +                                             &val);
>> +             power_supply_put(psy);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             *status = val.intval;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int sc27xx_fgu_get_property(struct power_supply *psy,
>> +                                enum power_supply_property psp,
>> +                                union power_supply_propval *val)
>> +{
>> +     struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
>> +     int ret = 0;
>> +     int value;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     switch (psp) {
>> +     case POWER_SUPPLY_PROP_STATUS:
>> +             ret = sc27xx_fgu_get_status(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_HEALTH:
>> +             ret = sc27xx_fgu_get_health(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_PRESENT:
>> +             val->intval = data->bat_present;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_TEMP:
>> +             ret = sc27xx_fgu_get_temp(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_TECHNOLOGY:
>> +             val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_CAPACITY:
>> +             ret = sc27xx_fgu_get_capacity(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +             ret = sc27xx_fgu_get_vbat_vol(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value * 1000;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_VOLTAGE_OCV:
>> +             ret = sc27xx_fgu_get_vbat_ocv(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value;
>> +             break;
>> +
>> +     case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +     case POWER_SUPPLY_PROP_CURRENT_AVG:
>> +             ret = sc27xx_fgu_get_current(data, &value);
>> +             if (ret)
>> +                     goto error;
>> +
>> +             val->intval = value * 1000;
>> +             break;
>> +
>> +     default:
>> +             ret = -EINVAL;
>> +             break;
>> +     }
>> +
>> +error:
>> +     mutex_unlock(&data->lock);
>> +     return ret;
>> +}
>> +
>> +static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
>> +{
>> +     struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
>> +
>> +     power_supply_changed(data->battery);
>> +}
>> +
>> +static enum power_supply_property sc27xx_fgu_props[] = {
>> +     POWER_SUPPLY_PROP_STATUS,
>> +     POWER_SUPPLY_PROP_HEALTH,
>> +     POWER_SUPPLY_PROP_PRESENT,
>> +     POWER_SUPPLY_PROP_TEMP,
>> +     POWER_SUPPLY_PROP_TECHNOLOGY,
>> +     POWER_SUPPLY_PROP_CAPACITY,
>> +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +     POWER_SUPPLY_PROP_VOLTAGE_OCV,
>> +     POWER_SUPPLY_PROP_CURRENT_NOW,
>> +     POWER_SUPPLY_PROP_CURRENT_AVG,
>> +};
>> +
>> +static const struct power_supply_desc sc27xx_fgu_desc = {
>> +     .name                   = "sc27xx-fgu",
>> +     .type                   = POWER_SUPPLY_TYPE_BATTERY,
>> +     .properties             = sc27xx_fgu_props,
>> +     .num_properties         = ARRAY_SIZE(sc27xx_fgu_props),
>> +     .get_property           = sc27xx_fgu_get_property,
>> +     .external_power_changed = sc27xx_fgu_external_power_changed,
>> +};
>> +
>> +static irqreturn_t sc27xx_fgu_bat_detection(int irq, void *dev_id)
>> +{
>> +     struct sc27xx_fgu_data *data = dev_id;
>> +     int state;
>> +
>> +     mutex_lock(&data->lock);
>> +
>> +     state = gpiod_get_value_cansleep(data->gpiod);
>> +     if (state < 0) {
>> +             dev_err(data->dev, "failed to get gpio state\n");
>> +             mutex_unlock(&data->lock);
>> +             return IRQ_RETVAL(state);
>> +     }
>> +
>> +     data->bat_present = !!state;
>> +
>> +     mutex_unlock(&data->lock);
>> +
>> +     power_supply_changed(data->battery);
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static void sc27xx_fgu_disable(void *_data)
>> +{
>> +     struct sc27xx_fgu_data *data = _data;
>> +
>> +     regmap_update_bits(data->regmap, SC27XX_CLK_EN0, SC27XX_FGU_RTC_EN, 0);
>> +     regmap_update_bits(data->regmap, SC27XX_MODULE_EN0, SC27XX_FGU_EN, 0);
>> +}
>> +
>> +static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity)
>> +{
>> +     /*
>> +      * Get current capacity (mAh) = battery total capacity (mAh) *
>> +      * current capacity percent (capacity / 100).
>> +      */
>> +     int cur_cap = DIV_ROUND_CLOSEST(data->total_cap * capacity, 100);
>> +
>> +     /*
>> +      * Convert current capacity (mAh) to coulomb counter according to the
>> +      * formula: 1 mAh =3.6 coulomb.
>> +      */
>> +     return DIV_ROUND_CLOSEST(cur_cap * 36, 10);
>> +}
>> +
>> +static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
>> +{
>> +     struct power_supply_battery_info info = { };
>> +     struct power_supply_battery_ocv_table *table;
>> +     int ret, i;
>> +
>> +     ret = power_supply_get_battery_info(data->battery, &info);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to get battery information\n");
>> +             return ret;
>> +     }
>> +
>> +     data->total_cap = info.charge_full_design_uah / 1000;
>> +     data->max_volt = info.constant_charge_voltage_max_uv / 1000;
>> +     data->internal_resist = info.factory_internal_resistance_uohm / 1000;
>> +
>> +     /*
>> +      * For SC27XX fuel gauge device, we only use one ocv-capacity
>> +      * table in normal temperature 20 Celsius.
>> +      */
>> +     table = power_supply_find_ocv2cap_table(&info, 20, &data->table_len);
>> +     if (!table)
>> +             return -EINVAL;
>> +
>> +     data->cap_table = devm_kzalloc(data->dev,
>> +                                    data->table_len * sizeof(*table),
>> +                                    GFP_KERNEL);
>> +     if (!data->cap_table) {
>> +             power_supply_put_battery_info(data->battery, &info);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     for (i = 0; i < data->table_len; i++) {
>> +             data->cap_table[i].ocv = table[i].ocv / 1000;
>> +             data->cap_table[i].capacity = table[i].capacity;
>> +     }
>
> Don't divide the OCV by 1000. You feed this table into the
> generic power-supply function later, which should always
> get uV. Instead multiply the ocv parameter in your
> power_supply_ocv2cap_simple() call with 1000. This
> means you can just use devm_kmemdup() here.

Good point. Will change it in next version.

>
> Some ideas for later (I'm fine with merging the driver
> without these changes):
>
>  * Store battery_info directly in private driver data
>    instead of doing a copy of the temperature table.
>  * Call power_supply_ocv2cap() with current battery
>    temperature and let the power-supply core figure
>    out which ocv-to-capacity curve should be used.

I should keep my original method, since we have no temperature table
now and only use one room temperature (20 degree). Thanks for your
useful comments.

-- 
Baolin Wang
Best Regards
