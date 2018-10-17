Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1316921523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1316921523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJQOHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:07:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41747 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:07:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id x31-v6so23664341edd.8;
        Tue, 16 Oct 2018 23:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5pUGGV8ybD9pUNx6d59Rl5A0ZkqVrd9KjHYob1JJ+E=;
        b=jAC3lSJn18C7/XeYJYcLT4KpTwP3U//RsNsHY2botPLjD536Qhu4eO7R+p4QLZc9uQ
         R1yjs8QCWUcmnAulThwnetOcy3r+AETZy8Y59be5FtjOCY6JMxkbMrMjKD9gE9X0yYVk
         9uHP51akdwZ9aDLPcuraNk0CCvOAqmYP0O08cADGudq6KMM16zXR1zhvjgB8AIam6BAs
         +gm8EmOg/0NduGKf61TiayMBaGZZs9XHzZnsJwuRjwuu0knv2orfGZYW59tohTYbsBE/
         uxIJFyTbjZ3XZ61QfsqjbGDZl78VIHpNj8oZF56kcwKddYfdFlypjnruhbEsqYO+KvyG
         ZSTg==
X-Gm-Message-State: ABuFfoj9ZWR/FNQa9eBsJr1qVbOmOWl1yviaddDsLP7pqm8ewyiUXmaB
        sKXPorBwYXTjwVtADoYHABCelTqt
X-Google-Smtp-Source: ACcGV61LxQY+fIbFxWsJPcPCVJsEa7AunTixCwJo3Pd1l+5U9b48IUA6dxcJ0iwTcyu5ZwrnQoB2ZQ==
X-Received: by 2002:a50:930e:: with SMTP id m14-v6mr33778470eda.114.1539756792463;
        Tue, 16 Oct 2018 23:13:12 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id y32-v6sm6197420edb.66.2018.10.16.23.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 23:13:12 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id d2-v6so28166354wro.7;
        Tue, 16 Oct 2018 23:13:12 -0700 (PDT)
X-Received: by 2002:a5d:5649:: with SMTP id j9-v6mr20562063wrw.41.1539756791392;
 Tue, 16 Oct 2018 23:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-6-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-6-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 17 Oct 2018 14:12:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v646PM4s+MvFt3MRS7g6O7_DBw8Jha24dd=a0DmMsvcAoQ@mail.gmail.com>
