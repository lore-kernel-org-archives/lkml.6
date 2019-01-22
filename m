Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F90021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwx6t/w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfAVOse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:48:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41900 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfAVOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:48:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so11572673plm.8;
        Tue, 22 Jan 2019 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aj/QfMi29RxbfWMS0T22yu10j2M1vxeQW93G/sgXZ/k=;
        b=Cwx6t/w5MtX57BIDQlS6Pg3WyHv+3u/Vi8wvw0EeWHlU2OTXtI5erD6qUl8hxvauns
         ycfUm0brcXZTgqM2oHmOEqLWkjhF88A3LAwDJoHVxPy//Ny3qgnLdPMM7YeHCd6lZ0JZ
         X9Gp5/FmK99DusYvqZxrA8yooiib1bDjrzW1mco2dVUHunzPv/kckx0ElxD9MDrJRY48
         pbSqDogQAdUkf6E7sYmtbZIzwldwdzdPbniGfSq2zDw6pBVe1Go42rUVOCKHPhiJddE7
         gUGrb1HiDNEPfu4lIzs5CPo0iomKgwK/eKh5tiHYvZBihM5ujNhAZ4FCwurDwwVlblbt
         mRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aj/QfMi29RxbfWMS0T22yu10j2M1vxeQW93G/sgXZ/k=;
        b=G92yV7GhtVHsvo0VrSwOxFIyUbm3cr7ct3LY4qfMg7vwk8KBLZ9GGoN6QbQ+GWmx7o
         h4njBIsgvcCRmHmk/0UM2cEiI6GeHHYJZTR80yU+2oz4XjrOuqNb2PmfjrAYdnjR8TBU
         muULh8PhuGxzbZPduETVMMvwegHYrQaoAe8aposDwG27ZtEdAkr00wQK5PRfTfGRwHY3
         /+jCQySfyYbvivfvtRVwe51CJdjO8Nsq82WYAI4RfugtHUz18rNGWPuD+eoFgn3hYikp
         /RyhkDzhCaEOmMZM8UlFnEN14jx/hcMBfTVEvVWBEEhgs7zL0JWVgNCa/ZrdQT7Z+Huk
         FJQg==
X-Gm-Message-State: AJcUukdlhXJvVM3VI6zMegKLb1Ms6md8qNqNqChyAqN0qb/1ZJUSNND3
        xhTJbYuU22tQpQCI1rmePkc=
X-Google-Smtp-Source: ALg8bN7X+JNQb6ePZeNubqTBYI/lrsUkQV4CV3Mbv1HAia9aSFR2/cHgBEO0gDRAUl+IcGd3gV0n3g==
X-Received: by 2002:a17:902:7107:: with SMTP id a7mr34487851pll.290.1548168510614;
        Tue, 22 Jan 2019 06:48:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n73sm22820945pfj.148.2019.01.22.06.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:48:29 -0800 (PST)
