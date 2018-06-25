Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72774C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195E25B93
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QsipTKrb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PF5NHaUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2195E25B93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeFYOiY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:38:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934255AbeFYOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:38:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C899607EB; Mon, 25 Jun 2018 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529937502;
        bh=RKTkE/Zd7Ena1Eu/mNuudsmwbEvsSuGs5VPkan1DAn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QsipTKrb0H5kdR9ACTxhWboGM3Ne1NThHQFDyowlT10zGH6qRK68eNOIkS1UKRxgV
         gzliFrZRI5c4mjOPe8wTn/1nKVaM3qYTC3kvyvHn6p+dgtkg7Npukt+o8XgABVguKi
         l08BPLrW/Upy9cYBCV/kMpnLy6OE5U/BkxMq+EEU=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D0EC60376;
        Mon, 25 Jun 2018 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529937500;
        bh=RKTkE/Zd7Ena1Eu/mNuudsmwbEvsSuGs5VPkan1DAn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PF5NHaUYIQjXZw26trACD1tEMgO4rIlVp0W8cEBBNW/KjC+fGa4W+4IJ1/4xDbp5X
         WEZFnHDcXKI8x9TmRnQyUvPf/9OwpvSA1bTY06caSQgATQjzO+OEnm3eo10Dk5zvqD
         89JlxZ7mYrm2tgD6IBSx2zMVsDGiSpVoiDswyrXI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D0EC60376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource
 & persistent clock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org, gkohli@codeaurora.org,
        cpandya@codeaurora.org
References: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
 <alpine.DEB.2.21.1806222312340.1589@nanos.tec.linutronix.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e869c2ec-90fa-27e2-975c-a92469f56dac@codeaurora.org>
Date:   Mon, 25 Jun 2018 20:08:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806222312340.1589@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks you very much for your time and reply.


On 6/23/2018 2:57 AM, Thomas Gleixner wrote:
> On Wed, 30 May 2018, Mukesh Ojha wrote:
>> Currently, for both non-stop clocksource and persistent clock
>> there is a corner case, when a driver failed to go suspend mode.
>> rtc_resume() injects the sleeptime as timekeeping_rtc_skipresume()
>> returned 'false'(sleeptime_injected=false) due to which we can
>> see mismatch in timestamps between system clock and other timers.
>>
>> Fix this by updating sleeptime_injected=true for both non-stop
>> clocksource and persistent clock.
>>
>> Success case:
>> ------------
>>                                           {sleeptime_injected=true}
>> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>>    rtc_resume()
>>
>> Failure case:
>> ------------
>>               {failure in sleep path} {sleeptime_injected=false}
>> rtc_suspend()          =>            rtc_resume()
> I can see the problem.
>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>> Changes in v2:
>>   * Updated the commit text.
>>   * Removed extra variable and used the earlier static
>>     variable 'sleeptime_injected'.
>>
>>   kernel/time/timekeeping.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 49cbcee..2754c1b 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1610,6 +1610,17 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>>    */
>>   bool timekeeping_rtc_skipresume(void)
>>   {
>> +	struct timekeeper *tk = &tk_core.timekeeper;
>> +	/*
>> +	 * This is to ensure that we don't end up injecting
>> +	 * the sleeptime via rtc_resume() for non-stop clocksource
>> +	 * when we fail to sleep.
>> +	 */
>> +	if (!sleeptime_injected)
>> +		sleeptime_injected = ((tk->tkr_mono.clock->flags &
>> +			CLOCK_SOURCE_SUSPEND_NONSTOP) ||
>> +			(persistent_clock_exists)) ? true : false;
> But this is really a horrible hack. The right thing to do is to keep track
> whether timekeeping_suspend() has been reached in the first place. There is
> a very simple way to do that. Uncompiled and completely untested patch
> below, but you get the idea.

Yeah, missed completely the fact that the issue can also come where only 
clocksource is RTC.
> Thanks,
>
> 	tglx
>
> 8<-------------------
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 4786df904c22..32ae9aea61c3 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>   	ts->tv_nsec = 0;
>   }
>   
> -/* Flag for if timekeeping_resume() has injected sleeptime */
> -static bool sleeptime_injected;
> +/*
> + * Flag reflecting whether timekeeping_resume() has injected sleeptime.
> + *
> + * The flag starts of true and is only cleared when a suspend reaches
> + * timekeeping_suspend(), timekeeping_resume() sets it when the timekeeper
> + * clocksource is not stopping across suspend and has been used to update
> + * sleep time. If the timekeeper clocksource has stopped then the flag
> + * stays false and is used by the RTC resume code to decide whether sleep
> + * time must be injected and if so the flag gets set then.
> + *
> + * If a suspend fails before reaching timekeeping_resume() then the flag
> + * stays true and prevents erroneous sleeptime injection.
> + */
> +static bool sleeptime_injected = true;

This will prevent first sleep failure.

>   
>   /* Flag for if there is a persistent clock on this platform */
>   static bool persistent_clock_exists;
> @@ -1646,6 +1658,8 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
>   	raw_spin_lock_irqsave(&timekeeper_lock, flags);
>   	write_seqcount_begin(&tk_core.seq);
>   
> +	sleeptime_injected = true;

This will prevent further extra sleeptime injection if sleep fails 
(valid for RTC only).
Looks good!

> +
>   	timekeeping_forward_now(tk);
>   
>   	__timekeeping_inject_sleeptime(tk, delta);
> @@ -1671,7 +1685,6 @@ void timekeeping_resume(void)
>   	struct timespec64 ts_new, ts_delta;
>   	u64 cycle_now;
>   
> -	sleeptime_injected = false;
>   	read_persistent_clock64(&ts_new);
>   
>   	clockevents_resume();
> @@ -1743,6 +1756,8 @@ int timekeeping_suspend(void)
>   	if (timekeeping_suspend_time.tv_sec || timekeeping_suspend_time.tv_nsec)
>   		persistent_clock_exists = true;
>   
> +	sleeptime_injected = false;

I did not get the exact valid point of moving it from 
`timekeeping_suspend` to `timekeeping_resume`.
Although it will not have any side effect.

> +
>   	raw_spin_lock_irqsave(&timekeeper_lock, flags);
>   	write_seqcount_begin(&tk_core.seq);
>   	timekeeping_forward_now(tk);
>

Thanks for the change;  will check and update.

Cheers,
Mukesh