Message-ID: <CAGb2v646PM4s+MvFt3MRS7g6O7_DBw8Jha24dd=a0DmMsvcAoQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] power: supply: add AC power supply driver for AXP813
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP813 and AXP803 PMICs can control input current and
> minimum voltage.
>
> Both of these values are configurable.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 92 ++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h             |  1 +
>  2 files changed, 93 insertions(+)
>
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
> index 0771f951b11f..059a97d6e14c 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -27,6 +27,16 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL   BIT(6)
>
> +#define AXP813_VHOLD_MASK              GENMASK(5, 3)
> +#define AXP813_VHOLD_UV_TO_BIT(x)      ((((x) / 100000) - 40) << 3)
> +#define AXP813_VHOLD_REG_TO_UV(x)      \
> +       (((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
> +
> +#define AXP813_CURR_LIMIT_MASK         GENMASK(2, 0)
> +#define AXP813_CURR_LIMIT_UA_TO_BIT(x) (((x) / 500000) - 3)
> +#define AXP813_CURR_LIMIT_REG_TO_UA(x) \
> +       ((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
> +
>  #define DRVNAME "axp20x-ac-power-supply"
>
>  struct axp20x_ac_power {
> @@ -102,6 +112,55 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
>
>                 return 0;
>
> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +               ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +               if (ret)
> +                       return ret;
> +
> +               val->intval = AXP813_VHOLD_REG_TO_UV(reg);
> +
> +               return 0;
> +
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +               if (ret)
> +                       return ret;
> +
> +               val->intval = AXP813_CURR_LIMIT_REG_TO_UA(reg);

This doesn't handle the case where the register value is set to 0x6 or 0x7,
which should still mean 4000 mA.

> +
> +               return 0;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int axp813_ac_power_set_property(struct power_supply *psy,
> +                                       enum power_supply_property psp,
> +                                       const union power_supply_propval *val)
> +{
> +       struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +               if (val->intval < 4000000 || val->intval > 4700000)
> +                       return -EINVAL;
> +
> +               return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
> +                                         AXP813_VHOLD_MASK,
> +                                         AXP813_VHOLD_UV_TO_BIT(val->intval));
> +
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               if (val->intval < 1500000 || val->intval > 4000000)
> +                       return -EINVAL;
> +
> +               return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
> +                                         AXP813_CURR_LIMIT_MASK,
> +                                         AXP813_CURR_LIMIT_UA_TO_BIT
> +                                         (val->intval));

Nit, don't wrap this part. Even if it exceeds the 80 character limit, it's
still easier to read that way.

ChenYu

> +
>         default:
>                 return -EINVAL;
>         }
> @@ -109,6 +168,13 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
>         return -EINVAL;
>  }
>
> +static int axp813_ac_power_prop_writeable(struct power_supply *psy,
> +                                         enum power_supply_property psp)
> +{
> +       return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> +              psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> +}
> +
>  static enum power_supply_property axp20x_ac_power_properties[] = {
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_PRESENT,
> @@ -123,6 +189,14 @@ static enum power_supply_property axp22x_ac_power_properties[] = {
>         POWER_SUPPLY_PROP_ONLINE,
>  };
>
> +static enum power_supply_property axp813_ac_power_properties[] = {
> +       POWER_SUPPLY_PROP_HEALTH,
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
>  static const struct power_supply_desc axp20x_ac_power_desc = {
>         .name = "axp20x-ac",
>         .type = POWER_SUPPLY_TYPE_MAINS,
> @@ -139,6 +213,16 @@ static const struct power_supply_desc axp22x_ac_power_desc = {
>         .get_property = axp20x_ac_power_get_property,
>  };
>
> +static const struct power_supply_desc axp813_ac_power_desc = {
> +       .name = "axp813-ac",
> +       .type = POWER_SUPPLY_TYPE_MAINS,
> +       .properties = axp813_ac_power_properties,
> +       .num_properties = ARRAY_SIZE(axp813_ac_power_properties),
> +       .property_is_writeable = axp813_ac_power_prop_writeable,
> +       .get_property = axp20x_ac_power_get_property,
> +       .set_property = axp813_ac_power_set_property,
> +};
> +
>  struct axp_data {
>         const struct power_supply_desc  *power_desc;
>         bool                            acin_adc;
> @@ -154,6 +238,11 @@ static const struct axp_data axp22x_data = {
>         .acin_adc = false,
>  };
>
> +static const struct axp_data axp813_data = {
> +       .power_desc = &axp813_ac_power_desc,
> +       .acin_adc = false,
> +};
> +
>  static int axp20x_ac_power_probe(struct platform_device *pdev)
>  {
>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> @@ -234,6 +323,9 @@ static const struct of_device_id axp20x_ac_power_match[] = {
>         }, {
>                 .compatible = "x-powers,axp221-ac-power-supply",
>                 .data = &axp22x_data,
> +       }, {
> +               .compatible = "x-powers,axp813-ac-power-supply",
> +               .data = &axp813_data,
>         }, { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 517e60eecbcb..2302b620d238 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -266,6 +266,7 @@ enum axp20x_variants {
>  #define AXP288_RT_BATT_V_H             0xa0
>  #define AXP288_RT_BATT_V_L             0xa1
>
> +#define AXP813_ACIN_PATH_CTRL          0x3a
>  #define AXP813_ADC_RATE                        0x85
>
>  /* Fuel Gauge */
> --
> 2.17.1
>
