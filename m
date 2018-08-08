Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D3F21700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPWwtzTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D3F21700
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeHHL0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:26:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33580 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:26:52 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w78983ih001980;
        Wed, 8 Aug 2018 04:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533719283;
        bh=UF/gtf0xh/GcSZ2JQJumLOViBPJRjRN4UULWmvxxpwo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EPWwtzTwWH7igcrlb5GpNuwOAx5BBs3l6HjAHitraXvYO+msdIY6+XhlEx3mWYUrd
         XEiUi9tcAVgsa10QY/NK+LrlncBhUbXmrFZN/L2rWGIluHZNdieeZJ/goHYCLcQDwv
         9QAdn/niVIuDmyJNPsg0kbXsS4EUG3qmD6U9+y3Q=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78982dQ022269;
        Wed, 8 Aug 2018 04:08:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 04:08:02 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 04:08:02 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78980Ih003647;
        Wed, 8 Aug 2018 04:08:01 -0500
Subject: Re: [PATCH] arm: dts: am4372: setup rtc as system-power-controller
To:     Tony Lindgren <tony@atomide.com>
CC:     <t-kristo@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
 <20180808090607.GR99251@atomide.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <bc07ac40-accc-64aa-a277-063833645545@ti.com>
Date:   Wed, 8 Aug 2018 14:38:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180808090607.GR99251@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 08 August 2018 02:36 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180725 05:59]:
>> RTC alarm2 is connected to pmic_en line and hence can be used to control
>> the pmic enabling/disabling. Hence add the system-power-controller for rtc
>> node.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index f0cbd86..d4b7c59 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -469,6 +469,7 @@
>>  			ti,hwmods = "rtc";
>>  			clocks = <&clk_32768_ck>;
>>  			clock-names = "int-clk";
>> +			system-power-controller;
>>  			status = "disabled";
>>  		};
>>  
> 
> Should this be queued as a fix for v4.19-rc series?

Yes this makes pmic to shutdown during power off.

> 
> Regards,
> 
> Tony
> 
