Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87225FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFAA204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s1jEC3B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFAA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeINQy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:54:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39331 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeINQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:54:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180914114048euoutp023069ef219f99fd9b9a13a91dd2da835e~UQV7LdJRG0608706087euoutp02z
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 11:40:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180914114048euoutp023069ef219f99fd9b9a13a91dd2da835e~UQV7LdJRG0608706087euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536925248;
        bh=hA82HCisGvXEodxvaQexpYPioGbxERlDFbQvK2msGGg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s1jEC3B/BZHyZAFQLu073UPbBL3o+Frx8n2UGSPWqs2xBdzjpWjYpsHhATTtqhwKG
         yub4jUDHuB5TS/ROKHN0N/slKKvcEzwS1HfCAy//V/WU5w2s+JQtUTxns81q+BkAZS
         EbCsnJG0dujRCrtAb2HfPRYYOMloVZZjFpNxuouI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180914114047eucas1p10fe15476624f19c5a3308c30ee08de62~UQV6RwCg_0451704517eucas1p18;
        Fri, 14 Sep 2018 11:40:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.67.04806.E3E9B9B5; Fri, 14
        Sep 2018 12:40:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180914114046eucas1p1e2d1101ec18f0ca090c9fd97c6840e78~UQV5bGFjE0451704517eucas1p17;
        Fri, 14 Sep 2018 11:40:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180914114046eusmtrp23f8759f2ce6c52df55b1c3cc23d74af0~UQV5J1sd72348123481eusmtrp2J;
        Fri, 14 Sep 2018 11:40:46 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-50-5b9b9e3eb913
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.01.04284.D3E9B9B5; Fri, 14
        Sep 2018 12:40:45 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180914114045eusmtip2e979696721d0e06b0548b80b2a983417~UQV4dT-Sp1855718557eusmtip2u;
        Fri, 14 Sep 2018 11:40:45 +0000 (GMT)
Subject: Re: [PATCH 01/17] thermal: add thermal_zone_device_toggle() helper
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Fri, 14 Sep 2018 13:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180910171605.GA4196@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85OzsON46z8KWL0rqBkRkmvZXYyrID9aE+BJJFrjxZNC9s
        XjKS1MJSMCuS0VyznHkZpTKcU1Er063SJNOGmas0u5ozWrmZku10FPz2f57n/3uf5w8vhUud
        giXUqaRUVpWkUMpIEdFgnepZH6kviQ2dzN6CPrlsAN0v7CRQab9dgB7m9AE0OzImQM8suRi6
        qC0jUPnosBD1NetI5CrsAEjnfCNEo8NXSPSlPgCZqgZINNWsJ1DrWxeQ00zuhJVktO+ek0yT
        1iFkzIPhjKHlK8aYjPkkM2RvIZnCC06Ssdj1OPNE4yYY24AFY1ymwP2+h0QR8azyVDqr2hAZ
        JzppMBiFKdroM7rxYmE2MG8tAD4UpDdB3dggUQBElJSuAtBp68S4gZT+BeA9vZIfuACsni4V
        zhOuypY5ohLA7qEiIV9MAJjTOyEoABTlT++FbkcMByyig+GTlxaM8+D0bQK+ftXzfwVJb4XX
        LhkBpwl6NXT/fSbk2MV0DCzqXsu1xbQffHpzlOC0j9f+8U7ZfztOh8KOMp2A10HQMq7Dufch
        XUzBtooOkofTYU2DG+Ov3gV/eIoAr/3hN1v9XJplcLapFONhDYDf/9wl+KLWm7/bOkdvg49t
        vQJe74DOoUaMuxTSEjgw7sdfIYHXGzQ43xbDy3lS3r0G1lXUkfO7CpqqcV4zsPyblbwKVmgX
        5NQuyKZdkO02wI0ggE1TJyaw6rAkNiNErUhUpyUlhBxPTjQB7y/s+mv73QjaZo61A5oCMl+x
        /LM2VipQpKszE9sBpHDZInHtQW9LHK/IPMuqko+q0pSsuh0spQhZgFgSfCJWSicoUtnTLJvC
        quanGOWzJBvUqH4O++f3BmQ4XL2H26zykXXVqYH9kqi8WDFStm0P7ciQmz1ALJquOdfzovt+
        XJZ+uTlq89NHI3vOywf8JnQflTMazwd72O4qvT6rrqs2sss4aJh8H91/y4PleiLSVh4Kd4Sd
        LrHty5cGBz24deBGePnnnXJ7aNSRCFtrWfIqGaE+qdgYjKvUin8AaYK5gQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7q282ZHG6y/Y2Xx7PNxRou1vUdZ
        LOZfucZqcaDxMqPF/0evWS1ObW9ismiZtYjFYsmTh+wWl3fNYbP43HuE0WLOu9vsFk8e9rFZ
        vNgibrFpxQ02i5+75rFY7L33mdFBwKPp/TE2j1n3z7J57Jx1l91j6y1Tj8V7XjJ5bFrVyeZx
        59oeNo/e5ndsHtuvzWP2ODH9O4vH8RvbmTw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S0
        0DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1i8eBV7wSy3ijlvp7I3MG616mLk5JAQMJH4
        vHwPSxcjF4eQwFJGic1z9zF2MXIAJWQkjq8vg6gRlvhzrYsNouYto8ThpRtZQWqEBbwlvt+N
        AKkREdCSOHFpOxNETTeTxMnD28EamAUWsUjs+beJGaSKTcBKYmL7KkYQm1fATuL+4t3sIDaL
        gKrE93+nwGxRgQiJWw87WCBqBCVOznwCZnMC9T5duAisl1lAT2LH9V+sELa8xPa3c5gnMArO
        QtIyC0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG+LZjPzfvYLy0MfgQowAH
        oxIPr8PzWdFCrIllxZW5hxglOJiVRHjXhwKFeFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR+Y
        fPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBKzHX+d3/2LJ7H
        Va4GW2W4fnQcuO16jPVUBVtZz2Qz5bKfy3Smf6tcwLGnynrlhclGdZ966k6+dmd476vlPLtM
        Kfa8yaQdJ1PEBCQ3T6gsr2n1sbaZYWjkYaOgs5fRveL32i5Fhsw7KzLZ0+tKdUvEIox+RBe+
        X+GqVzv5mP7NXs1iafYT2UosxRmJhlrMRcWJADZOOIwGAwAA
