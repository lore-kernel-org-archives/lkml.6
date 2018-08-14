Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6952175C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N57bhZcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6952175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeHNMm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:42:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34492 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:42:29 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7E9spIt000572;
        Tue, 14 Aug 2018 04:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534240491;
        bh=wycwNPRTYNcFKTOPsOSDTlSOCyaNW7LFl4WDtSV5TcY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=N57bhZcplVUaN8GVihqEw5/2K93cT0iepIAjqbMq+dkdMsf+qLEegByz0QBANdB2C
         n2cYiMBvnJ86749ZZaa02wPY3eLauYU89AaVWTa7DlF9kiHS5czxJYaJte7LMorYyE
         VCAguezbHFa4BfBRyk+fjFy7mDF3pVpMQaQNjX30=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7E9spDu006039;
        Tue, 14 Aug 2018 04:54:51 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 14
 Aug 2018 04:54:51 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 14 Aug 2018 04:54:51 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7E9smlr000927;
        Tue, 14 Aug 2018 04:54:49 -0500
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
To:     Johan Hovold <johan@kernel.org>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <t-kristo@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
 <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
 <20180814092317.GA30344@localhost>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <08a9624e-eb18-53e3-bba9-bacfc9f3cce5@ti.com>
Date:   Tue, 14 Aug 2018 15:24:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180814092317.GA30344@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 14 August 2018 02:53 PM, Johan Hovold wrote:
> On Wed, Jul 25, 2018 at 11:21:22AM +0530, Keerthy wrote:
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
> 
> Nit: I'd place this above val to maintain the reverse xmas-tree style.

okay

> 
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
> 
> This is unnecessarily verbose; I'd rephrase it as something like:
> 
> 	/* Retry in case roll over happened before alarm was armed. */

Okay

> 
>> +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
>> +						 OMAP_RTC_STATUS_REG)) &&
>> +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>> +		goto again;
> 
> And this is clearly broken. First, you use boolean && instead of the &
> bit operation.

Ah my bad. I will fix it.

> 
> Second, you need to check the status register *after* checking for
> roll-over, as I already mentioned.
> 
> Also, use the rtc pointer rather than omap_rtc_power_off_rtc, which will
> allow for more readable code.

Okay

> 
> I also strongly suggest you split the conditional, and use val to store
> the status register value, that is:
> 
> 	if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) != seconds) {
> 		val = rtc_read(rtc, OMAP_RTC_STATUS_REG);
> 		if (!(val & OMAP_RTC_STATUS_ALARM2))
> 			goto again;
> 	}
> 
>> +
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
> 
> Johan
> 
