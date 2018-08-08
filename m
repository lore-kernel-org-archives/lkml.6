Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F579C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28407219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QnOQ/p/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28407219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHHPaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:30:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47694 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:30:52 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w78DAxSX076597;
        Wed, 8 Aug 2018 08:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533733859;
        bh=gheEamDOl8huH9UNfD1KACLpgbz95RaSovwHxA7A2gM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QnOQ/p/AxeF4g5WW+vOLpare21P64y2iOLky3HlC1AbW63TCK+/VjhdtcSa1Xtzqc
         GOZzmXx+Ds1tJ35H5xtn9oKknhcUbhbWoG/rgxEIEaBW7OIk9KG2Tj6chzrOiEKFMp
         FO461XkKHv89Ss6eNxK5h6AAfgiHY/k3a+8f0xtM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78DAxFh008528;
        Wed, 8 Aug 2018 08:10:59 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 08:10:58 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 08:10:58 -0500
Received: from [172.22.218.79] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78DApoK008001;
        Wed, 8 Aug 2018 08:10:53 -0500
Subject: Re: [PATCH] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
To:     Tony Lindgren <tony@atomide.com>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <baolin.wang@linaro.org>, <d-gerlach@ti.com>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
 <20180808065852.GO99251@atomide.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <0f6601d6-5b14-8d1f-65db-2b8b5a50397d@ti.com>
Date:   Wed, 8 Aug 2018 18:40:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808065852.GO99251@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2018 12:28 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180807 09:29]:
>> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
>> add the flag for all the other SoCs.
>>
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks Tony. Lokesh pointed out about am43x-epos. So will make a minor 
correction to this patch with compatible. I searched all the am4 boards 
& seems like ti,am43 is the most generic compatible cover am43x-epos as 
well. So i will retain your ack and send a v2 with am43 compatible 
changed to a more generic ti,am43.

> 
>> ---
>>   drivers/clocksource/timer-ti-32k.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
>> index 29e2e1a..dd09171 100644
>> --- a/drivers/clocksource/timer-ti-32k.c
>> +++ b/drivers/clocksource/timer-ti-32k.c
>> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
>>   		return -ENXIO;
>>   	}
>>   
>> +	if (!of_machine_is_compatible("ti,am4372"))
>> +		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>> +
>>   	ti_32k_timer.counter = ti_32k_timer.base;
>>   
>>   	/*
>> -- 
>> 1.9.1
>>
