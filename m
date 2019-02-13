Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D49021934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="REZi4wN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392664AbfBMQYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:24:31 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3183 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:24:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6444c10000>; Wed, 13 Feb 2019 08:24:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Feb 2019 08:24:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Feb 2019 08:24:29 -0800
Received: from [172.17.136.14] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Feb
 2019 16:24:29 +0000
Subject: Re: [PATCH V2] arm64: tegra: add topology data for Tegra194 cpu
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190131222517.GB13156@mithrandir>
 <1549928827-14006-1-git-send-email-byan@nvidia.com>
 <20190213081252.GA647@ulmo>
X-Nvconfidentiality: public
From:   Bo Yan <byan@nvidia.com>
Message-ID: <705dcfd2-0808-2c50-d73f-97050bf876f0@nvidia.com>
Date:   Wed, 13 Feb 2019 08:24:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213081252.GA647@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550075073; bh=UclfUCethAx4spVjmkQXGT7PLw5oZe23bVhYJx1K/pQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=REZi4wN7xlDzS3S1/d4QxzsqAoQ6ePmIgx3DdzrpaN40DljF2ahGW99prZ8wM8yWp
         E9/X+jNulpr6pL730NxT9PCyfsqeZ9YxxEg/oIJnNeRwEDE3UzDeZ7UzqdZ+AJlslE
         JPg2d//Ig1rInzS1m1t+fl6E2T9+u4xnB5icEZxSs9kffSN/o++6DnPfkqB1/LhMsQ
         uYFKS2/TAcqKQRUyQ9Rx0DsiYH0UU6DM4gVvlahrqmcijaMysw/2LnHCO8xBBBPr3n
         9dQzkeLDCnjFXqvDW+BYkeag+z6YhHgCX3XvM5c5TcRVYkiNe7074Oq4JGzcPalKOc
         tTV8uAGCf/s+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree, will update this patch with full paths replacing phandles.

On 2/13/19 12:12 AM, Thierry Reding wrote:
> On Mon, Feb 11, 2019 at 03:47:07PM -0800, Bo Yan wrote:
>> The xavier CPU architecture includes 8 CPU cores organized in
>> 4 clusters. Add cpu-map data for topology initialization, this
>> fixes the topology information in
>> /sys/devices/system/cpu/cpu[n]/topology
>>
>> Signed-off-by: Bo Yan <byan@nvidia.com>
>> ---
>> V2: remove cache nodes, add topology data only
>>
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 58 +++++++++++++++++++++++++++-----
>>   1 file changed, 50 insertions(+), 8 deletions(-)
> 
> This mostly looks good to me. One minor comment below.
> 
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index 6dfa1ca..35e6e76 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -870,56 +870,98 @@
>>   		#address-cells = <1>;
>>   		#size-cells = <0>;
>>   
>> -		cpu@0 {
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&cl0_0>;
> 
> I wonder if perhaps in this case it would be better to use the full path
> to refer to the phandle here. That way we can avoid the labels, which
> are somewhat cumbersome to write and the hierarchy, in my opinion, is a
> much more natural way to reference these.
> 
> What I'm suggesting would look roughly like this:
> 
> 		cpu-map {
> 			cluster0 {
> 				core0 {
> 					cpu = <&{/cpus/cpu@0}>;
> 				};
> 
> 				core1 {
> 					cpu = <&{/cpus/cpu@1}>;
> 				};
> 			};
> 
> 			cluster1 {
> 				core0 {
> 					cpu = <&{/cpus/cpu@2}>;
> 				};
> 
> 				core1 {
> 					cpu = <&{/cpus/cpu@3}>;
> 				};
> 			};
> 
> 			...
> 		};
> 
> That's slightly more characters, but I think it's much easier to read
> than the labels.
> 
> I don't feel very strongly about it, though, so feel free to keep this
> as-is if you prefer.
> 
> Thierry
> 
