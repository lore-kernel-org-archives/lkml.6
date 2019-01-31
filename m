Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54076C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D72086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C3FfKWEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfAaX3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:29:38 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10298 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAaX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:29:37 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5384c30000>; Thu, 31 Jan 2019 15:29:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 15:29:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 31 Jan 2019 15:29:35 -0800
Received: from [172.17.136.14] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 23:29:34 +0000
Subject: Re: [PATCH] arm64: tegra: add topology data for Tegra194 cpu
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1548959754-3941-1-git-send-email-byan@nvidia.com>
 <20190131222517.GB13156@mithrandir>
X-Nvconfidentiality: public
From:   Bo Yan <byan@nvidia.com>
Message-ID: <dc0055ca-b9eb-bcc6-1815-2aa482fa7c1f@nvidia.com>
Date:   Thu, 31 Jan 2019 15:29:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131222517.GB13156@mithrandir>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548977347; bh=fShSkGhR9I+0uaotTOFrDSaaZV9VxITLqhqy4Iw9z0k=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=C3FfKWEMuKuLN3kgw8hRT+VMt2iWEXh6nImdrALjaWCvT5UOPFg9mnXz0uySZ8nmP
         tOdkkHcFT2wxQxZD0BD2Ul1rLdqCKkwegGcWXVzEf6/8M/AiEBr5Yq5v8YldZI8UHa
         fOVUOTqDdwo8lz9EHgCt75pFZzAACaec1/SIYRXtsLbWN5THCgr7XUg4jWCNnHGkx2
         hPd7kPU4DFaQQfl6lOnZLXNRacOcTLXRQ7iZni9TiXk9k00jCGFjmBIy3PbfyQnL1a
         MBhAbOyJtbjmjr9vYAJKcn3bt/Ba4jX12St6UyOJWTkifxkQOZOjXpFYw+8ynpeLE1
         6ODf7B3JbpXrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/19 2:25 PM, Thierry Reding wrote:
> On Thu, Jan 31, 2019 at 10:35:54AM -0800, Bo Yan wrote:
>> The xavier CPU architecture includes 8 CPU cores organized in
>> 4 clusters. Add cpu-map data for topology initialization, add
>> cache data for cache node creation in sysfs.
>>
>> Signed-off-by: Bo Yan <byan@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 148 +++++++++++++++++++++++++++++--
>>   1 file changed, 140 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index 6dfa1ca..7c2a1fb 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -870,63 +870,195 @@
>>   		#address-cells = <1>;
>>   		#size-cells = <0>;

> These don't seem to be well-defined. They are mentioned in a very weird
> locations (Documentation/devicetree/booting-without-of.txt) but there
> seem to be examples and other device tree files that use them so maybe
> those are all valid. It might be worth mentioning these in other places
> where people can more easily find them.

It might be logical to place a reference to this document 
(booting-without-of.txt) in architecture specific documents, for 
example, arm/cpus.txt. I see the need for improved documentation, but 
this probably should be best done in a separate change.
> 
> According to the above document, {i,d}-cache-line-size are deprecated in
> favour of {i,d}-cache-block-size.

Mostly, this seems to be derived from the oddity of PowerPC, which might 
have different cache-line-size and cache-block-size. I don't know if 
there are other examples? It looks like the {i,d}-cache-line-size are 
being used in dts files for almost all architectures, the only exception 
is arch/sh/boot/dts/j2_mimas_v2.dts. On ARM and ARM64, cache-line-size 
is the same as cache-block-size. So I am wondering whether the 
booting-without-of.txt should be fixed instead? just to keep it 
consistent among dts files, especially in arm64.

> 
> I also don't see any mention of {i,d}-cache_sets in the device tree
> bindings, though riscv/cpus.txt mentions {i,d}-cache-sets (note the
> hyphen instead of underscore) in the examples. arm/l2c2x0.txt and
> arm/uniphier/cache-unifier.txt describe cache-sets, though that's
> slightly different.
> 
> Might make sense to document all these in more standard places. Maybe
> adding them to arm/cpus.txt. For consistency with other properties, I
> think there should be called {i,d}-cache-sets like for RISC-V.
> 
>> +			l2-cache = <&l2_0>;
> 
> This seems to be called next-level-cache everywhere else, though it's
> only formally described in arm/uniphier/cache-uniphier.txt. So might
> also make sense to add this to arm/cpus.txt.

the improved documentation is certainly desired, I agree.
> 
>>   		};
>>   
>> -		cpu@1 {
>> +		cl0_1: cpu@1 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x10001>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_0>;
>>   		};
>>   
>> -		cpu@2 {
>> +		cl1_0: cpu@2 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x100>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_1>;
>>   		};
>>   
>> -		cpu@3 {
>> +		cl1_1: cpu@3 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x101>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_1>;
>>   		};
>>   
>> -		cpu@4 {
>> +		cl2_0: cpu@4 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x200>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_2>;
>>   		};
>>   
>> -		cpu@5 {
>> +		cl2_1: cpu@5 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x201>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_2>;
>>   		};
>>   
>> -		cpu@6 {
>> +		cl3_0: cpu@6 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x10300>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_3>;
>>   		};
>>   
>> -		cpu@7 {
>> +		cl3_1: cpu@7 {
>>   			compatible = "nvidia,tegra194-carmel", "arm,armv8";
>>   			device_type = "cpu";
>>   			reg = <0x10301>;
>>   			enable-method = "psci";
>> +			i-cache-size = <131072>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <512>;
>> +			d-cache-size = <65536>;
>> +			d-cache-line-size = <64>;
>> +			d-cache_sets = <256>;
>> +			l2-cache = <&l2_3>;
>>   		};
>>   	};
>>   
>> +	l2_0: l2-cache0 {
>> +		cache-size = <2097152>;
>> +		cache-line-size = <64>;
>> +		cache-sets = <2048>;
>> +		next-level-cache = <&l3>;
>> +	};
> 
> Does this need a compatible string? Also, are there controllers behind
> these caches? I'm just wondering if these also need reg properties and
> unit-addresses.

No need for compatible string. No reg properties and addresses. These 
will be parsed by drivers/of/base.c and drivers/base/cacheinfo.c, they 
are generic.
> 
> arm/l2c2x0.txt and arm/uniphier/cache-uniphier.txt describe an
> additional property that you don't specify here: cache-level. This
> sounds useful to have so that we don't have to guess the cache level
> from the name, which may or may not work depending on what people name
> the nodes.

the cache level property is implied in device tree hierarchy, so after 
system boots up, I can find cache level in related sysfs nodes:

     [root@alarm cache]# cat index*/level
     1
     1
     2
     3


> 
> Also, similar to the L1 cache, cache-block-size is preferred over
> cache-line-size.
> 
>> +	l3: l3-cache {
>> +		cache-size = <4194304>;
>> +		cache-line-size = <64>;
>> +		cache-sets = <4096>;
>> +	};
> 
> The same comments apply as for the L2 caches.
> 
> Thierry
> 