Subject: Re: [RFC PATCH v1 11/13] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ebe1618710baf7cf59622c878e40052ca48cc7c3.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <390e9379-329b-02dc-13f6-763aeae703e1@roeck-us.net>
Date:   Tue, 22 Jan 2019 06:48:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ebe1618710baf7cf59622c878e40052ca48cc7c3.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 1:47 AM, Matti Vaittinen wrote:
> Support RTC block in ROHM bd70528 power management IC. Support
> getting and setting the time and date as well as arming an alarm
> which can also be used to wake the PMIC from standby state.
> 
> HW supports wake interrupt only for the next 24 hours (sec, minute
> and hour information only) so we limit also the alarm interrupt to
> this 24 hours for the sake of consistency.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>   drivers/rtc/Kconfig       |   8 +
>   drivers/rtc/Makefile      |   1 +
>   drivers/rtc/rtc-bd70528.c | 439 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 448 insertions(+)
>   create mode 100644 drivers/rtc/rtc-bd70528.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 225b0b8516f3..df6211cbd83f 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -487,6 +487,14 @@ config RTC_DRV_M41T80_WDT
>   	help
>   	  If you say Y here you will get support for the
>   	  watchdog timer in the ST M41T60 and M41T80 RTC chips series.
> +config RTC_DRV_BD70528
> +	tristate "ROHM BD70528 PMIC RTC"
> +	help
> +	  If you say Y here you will get support for the RTC
> +	  on ROHM BD70528 Power Management IC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-bd70528.
>   
>   config RTC_DRV_BQ32K
>   	tristate "TI BQ32000"
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index df022d820bee..740b13840913 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
>   obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
>   obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
>   obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
> +obj-$(CONFIG_RTC_DRV_BD70528)	+= rtc-bd70528.o
>   obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
>   obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
>   obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
> diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
> new file mode 100644
> index 000000000000..7c7e1f8769e8
> --- /dev/null
> +++ b/drivers/rtc/rtc-bd70528.c
> @@ -0,0 +1,439 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Copyright (C) 2018 ROHM Semiconductors
> +//
> +// RTC driver for ROHM BD70528 PMIC
> +
> +#include <linux/bcd.h>
> +#include <linux/mfd/rohm-bd70528.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +/*
> + * We read regs RTC_SEC => RTC_YEAR
> + * this struct is ordered according to chip registers.
> + * Keep it u8 only to avoid padding issues.
> + */
> +struct bd70528_rtc_day {
> +	u8 sec;
> +	u8 min;
> +	u8 hour;
> +};
> +struct bd70528_rtc_data {
> +	struct bd70528_rtc_day time;
> +	u8 week;
> +	u8 day;
> +	u8 month;
> +	u8 year;
> +};
> +struct bd70528_rtc_wake {
> +	struct bd70528_rtc_day time;
> +	u8 ctrl;
> +};
> +struct bd70528_rtc_alm {
> +	struct bd70528_rtc_data data;
> +	u8 alm_mask;
> +	u8 alm_repeat;
> +};
> +
> +static int bd70528_set_wake(struct bd70528 *bd70528,
> +			    int enable, int *old_state)
> +{
> +	int ret;
> +	unsigned int ctrl_reg;
> +
> +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WAKE_EN, &ctrl_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (old_state) {
> +		if (ctrl_reg & BD70528_MASK_WAKE_EN)
> +			*old_state |= BD70528_WAKE_STATE_BIT;
> +		else
> +			*old_state &= ~BD70528_WAKE_STATE_BIT;
> +
> +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
> +			return 0;
> +	}
> +
> +	if (enable)
> +		ctrl_reg |= BD70528_MASK_WAKE_EN;
> +	else
> +		ctrl_reg &= ~BD70528_MASK_WAKE_EN;
> +
> +	return regmap_write(bd70528->chip.regmap, BD70528_REG_WAKE_EN,
> +			    ctrl_reg);
> +}
> +
> +static int bd70528_set_elapsed_tmr(struct bd70528 *bd70528,
> +				   int enable, int *old_state)
> +{
> +	int ret;
> +	unsigned int ctrl_reg;
> +
> +	/*
> +	 * TBD
> +	 * What is the purpose of elapsed timer ?
> +	 * Is the timeout registers counting down, or is the disable - re-enable
> +	 * going to restart the elapsed-time counting? If counting is restarted
> +	 * the timeout should be decreased by the amount of time that has
> +	 * elapsed since starting the timer. Maybe we should store the monotonic
> +	 * clock value when timer is started so that if RTC is set while timer
> +	 * is armed we could do the compensation. This is a hack if RTC/system
> +	 * clk are drifting. OTOH, RTC controlled via I2C is in any case
> +	 * inaccurate...
> +	 */
> +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_ELAPSED_TIMER_EN,
> +			  &ctrl_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (old_state) {
> +		if (ctrl_reg & BD70528_MASK_ELAPSED_TIMER_EN)
> +			*old_state |= BD70528_ELAPSED_STATE_BIT;
> +		else
> +			*old_state &= ~BD70528_ELAPSED_STATE_BIT;
> +
> +		if ((!enable) == (!(*old_state & BD70528_ELAPSED_STATE_BIT)))
> +			return 0;
> +	}
> +
> +	if (enable)
> +		ctrl_reg |= BD70528_MASK_ELAPSED_TIMER_EN;
> +	else
> +		ctrl_reg &= ~BD70528_MASK_ELAPSED_TIMER_EN;
> +
> +	return regmap_write(bd70528->chip.regmap, BD70528_REG_ELAPSED_TIMER_EN,
> +			    ctrl_reg);
> +}
> +
> +static int bd70528_set_rtc_based_timers(struct bd70528 *bd70528, int new_state,
> +							int *old_state)

