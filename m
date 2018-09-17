Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F9B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJxUemSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F9B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIQJ1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:27:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44800 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeIQJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:27:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so9896083oth.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=milZay74NtxS5fe+HT5EG/E5HKc+bqrfz2qj3ZgHSuE=;
        b=KJxUemSed+BP6t4fpaeLUcOahUsgNq8hbTjoQiDVX2+q7GRtStv2YJn0vZuGEU3Te8
         7bKVm8NLh9bvnH0hnk4zyLWQnEEyxvznjBbYs7BHZO/WJAqS4ANI4Tcnj2E3sp8g9D9J
         MRP8Zey4BiD+Yq+ubk1FD+yc+cUaNJdymINFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=milZay74NtxS5fe+HT5EG/E5HKc+bqrfz2qj3ZgHSuE=;
        b=jT3U6d4Ye3nK1ccX+Hv5itrezuwigQDavCHgOxjfLjWrWM09qssrkDmWj/i5AFFbfG
         in1uQKoZ39dOOGUHDp9Ga/vmz5K3q9KfsByEbbq5iGhLTbqeWOzQ72L8QbCorexKYTFA
         rZQ2+Z5gibBO95kWr5PCKjN7AKL26fjnQ6gXJ54MsxSPKVVEeRovzvynGq5qisYT1xXj
         pcOHkMG4riLjK+Z3VfTRZrEbYO/bvpcwdjzEhf7kyhbq2bNaJH+zoCXqt0JJ5O0nnzZh
         4wlYhDxQ36uBq/b/Ymu5z1c62gsoNMnGLz1o8CyrOYEYfahGhFrZ/k3yg9iq6hkXg+ys
         oMZg==
X-Gm-Message-State: APzg51AwKfaUJYUrzFC8r3FMJH8RjsmAaJm+wcg/arIQwoDBbFETvB7I
        GQr02wNjR3ha1yylA29Rg0kbC6K8Mjglvz9oC0r64Q==
X-Google-Smtp-Source: ANB0VdYujORUkphDihU6aFumPI/FYrGOEe15UUS4JF+CgqutgCQYt7n9CSHGTGo0WM4EjVPee6lrOf+6V5qFByELBUc=
X-Received: by 2002:a9d:40e2:: with SMTP id t31-v6mr10909410oti.335.1537156911979;
 Sun, 16 Sep 2018 21:01:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Sun, 16 Sep 2018 21:01:51
 -0700 (PDT)
In-Reply-To: <20180916143552.3oxjqpo6vravh5cy@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <1295864a38810a6db6c97e298c6663ae2b1350c1.1536736399.git.baolin.wang@linaro.org>
 <20180916143552.3oxjqpo6vravh5cy@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 17 Sep 2018 12:01:51 +0800
Message-ID: <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC27XX fuel gauge unit driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 16 September 2018 at 22:35, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> Looks mostly good. I have a couple of comments in addition to the
> ones from the binding about using battery_info for the OCV ->
> capacity mapping.

OK.

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
>> +     *val = vol - (cur * data->inner_resist) / 1000;
>
> You multiply this with 1000 directly after this function to get back
> to uV. Just drop the division and the multiplication.

But the vol's unit is mV, so I can change to:

 *val = vol * 1000 - cur * data->inner_resist;

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
>> +             val->intval = value * 1000;
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
>> +     if (state)
>> +             data->bat_present = true;
>> +     else
>> +             data->bat_present = false;
>> +
>> +     mutex_unlock(&data->lock);
>
> You want to call power_supply_changed() here.

Ah, right. Missed this.

>
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
>> +     int ret;
>> +
>> +     ret = power_supply_get_battery_info(data->battery, &info);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to get battery information\n");
>> +             return ret;
>> +     }
>> +
>> +     data->total_cap = info.charge_full_design_uah / 1000;
>> +     data->max_volt = info.constant_charge_voltage_max_uv / 1000;
>> +
>> +     /* Enable the FGU module */
>> +     ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN0,
>> +                              SC27XX_FGU_EN, SC27XX_FGU_EN);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to enable fgu\n");
>> +             return ret;
>> +     }
>> +
>> +     /* Enable the FGU RTC clock to make it work */
>> +     ret = regmap_update_bits(data->regmap, SC27XX_CLK_EN0,
>> +                              SC27XX_FGU_RTC_EN, SC27XX_FGU_RTC_EN);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to enable fgu RTC clock\n");
>> +             goto disable_fgu;
>> +     }
>> +
>> +     /*
>> +      * Get the boot battery capacity when system powers on, which is used to
>> +      * initialize the coulomb counter. After that, we can read the coulomb
>> +      * counter to measure the battery capacity.
>> +      */
>> +     ret = sc27xx_fgu_get_boot_capacity(data, &data->init_cap);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to get boot capacity\n");
>> +             goto disable_clk;
>> +     }
>> +
>> +     /*
>> +      * Convert battery capacity to the corresponding initial coulomb counter
>> +      * and set into coulomb counter registers.
>> +      */
>> +     data->init_clbcnt = sc27xx_fgu_cap_to_clbcnt(data, data->init_cap);
>> +     ret = sc27xx_fgu_set_clbcnt(data, data->init_clbcnt);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to initialize coulomb counter\n");
>> +             goto disable_clk;
>> +     }
>> +
>> +     return 0;
>> +
>> +disable_clk:
>> +     regmap_update_bits(data->regmap, SC27XX_CLK_EN0, SC27XX_FGU_RTC_EN, 0);
>> +disable_fgu:
>> +     regmap_update_bits(data->regmap, SC27XX_MODULE_EN0, SC27XX_FGU_EN, 0);
>> +
>> +     return ret;
>> +}
>> +
>> +static int sc27xx_fgu_parse_dt(struct sc27xx_fgu_data *data,
>> +                            struct device_node *np)
>> +{
>> +     const __be32 *list;
>> +     int i, len, size, ret;
>> +
>> +     ret = of_property_read_u32(np, "reg", &data->base);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to get fgu address\n");
>> +             return ret;
>> +     }
>> +
>> +     data->gpiod = devm_gpiod_get_optional(data->dev, "bat-detect", GPIOD_IN);
>> +     if (IS_ERR(data->gpiod)) {
>> +             dev_err(data->dev, "failed to get battery detection GPIO\n");
>> +             return PTR_ERR(data->gpiod);
>> +     }
>
> According to the binding (and the remaining code!) this gpio is not
> optional.

