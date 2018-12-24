Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F96C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B878D218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PPjdCuQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeLXJjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:39:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLXJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:39:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBO9d6CB044661;
        Mon, 24 Dec 2018 03:39:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545644346;
        bh=P4qonrIkSx7ObI/3e4xGkBjwcS7GDLbwqGtYa9P06Pk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PPjdCuQJapgNwqpF0qAOc7hYZo6cC7VXYdzeNNGRv47wyvnFkj+zTbL9aJr3zHN25
         /SWmyXS+N1Nb/ezurlXCDDs01denoujIkwnNHU5+OhFItaF1OlvmnrHOrMv/zpwDsh
         lH2kxRRdFMn55J/JqZqmm6/OioUQj/q2WDe6+P+0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBO9d63x059113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Dec 2018 03:39:06 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 24
 Dec 2018 03:39:05 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 24 Dec 2018 03:39:05 -0600
Received: from [172.22.217.62] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBO9cxj9004571;
        Mon, 24 Dec 2018 03:39:00 -0600
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
To:     Lee Jones <lee.jones@linaro.org>,
        Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181221110128.GO13248@dell>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <16dc864e-1952-5d9c-2939-2804872c7814@ti.com>
Date:   Mon, 24 Dec 2018 15:08:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221110128.GO13248@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2018 4:31 PM, Lee Jones wrote:
> On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:
> 
>> These options apply to all regulators in this chip.
>>
>> strict-supply-voltage:
>>    Set STRICT flag in CONFIG1
>> under-voltage-limit:
>>    Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
>> under-voltage-hysteresis:
>>    Select 200mV or 400mV UVLOHYS in CONFIG2
>>
>> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
>> ---
>>   drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
> 
> This needs a close review by Tony and any of the other OMAP guys.
> 
> At the very least, please put '\n's between the if() statements.  You
> also need to return after an error print, else I suggest it's not an
> error.
> 
> It would also look tidier if you changed the if()s to one liners to
> assign to different variables, then dealt with them separately later
> on.  The way it's done here looks messy to say the least.
> 
>> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
>> index 8bcdecf..f5e559b 100644
>> --- a/drivers/mfd/tps65218.c
>> +++ b/drivers/mfd/tps65218.c
>> @@ -211,6 +211,50 @@ static const struct of_device_id of_tps65218_match_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
>>   
>> +static void tps65218_options(struct tps65218 *tps)
>> +{
>> +	struct device *dev = tps->dev;
>> +	struct device_node *np = dev->of_node;
>> +	u32 pval;
> 
> What does pval mean?  I suggest just val is more common.
> 
>> +	if (!of_property_read_u32(np, "strict-supply-voltage", &pval)) {
>> +		tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
>> +			TPS65218_CONFIG1_STRICT,
>> +			pval ? TPS65218_CONFIG1_STRICT : 0,
>> +			TPS65218_PROTECT_L1);
>> +		dev_dbg(dev, "tps65218 strict-supply-voltage: %d\n", pval);
>> +	}
>> +	if (!of_property_read_u32(np, "under-voltage-hysteresis", &pval)) {
>> +		if (pval != 400000 && pval != 200000) {
>> +			dev_err(dev,
>> +				 "under-voltage-hysteresis must be %d or %d\n",
>> +				 200000, 400000);
>> +		} else {
>> +			tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
>> +				TPS65218_CONFIG2_UVLOHYS,
>> +				pval == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
>> +				TPS65218_PROTECT_L1);
>> +		}
>> +		dev_dbg(dev, "tps65218 under-voltage-hysteresis: %d\n", pval);
>> +	}
>> +	if (!of_property_read_u32(np, "under-voltage-limit", &pval)) {
>> +		int i, vals[] = { 275, 295, 325, 335 };
>> +
>> +		for (i = 0; i < ARRAY_SIZE(vals); i++) {
>> +			if (pval == vals[i] * 10000)
> 
> Just use the full value in 'vals'.
> 
>> +				break;
>> +		}
> 
> It took me a few seconds to realise what you're doing here.
> 
> I think a switch() statement would be cleaner.
> 
> You should also #define the values.
> 
> TPS65218_UNDER_VOLT_LIM_2750000 0
> 
> Etc.
> 
>> +		if (i < ARRAY_SIZE(vals)) {
>> +			tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
>> +				TPS65218_CONFIG1_UVLO_MASK, i,
>> +				TPS65218_PROTECT_L1);
>> +		} else {
>> +			dev_err(dev, "Invalid under-voltage-limit: %d\n", pval);
> 
> This could go in the default: section.
> 
>> +		}
>> +		dev_dbg(dev, "tps65218 under-voltage-limit: %d=%d\n", pval, i);
> 
> I suggest considering removing these.
> 
>> +	}
>> +}
>> +
>>   static int tps65218_probe(struct i2c_client *client,
>>   				const struct i2c_device_id *ids)
>>   {
>> @@ -249,6 +293,8 @@ static int tps65218_probe(struct i2c_client *client,
>>   
>>   	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
>>   
>> +	tps65218_options(tps);
> 
> Options is not good nomenclature as it doesn't really tell us
> anything.  Looks like all the values are voltage related to me?

Can we simply call them tps65218_voltage_set_strict, 
tps65218_voltage_set_uvlo, tps65218_voltage_set_uv_hyst?

or if you want them under one function then i would suggest 
tps65218_set_voltage_quirks or something like that.

- Keerthy
> 
>>   	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
>>   			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>>   			      regmap_irq_get_domain(tps->irq_data));
> 
