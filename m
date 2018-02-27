Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeB0Cyu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:54:50 -0500
Received: from regular1.263xmail.com ([211.150.99.136]:57300 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeB0Cys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:54:48 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: briannorris@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <2a346683acf009163456946dbae3b298>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A94C863.5060504@rock-chips.com>
Date: Tue, 27 Feb 2018 10:54:27 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
CC: linux-kernel@vger.kernel.org, zyw@rock-chips.com,
        briannorris@google.com, dianders@google.com, jwerner@chromium.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: cros-ec: return -ETIME when refused to set alarms
 in the past
References: <20180225081802.8965-1-jeffy.chen@rock-chips.com> <20180226183727.GC225858@rodete-desktop-imager.corp.google.com>
In-Reply-To: <20180226183727.GC225858@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thanks for your reply.

On 02/27/2018 02:37 AM, Brian Norris wrote:
>> >+	/* Don't set an alarm in the past. */
>> >+	if ((u32)alarm_time <= current_time)
>> >+		return -ETIME;
>> >+
>> >  	if (!alrm->enabled) {
>> >  		/*
>> >  		 * If the alarm is being disabled, send an alarm
>> >@@ -196,11 +200,7 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> >  		alarm_offset = EC_RTC_ALARM_CLEAR;
>> >  		cros_ec_rtc->saved_alarm = (u32)alarm_time;
>> >  	} else {
>> >-		/* Don't set an alarm in the past. */
>> >-		if ((u32)alarm_time < current_time)
> It's probably worth noting in the commit message that you're also fixing
> the case where 'alarm_time == current_time'; in the current driver
> source, it*looks*  like you're setting a 0-second alarm. But in fact, 0
> means EC_RTC_ALARM_CLEAR, which would disable the alarm. So you are
> (correctly) returning -ETIME in that case.
Right, i'll rewrite the commit message, and move the check back here:)

>
> Brian
>