Passed parameter is an int, not int *. I'd be quite surprised if this compiles
without warning.

> +{
> +	int ret;
> +
> +	ret = bd70528->wdt_set(bd70528, new_state & BD70528_WDT_STATE_BIT,
> +			       old_state);
> +	if (ret) {
> +		dev_err(bd70528->chip.dev,
> +			"Failed to disable WDG for RTC setting (%d)\n", ret);
> +		return ret;
> +	}
> +	ret = bd70528_set_elapsed_tmr(bd70528,
> +				      new_state & BD70528_ELAPSED_STATE_BIT,
> +				      old_state);
> +	if (ret) {
> +		dev_err(bd70528->chip.dev,
> +			"Failed to disable 'elapsed timer' for RTC setting\n");
> +		return ret;
> +	}
> +	ret = bd70528_set_wake(bd70528, new_state & BD70528_WAKE_STATE_BIT,
> +			       old_state);
> +	if (ret) {
> +		dev_err(bd70528->chip.dev,
> +			"Failed to disable 'wake timer' for RTC setting\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bd70528_re_enable_rtc_based_timers(struct bd70528 *bd70528,
> +							int old_state)
> +{
> +	if (bd70528->rtc_timer_lock)
> +		mutex_unlock(bd70528->rtc_timer_lock);
> +
Unlock before calling bd70528_set_rtc_based_timers is odd, especially since it
is called after locking below.

> +	return bd70528_set_rtc_based_timers(bd70528, old_state, NULL);
> +}
> +
> +static int bd70528_disable_rtc_based_timers(struct bd70528 *bd70528,
> +							int *old_state)
> +{
> +	if (bd70528->rtc_timer_lock)
> +		mutex_lock(bd70528->rtc_timer_lock);
> +
> +	return bd70528_set_rtc_based_timers(bd70528, 0, old_state);
> +}
> +
> +static inline void tmday2rtc(struct rtc_time *t, struct bd70528_rtc_day *d)
> +{
> +	d->sec &= ~BD70528_MASK_RTC_SEC;
> +	d->min &= ~BD70528_MASK_RTC_MINUTE;
> +	d->hour &= ~BD70528_MASK_RTC_HOUR;
> +	d->sec |= bin2bcd(t->tm_sec);
> +	d->min |= bin2bcd(t->tm_min);
> +	d->hour |= bin2bcd(t->tm_hour);
> +}
> +
> +static inline void tm2rtc(struct rtc_time *t, struct bd70528_rtc_data *r)
> +{
> +	r->day &= ~BD70528_MASK_RTC_DAY;
> +	r->week &= ~BD70528_MASK_RTC_WEEK;
> +	r->month &= ~BD70528_MASK_RTC_MONTH;
> +	/*
> +	 * PM and 24H bits are not used by Wake - thus iwe clear them
> +	 * here and not in tmday2rtc() which is also used by wake.
> +	 */
> +	r->time.hour &= ~(BD70528_MASK_RTC_HOUR_PM | BD70528_MASK_RTC_HOUR_24H);
> +
> +	tmday2rtc(t, &r->time);
> +	/*
> +	 * We do always set time in 24H mode.
> +	 */
> +	r->time.hour |= BD70528_MASK_RTC_HOUR_24H;
> +	r->day |= bin2bcd(t->tm_mday);
> +	r->week |= bin2bcd(t->tm_wday);
> +	r->month |= bin2bcd(t->tm_mon + 1);
> +	r->year = bin2bcd(t->tm_year-100);
> +}
> +
> +static inline void rtc2tm(struct bd70528_rtc_data *r, struct rtc_time *t)
> +{
> +	t->tm_sec = bcd2bin(r->time.sec & BD70528_MASK_RTC_SEC);
> +	t->tm_min = bcd2bin(r->time.min & BD70528_MASK_RTC_MINUTE);
> +	t->tm_hour = bcd2bin(r->time.hour & BD70528_MASK_RTC_HOUR);
> +	/*
> +	 * If RTC is in 12H mode, then bit BD70528_MASK_RTC_HOUR_PM
> +	 * is not BCD value but tells whether it is AM or PM
> +	 */
> +	if (!(r->time.hour & BD70528_MASK_RTC_HOUR_24H)) {
> +		t->tm_hour %= 12;
> +		if (r->time.hour & BD70528_MASK_RTC_HOUR_PM)
> +			t->tm_hour += 12;
> +	}
> +	t->tm_mday = bcd2bin(r->day & BD70528_MASK_RTC_DAY);
> +	t->tm_mon = bcd2bin(r->month & BD70528_MASK_RTC_MONTH) - 1;
> +	t->tm_year = 100 + bcd2bin(r->year & BD70528_MASK_RTC_YEAR);
> +	t->tm_wday = bcd2bin(r->week & BD70528_MASK_RTC_WEEK);
> +}
> +
> +static int bd70528_set_alarm(struct device *dev, struct rtc_wkalrm *a)
> +{
> +	struct bd70528 *bd70528 = dev_get_drvdata(dev);
> +	struct bd70528_rtc_wake wake;
> +	struct bd70528_rtc_alm alm;
> +	int ret;
> +
> +	ret = regmap_bulk_read(bd70528->chip.regmap, BD70528_REG_RTC_WAKE_START,
> +			       &wake, sizeof(wake));
> +	if (ret) {
> +		dev_err(dev, "Failed to read wake regs\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(bd70528->chip.regmap, BD70528_REG_RTC_ALM_START,
> +			       &alm, sizeof(alm));
> +	if (ret) {
> +		dev_err(dev, "Failed to read alarm regs\n");
> +		return ret;
> +	}
> +
> +	tm2rtc(&a->time, &alm.data);
> +	tmday2rtc(&a->time, &wake.time);
> +
> +	if (a->enabled) {
> +		alm.alm_mask &= ~BD70528_MASK_ALM_EN;
> +		wake.ctrl |= BD70528_MASK_WAKE_EN;
> +	} else {
> +		alm.alm_mask |= BD70528_MASK_ALM_EN;
> +		wake.ctrl &= ~BD70528_MASK_WAKE_EN;
> +	}
> +
> +	ret = regmap_bulk_write(bd70528->chip.regmap,
> +				BD70528_REG_RTC_WAKE_START, &wake,
> +				sizeof(wake));
> +	if (ret) {
> +		dev_err(dev, "Failed to set wake time\n");
> +		return ret;
> +	}
> +	ret = regmap_bulk_write(bd70528->chip.regmap, BD70528_REG_RTC_ALM_START,
> +				&alm, sizeof(alm));
> +	if (ret)
> +		dev_err(dev, "Failed to set alarm time\n");
> +
> +	return ret;
> +}
> +
> +static int bd70528_read_alarm(struct device *dev, struct rtc_wkalrm *a)
> +{
> +	struct bd70528 *bd70528 = dev_get_drvdata(dev);
> +	struct bd70528_rtc_alm alm;
> +	int ret;
> +
> +	ret = regmap_bulk_read(bd70528->chip.regmap, BD70528_REG_RTC_ALM_START,
> +			  &alm, sizeof(alm));
> +	if (ret) {
> +		dev_err(dev, "Failed to read alarm regs\n");
> +		return ret;
> +	}
> +
> +	rtc2tm(&alm.data, &a->time);
> +	a->time.tm_mday = -1;
> +	a->time.tm_mon = -1;
> +	a->time.tm_year = -1;
> +	if (alm.alm_mask & BD70528_MASK_ALM_EN)
> +		a->enabled = 0;
> +	else
> +		a->enabled = 1;
> +
> +	a->pending = 0;
> +
> +	return 0;
> +}
> +
> +static int bd70528_set_time(struct device *dev, struct rtc_time *t)
> +{
> +	int ret, old_states;
> +	struct bd70528_rtc_data rtc_data;
> +	struct bd70528 *bd70528 = dev_get_drvdata(dev);
> +
> +	ret = bd70528_disable_rtc_based_timers(bd70528, &old_states);
> +
> +	ret = regmap_bulk_read(bd70528->chip.regmap,
> +			       BD70528_REG_RTC_START, &rtc_data,
> +			       sizeof(rtc_data));
> +
> +	tm2rtc(t, &rtc_data);
> +
> +	ret = regmap_bulk_write(bd70528->chip.regmap,
> +				BD70528_REG_RTC_START, &rtc_data,
> +				sizeof(rtc_data));
> +
> +	ret = bd70528_re_enable_rtc_based_timers(bd70528, old_states);
> +
> +	return 0;
> +}
> +static int bd70528_get_time(struct device *dev, struct rtc_time *t)
> +{
> +	struct bd70528 *bd70528 = dev_get_drvdata(dev);
> +	struct bd70528_rtc_data rtc_data;
> +	int ret;
> +
> +	/* read the RTC date and time registers all at once */
> +	ret = regmap_bulk_read(bd70528->chip.regmap,
> +			       BD70528_REG_RTC_START, &rtc_data,
> +			       sizeof(rtc_data));
> +	if (ret) {
> +		dev_err(dev, "Failed to read RTC time (err %d)\n", ret);
> +		return ret;
> +	}
> +
> +	rtc2tm(&rtc_data, t);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops bd70528_rtc_ops = {
> +	.read_time	= bd70528_get_time,
> +	.set_time	= bd70528_set_time,
> +	.read_alarm	= bd70528_read_alarm,
> +	.set_alarm	= bd70528_set_alarm,
> +};
> +
> +static irqreturn_t alm_hndlr(int irq, void *data)
> +{
> +	struct rtc_device *rtc = data;
> +
> +	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF | RTC_PF);
> +	return IRQ_HANDLED;
> +}
> +
> +static int bd70528_probe(struct platform_device *pdev)
> +{
> +	struct bd70528 *bd70528;
> +	struct bd70528 *tmp;
> +	int ret;
> +	struct rtc_device *rtc;
> +	int irq;
> +	unsigned int hr;
> +
> +	tmp = dev_get_drvdata(pdev->dev.parent);
> +	if (!tmp) {
> +		dev_err(&pdev->dev, "No MFD driver data\n");
> +		return -EINVAL;
> +	}
> +	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
> +	if (!bd70528)
> +		return -ENOMEM;
> +
> +	*bd70528 = *tmp;
> +	bd70528->chip.dev = &pdev->dev;
> +
> +	irq = platform_get_irq_byname(pdev, "bd70528-rtc-alm");
> +
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq\n");
> +		return irq;
> +	}
> +
> +	platform_set_drvdata(pdev, bd70528);
> +
> +
> +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_RTC_HOUR, &hr);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to reag RTC clock\n");
> +		return ret;
> +	}
> +
> +	if (!(hr & BD70528_MASK_RTC_HOUR_24H)) {
> +		struct rtc_time t;
> +
> +		ret = bd70528_get_time(&pdev->dev, &t);
> +		if (ret)
> +			return ret;
> +
> +		ret = bd70528_set_time(&pdev->dev, &t);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Setting 24H clock for RTC failed\n");
> +		return ret;
> +	}
> +
> +	device_set_wakeup_capable(&pdev->dev, true);
> +	device_wakeup_enable(&pdev->dev);
> +	rtc = devm_rtc_device_register(&pdev->dev, "bd70528-rtc",
> +				       &bd70528_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc)) {
> +		dev_err(&pdev->dev, "Registering RTC failed\n");
> +		return PTR_ERR(rtc);
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, &alm_hndlr,
> +					IRQF_ONESHOT, "bd70528-rtc", rtc);
> +
> +	/*
> +	 *  BD70528 irq controller is not touching the main mask register.
> +	 *  So enable the RTC block interrupts at main level. We can just
> +	 *  leave them enabled as irq-controller should disable irqs
> +	 *  from sub-registers when IRQ is disabled or freed.
> +	 */
> +	ret = regmap_update_bits(bd70528->chip.regmap,
> +				 BD70528_REG_INT_MAIN,
> +				 BD70528_INT_RTC_MASK, 0);
> +
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to enable RTC interrupts\n");
> +
> +	return ret;
> +}
> +
> +static struct platform_driver bd70528_rtc = {
> +	.driver = {
> +		.name = "bd70528-rtc"
> +	},
> +	.probe = bd70528_probe,
> +};
> +
> +module_platform_driver(bd70528_rtc);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("BD70528 RTC driver");
> +MODULE_LICENSE("GPL");
> 

