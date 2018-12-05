Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A00C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA4A20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Oq8CCAdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA4A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeLEIaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:30:18 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10925 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeLEIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:30:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c078c960000>; Wed, 05 Dec 2018 00:30:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Dec 2018 00:30:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Dec 2018 00:30:15 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 08:30:13 +0000
Subject: Re: [PATCH] thermal: tegra: add get_trend ops
From:   Wei Ni <wni@nvidia.com>
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>
References: <1542705077-29697-1-git-send-email-wni@nvidia.com>
 <20181120153833.GB28796@ulmo>
 <d510d768-452f-5f70-a9b6-37d6a63a56c9@nvidia.com>
 <20181129170145.GG2688@localhost.localdomain>
 <f2d10339-4086-7102-9949-719483f545bf@nvidia.com>
Message-ID: <92e4304d-df83-946f-a7d5-a12b77a9d9e8@nvidia.com>
Date:   Wed, 5 Dec 2018 16:30:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f2d10339-4086-7102-9949-719483f545bf@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543998614; bh=w+sIaRjf4gVQYTUxqwRnFccGvdVd3MjnI42LXU+a02g=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Oq8CCAduw77rOiA7XjkSXPCy8w8BPsYCZKWzqYguU8rsyrVy7INnQY1xUM+CZji4c
         y37YUZxsJ13Q0XHnSy0wmJazZ4f75S3IQrQOIKTYFAJtS1XjtRMV/C06VHLfv8sbLC
         QQpNwyLztIAGSUbz66pwLUZnrOFVC0S7cdmPsEUvtZiNyN5bAx5qhpGOiHsf4915zL
         Xx1g3sl+r39pAa48V0JgVlHweqnzLi4qYV+jWCWgquytChhgC1emzuKNuqWZUQobBn
         HvTIpxLMxHR7FWqVZtVw7oS1Xm4bmJ295LM+3PzJMcNhJNNeSy4jKLASBO+yknd1nj
         JVgdmALxHakOg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
It seems no more comments, could this patch be approved?

Thanks.
Wei.

On 30/11/2018 11:07 AM, Wei Ni wrote:
> 
> 
> On 30/11/2018 1:01 AM, Eduardo Valentin wrote:
>> On Wed, Nov 21, 2018 at 02:36:10PM +0800, Wei Ni wrote:
>>>
>>>
>>> On 20/11/2018 11:38 PM, Thierry Reding wrote:
>>>> On Tue, Nov 20, 2018 at 05:11:17PM +0800, Wei Ni wrote:
>>>>> Add support for get_trend ops that allows soctherm
>>>>> sensors to be used with the step-wise governor.
>>>>>
>>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>>> ---
>>>>>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 34 insertions(+)
>>>>>
>>>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>>>>> index ed28110a3535..d2951fbe2b7c 100644
>>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>>> @@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> +static int tegra_thermctl_get_trend(void *data, int trip,
>>>>> +				    enum thermal_trend *trend)
>>>>> +{
>>>>> +	struct tegra_thermctl_zone *zone = data;
>>>>> +	struct thermal_zone_device *tz = zone->tz;
>>>>> +	int trip_temp, temp, last_temp, ret;
>>>>> +
>>>>> +	if (!tz)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	mutex_lock(&tz->lock);
>>>>> +	temp = tz->temperature;
>>>>> +	last_temp = tz->last_temperature;
>>>>> +	mutex_unlock(&tz->lock);
>>>>> +
>>>>> +	if (temp > trip_temp) {
>>>>> +		if (temp >= last_temp)
>>>>> +			*trend = THERMAL_TREND_RAISING;
>>>>> +		else
>>>>> +			*trend = THERMAL_TREND_STABLE;
>>>>> +	} else if (temp < trip_temp) {
>>>>> +		*trend = THERMAL_TREND_DROPPING;
>>>>> +	} else {
>>>>> +		*trend = THERMAL_TREND_STABLE;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>
>>>> This looks like a reimplementation of the get_tz_trend() helper. Is
>>>> seems like that helper already has everything we need. Perhaps this
>>>> isn't working because of-thermal installs of_thermal_get_trend(), a
>>>> function that returns -EINVAL if the driver doesn't implement the
>>>> ->get_trend() callback.
>>>
>>> 1. The get_tz_trend() helper can work, because it has:
>>> if (tz->emul_temperature || !tz->ops->get_trend ||
>>>             tz->ops->get_trend(tz, trip, &trend)) {
>>> ...
>>> }
>>> the tz->ops->get_trend is of_thermal_get_trend(). If without special
>>> get_trend(), it will return -EINVAL, so it will implement the if block
>>> to get the "trend". If we have the special get_trend(), then the
>>> of_thermal_get_trend() will return 0, so this helper will not implement
>>> the if block, it will get the "trend" from the special get_trend().
>>
>> The idea of the helper is to provide a trend in case drivers dont have
>> a specific way of doing so. 
> 
> Yes, thanks for your explanation.
> 
>>
>>>
>>> 2. There has a little difference between the helper and our special
>>> callback. The tegra_thermctl_get_trend() consider the trip_temp, but the
>>> get_tz_trend() helper didn't.
>>>
>>
>> Yeah, if you are computing trend towards a trip, then yes, that is
>> different and this patch is needed.
>>
>>>>
>>>> Perhaps a better way would be to do something like this in
>>>> thermal_zone_of_add_sensor():
>>>>
>>>> 	if (ops->get_trend)
>>>> 		tzd->ops->get_trend = of_thermal_get_trend;
>>>>
>>>> That's similar to how ->set_trips() and ->set_emul_temp() are set up
>>>> and should make sure that get_tz_trend() will do the right thing for
>>>> all drivers that don't implement a special ->get_trend().
>>>
>>> As above description, I think the of_thermal_get_trend() already can
>>> handle this case, doesn't need to change.
>>>
>>> Wei.
>>>
>>>>
>>>> Thierry
>>>>
