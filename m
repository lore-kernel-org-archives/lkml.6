Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC221C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3976520868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXn+OuXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeH2Sdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeH2Sdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:33:51 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334FB20867;
        Wed, 29 Aug 2018 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535553395;
        bh=tz0a7y0nIXFLJd1elZRz6sefTgvowlzkLe9fWgrBCZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXn+OuXKsYGuC71h91Nc6uJgGkV6oaojYTv5TEyo58jZh49fFy52CjLr+Tr6WZG6p
         v/CWo/nA6m6gRPIPCBNAjm9e8uDUyQ1u7/HRm1dv9xESwAQebLElUcIvzQHLpO2Q9h
         51YZQNloa5LjKiAt9ekX/yahvCArVb63BQZlDIE8=
Received: by mail-wr1-f41.google.com with SMTP id u12-v6so5058936wrr.4;
        Wed, 29 Aug 2018 07:36:35 -0700 (PDT)
X-Gm-Message-State: APzg51DgYphTlPyKaHlNc/bpxhlq7u3BTZ4fjSNwff2Dl6yQ0Yy+qG8R
        pOuWgx9ep/XfU2h2uef04fmhrrEsMXEtVWzyocs=
X-Google-Smtp-Source: ANB0VdYjoe1KwovcTrbH/gcDEEhGINmjmchSrPOOYNXD6i0zFiSsakWtgjTkcVOK6LJXhskE3oJNIn9HgvS5DZaCgII=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr4241686wrp.184.1535553393691;
 Wed, 29 Aug 2018 07:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
 <e8a3aba289cd2505db4a8891256bf731f32072cd.1535446321.git.baolin.wang@linaro.org>
In-Reply-To: <e8a3aba289cd2505db4a8891256bf731f32072cd.1535446321.git.baolin.wang@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 16:36:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd48mSp5srOzr4FkEgb2aS-nqkt+egxbuMi6qodtO1JYw@mail.gmail.com>
Message-ID: <CAJKOXPd48mSp5srOzr4FkEgb2aS-nqkt+egxbuMi6qodtO1JYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC2731 charger support
To:     baolin.wang@linaro.org
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try one more time... but without HTML from Gmail. Previous mail
bounced from lists.

On Tue, 28 Aug 2018 at 11:04, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch adds the SC2731 PMIC switch charger support.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/power/supply/Kconfig          |    7 +
>  drivers/power/supply/Makefile         |    1 +
>  drivers/power/supply/sc2731_charger.c |  451 +++++++++++++++++++++++++++++++++
>  3 files changed, 459 insertions(+)
>  create mode 100644 drivers/power/supply/sc2731_charger.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ff6dab0..f27cf07 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -645,4 +645,11 @@ config CHARGER_CROS_USBPD
>           what is connected to USB PD ports from the EC and converts
>           that into power_supply properties.
>
> +config CHARGER_SC2731
> +       tristate "Spreadtrum SC2731 charger driver"
> +       depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +       help
> +        Say Y here to enable support for battery charging with SC2731
> +        PMIC chips.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index a26b402..767105b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -85,3 +85,4 @@ obj-$(CONFIG_CHARGER_TPS65217)        += tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)   += axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)       += cros_usbpd-charger.o
> +obj-$(CONFIG_CHARGER_SC2731)   += sc2731_charger.o
> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
> new file mode 100644
> index 0000000..49ae16a
> --- /dev/null
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -0,0 +1,451 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Spreadtrum Communications Inc.
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>

slab.h includes looks not needed.

> +#include <linux/usb/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/extcon.h>

Looks not used.

> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +
> +/* PMIC global registers definition */
> +#define SC2731_CHARGE_STATUS           0xedc
> +#define SC2731_CHARGE_FULL             BIT(4)
> +#define SC2731_MODULE_EN1              0xc0c
> +#define SC2731_CHARGE_EN               BIT(5)
> +
> +/* SC2731 switch charger registers definition */
> +#define SC2731_CHG_CFG0                        0x0
> +#define SC2731_CHG_CFG1                        0x4
> +#define SC2731_CHG_CFG2                        0x8
> +#define SC2731_CHG_CFG3                        0xc
> +#define SC2731_CHG_CFG4                        0x10
> +#define SC2731_CHG_CFG5                        0x28
> +
> +/* SC2731_CHG_CFG0 register definition */
> +#define SC2731_PRECHG_RNG_SHIFT                11
> +#define SC2731_PRECHG_RNG_MASK         GENMASK(12, 11)
> +
> +#define SC2731_TERMINATION_VOL_MASK    GENMASK(2, 1)
> +#define SC2731_TERMINATION_VOL_SHIFT   1
> +#define SC2731_TERMINATION_VOL_CAL_MASK        GENMASK(8, 3)
> +#define SC2731_TERMINATION_VOL_CAL_SHIFT       3
> +#define SC2731_TERMINATION_CUR_MASK    GENMASK(2, 0)
> +
> +#define SC2731_CC_EN                   BIT(13)
> +#define SC2731_CHARGER_PD              BIT(0)
> +
> +/* SC2731_CHG_CFG1 register definition */
> +#define SC2731_CUR_MASK                        GENMASK(5, 0)
> +
> +/* SC2731_CHG_CFG5 register definition */
> +#define SC2731_CUR_LIMIT_SHIFT         8
> +#define SC2731_CUR_LIMIT_MASK          GENMASK(9, 8)
> +
> +#define SC2731_CURRENT_LIMIT_100       100
> +#define SC2731_CURRENT_LIMIT_500       500
> +#define SC2731_CURRENT_LIMIT_900       900
> +#define SC2731_CURRENT_LIMIT_2000      2000
> +
> +#define SC2731_CURRENT_PRECHG          450
> +#define SC2731_CURRENT_STEP            50

