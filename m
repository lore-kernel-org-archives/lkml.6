Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EB4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC17C217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZvRR9f05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfBSGbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:31:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15132 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:31:32 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6ba2c20000>; Mon, 18 Feb 2019 22:31:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 22:31:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 22:31:31 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 06:31:28 +0000
Subject: Re: [PATCH v1 11/12] of: Add bindings of OC hw throttle for Tegra
 soctherm
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-13-git-send-email-wni@nvidia.com>
 <20190218203204.GA12911@bogus>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <9b489907-d776-230b-7e82-df823ad72854@nvidia.com>
Date:   Tue, 19 Feb 2019 14:31:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218203204.GA12911@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550557890; bh=xFImaNPNacPuSNJLjp9m1keBVusYeVj1Q5xGbHlML2w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZvRR9f05zYF2X2P8S3kpTjzSp6ck4PGSi2WHD+JlfVXSkCqrDO4n0Vf5373LhhSga
         ZA8SyracJP2A9DtcVBKc1V5uhSh8ldkD2+UFU7MBj17MCjAUQWlUUGdGgw9xzFnoj1
         8/KpMj6LfwASHtGO/tO642lHdk/LpHpb4xZb6IOuno5+RdiNPF4biroN0n5MrAwCG8
         dpO00EoJzW9w/W2Tq1/dajmVZEsC5MbsPELCxKEYFzBI35Zw2JxlifR52LQtxbSr0k
         ZVT3IMw3dY4eoGv7wmy6J4nPvcpmBqfuyS1FQgakkRM3CNi9WmBwPwSY+BL1f7SLaB
         9d22FRMy3k/vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/2/2019 4:32 AM, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 03:34:43PM +0800, Wei Ni wrote:
>> Add OC HW throttle configuration for soctherm in DT.
>> It is used to describe the OCx throttle events.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> index cf6d0be56b7a..d112a8e59ec3 100644
>> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> @@ -64,6 +64,21 @@ Required properties :
>>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>>          See ./thermal.txt for a description of this property.
>>  
>> +      Optional properties: The following properties are T210 specific and
>> +      valid only for OCx throttle events.
>> +      - nvidia,count-threshold: Specifies the number of OC events that are
>> +        required for triggering an interrupt. Interrupts are not triggered if
>> +        the property is missing. A value of 0 will interrupt on every OC alarm.
>> +      - nvidia,polarity-active-low: Configures the polarity of the OC alaram
>> +        signal. Accepted values are 1 for assert low and 0 for assert high.
>> +        Default value is 0.
> 
> Why not boolean?

Ok, will change to use boolean.

> 
>> +      - nvidia,alarm-filter: Number of clocks to filter event. When the filter
>> +        expires (which means the OC event has not occurred for a long time),
>> +        the counter is cleared and filter is rearmed. Default value is 0.
>> +      - nvidia,throttle-period: Specifies the number of uSec for which
>> +        throttling is engaged after the OC event is deasserted. Default value
>> +        is 0.
> 
> Needs a unit suffix as defined in property-units.txt.

Yes, will add suffix "-us" for it.

> 
>> +
>>  Optional properties:
>>  - nvidia,thermtrips : When present, this property specifies the temperature at
>>    which the soctherm hardware will assert the thermal trigger signal to the
>> @@ -134,6 +149,17 @@ Example :
>>  			 * arbiter will select the highest priority as the final throttle
>>  			 * settings to skip cpu pulse.
>>  			 */
>> +
>> +			throttle_oc1: oc1 {
>> +				nvidia,priority = <50>;
>> +				nvidia,polarity-active-low = <1>;
>> +				nvidia,count-threshold = <100>;
>> +				nvidia,alarm-filter = <5100000>;
>> +				nvidia,throttle-period = <0>;
>> +				nvidia,cpu-throt-percent = <75>;
>> +				nvidia,gpu-throt-level =
>> +						<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
>> +                        };
>>  		};
>>  	};
>>  
>> -- 
>> 2.7.4
>>
