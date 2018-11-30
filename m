Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEAAC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3E02086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gEUtLls1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3E02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeK3OIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:08:12 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11752 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3OIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:08:12 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c00a7cf0001>; Thu, 29 Nov 2018 19:00:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 29 Nov 2018 19:00:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 29 Nov 2018 19:00:26 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Nov
 2018 03:00:23 +0000
Subject: Re: [PATCH v4 3/3] thermal: tegra: parse sensor id before sensor
 register
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <rui.zhang@intel.com>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1543486183-2868-1-git-send-email-wni@nvidia.com>
 <1543486183-2868-4-git-send-email-wni@nvidia.com>
 <20181129164656.GA2688@localhost.localdomain>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <19b6f139-c54c-6bf7-45ab-6e8bcbf8e6d8@nvidia.com>
Date:   Fri, 30 Nov 2018 11:00:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129164656.GA2688@localhost.localdomain>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543546831; bh=7ef2Ws1xUU/zS+Rm5Jt+e01hr2n1VZaVyu3DNKm3dTg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gEUtLls12xtp6VJAICWfdj+2d2lAcAiFgOBGD+ygHL6P7wdDfJngDWHULZcqO4jjy
         FZpgWTkTQR3ID3OQmGEHJQAeI3zOJ5P5rQSmsfr6dUZRsJSuScIdp9pTvBcIrLgpFL
         xz6T8aPT24+mHnPGqa66VA3z92ZnrDR21qZ0f4tQ6Qq33usTwx9RlIf8ILyB28jdX/
         vJWZlQ7rX5Bu2QBKyzVxT80d3F/zJQdbcFC2ydOqZU+yuVVNsG78ZhPmWHHwAeTyHK
         ainPhxWI/bqsjZFycwoSU3XlyNG9XzdBOdRRgWk7P61sAWZPr2R56vIughJx6ZmH3/
         DudGZolkDpZvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2018 12:46 AM, Eduardo Valentin wrote:
> On Thu, Nov 29, 2018 at 06:09:43PM +0800, Wei Ni wrote:
>> Since different platforms may not support all 4
>> sensors, so the sensor registration may be failed.
>> Add codes to parse dt to find sensor id which
>> need to be registered. So that the registration
>> can be successful on all platform.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 46 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index 375cadbc24cd..bdc660f2794a 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -1224,6 +1224,42 @@ static void soctherm_init(struct platform_device *pdev)
>>  	tegra_soctherm_throttle(&pdev->dev);
>>  }
>>  
>> +static bool tegra_soctherm_find_sensor_id(unsigned int sensor_id)
>> +{
>> +	bool ret = false;
>> +	struct of_phandle_args sensor_specs;
>> +	struct device_node *np, *sensor_np;
>> +
>> +	np = of_find_node_by_name(NULL, "thermal-zones");
>> +	if (!np)
>> +		return ret;
>> +
>> +	sensor_np = of_get_next_child(np, NULL);
>> +	for_each_available_child_of_node(np, sensor_np) {
>> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
>> +						 "#thermal-sensor-cells",
>> +						 0, &sensor_specs))
>> +			continue;
>> +
>> +		if (sensor_specs.args_count != 1) {
>> +			WARN(sensor_specs.args_count != 1,
>> +			     "%s: wrong cells in sensor specifier %d\n",
>> +			     sensor_specs.np->name, sensor_specs.args_count);
>> +			continue;
>> +		}
>> +
>> +		if (sensor_specs.args[0] == sensor_id) {
>> +			ret = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	of_node_put(np);
>> +	of_node_put(sensor_np);
>> +
>> +	return ret;
>> +}
>> +
>>  static const struct of_device_id tegra_soctherm_of_match[] = {
>>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>>  	{
>> @@ -1365,13 +1401,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>  		zone->sg = soc->ttgs[i];
>>  		zone->ts = tegra;
>>  
>> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
>> +			continue;
>> +
> 
> 
> Instead of matching driver id with DT id presence, wouldnt make sense to
> simply have DT with the sensors that makes sense for that platform?
> 
> I am failing to understand why you need to go over and find ids.

As discussed with Daniel several days ago, this driver will always try
to register 4 thermal zones, including cpu, gpu, mem and pll, but some
platform doesn't need to support all of them, so the thermal zone
registration will be failed. In previous patches, we just ignore the
failure and continue to register next sensors, but Daniel think it's not
good. And per his suggestion, we refer to the qoriq thermal driver to
parse dt to get sensor_id, so that we can make the registration to be
successful.

Wei.

> 
>>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>  							 soc->ttgs[i]->id, zone,
>>  							 &tegra_of_thermal_ops);
>>  		if (IS_ERR(z)) {
>>  			err = PTR_ERR(z);
>> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>> -				err);
>> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
>> +				soc->ttgs[i]->name, err);
>>  			goto disable_clocks;
>>  		}
>>  
>> @@ -1434,6 +1473,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>  		struct thermal_zone_device *tz;
>>  
>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>> +		if (!tz)
>> +			continue;
>> +
>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>>  		if (err) {
>>  			dev_err(&pdev->dev,
>> -- 
>> 2.7.4
>>
