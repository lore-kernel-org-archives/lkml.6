Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC23C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F7F2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SWpMev0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfBSGIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:08:35 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17991 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSGIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:08:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b9d5f0000>; Mon, 18 Feb 2019 22:08:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 22:08:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 22:08:33 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 06:08:29 +0000
Subject: Re: [PATCH v1 04/12] of: Add bindings of gpu hw throttle for Tegra
 soctherm
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-6-git-send-email-wni@nvidia.com>
 <20190218202939.GA7473@bogus>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <5ce01da3-cb00-3d35-5164-d837df65c184@nvidia.com>
Date:   Tue, 19 Feb 2019 14:08:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218202939.GA7473@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550556513; bh=F4VXMFnxSNm23FFb83QK8MzofUbP12Bnt1hGWLKIul4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SWpMev0UhwORMDbzXuioKEiDpbx4HTP2XJkMHTopoly407O3MTWapr61NTvnVbwq0
         fgN6Qw961LLVJC4KAHsIXX9s+/iDHO5m8KClqKD6ER4GElzKId5U3veNVcr3GXmWQE
         AGltqohhuTg4fvKY0JNGCdLwReiAJQBBheSD1tEnP03ziNEY75qzYAI2FrzIU8ooMM
         9puiYGzEQgwJ67aQWu30sycG0ikZG2wCb/Ok5W5JMASFARCOMamCSqFBWQM1NlzKqF
         rQRekVEwSuaRMOu3SmnbR+m9sY6HNxxGw21kll+e9FuDvkGwIIvNPdrBmaSvUQgWce
         a9NkUjKf1JAIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/2/2019 4:29 AM, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 03:34:36PM +0800, Wei Ni wrote:
>> Add "nvidia,gpu-throt-level" property to set gpu hw
>> throttle level.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 17 +++++++++++++++--
>>  include/dt-bindings/thermal/tegra124-soctherm.h    | 22 ++++++++++++++++++----
>>  2 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> index ab66d6feab4b..cf6d0be56b7a 100644
>> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
>> @@ -52,6 +52,15 @@ Required properties :
>>          Must set as following values:
>>          TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
>>          TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
>> +      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.
>> +        It is the level of pulse skippers, which used to throttle clock
>> +        frequencies. It indicates gpu clock throttling depth and can be
>> +        programmed to any of the following values which represent a throttling
>> +        percentage:
>> +        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
>> +        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
>> +        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
>> +        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
>>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>>          See ./thermal.txt for a description of this property.
>>  
>> @@ -96,22 +105,26 @@ Example :
>>  		throttle-cfgs {
>>  			/*
>>  			 * When the "heavy" cooling device triggered,
>> -			 * the HW will skip cpu clock's pulse in 85% depth
>> +			 * the HW will skip cpu clock's pulse in 85% depth,
>> +			 * skip gpu clock's pulse in 85% level
>>  			 */
>>  			throttle_heavy: heavy {
>>  				nvidia,priority = <100>;
>>  				nvidia,cpu-throt-percent = <85>;
>> +				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
>>  
>>  				#cooling-cells = <1>;
>>  			};
>>  
>>  			/*
>>  			 * When the "light" cooling device triggered,
>> -			 * the HW will skip cpu clock's pulse in 50% depth
>> +			 * the HW will skip cpu clock's pulse in 50% depth,
>> +			 * skip gpu clock's pulse in 50% level
>>  			 */
>>  			throttle_light: light {
>>  				nvidia,priority = <80>;
>>  				nvidia,cpu-throt-percent = <50>;
>> +				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_LOW>;
>>  
>>  				#cooling-cells = <1>;
>>  			};
>> diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
>> index c15e8b709a0d..75853df1c609 100644
>> --- a/include/dt-bindings/thermal/tegra124-soctherm.h
>> +++ b/include/dt-bindings/thermal/tegra124-soctherm.h
>> @@ -1,5 +1,19 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>>  /*
>> + * Copyright (c) 2014 - 2018, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * Author:
>> + *      Mikko Perttunen <mperttunen@nvidia.com>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
> 
> Why are you adding this?

We doesn't need it, will remove it.

> 
>>   * This header provides constants for binding nvidia,tegra124-soctherm.
>>   */
>>  
>> @@ -12,9 +26,9 @@
>>  #define TEGRA124_SOCTHERM_SENSOR_PLLX 3
>>  #define TEGRA124_SOCTHERM_SENSOR_NUM 4
>>  
>> -#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  0
>> -#define TEGRA_SOCTHERM_THROT_LEVEL_MED  1
>> -#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 2
>> -#define TEGRA_SOCTHERM_THROT_LEVEL_NONE -1
>> +#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
>> +#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
>> +#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
>> +#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
> 
> You are breaking an ABI.
> 
> Rob
> 