Message-Id: <20180914114046eucas1p1e2d1101ec18f0ca090c9fd97c6840e78~UQV5bGFjE0451704517eucas1p17@eucas1p1.samsung.com>
X-CMS-MailID: 20180914114046eucas1p1e2d1101ec18f0ca090c9fd97c6840e78
X-Msg-Generator: CA
X-RootMTR: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410124248epcas1p453f74df4e183f9d68de255847c093d4e
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124248epcas1p453f74df4e183f9d68de255847c093d4e@epcas1p4.samsung.com>
        <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
        <20180910171605.GA4196@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/10/2018 07:16 PM, Eduardo Valentin wrote:
> On Tue, Apr 10, 2018 at 02:41:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> Add thermal_zone_device_toggle() helper. Then update core code and
>> drivers to use it.
> 
> Cool, but I think it would be good to have some sort of rational here
> at the commit message telling why this helper is being added, 
> don't you agree?

Ok, I will enhance the patch description (the rationale is removing
code duplication and preparation for changes in the later patches from
the series).

>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/thermal/hisi_thermal.c     | 14 ++------------
>>  drivers/thermal/of-thermal.c       |  2 +-
>>  drivers/thermal/rockchip_thermal.c | 22 +++++-----------------
>>  drivers/thermal/thermal_helpers.c  | 15 +++++++++++++++
>>  drivers/thermal/thermal_sysfs.c    |  8 +++++---
>>  include/linux/thermal.h            |  1 +
>>  6 files changed, 29 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index 761d055..9428499 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -515,15 +515,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
>>  };
>>  MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
>>  
>> -static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
>> -				       bool on)
>> -{
>> -	struct thermal_zone_device *tzd = sensor->tzd;
>> -
>> -	tzd->ops->set_mode(tzd,
>> -		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
>> -}
>> -
>>  static int hisi_thermal_probe(struct platform_device *pdev)
>>  {
>>  	struct hisi_thermal_data *data;
>> @@ -571,7 +562,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> -	hisi_thermal_toggle_sensor(&data->sensor, true);
>> +	thermal_zone_device_toggle((&data->sensor)->tzd, true);
>>  
>>  	return 0;
>>  }
>> @@ -579,9 +570,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>>  static int hisi_thermal_remove(struct platform_device *pdev)
>>  {
>>  	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
>> -	struct hisi_thermal_sensor *sensor = &data->sensor;
>>  
>> -	hisi_thermal_toggle_sensor(sensor, false);
>> +	thermal_zone_device_toggle((&data->sensor)->tzd, false);
>>  
>>  	data->disable_sensor(data);
>>  
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>> index e09f035..f138b78 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -510,7 +510,7 @@ struct thermal_zone_device *
>>  			tzd = thermal_zone_of_add_sensor(child, sensor_np,
>>  							 data, ops);
>>  			if (!IS_ERR(tzd))
>> -				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
>> +				thermal_zone_device_toggle(tzd, true);
>>  
>>  			of_node_put(sensor_specs.np);
>>  			of_node_put(child);
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>> index f36375d..c191e41 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -1022,15 +1022,6 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>  };
>>  MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
>>  
>> -static void
>> -rockchip_thermal_toggle_sensor(struct rockchip_thermal_sensor *sensor, bool on)
>> -{
>> -	struct thermal_zone_device *tzd = sensor->tzd;
>> -
>> -	tzd->ops->set_mode(tzd,
>> -		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
>> -}
>> -
>>  static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
>>  {
>>  	struct rockchip_thermal_data *thermal = dev;
>> @@ -1292,7 +1283,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>  	thermal->chip->control(thermal->regs, true);
>>  
>>  	for (i = 0; i < thermal->chip->chn_num; i++)
>> -		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
>>  
>>  	platform_set_drvdata(pdev, thermal);
>>  
>> @@ -1311,11 +1302,8 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>>  	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
>>  	int i;
>>  
>> -	for (i = 0; i < thermal->chip->chn_num; i++) {
>> -		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
>> -
>> -		rockchip_thermal_toggle_sensor(sensor, false);
>> -	}
>> +	for (i = 0; i < thermal->chip->chn_num; i++)
>> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
>>  
>>  	thermal->chip->control(thermal->regs, false);
>>  
>> @@ -1332,7 +1320,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>>  	int i;
>>  
>>  	for (i = 0; i < thermal->chip->chn_num; i++)
>> -		rockchip_thermal_toggle_sensor(&thermal->sensors[i], false);
>> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
>>  
>>  	thermal->chip->control(thermal->regs, false);
>>  
>> @@ -1383,7 +1371,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>>  	thermal->chip->control(thermal->regs, true);
>>  
>>  	for (i = 0; i < thermal->chip->chn_num; i++)
>> -		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
>>  
>>  	pinctrl_pm_select_default_state(dev);
>>  
>> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
>> index eb03d7e..d5db101 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -227,3 +227,18 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
>> +
>> +/**
>> + * thermal_zone_device_toggle() - enables/disables thermal zone device
>> + * @tz: a valid pointer to a struct thermal_zone_device
>> + *
>> + * Enables/Disables thermal zone device.
>> + *
>> + * Return: On success returns 0, an error code otherwise.
>> + */
>> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on)
>> +{
>> +	return tz->ops->set_mode(tz,
>> +		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
> 
> why not simply getting a mode type (enum thermal_device_mode)?

Well, none of open-coded instances that thermal_zone_device_toggle()
replaces used enum thermal_device_mode. Using bool is simpler and
this enum looks a bit like over-engineering, though I can use it if
you insist.

>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_device_toggle);
> 
> I know naming is always the hardest part :-), but to me, this function
> is more a thermal_zone_set_mode() than device_toggle(). At least, based
> on what I see in the code, we are not really toggling device per si,
> just setting a mode.

Ok, I will change it (the naming was based on existing helpers from
hisi_thermal.c and rockchip_thermal.c).

>> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
>> index 23b5e0a..343f52b 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -72,17 +72,19 @@
>>  {
>>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>>  	int result;
>> +	bool on;
>>  
>>  	if (!tz->ops->set_mode)
>>  		return -EPERM;
>>  
>>  	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
>> -		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
>> +		on = true;
>>  	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
>> -		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
>> +		on = false;
>>  	else
>> -		result = -EINVAL;
>> +		return -EINVAL;
>>  
>> +	result = thermal_zone_device_toggle(tz, on);
>>  	if (result)
>>  		return result;
>>  
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 7834be6..4fbbabe 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -467,6 +467,7 @@ struct thermal_cooling_device *
>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
>>  
> 
> You missed the #else section of the #if IS_ENABLED(CONFIG_THERMAL),
> didn't you?

No, this function shouldn't be used outside of CONFIG_THERMAL.

> We want to have a stub when config thermal is not set.

Actually it seems that a lot of these existing stubs don't make sense
outside of CONFIG_THERMAL and should be cleaned up.

>>  int get_tz_trend(struct thermal_zone_device *, int);
>>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
