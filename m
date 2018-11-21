Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6500C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7262146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ho+G9Vdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7262146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeKURJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:09:27 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4603 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKURJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:09:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf4fcdf0000>; Tue, 20 Nov 2018 22:36:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 22:36:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 22:36:15 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 21 Nov
 2018 06:36:13 +0000
Subject: Re: [PATCH] thermal: tegra: add get_trend ops
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1542705077-29697-1-git-send-email-wni@nvidia.com>
 <20181120153833.GB28796@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <d510d768-452f-5f70-a9b6-37d6a63a56c9@nvidia.com>
Date:   Wed, 21 Nov 2018 14:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120153833.GB28796@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542782175; bh=YkCGkxzpDfjW+OP4B45NyIRv2+jWK/j+fejmr3EN9o4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ho+G9VdtjTpUyMmbEu8mTTuqq/DseKLERj68HvOiFs4/7KaetTS4CHTWeAVXK6PHs
         XT/0o4Igi7mQaIFvi0EflFHb3wuV71935Asy/wcgFq0UFBehJIJYR6R6jHBHBQ83SC
         HLLOIFuA2GkU0QM+dtg/+gtMO8ntNlpifP9cNvFCmTC1wmirsGadz6nE0GO5K5MtFb
         jXzbMHcBAMIdAVzPbiFtlaCwXlMOGzy/KhIiuTeFgYHYcVuTddiJnIf+0pHYwbDkAY
         djAd8wRDqHLzHC3dKXolRsLbcxpKNc+UZwTxRPxr4HO5BPg56k0O1W++SGJj5dwe4K
         R5NmLKZkKWXGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2018 11:38 PM, Thierry Reding wrote:
> On Tue, Nov 20, 2018 at 05:11:17PM +0800, Wei Ni wrote:
>> Add support for get_trend ops that allows soctherm
>> sensors to be used with the step-wise governor.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index ed28110a3535..d2951fbe2b7c 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>>  	return 0;
>>  }
>>  
>> +static int tegra_thermctl_get_trend(void *data, int trip,
>> +				    enum thermal_trend *trend)
>> +{
>> +	struct tegra_thermctl_zone *zone = data;
>> +	struct thermal_zone_device *tz = zone->tz;
>> +	int trip_temp, temp, last_temp, ret;
>> +
>> +	if (!tz)
>> +		return -EINVAL;
>> +
>> +	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&tz->lock);
>> +	temp = tz->temperature;
>> +	last_temp = tz->last_temperature;
>> +	mutex_unlock(&tz->lock);
>> +
>> +	if (temp > trip_temp) {
>> +		if (temp >= last_temp)
>> +			*trend = THERMAL_TREND_RAISING;
>> +		else
>> +			*trend = THERMAL_TREND_STABLE;
>> +	} else if (temp < trip_temp) {
>> +		*trend = THERMAL_TREND_DROPPING;
>> +	} else {
>> +		*trend = THERMAL_TREND_STABLE;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This looks like a reimplementation of the get_tz_trend() helper. Is
> seems like that helper already has everything we need. Perhaps this
> isn't working because of-thermal installs of_thermal_get_trend(), a
> function that returns -EINVAL if the driver doesn't implement the
> ->get_trend() callback.

1. The get_tz_trend() helper can work, because it has:
if (tz->emul_temperature || !tz->ops->get_trend ||
            tz->ops->get_trend(tz, trip, &trend)) {
...
}
the tz->ops->get_trend is of_thermal_get_trend(). If without special
get_trend(), it will return -EINVAL, so it will implement the if block
to get the "trend". If we have the special get_trend(), then the
of_thermal_get_trend() will return 0, so this helper will not implement
the if block, it will get the "trend" from the special get_trend().

2. There has a little difference between the helper and our special
callback. The tegra_thermctl_get_trend() consider the trip_temp, but the
get_tz_trend() helper didn't.

> 
> Perhaps a better way would be to do something like this in
> thermal_zone_of_add_sensor():
> 
> 	if (ops->get_trend)
> 		tzd->ops->get_trend = of_thermal_get_trend;
> 
> That's similar to how ->set_trips() and ->set_emul_temp() are set up
> and should make sure that get_tz_trend() will do the right thing for
> all drivers that don't implement a special ->get_trend().

As above description, I think the of_thermal_get_trend() already can
handle this case, doesn't need to change.

Wei.

> 
> Thierry
> 
