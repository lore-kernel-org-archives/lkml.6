Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C551EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECC320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RMzZ68Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfANGiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:38:20 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54234 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:38:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0E6c97q046810;
        Mon, 14 Jan 2019 00:38:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547447889;
        bh=w6vAKsjI5QvwuK1qK0XoB+f6aB6H/dQwm+KSOlsbuWQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RMzZ68HaaLelL1E7u3bqoFGA0MxbDpmKcWxw/4j3BzMTpKE2QBNVVy9VaaeqQq7KJ
         H1Aj7TnxC+TkHaKXWqmzBrQtNdR1Onl8biqaW6Ch5u4IFctSYhuKJ6ZqqVI3qch+MY
         lBncG7BUgYQb/I3oszGuR/ofoZH8G2JFO4dk0S94=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0E6c9nQ066867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 00:38:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 00:38:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 00:38:09 -0600
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0E6c5lJ028928;
        Mon, 14 Jan 2019 00:38:06 -0600
Subject: Re: [PATCH v2 2/2] mfd: tps65218.c: Add input voltage options
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1546523226-358-3-git-send-email-Christian.Hohnstaedt@wago.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <d50e3ea1-9be0-88fb-ce86-53b3c9873ca0@ti.com>
Date:   Mon, 14 Jan 2019 12:08:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1546523226-358-3-git-send-email-Christian.Hohnstaedt@wago.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 03 January 2019 07:17 PM, Christian Hohnstaedt wrote:
> These options apply to all regulators in this chip.
> 
> ti,strict-supply-voltage-supervision:
>   Set STRICT flag in CONFIG1
> ti,under-voltage-limit-microvolt:
>   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> ti,under-voltage-hyst-microvolt:
>   Select 200mV or 400mV UVLOHYS in CONFIG2

CHECK: Alignment should match open parenthesis
#146: FILE: drivers/mfd/tps65218.c:219:
+	if (of_property_read_u32(tps->dev->of_node,
+			"ti,strict-supply-voltage-supervision", &strict))

CHECK: Alignment should match open parenthesis
#156: FILE: drivers/mfd/tps65218.c:229:
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+		TPS65218_CONFIG1_STRICT,

CHECK: Alignment should match open parenthesis
#166: FILE: drivers/mfd/tps65218.c:239:
+	if (of_property_read_u32(tps->dev->of_node,
+			"ti,under-voltage-hyst-microvolt", &hyst))

CHECK: Alignment should match open parenthesis
#176: FILE: drivers/mfd/tps65218.c:249:
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
+		TPS65218_CONFIG2_UVLOHYS,

CHECK: Alignment should match open parenthesis
#188: FILE: drivers/mfd/tps65218.c:261:
+	if (of_property_read_u32(tps->dev->of_node,
+			 "ti,under-voltage-limit-microvolt", &uvlo))

CHECK: Alignment should match open parenthesis
#211: FILE: drivers/mfd/tps65218.c:284:
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+		TPS65218_CONFIG1_UVLO_MASK, uvloval,

Some checkpatch warnings to be fixed.

Other than that i tested your patch on am437x-gp-evm for boot and suspend/resume.

After fixing them you can add my:

Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  drivers/mfd/tps65218.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65218.h |  4 ++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 8bcdecf..b5e0f3a 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -211,6 +211,81 @@ static const struct of_device_id of_tps65218_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
>  
> +static int tps65218_voltage_set_strict(struct tps65218 *tps)
> +{
> +	u32 strict;
> +
> +	if (of_property_read_u32(tps->dev->of_node,
> +			"ti,strict-supply-voltage-supervision", &strict))
> +		return 0;
> +
> +	if (strict != 0 && strict != 1) {
> +		dev_err(tps->dev,
> +			"Invalid ti,strict-supply-voltage-supervision value\n");
> +		return -EINVAL;
> +	}
> +
> +	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
> +		TPS65218_CONFIG1_STRICT,
> +		strict ? TPS65218_CONFIG1_STRICT : 0, TPS65218_PROTECT_L1);
> +	return 0;
> +}
> +
> +static int tps65218_voltage_set_uv_hyst(struct tps65218 *tps)
> +{
> +	u32 hyst;
> +
> +	if (of_property_read_u32(tps->dev->of_node,
> +			"ti,under-voltage-hyst-microvolt", &hyst))
> +		return 0;
> +
> +	if (hyst != 400000 && hyst != 200000) {
> +		dev_err(tps->dev,
> +			"Invalid ti,under-voltage-hyst-microvolt value\n");
> +		return -EINVAL;
> +	}
> +
> +	tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
> +		TPS65218_CONFIG2_UVLOHYS,
> +		hyst == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
> +		TPS65218_PROTECT_L1);
> +	return 0;
> +}
> +
> +static int tps65218_voltage_set_uvlo(struct tps65218 *tps)
> +{
> +	u32 uvlo;
> +	int uvloval;
> +
> +	if (of_property_read_u32(tps->dev->of_node,
> +			 "ti,under-voltage-limit-microvolt", &uvlo))
> +		return 0;
> +
> +	switch (uvlo) {
> +	case 2750000:
> +		uvloval = TPS65218_CONFIG1_UVLO_2750000;
> +		break;
> +	case 2950000:
> +		uvloval = TPS65218_CONFIG1_UVLO_2950000;
> +		break;
> +	case 3250000:
> +		uvloval = TPS65218_CONFIG1_UVLO_3250000;
> +		break;
> +	case 3350000:
> +		uvloval = TPS65218_CONFIG1_UVLO_3350000;
> +		break;
> +	default:
> +		dev_err(tps->dev,
> +			"Invalid ti,under-voltage-limit-microvolt value\n");
> +		return -EINVAL;
> +	}
> +
> +	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
> +		TPS65218_CONFIG1_UVLO_MASK, uvloval,
> +		TPS65218_PROTECT_L1);
> +	return 0;
> +}
> +
>  static int tps65218_probe(struct i2c_client *client,
>  				const struct i2c_device_id *ids)
>  {
> @@ -249,6 +324,18 @@ static int tps65218_probe(struct i2c_client *client,
>  
>  	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
>  
> +	ret = tps65218_voltage_set_strict(tps);
> +	if (ret)
> +		return ret;
> +
> +	ret = tps65218_voltage_set_uvlo(tps);
> +	if (ret)
> +		return ret;
> +
> +	ret = tps65218_voltage_set_uv_hyst(tps);
> +	if (ret)
> +		return ret;
> +
>  	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
>  			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));
> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
> index c204d9a..3cbe103 100644
> --- a/include/linux/mfd/tps65218.h
> +++ b/include/linux/mfd/tps65218.h
> @@ -137,6 +137,10 @@
>  #define TPS65218_CONFIG1_PGDLY_MASK	0x18
>  #define TPS65218_CONFIG1_STRICT		BIT(2)
>  #define TPS65218_CONFIG1_UVLO_MASK	0x3
> +#define TPS65218_CONFIG1_UVLO_2750000	0x0
> +#define TPS65218_CONFIG1_UVLO_2950000	0x1
> +#define TPS65218_CONFIG1_UVLO_3250000	0x2
> +#define TPS65218_CONFIG1_UVLO_3350000	0x3
>  
>  #define TPS65218_CONFIG2_DC12_RST	BIT(7)
>  #define TPS65218_CONFIG2_UVLOHYS	BIT(6)
> 
