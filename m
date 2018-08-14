Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D348DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB2C21733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OeX8c+MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB2C21733
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeHNMTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:19:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53476 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeHNMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:19:43 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7E9W7Z3117074;
        Tue, 14 Aug 2018 04:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534239127;
        bh=dp46vi/iPKkMOTlDF+fROOBpv8v3A66vPbcJRfijYuw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OeX8c+MYOunBd2jw77ap+EuSDqpcEk74mKRv+/uzW1ZRRImTIRgSXhPFmyCzMRpUq
         aL+L8KLR7DgwOPp+8NTfI56mZjTqjsdi09gH3WA11dvlxmG4/n4zTI4XQLrHqeMcv+
         fqsbQFwPwNK70T3DpX0/90ATIWzLvnSfg94wLikc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7E9W7va001797;
        Tue, 14 Aug 2018 04:32:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 14
 Aug 2018 04:32:07 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 14 Aug 2018 04:32:07 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7E9W49I010319;
        Tue, 14 Aug 2018 04:32:05 -0500
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <t-kristo@ti.com>,
        <linux-rtc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan@kernel.org>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
 <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
 <20180725093018.GA3539@piout.net>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <87ea901f-2a0b-007e-530a-0ca0e9392829@ti.com>
Date:   Tue, 14 Aug 2018 15:02:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180725093018.GA3539@piout.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 25 July 2018 03:00 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 25/07/2018 11:21:22+0530, Keerthy wrote:
>> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
>> over try again.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v5:
>>
>>   * Added an additional check to see if ALARM2 status is not set
>>     before retrying.
>>   * Cleaned up comments
>>   * Also reduced mdelay to 1S lesser as per this commit
>>
>>  drivers/rtc/rtc-omap.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 44ff4cc..caa6da6 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -421,12 +421,6 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>>   * The RTC can be used to control an external PMIC via the pmic_power_en pin,
>>   * which can be configured to transition to OFF on ALARM2 events.
>>   *
>> - * Notes:
>> - * The two-second alarm offset is the shortest offset possible as the alarm
>> - * registers must be set before the next timer update and the offset
>> - * calculation is too heavy for everything to be done within a single access
>> - * period (~15 us).
>> - *
>>   * Called with local interrupts disabled.
>>   */
>>  static void omap_rtc_power_off(void)
>> @@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
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
>> @@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
>> +
>> +	/*
>> +	 * first check if ALARM2 has fired, if not then check if
>> +	 * our calculations started right before the rollover, try again
>> +	 * in case of rollover
>> +	 */
>> +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
>> +						 OMAP_RTC_STATUS_REG)) &&
>> +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>> +		goto again;
>> +
> 
> Can you use a while loop instead of goto?

Apologies for the late reply. A one time retry should be able to take
care of the exception case.

> 
>>  	rtc->type->lock(rtc);
>>  
>>  	/*
>> -	 * Wait for alarm to trigger (within two seconds) and external PMIC to
>> +	 * Wait for alarm to trigger (within one second) and external PMIC to
>>  	 * power off the system. Add a 500 ms margin for external latencies
>>  	 * (e.g. debounce circuits).
>>  	 */
>> -	mdelay(2500);
>> +	mdelay(1500);
>>  }
>>  
>>  static const struct rtc_class_ops omap_rtc_ops = {
>> -- 
>> 1.9.1
>>
> 