What units are used for all these currents?

> +
> +struct sc2731_charger_info {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct usb_phy *usb_phy;
> +       struct notifier_block usb_notify;
> +       struct power_supply *psy_usb;
> +       bool charging;
> +       u32 base;
> +};
> +
> +static void sc2731_charger_stop_charge(struct sc2731_charger_info *info)
> +{
> +       regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +                          SC2731_CC_EN, 0);
> +
> +       regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +                          SC2731_CHARGER_PD, SC2731_CHARGER_PD);
> +}
> +
> +static int sc2731_charger_start_charge(struct sc2731_charger_info *info)
> +{
> +       int ret;
> +
> +       /* Enable charger constant current mode */
> +       ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +                                SC2731_CC_EN, SC2731_CC_EN);
> +       if (ret)
> +               return ret;
> +
> +       /* Start charging */
> +       return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +                                 SC2731_CHARGER_PD, 0);
> +}
> +
> +static int sc2731_charger_set_current_limit(struct sc2731_charger_info *info,
> +                                           u32 limit)
> +{
> +       u32 val;
> +
> +       if (limit <= SC2731_CURRENT_LIMIT_100)
> +               val = 0;
> +       else if (limit <= SC2731_CURRENT_LIMIT_500)
> +               val = 3;
> +       else if (limit <= SC2731_CURRENT_LIMIT_900)
> +               val = 2;
> +       else
> +               val = 1;
> +
> +       return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG5,
> +                                 SC2731_CUR_LIMIT_MASK,
> +                                 val << SC2731_CUR_LIMIT_SHIFT);
> +}
> +
> +static int sc2731_charger_set_current(struct sc2731_charger_info *info, u32 cur)
> +{
> +       u32 val;
> +       int ret;
> +
> +       if (cur > SC2731_CURRENT_LIMIT_2000)
> +               cur = SC2731_CURRENT_LIMIT_2000;
> +       else if (cur < SC2731_CURRENT_PRECHG)
> +               cur = SC2731_CURRENT_PRECHG;
> +
> +       /* Calculte the step value, each step is 50 mA */

s/Calculte/Calculate/

> +       val = (cur - SC2731_CURRENT_PRECHG) / SC2731_CURRENT_STEP;
> +
> +       /* Set pre-charge current as 450 mA */
> +       ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +                                SC2731_PRECHG_RNG_MASK,
> +                                0x3 << SC2731_PRECHG_RNG_SHIFT);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG1,
> +                                 SC2731_CUR_MASK, val);
> +}
> +
> +static int sc2731_charger_get_status(struct sc2731_charger_info *info)
> +{
> +       u32 val;
> +       int ret;
> +
> +       ret = regmap_read(info->regmap, SC2731_CHARGE_STATUS, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val & SC2731_CHARGE_FULL)
> +               return POWER_SUPPLY_STATUS_FULL;
> +
> +       return POWER_SUPPLY_STATUS_CHARGING;
> +}
> +
> +static int sc2731_charger_get_current(struct sc2731_charger_info *info,
> +                                     u32 *cur)
> +{
> +       int ret;
> +       u32 val;
> +
> +       ret = regmap_read(info->regmap, info->base + SC2731_CHG_CFG1, &val);
> +       if (ret)
> +               return ret;
> +
> +       val &= SC2731_CUR_MASK;
> +       *cur = val * SC2731_CURRENT_STEP + SC2731_CURRENT_PRECHG;

One empty line please.

> +       return 0;
> +}
> +
> +static int sc2731_charger_get_current_limit(struct sc2731_charger_info *info,
> +                                           u32 *cur)
> +{
> +       int ret;
> +       u32 val;
> +
> +       ret = regmap_read(info->regmap, info->base + SC2731_CHG_CFG5, &val);
> +       if (ret)
> +               return ret;
> +
> +       val = (val & SC2731_CUR_LIMIT_MASK) >> SC2731_CUR_LIMIT_SHIFT;
> +
> +       switch (val) {
> +       case 0:
> +               *cur = SC2731_CURRENT_LIMIT_100;
> +               break;
> +
> +       case 1:
> +               *cur = SC2731_CURRENT_LIMIT_2000;
> +               break;
> +
> +       case 2:
> +               *cur = SC2731_CURRENT_LIMIT_900;
> +               break;
> +
> +       case 3:
> +               *cur = SC2731_CURRENT_LIMIT_500;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +sc2731_charger_usb_set_property(struct power_supply *psy,
> +                               enum power_supply_property psp,
> +                               const union power_supply_propval *val)
> +{
> +       struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
> +       int ret;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +               ret = sc2731_charger_set_current(info, val->intval);
> +               if (ret < 0)
> +                       dev_warn(info->dev, "set charge current failed\n");
> +               break;
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret = sc2731_charger_set_current_limit(info, val->intval);
> +               if (ret < 0)
> +                       dev_warn(info->dev, "set input current limit failed\n");
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int sc2731_charger_usb_get_property(struct power_supply *psy,
> +                                          enum power_supply_property psp,
> +                                          union power_supply_propval *val)
> +{
> +       struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
> +       u32 cur;
> +       int ret;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_STATUS:
> +               if (info->charging)
> +                       val->intval = sc2731_charger_get_status(info);
> +               else
> +                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               break;
> +
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +               if (!info->charging) {
> +                       val->intval = 0;
> +                       break;
> +               }
> +
> +               ret = sc2731_charger_get_current(info, &cur);
> +               if (ret)
> +                       return ret;
> +
> +               val->intval = cur;
> +               break;
> +
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               if (!info->charging) {
> +                       val->intval = 0;
> +                       break;
> +               }
> +
> +               ret = sc2731_charger_get_current_limit(info, &cur);
> +               if (ret)
> +                       return ret;
> +
> +               val->intval = cur;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sc2731_charger_property_is_writeable(struct power_supply *psy,
> +                                               enum power_supply_property psp)
> +{
> +       int ret;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret = 1;
> +               break;
> +       default:
> +               ret = 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static enum power_supply_property sc2731_usb_props[] = {
> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
> +static const struct power_supply_desc sc2731_charger_desc = {
> +       .name                   = "sc2731_charger",
> +       .type                   = POWER_SUPPLY_TYPE_USB,
> +       .properties             = sc2731_usb_props,
> +       .num_properties         = ARRAY_SIZE(sc2731_usb_props),
> +       .get_property           = sc2731_charger_usb_get_property,
> +       .set_property           = sc2731_charger_usb_set_property,
> +       .property_is_writeable  = sc2731_charger_property_is_writeable,
> +};
> +
> +static int sc2731_charger_usb_change(struct notifier_block *nb,
> +                                    unsigned long limit, void *data)
> +{
> +       struct sc2731_charger_info *info =
> +               container_of(nb, struct sc2731_charger_info, usb_notify);
> +       int ret;
> +
> +       /* set current limitation and start to charge */
> +       if (limit > 0) {
> +               ret = sc2731_charger_set_current_limit(info, limit);
> +               if (ret)
> +                       return ret;
> +
> +               ret = sc2731_charger_set_current(info, limit);
> +               if (ret)
> +                       return ret;
> +
> +               ret = sc2731_charger_start_charge(info);
> +               if (ret)
> +                       return ret;
> +
> +               info->charging = true;
> +               return 0;
> +       }
> +
> +       /* Stop charging */
> +       sc2731_charger_stop_charge(info);
> +       info->charging = false;

Here and in other places (get_property) you depend on information from
USB phy. But maybe your device already provides information whether it
is charging or not. It should be more accurate.

> +
> +       return 0;
> +}
> +
> +static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
> +{
> +       int ret;
> +
> +       /* Enable charger module */
> +       ret = regmap_update_bits(info->regmap, SC2731_MODULE_EN1,
> +                                SC2731_CHARGE_EN, SC2731_CHARGE_EN);
> +       if (ret)
> +               return ret;
> +
> +       /* Set default charge termination current to 120 mA */
> +       ret = regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG2,
> +                                SC2731_TERMINATION_CUR_MASK, 0x2);

Looks like DeviceTree property.

> +       if (ret)
> +               goto error;
> +
> +       /* Set default charge termination voltage to 4.35V */

Looks like DeviceTree property.

Best regards,
Krzysztof
