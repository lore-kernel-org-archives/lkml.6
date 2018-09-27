Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CE3208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJKYsNJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CE3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeI0HZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:25:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36466 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeI0HZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:25:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so785159ljb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jR9HQQTP2XO+7Yl8j8FMzABXyO4APhcSamG8NfhKKU4=;
        b=ZJKYsNJCmtL4JSeCtixOdl3q1nZKzKAxs7W95IL40G+E3o41hKyJtStPiWqyAPPYAR
         qEl9Fq4QrmRwWCJl2u78v9GUaU8w/TLIIc3JrDxToTa2AQGNU3h9DXPyuUet59zBEtmE
         fi+Xu0qwn8FLTVg8+RR9x8biPmGjxr8Zg0G38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jR9HQQTP2XO+7Yl8j8FMzABXyO4APhcSamG8NfhKKU4=;
        b=McCH3q6EBGTxvHFnd5x39EX9nSZWHd2W+o89PMF7TiM0vUAutNZAJOiDLapW9PtyHW
         cFh56r2wvyxKW3JVid1lakC4NZApEsA3Ky24yYD1pzj+wcGflGmXTqU9/xOt4WRObBNv
         Om9Cop332EXp394580UmJPkG5NBgGTnqlAR4e8a0Octrct/YNH0PzwGsZFYaSZA9PVm6
         CMl8V7781UMLq5gV32FAfhftoU3LNzG2fTorXtacDRjVru1P8MX35z+SkZVOw6WQHG9g
         K3BxfEFO1vuYAoUbBYutYZAgZaKFF2DC2HNo7TnMq6YxARGBTSh9KHO4jRTTfxyZJ/OR
         Xt1A==
X-Gm-Message-State: ABuFfoiuQW7IKKVaMrBTtrjoCgFJHIHnDFPILbfDkVwoJtdmygsk2nh6
        jXtXUi6WyQ9tvMZKwgIBFKw2IdAW4QcNr2UslR0C3LHcR8IziA==
X-Google-Smtp-Source: ACcGV604/Xna8aaw/carBqqDUAq6Q/eV2ylbLheDUydtVL59xUT2Car4ZpZxg9bR8V8NYp5fBmc6c2JE55uTthufHIE=
X-Received: by 2002:a2e:1510:: with SMTP id s16-v6mr1085160ljd.4.1538010605853;
 Wed, 26 Sep 2018 18:10:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 18:10:05
 -0700 (PDT)
In-Reply-To: <20180926135150.fla2r4ilfco3atws@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
 <20180926135150.fla2r4ilfco3atws@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 27 Sep 2018 09:10:05 +0800
Message-ID: <CAMz4kuK0PGonikK=pH50p=7NFXZHRuMZ+Aq9ZYT+8q8giKZCAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: supply: core: Introduce properties to
 present the battery OCV table
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

