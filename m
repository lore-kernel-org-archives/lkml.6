Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F9C217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BGtr2b5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfBSCPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:15:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8814 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfBSCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:15:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b66ae0000>; Mon, 18 Feb 2019 18:15:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 18:15:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 18:15:10 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 02:15:08 +0000
Subject: Re: [PATCH v7 3/3] thermal: tegra: add get_trend ops
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-4-git-send-email-wni@nvidia.com>
 <bae5b0c3-3d7f-0b60-da96-730c7e8c4e5c@linaro.org>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <ecabe3d8-274f-7c0e-f875-6968c65a4425@nvidia.com>
Date:   Tue, 19 Feb 2019 10:15:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bae5b0c3-3d7f-0b60-da96-730c7e8c4e5c@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550542510; bh=PjMVT6E2DOr7ZQEr7mDt49kl1Qjrn8fP6m8/uvzE78w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BGtr2b5F2CxqoZoLEmYLU5H5LvDQ2tzwtyfrkfTj6VBUHPkRx4W/jBWVlp4Zrv9au
         48bONdc4HyNrk9h7taVGoM0shE0xnJVQCM2wmgxMTxlq1H6VnmDJCdEWByVGpJz07x
         +GQP3QKHF8mamMf5V2W4r3Y3dv5+KcHBHMF6y669j1cGdMo/Qy9fxLVMjkz0t8nQow
         uuk9c0NZtQVHT74eowPutuDheMUZ2qNmQRZm4zqFGB5IpUJTB02P6NkwUCPhcJ3sBM
         zBcLdicio++fB5iMCurgVQ9ju1RhkN+7oWRi9f4J5bzsgB30czdoaHoFUjjj/XN1Ur
         vkwfGHxVZDWwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/2/2019 6:27 PM, Daniel Lezcano wrote:
> On 03/01/2019 11:12, Wei Ni wrote:
>> Add support for get_trend ops that allows soctherm
>> sensors to be used with the step-wise governor.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index fd2703c0cfc5..864205af104b 100644
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
> 
> No need to use the mutex here.
> 
> Why not ?
> 
> temp = READ_ONCE(tz->temperature);
> last_temp = READ_ONCE(tz->last_temperature);

Yes, you are right, will change it in next version.

Wei.

> 
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
>> +
>>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>>  	.get_temp = tegra_thermctl_get_temp,
>>  	.set_trip_temp = tegra_thermctl_set_trip_temp,
>> +	.get_trend = tegra_thermctl_get_trend,
>>  };
>>  
>>  static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
>>
> 
> 
