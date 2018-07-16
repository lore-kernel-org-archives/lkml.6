Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13021208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wo574RDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13021208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeGPTXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:23:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbeGPTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:23:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so5834142wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i/Z1G+hcYEVl7jHUIMj6U3Bscp/LD6iiEp2NvqajwmA=;
        b=Wo574RDR5Mnfy/5hpyETkPbw9lpqcBueWgEl3PzGq+yMVbCLELVawMFJ7hZQsP/2Xd
         IcI0Qc3XxPq3Sa5uTAnWZZ2R0f5aDgNP/EYAyLbOJaGIjZgALa+dudIu+YDLGA6x2Kg5
         1GoJjNkfyBsPRGQDa1KzwSovEjvLx0/guMqLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i/Z1G+hcYEVl7jHUIMj6U3Bscp/LD6iiEp2NvqajwmA=;
        b=s5QZ4IQQLYgnqB8OC6E7kDPvERumOAVwcXNZeqi0d1PvZYlXVCcEA6/Y9b7DROZIKd
         r7IG88J65OfZ961doIx12psEfIFDLvSkBlIZVQBAhncsItLQdmEKH18EvQ+3UvgZj9tq
         GgvO/FHL0+pK1v0HbLm3Aznrc5t8l/iwQMBDqkdrTvkJJ1dZQudFIT+vomO0E8kvdMVz
         O9CXTbb07j1tervFlUQ/eEaRqhrIKLmq9jJOvYes0tvFG61n2sRU4LVD5D2CQ3Ydq9bi
         V8uoKRCNhWdXEljKsLbBlpRr0YsBB4hsAeXf9ZahiGOtSbmvSOPuoUtaZgGzGnQAUwWm
         pKjQ==
X-Gm-Message-State: AOUpUlFUlzk5LFf93HpXupxNQxclH5vS+UdZRbykevuZAIRONqrzh8AU
        2+xfi8jPjoc1T7ozi/ASflYdtBU+aClcmB5UCLGSDA==
X-Google-Smtp-Source: AAOMgpfuvyccSwxaYcH5xCn7wPgCeLwFTHS/yojg9K8B5gQgO2P20IQblRo6Zv9pkD1RB6g6vt8xgErXzb94Be7BFSI=
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr9682915wmd.96.1531767253821;
 Mon, 16 Jul 2018 11:54:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 11:54:13
 -0700 (PDT)
In-Reply-To: <19b10a21-2636-49a9-2a1a-488f293aeb45@codeaurora.org>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com>
 <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org> <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
 <45be9c4f-34fd-200a-df95-9c30b332a96b@codeaurora.org> <CALAqxLVtOv52O=PePEfMmTXeJ5ndkoG8DRwoRs0dxnu+QwqVXQ@mail.gmail.com>
 <CALAqxLXN9=KgGpG+qexBesn5A2OyszyyzatkP5z_wg1GbcMzQA@mail.gmail.com> <19b10a21-2636-49a9-2a1a-488f293aeb45@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Jul 2018 11:54:13 -0700