On 26 September 2018 at 21:51, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Sep 26, 2018 at 10:59:12AM +0800, Baolin Wang wrote:
>> Some battery driver will use the open circuit voltage (OCV) value to look
>> up the corresponding battery capacity percent in one certain degree Celsius.
>> Thus this patch provides some battery properties to present the OCV table
>> temperatures and OCV capacity table values.
>>
>> Suggested-by: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v1:
>>  - New patch in v2.
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++++
>>  drivers/power/supply/power_supply_core.c           |   63 +++++++++++++++++++-
>>  include/linux/power_supply.h                       |   11 ++++
>>  3 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 25b9d2e..ac2b303 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -23,6 +23,16 @@ Optional Properties:
>>   - constant-charge-current-max-microamp: maximum constant input current
>>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>>   - internal-resistance-micro-ohms: battery internal resistance
>> + - ocv-capacity-table-0: An array providing the battery capacity percent
>> +   with corresponding open circuit voltage (OCV) of the battery, which
>> +   is used to look up battery capacity according to current OCV value.
>> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
>> + ......
>> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
>> + - ocv-capacity-table-temperatures: An array containing the temperature
>> +   in degree Celsius, for each of the battery capacity lookup table.
>> +   The first temperature value specifies the OCV table 0, and the second
>> +   temperature value specifies the OCV table 1, and so on.
>>
>>  Battery properties are named, where possible, for the corresponding
>>  elements in enum power_supply_property, defined in
>> @@ -44,6 +54,10 @@ Example:
>>               constant-charge-current-max-microamp = <900000>;
>>               constant-charge-voltage-max-microvolt = <4200000>;
>>               internal-resistance-micro-ohms = <250000>;
>> +             ocv-capacity-table-temperatures = <(-10) 0 10>;
>> +             ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
>> +             ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
>> +             ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>>       };
>>
>>       charger: charger@11 {
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 9f3452f..151ff03 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -570,7 +570,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  {
>>       struct device_node *battery_np;
>>       const char *value;
>> -     int err;
>> +     int err, len, index;
>>
>>       info->energy_full_design_uwh         = -EINVAL;
>>       info->charge_full_design_uah         = -EINVAL;
>> @@ -581,6 +581,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>       info->constant_charge_voltage_max_uv = -EINVAL;
>>       info->internal_resistance_uohm       = -EINVAL;
>>
>> +     for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
>> +             info->ocv_table[index]       = NULL;
>> +             info->ocv_temp[index]        = -EINVAL;
>> +             info->ocv_table_size[index]  = -EINVAL;
>> +     }
>> +
>>       if (!psy->of_node) {
>>               dev_warn(&psy->dev, "%s currently only supports devicetree\n",
>>                        __func__);
>> @@ -620,10 +626,65 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>       of_property_read_u32(battery_np, "internal-resistance-micro-ohms",
>>                            &info->internal_resistance_uohm);
>>
>> +     len = of_property_count_u32_elems(battery_np,
>> +                                       "ocv-capacity-table-temperatures");
>> +     if (len < 0 && len != -EINVAL) {
>> +             return len;
>> +     } else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
>> +             dev_err(&psy->dev, "Too many temperature values\n");
>> +             return -EINVAL;
>> +     } else if (len > 0) {
>> +             of_property_read_u32_array(battery_np,
>> +                                        "ocv-capacity-table-temperatures",
>> +                                        info->ocv_temp, len);
>> +     }
>> +
>> +     for (index = 0; index < len; index++) {
>> +             struct power_supply_battery_ocv_table *table;
>> +             char *propname;
>> +             const __be32 *list;
>> +             int i, tab_len, size;
>> +
>> +             propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
>> +             list = of_get_property(battery_np, propname, &size);
>> +             kfree(propname);
>> +             if (!list || !size) {
>> +                     dev_err(&psy->dev, "failed to get ocv capacity table\n");
>
> I think it's better to replace "ocv capacity table" with %s / propname.

Yes.

>
>> +                     power_supply_put_battery_info(psy, info);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             tab_len = size / sizeof(*table);
>
> I think this should be
>
> tab_len = size / (2 * sizeof(__be32));
>
> which decouples DT memory layout from kernel memory layout.

Sure.

>
>> +             info->ocv_table_size[index] = tab_len;
>> +
>> +             table = info->ocv_table[index] = devm_kzalloc(&psy->dev,
>> +                                             tab_len * sizeof(*table),
>> +                                             GFP_KERNEL);
>> +             if (!info->ocv_table[index]) {
>> +                     power_supply_put_battery_info(psy, info);
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             for (i = 0; i < tab_len; i++) {
>> +                     table[i].ocv = be32_to_cpu(*list++);
>> +                     table[i].capacity = be32_to_cpu(*list++);
>> +             }
>> +     }
>> +
>>       return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
>>
>> +void power_supply_put_battery_info(struct power_supply *psy,
>> +                                struct power_supply_battery_info *info)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++)
>> +             kfree(info->ocv_table[i]);
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>> +
>>  int power_supply_get_property(struct power_supply *psy,
>>                           enum power_supply_property psp,
>>                           union power_supply_propval *val)
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index 019452d..b0a2768 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -309,6 +309,12 @@ struct power_supply_info {
>>       int use_for_apm;
>>  };
>>
>> +struct power_supply_battery_ocv_table {
>> +     int ocv;        /* microVolts */
>> +     int capacity;   /* percent */
>> +};
>> +
>> +#define POWER_SUPPLY_OCV_TEMP_MAX 20
>>  /*
>>   * This is the recommended struct to manage static battery parameters,
>>   * populated by power_supply_get_battery_info(). Most platform drivers should
>> @@ -327,6 +333,9 @@ struct power_supply_battery_info {
>>       int constant_charge_current_max_ua; /* microAmps */
>>       int constant_charge_voltage_max_uv; /* microVolts */
>>       int internal_resistance_uohm;       /* microOhms */
>> +     int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];  /* celsius */
>> +     struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
>> +     int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
>>  };
>>
>>  extern struct atomic_notifier_head power_supply_notifier;
>> @@ -350,6 +359,8 @@ extern struct power_supply *devm_power_supply_get_by_phandle(
>>
>>  extern int power_supply_get_battery_info(struct power_supply *psy,
>>                                        struct power_supply_battery_info *info);
>> +extern void power_supply_put_battery_info(struct power_supply *psy,
>> +                                       struct power_supply_battery_info *info);
>>  extern void power_supply_changed(struct power_supply *psy);
>>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>>  extern int power_supply_set_input_current_limit_from_supplier(
>
> Looks good to me. Technically this can result in existing users of
> power_supply_get_battery_info leaking memory, if they have an OCV
> table in DT.

Fortunately existing users did not have an OCV table. Moreover once
this patch merged, I will send patches to add
power_supply_put_battery_info() for existing users of battery info.

-- 
Baolin Wang
Best Regards
