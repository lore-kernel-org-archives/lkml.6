Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6507C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A38A2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L/7zPMUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A38A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934136AbeGDIaR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:30:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGDIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:30:13 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w648Ttb9125145;
        Wed, 4 Jul 2018 03:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530692995;
        bh=lwLJS7sTV0kQ+Ktu+lieCH8oT83zdFyiT3c4TZ9gx5c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L/7zPMURx24c3Gf3ZGpfXNMsSFiF2AkYV7g0J3XdCF2N6+biA1zHigoq7FTSLVeEf
         rMMO24c1izjwzqST3yL9QGR8BnDOgbnS22nV8F5rL3SPksQmmanaMke+zt0gHxR019
         15j64ecWSAYF6WlLqO2hPHQVMVulWyPMrGfj9j38=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w648TtLv000438;
        Wed, 4 Jul 2018 03:29:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 4 Jul
 2018 03:29:54 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 4 Jul 2018 03:29:54 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w648Tqx4023283;
        Wed, 4 Jul 2018 03:29:53 -0500
Subject: Re: [PATCH] rtc: OMAP: Add support for rtc-only mode
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <t-kristo@ti.com>,
        <linux-rtc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1530686025-546-1-git-send-email-j-keerthy@ti.com>
 <20180704074103.GG14626@piout.net>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <201d1fb6-a466-bc77-1924-bb8f15b8e3ba@ti.com>
Date:   Wed, 4 Jul 2018 13:59:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180704074103.GG14626@piout.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 04 July 2018 01:11 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 04/07/2018 12:03:45+0530, Keerthy wrote:
>> Prepare rtc driver for rtc-only mode. This involes splitting the power-off
>> function so that an external driver can initiate the programming of
>> setting the power_off to be triggered in the next second.
>>
> 
> I'm sorry, I don't see the point, can't you use
> of_device_is_system_power_controller and set the correct pm_power_off
> callback?

Thanks for the quick response.

The commit message did not capture that point apologies for that.
Basically there are two parts to this:

