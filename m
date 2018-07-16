Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8759ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEC7208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TX09J9Pj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q83q+a4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEC7208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:59:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeGPS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:59:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 005166074D; Mon, 16 Jul 2018 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531765832;
        bh=HUBYhO7SIjCK66ZuKfYQPO/pCOzedZiKMNeReQ1oA74=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TX09J9Pjew+rHoxDxueEezXZO32XgCxov33FWVCceGrqC49I44ChLCnl29OKk0LPZ
         2RTHKmhO5Zqh6GQRXNH0orkbLpH7D7dJr1PUiah4te+xxzKrOzl8WC1lSzxynyOBWb
         eiWuo81TYlX0xYb82SPVpC84n13kea6VHhtH5sRI=
Received: from [10.79.165.144] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E32F56074D;
        Mon, 16 Jul 2018 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531765831;
        bh=HUBYhO7SIjCK66ZuKfYQPO/pCOzedZiKMNeReQ1oA74=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q83q+a4S6Itt17/yo7nZkioWstwqmLdVld/4hS4SvMmy72nOyAkMjR1UMpMD8s5LX
         KnqJF+2hqgvMHMxyidIWtIzgFjzZTVTHvbc+wW3hNj9cg/XYYW72OlU2T1/34VCuB4
         vOE8WdDRtSdZLLyZPDSf+qgCcBm4v/TezLUuD5JI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E32F56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] time: Fix incorrect sleeptime injection when suspend
 fails
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org,
        Baolin Wang <baolin.wang@linaro.org>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com>
 <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org>
 <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
 <45be9c4f-34fd-200a-df95-9c30b332a96b@codeaurora.org>
 <CALAqxLVtOv52O=PePEfMmTXeJ5ndkoG8DRwoRs0dxnu+QwqVXQ@mail.gmail.com>
 <CALAqxLXN9=KgGpG+qexBesn5A2OyszyyzatkP5z_wg1GbcMzQA@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <19b10a21-2636-49a9-2a1a-488f293aeb45@codeaurora.org>
Date:   Tue, 17 Jul 2018 00:00:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLXN9=KgGpG+qexBesn5A2OyszyyzatkP5z_wg1GbcMzQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2018 10:44 PM, John Stultz wrote:
> On Mon, Jul 16, 2018 at 9:30 AM, John Stultz <john.stultz@linaro.org> wrote:
>> On Mon, Jul 16, 2018 at 9:17 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>>> On 7/13/2018 10:50 PM, John Stultz wrote:
>>>> On Fri, Jul 13, 2018 at 12:13 AM, Mukesh Ojha <mojha@codeaurora.org>
>>>>> On 7/11/2018 1:43 AM, John Stultz wrote:
>>>>>> I worry this upside-down logic is too subtle to be easily reasoned
>>>>>> about, and will just lead to future mistakes.
>>>>>>
>>>>>> Can we instead call this "suspend_timing_needed" and only set it to
>>>>>> true when we don't inject any sleep time on resume?
>>>>>
>>>>> I did not get your point "only set it to true when we don't inject any
>>>>> sleep
>>>>> time on resume? "
>>>>> How do we know  this ?
>>>>> This question itself depends on the "sleeptime_injected" if it is true
>>>>> means
>>>>> no need to inject else need to inject.
>>>>>
>>>>> Also, we need to make this variable back and forth true, false; suspends
>>>>> path ensures it to make it false.
>>>> So yea, I'm not saying logically the code is really any different,
>>>> this is more of a naming nit. So instead of having a variable that is
>>>> always on that we occasionally turn off, lets invert the naming and
>>>> have it be a flag that we occasionally turn on.
>>>
>>> I understand your concern about the name of the variable will be misleading.
>>> But the changing Boolean state would not solve the actual issue.
>>>
>>> If i understand you correctly you meant below code
>>>
>>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>>> index 32ae9ae..becc5bd 100644
>>> --- a/kernel/time/timekeeping.c
>>> +++ b/kernel/time/timekeeping.c
>>> @@ -1523,7 +1523,7 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>>>    * If a suspend fails before reaching timekeeping_resume() then the flag
>>>    * stays true and prevents erroneous sleeptime injection.
>>>    */
>>> -static bool sleeptime_injected = true;
>>> +static bool suspend_timing_needed;
>>>
>>>   /* Flag for if there is a persistent clock on this platform */
>>>   static bool persistent_clock_exists;
>>> @@ -1658,7 +1658,7 @@ void timekeeping_inject_sleeptime64(struct timespec64
>>> *delta)
>>>          raw_spin_lock_irqsave(&timekeeper_lock, flags);
>>>          write_seqcount_begin(&tk_core.seq);
>>>
>>> -       sleeptime_injected = true;
>>> +       suspend_timing_needed = false;
>>>
>>>          timekeeping_forward_now(tk);
>>>
>>> @@ -1714,10 +1714,10 @@ void timekeeping_resume(void)
>>>                                                tk->tkr_mono.mask);
>>>                  nsec = mul_u64_u32_shr(cyc_delta, clock->mult,
>>> clock->shift);
>>>                  ts_delta = ns_to_timespec64(nsec);
>>> -               sleeptime_injected = true;
>>> +               suspend_timing_needed = true;
>>>          } else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) >
>>> 0) {
>>>                  ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
>>> -               sleeptime_injected = true;
>>> +               suspend_timing_needed = true;
>>>          }
>> No no... This part is wrong. We only set suspend_timing_needed if we
>> *didn't* calculate the suspend time in timekeeping_resume.
>>
>> You have to invert all the boolean logic for it to be equivalent.
>>
> ...
>>>    <sleeptime injection happens here>
>>
>> So, I think with the logic bug above it will work out properly, but
>> let me know if I'm still missing something.

Please give it thought to a case where very first suspend fails with 
your logic.
If i am not able to get your thought, please write a patch.

-Mukesh

> Sorry, I meant "with the logic bug above fixed it will work out".
>
> thanks
> -john

