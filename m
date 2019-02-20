Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AE9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A1220859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ARAHHHbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfBTIjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:39:46 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9312 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:39:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6d12550000>; Wed, 20 Feb 2019 00:39:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 00:39:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 00:39:43 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 08:39:40 +0000
Subject: Re: [PATCH v1 01/12] of: Add bindings of thermtrip for Tegra soctherm
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     Rob Herring <robh@kernel.org>, <thierry.reding@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-3-git-send-email-wni@nvidia.com>
 <20181227230630.GA3659@bogus>
 <1441d2d1-acfa-7b8d-5ed8-c2ca257df05d@nvidia.com>
 <20190220012212.GE2811@localhost.localdomain>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <f963a6b9-e25e-6eab-1dfa-da94144c7ab6@nvidia.com>
Date:   Wed, 20 Feb 2019 16:39:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220012212.GE2811@localhost.localdomain>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550651989; bh=E07eKxmE6VsmQHM/VJAcJZSS/T7rf8EpBoxCL1ND+sE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ARAHHHboO88stvQfijo+Aui0ZIejz6Qu8hb7Q1K547WC+nyZ5Z6XXfLn6DWfKZpv7
         H211vrFgd4HL4jv218cfA/UbqQs6h22K8Jb1epSZde0uN4vfmwuhgp1hlGaavU1agC
         ig5xLWNxLXhVQlC/L7sxS9nJ52z9OzXyOPt/IjdbDc1fTMAZG+XleP4K/zKG5O267h
         QFQodaGnmuPyN6ZVISoQSEIbWaWjcSEGJNZiF6Z7ZxRGRNoH0rabrjTain0o/Iv+OO
         IlZSJh9D48cq0m7WCPS6LGKtSq0a+el8B57e8RuB4OEynFj3cv9oadOphBdjTDSwz0
         ctX7SOeW3f9bQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/2/2019 9:22 AM, Eduardo Valentin wrote:
> On Fri, Dec 28, 2018 at 11:28:42AM +0800, Wei Ni wrote:
>>
>>
>> On 28/12/2018 7:06 AM, Rob Herring wrote:
>>> On Tue, Dec 18, 2018 at 03:34:33PM +0800, Wei Ni wrote:
>>>> Add optional property "nvidia,thermtrips".
>>>> If present, these trips will be used as HW shutdown trips,
>>>> and critical trips will be used as SW shutdown trips.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 +++++++++++++++++---
>>>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>>>> index b6c0ae53d4dc..ab66d6feab4b 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>>>> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>>>> @@ -55,10 +55,21 @@ Required properties :
>>>>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>>>>          See ./thermal.txt for a description of this property.
>>>>  
>>>> +Optional properties:
>>>> +- nvidia,thermtrips : When present, this property specifies the temperature at
>>>> +  which the soctherm hardware will assert the thermal trigger signal to the
>>>> +  Power Management IC, which can be configured to reset or shutdown the device.
>>>> +  It is an array of pairs where each pair represents a tsensor id followed by a
>>>> +  temperature in milli Celcius. In the absence of this property the critical
>>>> +  trip point will be used for thermtrip temperature.
>>>> +
>>>>  Note:
>>>> -- the "critical" type trip points will be set to SOC_THERM hardware as the
>>>> -shut down temperature. Once the temperature of this thermal zone is higher
>>>> -than it, the system will be shutdown or reset by hardware.
>>>> +- the "critical" type trip points will be used to set the temperature at which
>>>> +the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
>>>> +property is missing. When the thermtrips property is present, the breach of a
>>>> +critical trip point is reported back to the thermal framework to implement
>>>> +software shutdown.
>>>
>>> This hardly seems like a NVidia specific concept. A h/w shutdown 
>>> temperature... Come up with something common.
>>
>> Hi Rob,
>> In current thermal framework, it doesn't support to set h/w shutdown
>> trips, the "critical" trip is used for s/w shutdown. I noticed that in
>> rockchip-thermal driver, it also used "rockchip,hw-tshut-temp" to set
>> h/w shutdown temperature.
> 
> Why a critical trip point cannot be used for your hw shutdown too?

Hi Eduardo,
The thermal framework handle the critical type trip point in
handle_critical_trips(), it will call orderly_poweroff to shutdown
system gracefully.
"
        if (trip_type == THERMAL_TRIP_CRITICAL) {
...
                if (!power_off_triggered) {
                        /*
                         * Queue a backup emergency shutdown in the event of
                         * orderly_poweroff failure
                         */
                        thermal_emergency_poweroff();
                        orderly_poweroff(true);
                        power_off_triggered = true;
                }
"
And in this change, we added a new property to handle hw shutdown for
Tegra. When trigger the hw shutdown trip point, the hw will cut the
power to poweroff directly. If the temperature is raised very quickly,
the hardware can shutdown system before s/w shutdown.

Thanks.
Wei.

> 
>>
>>>
>>> Also, we already have a temperature table. Why do we need temperatures 
>>> in 2 places.
>>
>> Sorry, what do you mean temperature table? Do you mean the trip nodes?
>>
>> Thanks.
>> Wei.
>>
>>>
>>>> +
>>>>  - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
>>>>  temperature. Once the the temperature of this thermal zone is higher
>>>>  than it, it will trigger the HW throttle event.
>>>> @@ -79,6 +90,9 @@ Example :
>>>>  
>>>>  		#thermal-sensor-cells = <1>;
>>>>  
>>>> +		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
>>>> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
>>>> +
>>>>  		throttle-cfgs {
>>>>  			/*
>>>>  			 * When the "heavy" cooling device triggered,
>>>> -- 
>>>> 2.7.4
>>>>