Yes, they are not optional. If we can not get the detection GPIO, we
will return errors. So am I missing something else?

Thanks for your comments.

>
> -- Sebastian
>
>> +     data->channel = devm_iio_channel_get(data->dev, "bat-temp");
>> +     if (IS_ERR(data->channel)) {
>> +             dev_err(data->dev, "failed to get IIO channel\n");
>> +             return PTR_ERR(data->channel);
>> +     }
>> +
>> +     /* Get the battery inner resistance */
>> +     ret = of_property_read_u32(np, "sprd,inner-resist", &data->inner_resist);
>> +     if (ret) {
>> +             dev_err(data->dev, "failed to get battery inner resistance\n");
>> +             return ret;
>> +     }
>> +
>> +     /* Get battery ocv-capacity table */
>> +     list = of_get_property(np, "sprd,ocv-cap-table", &size);
>> +     if (!list || !size) {
>> +             dev_err(data->dev, "failed to get ocv-capacity table\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     len = size / 8;
>> +     data->table_len = len;
>> +     data->cap_table = devm_kzalloc(data->dev,
>> +                             sizeof(struct sc27xx_fgu_capacity_table) * len,
>> +                             GFP_KERNEL);
>> +     if (!data->cap_table)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < len; i++) {
>> +             data->cap_table[i].ocv = be32_to_cpu(*list++);
>> +             data->cap_table[i].capacity = be32_to_cpu(*list++);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int sc27xx_fgu_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct power_supply_config fgu_cfg = { };
>> +     struct sc27xx_fgu_data *data;
>> +     int ret, irq;
>> +
>> +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +     if (!data->regmap) {
>> +             dev_err(&pdev->dev, "failed to get regmap\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     mutex_init(&data->lock);
>> +     data->dev = &pdev->dev;
>> +     data->bat_present = true;
>> +
>> +     ret = sc27xx_fgu_parse_dt(data, np);
>> +     if (ret)
>> +             return ret;
>> +
>> +     fgu_cfg.drv_data = data;
>> +     fgu_cfg.of_node = np;
>> +     data->battery = devm_power_supply_register(&pdev->dev, &sc27xx_fgu_desc,
>> +                                                &fgu_cfg);
>> +     if (IS_ERR(data->battery)) {
>> +             dev_err(&pdev->dev, "failed to register power supply\n");
>> +             return PTR_ERR(data->battery);
>> +     }
>> +
>> +     ret = sc27xx_fgu_hw_init(data);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to initialize fgu hardware\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = devm_add_action(&pdev->dev, sc27xx_fgu_disable, data);
>> +     if (ret) {
>> +             sc27xx_fgu_disable(data);
>> +             dev_err(&pdev->dev, "failed to add fgu disable action\n");
>> +             return ret;
>> +     }
>> +
>> +     irq = gpiod_to_irq(data->gpiod);
>> +     if (irq < 0) {
>> +             dev_err(&pdev->dev, "failed to translate GPIO to IRQ\n");
>> +             return irq;
>> +     }
>> +
>> +     ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>> +                                     sc27xx_fgu_bat_detection,
>> +                                     IRQF_ONESHOT | IRQF_TRIGGER_RISING |
>> +                                     IRQF_TRIGGER_FALLING,
>> +                                     pdev->name, data);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to request IRQ\n");
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id sc27xx_fgu_of_match[] = {
>> +     { .compatible = "sprd,sc2731-fgu", },
>> +     { }
>> +};
>> +
>> +static struct platform_driver sc27xx_fgu_driver = {
>> +     .probe = sc27xx_fgu_probe,
>> +     .driver = {
>> +             .name = "sc27xx-fgu",
>> +             .of_match_table = sc27xx_fgu_of_match,
>> +     }
>> +};
>> +
>> +module_platform_driver(sc27xx_fgu_driver);
>> +
>> +MODULE_DESCRIPTION("Spreadtrum SC27XX PMICs Fual Gauge Unit Driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.7.9.5
>>



-- 
Baolin Wang
Best Regards