1) RTC plus DDR in self-refresh is power a saving mode where in the
entire system including the different voltage rails from PMIC are
shutdown except the ones feeding on to RTC and DDR. DDR is kept in
self-refresh hence the contents are preserved. RTC ALARM2 is connected
to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
ALARM1 triggers waking up the system[1]. The control goes to bootloader.
The bootloader then checks RTC scratchpad registers to confirm it was an
rtc_only wakeup and follows a different path, configure bare minimal
clocks for ddr and then jumps to the resume address in another RTC
scratchpad registers and transfers the control to Kernel. Kernel then
restores the saved context. omap_rtc_power_off_program does the ALARM2
programming part.

     [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884

2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
above omap_rtc_power_off_program function and in addition to that
programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
the pushbutton and shuts off the PMIC.

Hence the split in omap_rtc_power_off. The omap_rtc_power_off_program
caters to rtc_only mode which is NOT poweroff but more of a timed boot.

I can add all the details in the commit message in the next version.

Thanks for pointing to of_device_is_system_power_controller function i
can use this while assigning the pm_power_off function.

> 
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/rtc/interface.c |  12 ++++
>>  drivers/rtc/rtc-omap.c  | 164 ++++++++++++++++++++++++++++++++++--------------
>>  include/linux/rtc.h     |   2 +
>>  3 files changed, 130 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>> index 6d4012d..d8b70f0 100644
>> --- a/drivers/rtc/interface.c
>> +++ b/drivers/rtc/interface.c
>> @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>>  	trace_rtc_set_offset(offset, ret);
>>  	return ret;
>>  }
>> +
>> +/**
>> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
>> + * line and can be used to power off the SoC.
>> + *
>> + * Kernel interface to program rtc to power off
>> + */
>> +void rtc_power_off_program(struct rtc_device *rtc)
>> +{
>> +	rtc->ops->power_off_program(rtc->dev.parent);
>> +}
>> +EXPORT_SYMBOL_GPL(rtc_power_off_program);
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 3908639..4dcee1c 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/pinctrl/pinconf-generic.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/regulator/machine.h>
>>  #include <linux/rtc.h>
>>  
>>  /*
>> @@ -131,6 +132,8 @@
>>  #define	KICK0_VALUE			0x83e70b13
>>  #define	KICK1_VALUE			0x95a4f1e0
>>  
>> +#define SHUTDOWN_TIME_SEC		1
>> +
>>  struct omap_rtc;
>>  
>>  struct omap_rtc_device_type {
>> @@ -415,6 +418,77 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>>  
>>  static struct omap_rtc *omap_rtc_power_off_rtc;
>>  
>> +/**
>> + * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
>> + * generates pmic_pwr_enable control, which can be used to control an external
>> + * PMIC.
>> + */
>> +void omap_rtc_power_off_program(struct device *dev)
>> +{
>> +	u32 val;
>> +	struct rtc_time tm;
>> +	unsigned long time;
>> +	int seconds;
>> +
>> +	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
>> +
>> +	/* Clear any existing ALARM2 event */
>> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_STATUS_REG,
>> +		   OMAP_RTC_STATUS_ALARM2);
>> +
>> +	pr_info("System will go to power_off state in approx. %d second\n",
>> +		SHUTDOWN_TIME_SEC);
>> +
>> +again:
>> +	/* Read rtc time */
>> +	tm.tm_sec = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG);
>> +	seconds = tm.tm_sec;
>> +	tm.tm_min = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_MINUTES_REG);
>> +	tm.tm_hour = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_HOURS_REG);
>> +	tm.tm_mday = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_DAYS_REG);
>> +	tm.tm_mon = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_MONTHS_REG);
>> +	tm.tm_year = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_YEARS_REG);
>> +	bcd2tm(&tm);
>> +
>> +	/* Convert Gregorian date to seconds since 01-01-1970 00:00:00 */
>> +	rtc_tm_to_time(&tm, &time);
>> +
>> +	/* Convert seconds since 01-01-1970 00:00:00 to Gregorian date */
>> +	rtc_time_to_tm(time + SHUTDOWN_TIME_SEC, &tm);
>> +
>> +	if (tm2bcd(&tm) < 0)
>> +		return;
>> +
>> +	/* After wait_not_busy, we have at least 15us until the next second. */
>> +	rtc_wait_not_busy(omap_rtc_power_off_rtc);
>> +
>> +	/* Our calculations started right before the rollover, try again */
>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>> +		goto again;
>> +
>> +	/*
>> +	 * pmic_pwr_enable is controlled by means of ALARM2 event. So here
>> +	 * programming alarm2 expiry time and enabling alarm2 interrupt
>> +	 */
>> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_SECONDS_REG,
>> +		  tm.tm_sec);
>> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_MINUTES_REG,
>> +		  tm.tm_min);
>> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_HOURS_REG,
>> +		  tm.tm_hour);
>> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_DAYS_REG,
>> +		  tm.tm_mday);
>> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_MONTHS_REG,
>> +		  tm.tm_mon);
>> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_YEARS_REG,
>> +		  tm.tm_year);
>> +
>> +	/* Enable alarm2 interrupt */
>> +	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_INTERRUPTS_REG);
>> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_INTERRUPTS_REG, val |
>> +		   OMAP_RTC_INTERRUPTS_IT_ALARM2);
>> +}
>> +
>>  /*
>>   * omap_rtc_poweroff: RTC-controlled power off
>>   *
>> @@ -431,45 +505,19 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>>   */
>>  static void omap_rtc_power_off(void)
>>  {
>> -	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
>> -	struct rtc_time tm;
>> -	unsigned long now;
>> +	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
>>  	u32 val;
>>  
>> -	rtc->type->unlock(rtc);
>> -	/* enable pmic_power_en control */
>> -	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>> -	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>> -
>> -	/* set alarm two seconds from now */
>> -	omap_rtc_read_time_raw(rtc, &tm);
>> -	bcd2tm(&tm);
>> -	rtc_tm_to_time(&tm, &now);
>> -	rtc_time_to_tm(now + 2, &tm);
>> -
>> -	if (tm2bcd(&tm) < 0) {
>> -		dev_err(&rtc->rtc->dev, "power off failed\n");
>> -		return;
>> -	}
>> -
>> -	rtc_wait_not_busy(rtc);
>> +	regulator_suspend_prepare(PM_SUSPEND_MAX);
>> +	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
>> +	omap_rtc_power_off_program(rtc->dev.parent);
>>  
>> -	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
>> -	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
>> -	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
>> -	rtc_write(rtc, OMAP_RTC_ALARM2_DAYS_REG, tm.tm_mday);
>> -	rtc_write(rtc, OMAP_RTC_ALARM2_MONTHS_REG, tm.tm_mon);
>> -	rtc_write(rtc, OMAP_RTC_ALARM2_YEARS_REG, tm.tm_year);
>> -
>> -	/*
>> -	 * enable ALARM2 interrupt
>> -	 *
>> -	 * NOTE: this fails on AM3352 if rtc_write (writeb) is used
>> -	 */
>> -	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>> -	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>> -			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
>> -	rtc->type->lock(rtc);
>> +	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
>> +	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
>> +	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
>> +	       OMAP_RTC_PMIC_EXT_WKUP_EN(0);
>> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
>> +	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
>>  
>>  	/*
>>  	 * Wait for alarm to trigger (within two seconds) and external PMIC to
>> @@ -477,6 +525,17 @@ static void omap_rtc_power_off(void)
>>  	 * (e.g. debounce circuits).
>>  	 */
>>  	mdelay(2500);
>> +
>> +	pr_err("rtc_power_off failed, bailing out.\n");
>> +}
>> +
>> +static void omap_rtc_cleanup_pm_power_off(struct omap_rtc *rtc)
>> +{
>> +	if (pm_power_off == omap_rtc_power_off &&
>> +	    omap_rtc_power_off_rtc == rtc) {
>> +		pm_power_off = NULL;
>> +		omap_rtc_power_off_rtc = NULL;
>> +	}
>>  }
>>  
>>  static const struct rtc_class_ops omap_rtc_ops = {
>> @@ -485,6 +544,7 @@ static void omap_rtc_power_off(void)
>>  	.read_alarm	= omap_rtc_read_alarm,
>>  	.set_alarm	= omap_rtc_set_alarm,
>>  	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
>> +	.power_off_program = omap_rtc_power_off_program,
>>  };
>>  
>>  static const struct omap_rtc_device_type omap_rtc_default_type = {
>> @@ -838,6 +898,11 @@ static int omap_rtc_probe(struct platform_device *pdev)
>>  	rtc->type->lock(rtc);
>>  
>>  	device_init_wakeup(&pdev->dev, true);
>> +	omap_rtc_power_off_rtc = rtc;
>> +
>> +	if (rtc->is_pmic_controller)
>> +		if (!pm_power_off)
>> +			pm_power_off = omap_rtc_power_off;
>>  
>>  	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
>>  	if (IS_ERR(rtc->rtc)) {
>> @@ -887,6 +952,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  err:
>> +	omap_rtc_cleanup_pm_power_off(rtc);
>>  	clk_disable_unprepare(rtc->clk);
>>  	device_init_wakeup(&pdev->dev, false);
>>  	rtc->type->lock(rtc);
>> @@ -901,11 +967,7 @@ static int omap_rtc_remove(struct platform_device *pdev)
>>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
>>  	u8 reg;
>>  
>> -	if (pm_power_off == omap_rtc_power_off &&
>> -			omap_rtc_power_off_rtc == rtc) {
>> -		pm_power_off = NULL;
>> -		omap_rtc_power_off_rtc = NULL;
>> -	}
>> +	omap_rtc_cleanup_pm_power_off(rtc);
>>  
>>  	device_init_wakeup(&pdev->dev, 0);
>>  
>> @@ -993,14 +1055,20 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
>>  	u8 mask;
>>  
>> -	/*
>> -	 * Keep the ALARM interrupt enabled to allow the system to power up on
>> -	 * alarm events.
>> -	 */
>>  	rtc->type->unlock(rtc);
>> -	mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>> -	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
>> -	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
>> +	/* If rtc does not control PMIC then no need to enable ALARM */
>> +	if (!rtc->is_pmic_controller) {
>> +		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
>> +	} else {
>> +		/*
>> +		 * Keep the ALARM interrupt enabled to allow the system to
>> +		 * power up on alarm events.
>> +		 */
>> +		mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>> +		mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
>> +		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
>> +	}
>> +
>>  	rtc->type->lock(rtc);
>>  }
>>  
>> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
>> index 6268208..f17bc6a 100644
>> --- a/include/linux/rtc.h
>> +++ b/include/linux/rtc.h
>> @@ -85,6 +85,7 @@ struct rtc_class_ops {
>>  	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
>>  	int (*read_offset)(struct device *, long *offset);
>>  	int (*set_offset)(struct device *, long offset);
>> +	void (*power_off_program)(struct device *dev);
>>  };
>>  
>>  typedef struct rtc_task {
>> @@ -229,6 +230,7 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
>>  int rtc_read_offset(struct rtc_device *rtc, long *offset);
>>  int rtc_set_offset(struct rtc_device *rtc, long offset);
>>  void rtc_timer_do_work(struct work_struct *work);
>> +void rtc_power_off_program(struct rtc_device *rtc);
>>  
>>  static inline bool is_leap_year(unsigned int year)
>>  {
>> -- 
>> 1.9.1
>>
> 
