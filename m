Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD5EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA132084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W6Qc60ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbeLQC5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:57:52 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17462 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeLQC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:57:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1710a60001>; Sun, 16 Dec 2018 18:57:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 16 Dec 2018 18:57:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 16 Dec 2018 18:57:50 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Dec
 2018 02:57:47 +0000
Subject: Re: [PATCH v1 1/3] of: add nvidia,thermtrips property
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1544177407-20203-1-git-send-email-wni@nvidia.com>
 <1544177407-20203-2-git-send-email-wni@nvidia.com>
 <20181214142956.GF23379@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <172f3d13-fc7f-209c-8fa7-0d859db7dcb2@nvidia.com>
Date:   Mon, 17 Dec 2018 10:57:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214142956.GF23379@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545015463; bh=E090Ya2UIuWG8/jHGr8qSE69KHuMHlTbw4IJ/FLEcAA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W6Qc60ikOwujeIj9yj4VsTziARX52gwiyQcHW1bfcA+Q45Pz1m+P3tEhHQp52gk7K
         38W31rMEDXJjMwNcTzHzhBHxxgTPY4hRBBKdR0WjU/ACgHwzEpZ46Is/mlJFe0oBKy
         b2XlXVpOzxayqsDqGtdldoyNkgAA0yLrFO/F6FruuXwNaMJk1I1pLekols2VlFRTUs
         yG0yFapn/TIwINn0FqAsQeCc6bFl7KQdbSkhLVG+P8ZHlec3L/1+NQ6uCczJTIAAIA
         vXkqgTwlYT4WkdvJMfgvbKVTFPE0tYG/VWjQODzRU9jIuhqJ5nQGEfTutK9KT8J3AG
         A8Gc0/axbz2XQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2018 10:29 PM, Thierry Reding wrote:
> On Fri, Dec 07, 2018 at 06:10:05PM +0800, Wei Ni wrote:
>> Add optional property "nvidia,thermtrips".
>> If present, these trips will be used as HW shutdown trips,
>> and critical trips will be used as SW shutdown trips.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> This seems like an odd exception. Why not extend the list of trip point
> types with a "shutdown" or "emergency" type that can be used for this?
> This doesn't seem like NVIDIA specific functionality, so adding an
> NVIDIA specific property doesn't seem right.

The thermal framework only support four types "active", "passive",
"hot", "critical". Normally if the "critical" trip is triggered, the
thermal framework will implement a software shutdown. In our soctherm
driver, we also set this "critical" trips to hardware, so it will cause
the HW shutdown directly.
This serial added the "nvidia,thermtrips" to set HW shutdown trips for
our NVIDIA specific functionality, and keep the "critical" trips to
implement SW shutdown.
For example, we will set "critical" trip to 102C, and set
""nvidia,thermtrips" to 103C, it mean if the temperature hit to 102, the
system will be software shutdown, if the temperature increase fast and
up to 103 directly, then it will cause the hardware shutdown.

Thanks.
Wei.

> 
> Also, please always Cc devicetree@vger.kernel.org and the device tree
> bindings maintainers when sending updates for a binding. They need to
> ack these kinds of patches and they can't do that if they don't get a
> copy of the patch.
> 
> Cc'ing them now and quoting the full patch for reference.
> 
> Thierry
> 
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> index b6c0ae53d4dc..ab66d6feab4b 100644
>> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> @@ -55,10 +55,21 @@ Required properties :
>>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>>          See ./thermal.txt for a description of this property.
>>  
>> +Optional properties:
>> +- nvidia,thermtrips : When present, this property specifies the temperature at
>> +  which the soctherm hardware will assert the thermal trigger signal to the
>> +  Power Management IC, which can be configured to reset or shutdown the device.
>> +  It is an array of pairs where each pair represents a tsensor id followed by a
>> +  temperature in milli Celcius. In the absence of this property the critical
>> +  trip point will be used for thermtrip temperature.
>> +
>>  Note:
>> -- the "critical" type trip points will be set to SOC_THERM hardware as the
>> -shut down temperature. Once the temperature of this thermal zone is higher
>> -than it, the system will be shutdown or reset by hardware.
>> +- the "critical" type trip points will be used to set the temperature at which
>> +the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
>> +property is missing. When the thermtrips property is present, the breach of a
>> +critical trip point is reported back to the thermal framework to implement
>> +software shutdown.
>> +
>>  - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
>>  temperature. Once the the temperature of this thermal zone is higher
>>  than it, it will trigger the HW throttle event.
>> @@ -79,6 +90,9 @@ Example :
>>  
>>  		#thermal-sensor-cells = <1>;
>>  
>> +		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
>> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
>> +
>>  		throttle-cfgs {
>>  			/*
>>  			 * When the "heavy" cooling device triggered,
>> -- 
>> 2.7.4
