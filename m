Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDB72146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Igh5O5xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDB72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeK2Q7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:59:18 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2245 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeK2Q7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:59:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bff7f100000>; Wed, 28 Nov 2018 21:54:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Nov 2018 21:55:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Nov 2018 21:55:07 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Nov
 2018 05:55:04 +0000
Subject: Re: [PATCH v3 3/3] thermal: tegra: parse sensor id before sensor
 register
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-4-git-send-email-wni@nvidia.com>
 <20181128102520.GC20723@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <9c373693-1d3c-cd02-4972-dde338651c0e@nvidia.com>
Date:   Thu, 29 Nov 2018 13:55:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128102520.GC20723@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543470864; bh=NrGxoq3Zscu4vNW7g2jr9T0rBHCD/ijwUD9IK5VnHgE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Igh5O5xFlCGVin3qyePCrnCXSD748wlMH8mHaVqq7TJp9DkoKDJ2WkyiJlK5hzEkg
         tYihd6NH5UQni2VIQmW66zYFhjAZ7dvtEINBiKsV5guAtbjfV/nzCHunRkzS1loK5K
         fxXKWD+aZZduHynYYjhi39HKF773/3T7aUvMAj4c2yR9Nm6Lbvlxalttu57iInO/0C
         m1+XGxVF01mKLzZGqvYRfrSC1cuuOt4tx6z+zfcpv5zDbZILq8tKcoA9YtPTDxAWpW
         bLq6uNMq4DznauTuBupn4Fe7fvjyknOK0QrWSUN9UH+rPmlNa4V6YLgo1w7X45sIzQ
         ecjvV9R4kFjvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/2018 6:25 PM, Thierry Reding wrote:
> On Wed, Nov 28, 2018 at 01:44:37PM +0800, Wei Ni wrote:
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
>> index 375cadbc24cd..79e4628224d7 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -1224,6 +1224,44 @@ static void soctherm_init(struct platform_device *pdev)
>>  	tegra_soctherm_throttle(&pdev->dev);
>>  }
>>  
>> +static bool tegra_soctherm_find_sensor_id(int sensor_id)
>> +{
>> +	int id;
> 
> You might want to make this and the sensor_id parameter unsigned int to
> match the signedness of the ID in the specifier arguments and the sensor
> groups.

Ok, will change it.

> 
> Thierry
> 
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
> 
> Aren't we leaking np here? I think we need of_node_put() after
> of_get_next_child() to make sure the reference to the "thermal-zones"
> node is properly released.

No, we will not leak np here. Because the
for_each_available_child_of_node will call
of_get_next_available_child(), which will call of_node_put(prev) to
decrease refcount of the prev node. So we just need to of_node_put the
last node after break from this for block.
> 
>> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
>> +						 "#thermal-sensor-cells",
>> +						 0, &sensor_specs))
>> +			continue;
>> +
>> +		if (sensor_specs.args_count != 1) {
>> +			WARN(sensor_specs.args_count > 1,
>> +			     "%s: wrong cells in sensor specifier %d\n",
>> +			     sensor_specs.np->name, sensor_specs.args_count);
>> +			continue;
> 
> This is odd. You check for args_count != 1 but then WARN on args_count >
> 1. Shouldn't both of these conditions be the same?

Sorry, it's my mistake, will fix it.

> 
>> +		} else {
> 
> Also, since the above has "continue;", we don't really need the else
> block.

Will fix it.
> 
>> +			id = sensor_specs.args[0];
>> +			if (sensor_id == id) {
> 
> It might not be worth to store the ID in a separate variable, we could
> just do:
> 
> 	if (sensor_specs.args[0] == sensor_id)
> 
> Thierry

Sure, will fix it.

>> +				ret = true;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	of_node_put(np);
We decrease refcount of the last np.

>> +	of_node_put(sensor_np);
>> +
>> +	return ret;
>> +}
>> +
>>  static const struct of_device_id tegra_soctherm_of_match[] = {
>>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>>  	{
>> @@ -1365,13 +1403,15 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>  		zone->sg = soc->ttgs[i];
>>  		zone->ts = tegra;
>>  
>> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
>> +			continue;
>>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
> 
> I'd would prefer a blank line after the if block for readability.

Sure, will update it.

> 
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
>> @@ -1434,6 +1474,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>  		struct thermal_zone_device *tz;
>>  
>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>> +		if (!tz)
>> +			continue;
>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
> 
> Same here:
> 
> 		if (!tz)
> 			continue;
> 
> 		err = ...
> 
> Thierry

Will update it.

> 