Message-ID: <CALAqxLXdLnDJMBsazpYdSshqYArrwFQ9=_t9g8veFtBXQYRY_Q@mail.gmail.com>
Subject: Re: [PATCH v3] time: Fix incorrect sleeptime injection when suspend fails
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:30 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 7/16/2018 10:44 PM, John Stultz wrote:
>>
>> On Mon, Jul 16, 2018 at 9:30 AM, John Stultz <john.stultz@linaro.org>
>> wrote:
>>>
>>> On Mon, Jul 16, 2018 at 9:17 AM, Mukesh Ojha <mojha@codeaurora.org>
>>> wrote:
>>>>
>>>> On 7/13/2018 10:50 PM, John Stultz wrote:
>>>>>
>>>>> On Fri, Jul 13, 2018 at 12:13 AM, Mukesh Ojha <mojha@codeaurora.org>
>>>>>>
>>>>>> On 7/11/2018 1:43 AM, John Stultz wrote:
>>>>>>>
>>>>>>> I worry this upside-down logic is too subtle to be easily reasoned
>>>>>>> about, and will just lead to future mistakes.
>>>>>>>
>>>>>>> Can we instead call this "suspend_timing_needed" and only set it to
>>>>>>> true when we don't inject any sleep time on resume?
>>>>>>
>>>>>>
>>>>>> I did not get your point "only set it to true when we don't inject any
>>>>>> sleep
>>>>>> time on resume? "
>>>>>> How do we know  this ?
>>>>>> This question itself depends on the "sleeptime_injected" if it is true
>>>>>> means
>>>>>> no need to inject else need to inject.
>>>>>>
>>>>>> Also, we need to make this variable back and forth true, false;
>>>>>> suspends
>>>>>> path ensures it to make it false.
>>>>>
>>>>> So yea, I'm not saying logically the code is really any different,
>>>>> this is more of a naming nit. So instead of having a variable that is
>>>>> always on that we occasionally turn off, lets invert the naming and
>>>>> have it be a flag that we occasionally turn on.
>>>>
>>>>
>>>> I understand your concern about the name of the variable will be
>>>> misleading.
>>>> But the changing Boolean state would not solve the actual issue.
>>>>
>>>> If i understand you correctly you meant below code
>>>>
>>>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>>>> index 32ae9ae..becc5bd 100644
>>>> --- a/kernel/time/timekeeping.c
>>>> +++ b/kernel/time/timekeeping.c
>>>> @@ -1523,7 +1523,7 @@ void __weak read_boot_clock64(struct timespec64
>>>> *ts)
>>>>    * If a suspend fails before reaching timekeeping_resume() then the
>>>> flag
>>>>    * stays true and prevents erroneous sleeptime injection.
>>>>    */
>>>> -static bool sleeptime_injected = true;
>>>> +static bool suspend_timing_needed;
>>>>
>>>>   /* Flag for if there is a persistent clock on this platform */
>>>>   static bool persistent_clock_exists;
>>>> @@ -1658,7 +1658,7 @@ void timekeeping_inject_sleeptime64(struct
>>>> timespec64
>>>> *delta)
>>>>          raw_spin_lock_irqsave(&timekeeper_lock, flags);
>>>>          write_seqcount_begin(&tk_core.seq);
>>>>
>>>> -       sleeptime_injected = true;
>>>> +       suspend_timing_needed = false;
>>>>
>>>>          timekeeping_forward_now(tk);
>>>>
>>>> @@ -1714,10 +1714,10 @@ void timekeeping_resume(void)
>>>>                                                tk->tkr_mono.mask);
>>>>                  nsec = mul_u64_u32_shr(cyc_delta, clock->mult,
>>>> clock->shift);
>>>>                  ts_delta = ns_to_timespec64(nsec);
>>>> -               sleeptime_injected = true;
>>>> +               suspend_timing_needed = true;
>>>>          } else if (timespec64_compare(&ts_new,
>>>> &timekeeping_suspend_time) >
>>>> 0) {
>>>>                  ts_delta = timespec64_sub(ts_new,
>>>> timekeeping_suspend_time);
>>>> -               sleeptime_injected = true;
>>>> +               suspend_timing_needed = true;
>>>>          }
>>>
>>> No no... This part is wrong. We only set suspend_timing_needed if we
>>> *didn't* calculate the suspend time in timekeeping_resume.
>>>
>>> You have to invert all the boolean logic for it to be equivalent.
>>>
>> ...
>>>>
>>>>    <sleeptime injection happens here>
>>>
>>>
>>> So, I think with the logic bug above it will work out properly, but
>>> let me know if I'm still missing something.
>
>
> Please give it thought to a case where very first suspend fails with your
> logic.

I believe I did. If the first suspend fails, we never reach
timekeeping_resume, so we never set "suspend_time_needed = true", so
then timekeeping_rtc_skipresume can then return true, and we don't
inject the time in the RTC code.

> If i am not able to get your thought, please write a patch.

I probably will, but I'd like to encourage you to follow through on
this one. You reported the issue, and submitted a few patches, so I
think it would be good for you to also get the patch credit here. I
don't believe its a complex request I've made, and I think you can
figure it out.

So, please, take one more real stab at this and I'll rework it if it
seems necessary.

thanks
-john
