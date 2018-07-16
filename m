Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823A2208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkPvQj3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823A2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeGPQ66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:58:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40809 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeGPQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:58:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so32541461wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8lwNPQDX1hFHkMBP4L3MW+wFxka5iETCzqUAFlH0nkU=;
        b=OkPvQj3xOHW6keElt2OFuDNEpRM2ifXXeZ8nNnqXXnE61VG5YQKplxoWzOldAnpFEy
         jbB52pyqiBJ8uqD+rDv2SKak/jfCZj4aSDFGCb5OEzhJxM+Jzmf+KXqPxOpxdEWHe5s+
         LS0wJ9gwlZly54QZ8+w9NBkweb6FN6v9tYqQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8lwNPQDX1hFHkMBP4L3MW+wFxka5iETCzqUAFlH0nkU=;
        b=msNEY8nifTqvuqBxnP4L7Ff7fmXZANvXAxEsZ6TS3e/1IcQMEEMk34MABlCh1LQNm3
         dlW9bQ+qRe1H/bLSuq0Mcx1Saa2HMmoDdzoRmiLDVu2z2Wm7OM+Zg/BJ50NFVJoNb1kY
         /dSpufZTLJuRwGUBozAVds6OsRuZ2B27YJN9FZrTwuVW6GKNujoyzVeozYvqUGhYUXMz
         LmiyusNm7/lAAhRm58qAL9X+mtQtpCG3ElcdKjikXIea5gl2hqeYWEKG7kyY/lsLX9GH
         fHWWqj38gSBKr9iltW4RPFDgROG0T9DUGOx4nYQB3sfleoHEuqb5177UCwgTj/8s7bhH
         iWHQ==
X-Gm-Message-State: AOUpUlHTdoRFumFER0fNmUPlRTJJRAA24mGyPCaCqPHjbD1mZTuGowzu
        dJi4Vfn/MRjwHBzSLlWY13fiqMS8ZGRgdpMYG3nvEtZF
X-Google-Smtp-Source: AAOMgpeUSkJRPjsenCymkxhqY+qIoY+V7GjTGMblxKTFLQfmJn3c4cSuqaKuGjCniDrwv13Duhd7vJp6Yr+1qwP/KeY=
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr12736071wrq.116.1531758646128;
 Mon, 16 Jul 2018 09:30:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 09:30:45
 -0700 (PDT)
In-Reply-To: <45be9c4f-34fd-200a-df95-9c30b332a96b@codeaurora.org>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
 <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com>
 <7e25b63e-cc9b-1f6d-e3d2-087dd484f631@codeaurora.org> <CALAqxLX=-ZZV=O7AAZwMYaXZ1s5h91BfFng4qbtgvkvrKtxgaw@mail.gmail.com>
 <45be9c4f-34fd-200a-df95-9c30b332a96b@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Jul 2018 09:30:45 -0700
Message-ID: <CALAqxLVtOv52O=PePEfMmTXeJ5ndkoG8DRwoRs0dxnu+QwqVXQ@mail.gmail.com>
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

On Mon, Jul 16, 2018 at 9:17 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
> On 7/13/2018 10:50 PM, John Stultz wrote:
>> On Fri, Jul 13, 2018 at 12:13 AM, Mukesh Ojha <mojha@codeaurora.org>
>>> On 7/11/2018 1:43 AM, John Stultz wrote:
>>>> I worry this upside-down logic is too subtle to be easily reasoned
>>>> about, and will just lead to future mistakes.
>>>>
>>>> Can we instead call this "suspend_timing_needed" and only set it to
>>>> true when we don't inject any sleep time on resume?
>>>
>>>
>>> I did not get your point "only set it to true when we don't inject any
>>> sleep
>>> time on resume? "
>>> How do we know  this ?
>>> This question itself depends on the "sleeptime_injected" if it is true
>>> means
>>> no need to inject else need to inject.
>>>
>>> Also, we need to make this variable back and forth true, false; suspends
>>> path ensures it to make it false.
>>
>> So yea, I'm not saying logically the code is really any different,
>> this is more of a naming nit. So instead of having a variable that is
>> always on that we occasionally turn off, lets invert the naming and
>> have it be a flag that we occasionally turn on.
>
>
> I understand your concern about the name of the variable will be misleading.
> But the changing Boolean state would not solve the actual issue.
>
> If i understand you correctly you meant below code
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 32ae9ae..becc5bd 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1523,7 +1523,7 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>   * If a suspend fails before reaching timekeeping_resume() then the flag
>   * stays true and prevents erroneous sleeptime injection.
>   */
> -static bool sleeptime_injected = true;
> +static bool suspend_timing_needed;
>
>  /* Flag for if there is a persistent clock on this platform */
>  static bool persistent_clock_exists;
> @@ -1658,7 +1658,7 @@ void timekeeping_inject_sleeptime64(struct timespec64
> *delta)
>         raw_spin_lock_irqsave(&timekeeper_lock, flags);
>         write_seqcount_begin(&tk_core.seq);
>
> -       sleeptime_injected = true;
> +       suspend_timing_needed = false;
>
>         timekeeping_forward_now(tk);
>
> @@ -1714,10 +1714,10 @@ void timekeeping_resume(void)
>                                               tk->tkr_mono.mask);
>                 nsec = mul_u64_u32_shr(cyc_delta, clock->mult,
> clock->shift);
>                 ts_delta = ns_to_timespec64(nsec);
> -               sleeptime_injected = true;
> +               suspend_timing_needed = true;
>         } else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) >
> 0) {
>                 ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
> -               sleeptime_injected = true;
> +               suspend_timing_needed = true;
>         }

No no... This part is wrong. We only set suspend_timing_needed if we
*didn't* calculate the suspend time in timekeeping_resume.

You have to invert all the boolean logic for it to be equivalent.

>         if (sleeptime_injected)
> @@ -1756,7 +1756,7 @@ int timekeeping_suspend(void)
>         if (timekeeping_suspend_time.tv_sec ||
> timekeeping_suspend_time.tv_nsec)
>                 persistent_clock_exists = true;
>
> -       sleeptime_injected = false;
> +       suspend_timing_needed = false;
>
>         raw_spin_lock_irqsave(&timekeeper_lock, flags);
>
>
> This has a problem..
>
>
>>
>> Just the name sleeptime_injected is read a statement, which if we say
>> is defaults to true, becomes confusing to think about when the
>> timekeeping_suspend/resume code hasn't yet run (which is the case
>> where your error cropped up) - and no sleeptime has actually been
>> injected.
>
>
> Yes, when very first suspend fails and timekeeping_suspend/resume did not
> run ; That is the exact issue.
> So, exact solution is no need to inject any sleeptime here.
>
>  If we set the default value to false then we will see timekeeping_resume
> will inject sleeptime by below code which was not intended.
>
> static int rtc_resume(struct device *dev)
> {
>         struct rtc_device       *rtc = to_rtc_device(dev);
>         struct rtc_time         tm;
>         struct timespec64       new_system, new_rtc;
>         struct timespec64       sleep_time;
>         int err;
>
>         if (timekeeping_rtc_skipresume())  // it will return the value false
> as sleep failed and timekeeping_resume() did not get called.
>                 return 0;
>
>   <sleeptime injection happens here>


So, I think with the logic bug above it will work out properly, but
let me know if I'm still missing something.

thanks
-john
