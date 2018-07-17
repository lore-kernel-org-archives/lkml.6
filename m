Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AAAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7762D208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="REIrGeFF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNGNrMM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7762D208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeGQGuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:50:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeGQGuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:50:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7493A60116; Tue, 17 Jul 2018 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531808393;
        bh=AFXgLPMvokrSKHyGzY1KVDnoowsGnOWZ9wANdY1Dt2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=REIrGeFFSqXS0QA5Z5HDNbl2DwVMmXG0Z7qR9EHtQjt63K1m+Qr/6uZG8bX3VPAEV
         u6V6MiSutOT4ohfjIWsg887lD9irsmXdde2r6/bN2yh72Sn0riIIjPSH+p5GwZ67u0
         w7XnIc2sk7AisBuRs+RFRJsWoRiMOh0LRqoexFFk=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A8B060116;
        Tue, 17 Jul 2018 06:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531808392;
        bh=AFXgLPMvokrSKHyGzY1KVDnoowsGnOWZ9wANdY1Dt2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JNGNrMM7oqUq19SM1QDCcf92wJaMY59CJFfTjpfzv7Y1pcXfkUhePBGngCEgj88AL
         tWwPX0kaaOaV1RCvlmUNvEyA0SJiIghgPWAp67V/0MJLTPwl/VXy1a+AujLoeO7XmT
         M7yjZDlsdPNCKQZa38cBtYs9j99NQb1sZqsfItew=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A8B060116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v4] time: Fix extra sleeptime injection when suspend fails
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        gkohli@codeaurora.org, cpandya@codeaurora.org,
        neeraju@codeaurora.org
References: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
 <alpine.DEB.2.21.1807162241470.1693@nanos.tec.linutronix.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6d6dbd5e-0fad-736e-197d-2c4546dda232@codeaurora.org>
Date:   Tue, 17 Jul 2018 11:49:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807162241470.1693@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2018 2:20 AM, Thomas Gleixner wrote:
> On Tue, 17 Jul 2018, Mukesh Ojha wrote:
>> @@ -102,7 +102,7 @@ static int rtc_resume(struct device *dev)
>>   	struct timespec64	sleep_time;
>>   	int err;
>>   
>> -	if (timekeeping_rtc_skipresume())
>> +	if (!timekeeping_rtc_skipresume())
>>   		return 0;
> That does not make any sense at all, really.
>
>>   /* Flag for if there is a persistent clock on this platform */
>>   static bool persistent_clock_exists;
>> @@ -1610,7 +1622,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>>    */
>>   bool timekeeping_rtc_skipresume(void)
>>   {
>> -	return sleeptime_injected;
>> +	return suspend_timing_needed;
> Just make this !suspend_timing_needed and the function name and its return
> value still makes sense.
>
>> @@ -1701,13 +1714,13 @@ void timekeeping_resume(void)
>>   					      tk->tkr_mono.mask);
>>   		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
>>   		ts_delta = ns_to_timespec64(nsec);
>> -		sleeptime_injected = true;
>> +		suspend_timing_needed = false;
>>   	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
>>   		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
>> -		sleeptime_injected = true;
>> +		suspend_timing_needed = false;
>>   	}
>>   
>> -	if (sleeptime_injected)
>> +	if (!suspend_timing_needed)
>>   		__timekeeping_inject_sleeptime(tk, &ts_delta);
> This reads odd as well. I'd rather keep a local variable inject_sleeptime
> or such and set that in the code pathes above.
>
>     	if (...) {
> 	   	...
> 		inject_sleeptime = true;
>     	} else if (...) {
> 	   	...
> 		inject_sleeptime = true;
> 	}
>
> 	if (inject_sleeptime) {
> 		suspend_timing_needed = false;
> 		__timekeeping_inject_sleeptime();
> 	}

Will do suggested change and send in v5.

Thanks.
>
> Hmm? Just blindly converting everything results in functional, but
> nonsensical code. Think about what happens when you look at that stuff 6
> month from now...
>
> Thanks,
>
> 	tglx
>

