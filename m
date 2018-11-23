Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A55C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430F120663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oCzefRfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430F120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408570AbeKWTLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:11:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8860 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408510AbeKWTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:11:21 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf7ba010000>; Fri, 23 Nov 2018 00:27:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 23 Nov 2018 00:28:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 23 Nov 2018 00:28:06 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 08:28:04 +0000
Subject: Re: [PATCH v2 1/3] thermal: tegra: continue if sensor register fails
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
 <1542103567-5521-2-git-send-email-wni@nvidia.com>
 <d212af68-fd18-74d4-d81c-ed8b3c0f136a@linaro.org>
 <70f08208-d04c-c9a4-07e6-d377c33a9386@nvidia.com>
 <d77fe117-3cde-108f-e1d7-2871f3d4c485@linaro.org>
 <5e09bc13-7880-40f2-3f90-01d2cc3510ba@nvidia.com>
 <299fc8a0-39e4-1bd9-821b-4712a7f25028@linaro.org>
 <2f5d3135-6a25-82ce-cf3a-d804484644a1@nvidia.com>
 <d9668442-94b7-b673-51cf-66e92b6a31ab@linaro.org>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <9d22a81c-f7f3-e4c0-e6e5-e07f2d8d89f8@nvidia.com>
Date:   Fri, 23 Nov 2018 16:28:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d9668442-94b7-b673-51cf-66e92b6a31ab@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542961665; bh=XG4NlVjX4g9cnyXBpGx6Dj7STTyw48aKxq+9oTsjE/M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oCzefRfo7Gp3VdrsRQ00Y5idamLbC8xF9CRhnaCPsmG+WaJ7D7LkA4C1rQHwZRfNj
         /QbVo5aCFqB6bS/7jFF1YwSL0HqzTuOfNrI81S+S9BUIpSMGwiXVywpHICZkMsR9FE
         Fze2zo/IYnCgfq1E+NmlsXwkUIByF27KfSCc3XHoC1TsHlF4syzePFaQqLKLGkKUi2
         INBniBlFs+80Ib2KyQlF9H8XnUsbVf2TPwzTiyjk3FU4Di7fogIPixUwDfZUHYDMBa
         6F43xwPsYiMoFzj5kCcNTNVamnYHRHeJbk2DFmu8koW9swNjM6yT2Yw9KFyxr1yTDY
         iK8TV5QE1HuOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2018 2:51 PM, Daniel Lezcano wrote:
> 
> Hi wei,
> 
> On 23/11/2018 07:15, Wei Ni wrote:
>>
>>
>> On 22/11/2018 9:07 PM, Daniel Lezcano wrote:
>>> On 22/11/2018 08:10, Wei Ni wrote:
>>>>
>>>>
>>>> On 21/11/2018 8:51 PM, Daniel Lezcano wrote:
>>>>> On 21/11/2018 11:23, Wei Ni wrote:
>>>>>>
>>>>>>
>>>>>> On 21/11/2018 4:55 PM, Daniel Lezcano wrote:
>>>>>>> On 13/11/2018 11:06, Wei Ni wrote:
>>>>>>>> Don't bail when a sensor fails to register with the
>>>>>>>> thermal zone and allow other sensors to register.
>>>>>>>> This allows other sensors to register with thermal
>>>>>>>> framework even if one sensor fails registration.
>>>>>>>
>>>>>>> I'm not sure if ignoring the error is really safe. Can you describe the
>>>>>>> real situation you want to overcome ? How do you differentiate critical
>>>>>>> sensors ?
>>>>>>
>>>>>> The driver will always try to register 4 thermal zones, including cpu,
>>>>>> gpu, mem and pll, but if the dts file doesn't set the corresponding
>>>>>> sensors, then the register will be failed.
>>>>>> Normally, the dts file will set all 4 sensors, but there may have some
>>>>>> platform doesn't support them all. So we post this patch.
>>>>>
>>>>> Ignoring errors is not the way to go to support different platforms. Fix
>>>>> the DT.
>>>>
>>>> The issue isn't in DT file. The Tegra soc thermal include 4 sensors:
>>>> cpu, gpu, mem, pll. But in some platforms, for example, we may only need
>>>> to support 2 sensors, such as cpu and gpu, so we only configure these
>>>> two senors in DT file. But the driver will always try to register 4
>>>> sensors, cpu/gpu/mem/pll, so mem and pll will be registered failed. So
>>>> in this case we need to ignoring the failure, and continue to enable the
>>>> driver.
>>>
>>> You can fix this by changing the driver to support the platform and
>>> register the sensor you are interested in.
>>>
>>> Ignoring errors is not a good idea.
>>
>> If hit the errors, the driver will print out the warning. In current
>> code, the driver probe routine will return failure directly, indeed it
>> didn't do anything either except print out warnings.
>> I think this error should not block other sensors' registration. Let's
>> consider this case, we have four sensors, if the one sensor register
>> failed, then the driver return probe failure, so the drive will not be
>> enabled, and other sensor can't work either, it mean the device may boot
>> up without any thermal sensors.
>> Or if the error is the -ENODEV, that mean the we didn't set
>> corresponding sensor id in the dt file, so we can continue to register.
>> If the error is other value, then we can return directly.
> 
> It is a possibility but may be there are a couple of alternatives:
> 
> 1. If there is a compatible string for the platform variant, use it to
> probe the right sensors
> 
> or
> 
> 2. Use the qoriq driver approach by reparsing the DT and find out the
> thermal zone and their respective sensor id.

Daniel, thanks for your comments, will consider it in my next version.

Wei.
> 
> 
>>>>>> BTW, what do you mean "critical sensors"? We will set critical trip temp
>>>>>> for all sensors.
>>>>>
>>>>> I meant sensor for thermal zone getting really high temperature.
>>>>
>>>> We doesn't have the critical sensors. We set the critical trip temp for
>>>> all registered sensors. And these trip temp is set to the Tegra
>>>> hardware. So it mean if the temperature reached the critical trip point,
>>>> then the system will be shutdown directly.
>>>>
>>>>>
>>>>>
>>>>>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>>>>>> ---
>>>>>>>>  drivers/thermal/tegra/soctherm.c | 8 +++++---
>>>>>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>>>>>>>> index ed28110a3535..a824d2e63af3 100644
>>>>>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>>>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>>>>>> @@ -1370,9 +1370,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>>>>>>>  							 &tegra_of_thermal_ops);
>>>>>>>>  		if (IS_ERR(z)) {
>>>>>>>>  			err = PTR_ERR(z);
>>>>>>>> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>>>>>>>> -				err);
>>>>>>>> -			goto disable_clocks;
>>>>>>>> +			dev_warn(&pdev->dev, "failed to register sensor %s: %d\n",
>>>>>>>> +				 soc->ttgs[i]->name, err);
>>>>>>>> +			continue;
>>>>>>>>  		}
>>>>>>>>  
>>>>>>>>  		zone->tz = z;
>>>>>>>> @@ -1434,6 +1434,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>>>>>>>  		struct thermal_zone_device *tz;
>>>>>>>>  
>>>>>>>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>>>>>>>> +		if (!tz)
>>>>>>>> +			continue;
>>>>>>>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>>>>>>>>  		if (err) {
>>>>>>>>  			dev_err(&pdev->dev,
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>
>>>
> 
> 
