Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D8FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142D21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O3bs5ZdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbfBOIrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:47:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42948 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfBOIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:47:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8l45F009427;
        Fri, 15 Feb 2019 02:47:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550220424;
        bh=nUJepTBtTwngvi6oNNkiaprUXgTouPzurWm6N7pL0Qo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O3bs5ZdHdFbv+U/iFhy82Gb8IBttho4URzllTvOZKrxd4oJYdg2LMGxmLe4QcvFCw
         IgubyvMVV5dJHXBTLW5Uda7LVBLwJAbHWX1INVPG2ra2hDbTmCR7ZFtQp3y4YK9Al3
         9bs8NmysBNV6dseoyR653YpelQ42STajPfBey8Zw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8l47Z111923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 02:47:04 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:47:02 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:47:02 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8kx90019290;
        Fri, 15 Feb 2019 02:46:59 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Add MSMC RAM node
To:     Roger Quadros <rogerq@ti.com>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        "Andrew F . Davis" <afd@ti.com>
References: <1547199855-16374-1-git-send-email-rogerq@ti.com>
 <5C5980B6.4010502@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <a2227e9f-dd47-cc33-b0f2-0be682462d36@ti.com>
Date:   Fri, 15 Feb 2019 10:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C5980B6.4010502@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 14:25, Roger Quadros wrote:
> Tero,
> 
> On 11/01/19 11:44, Roger Quadros wrote:
>> The AM65 SoC has 2MB MSMC RAM. Add this as a mmio-sram
>> node so drivers can use it via genpool API.
>>
>> Following areas are marked reserved:
>> - Lower 128KB for ATF
>> - 64KB@0xf0000 for SYSFW
>> - Upper 1MB for cache
>>
>> The reserved locations are subject to change at runtime by
>> the bootloader.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Lokesh Vutla <lokeshvutla@ti.com>
>> Cc: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Is this patch good to pick for -next?

Queued for 5.1, thanks.

-Tero

> 
> cheers,
> -roger
> 
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 272cf8f..5a18150 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -6,6 +6,26 @@
>>    */
>>   
>>   &cbass_main {
>> +	msmc_ram: sram@70000000 {
>> +		compatible = "mmio-sram";
>> +		reg = <0x0 0x70000000 0x0 0x200000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x70000000 0x200000>;
>> +
>> +		atf-sram@0 {
>> +			reg = <0x0 0x20000>;
>> +		};
>> +
>> +		sysfw-sram@f0000 {
>> +			reg = <0xf0000 0x10000>;
>> +		};
>> +
>> +		l3cache-sram@100000 {
>> +			reg = <0x100000 0x100000>;
>> +		};
>> +	};
>> +
>>   	gic500: interrupt-controller@1800000 {
>>   		compatible = "arm,gic-v3";
>>   		#address-cells = <2>;
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
