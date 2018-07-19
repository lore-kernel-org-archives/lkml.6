Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4FEC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DD420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XyPrFd6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DD420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeGSMgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:36:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41104 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeGSMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:36:46 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6JBrKsD069283;
        Thu, 19 Jul 2018 06:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532001200;
        bh=Q8wOBT4hGq3VHqkmxus8JPUwH6ENISr04Y5zcLHZjjQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XyPrFd6Tb4vSMn00bZAKZ+URNH5/DFdxgo7MX205yiUVQEQ83ES32MXpZ6KZwWqnE
         YbxCja5L9tyJiH1PSCvelD5PwPHLZWFAVagGZ2hlpvHEdMI2I3j+AJ3Kn4cdS4RWd2
         MLIuN4KjsXVBm9f0fiSZF4qPPCenf0YMh7dgEYIQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JBrJiL001045;
        Thu, 19 Jul 2018 06:53:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 19
 Jul 2018 06:53:19 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 19 Jul 2018 06:53:19 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JBrGtA031549;
        Thu, 19 Jul 2018 06:53:17 -0500
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
To:     Johan Hovold <johan@kernel.org>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <t-kristo@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
Date:   Thu, 19 Jul 2018 17:23:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180719100229.GQ10204@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
>> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
>> over try again.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v4:
>>
>>   * Fixed a compilation issue.
>>   * Extended the roll over check post interrupt programming.
>>
>>  drivers/rtc/rtc-omap.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 323ff55..88da927 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
> 
> First, the comment above this function would need to be updated as part
> of this patch as it refers to the two-second alarm offset.

Yes, will change that.

> 
>> @@ -435,17 +435,23 @@ static void omap_rtc_power_off(void)
>>  	struct rtc_time tm;
>>  	unsigned long now;
>>  	u32 val;
>> +	int seconds;
>>  
>>  	rtc->type->unlock(rtc);
>>  	/* enable pmic_power_en control */
>>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>>  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>>  
>> -	/* set alarm two seconds from now */
>> +again:
>> +	/* Clear any existing ALARM2 event */
>> +	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
> 
> Why is this needed? Any pending interrupt is cleared at probe, and a
> previous attempt to set the alarm really led to the alarm going off, why
> would we retry?

Yes this is not needed.

> 
>> +
>> +	/* set alarm one second from now */
>>  	omap_rtc_read_time_raw(rtc, &tm);
>> +	seconds = tm.tm_sec;
>>  	bcd2tm(&tm);
>>  	rtc_tm_to_time(&tm, &now);
>> -	rtc_time_to_tm(now + 2, &tm);
>> +	rtc_time_to_tm(now + 1, &tm);
>>  
>>  	if (tm2bcd(&tm) < 0) {
>>  		dev_err(&rtc->rtc->dev, "power off failed\n");
>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> 
> Add a newline here.

Okay

> 
>> +	/* Our calculations started right before the rollover, try again */
> 
> Nit: use all lower case unless writing full sentences, which also
> matches most of the other comments in this file.

okay

> 
>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>> +		goto again;
> 
> Here the alarm may have gone off as part of the roll over, in which case
> you shouldn't retry.

Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.

In the event of Roll over before setting the
OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
not miss the ALARM2 event? Then poweroff would fail right?

Hence the attempt to retry the next second. This sequence would begin
right at the beginning of a new second and we expect the full sequence
to get over without having to retry again.

Hope i am clear.

> 
> Add a newline here too.

Okay

> 
>>  	rtc->type->lock(rtc);
>>  
>>  	/*
> 
> Thanks,
> Johan
> 
