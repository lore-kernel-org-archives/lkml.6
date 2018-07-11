Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCF820C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KrjHZL0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCF820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbeGKQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:22:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59588 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733263AbeGKQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:22:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6BGGk66033905;
        Wed, 11 Jul 2018 11:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531325806;
        bh=mf9muP2rk8Ql/2uli2xR1x6064iV0j4mTELd+3Affmo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KrjHZL0ghtT8L6bhgRs6dxXVLfiKkAVAhCYgqCbaZ5bnmQGL2CRQ9E5lWXWQc+Gd7
         6Z23WqVd4gMmVgL6qagCoIrvPESIbKA5eLb2qFtCrzxBwGprrqtEZvjYn6B89jrBLa
         igLypl9gWRKEN2Cjm5oa/MM5rjOTmq3P0lewl654=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BGGkRQ000809;
        Wed, 11 Jul 2018 11:16:46 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 11
 Jul 2018 11:16:45 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 11 Jul 2018 11:16:45 -0500
Received: from [172.22.219.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BGGgN1023131;
        Wed, 11 Jul 2018 11:16:43 -0500
Subject: Re: [PATCH v3 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
To:     Johan Hovold <johan@kernel.org>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <t-kristo@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
 <1531205452-6086-2-git-send-email-j-keerthy@ti.com>
 <20180711135444.GC12517@localhost>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <cf50def4-9ff8-a921-521a-c568b4987b89@ti.com>
Date:   Wed, 11 Jul 2018 21:46:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711135444.GC12517@localhost>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2018 7:24 PM, Johan Hovold wrote:
> On Tue, Jul 10, 2018 at 12:20:49PM +0530, Keerthy wrote:
>> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
>> over try again.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/rtc/rtc-omap.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 323ff55..14f2241 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -441,11 +441,12 @@ static void omap_rtc_power_off(void)
>>   	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>>   	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>>   
>> -	/* set alarm two seconds from now */
>> +again:
>> +	/* set alarm one second from now */
>>   	omap_rtc_read_time_raw(rtc, &tm);
>>   	bcd2tm(&tm);
>>   	rtc_tm_to_time(&tm, &now);
>> -	rtc_time_to_tm(now + 2, &tm);
>> +	rtc_time_to_tm(now + 1, &tm);
>>   
>>   	if (tm2bcd(&tm) < 0) {
>>   		dev_err(&rtc->rtc->dev, "power off failed\n");
>> @@ -455,6 +456,10 @@ static void omap_rtc_power_off(void)
>>   
>>   	rtc_wait_not_busy(rtc);
>>   
>> +	/* Our calculations started right before the rollover, try again */
>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>> +		goto again;
> 
> First, this doesn't even compile.

My bad. seconds got introduced in patch 2 and i did not compile test 
this one individually. Apologies for that.

> 
> Second, nothing is preventing the rollover from happening here after the
> check.

Okay. That window cannot be ignored. So 'now + 2' will surely solve 
that. I will stick to that.

> 
>> +
>>   	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
>>   	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
>>   	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
> 
> Johan
> 
