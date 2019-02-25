Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D0D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUMql83o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfBYPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:01:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54811 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfBYPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:01:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so8420447wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I7Cam1ATgPa3L9mdQh/5uTPHzPf/5snkwT0tQj2CzaI=;
        b=HUMql83oCwUM/NbpzUgMiBg5zU6yctO4HO5cm5HO2mmciXy8RVTKD+WY+oVppuLg4X
         7MJOBw6I3bGKudmF0aMn2QAbD+yJZMX+6j51CU7YNVqrYd+NlBl43kCQVMk1S5S46jE0
         stJ0M7ivTjyRm7DUB/XQudNk5bj2c3f6kw5TKztV8Pibq4kzPlxFd/vmdidSiG9LCL2b
         BxDgCN/bZFoLSUc6b9zJoa/YB6d2xVoeuOzrhSRZ9pcTnaDTiVTdpQLs1f7Ql5btBwGD
         pLXDvWGlGZSDiBqaws2wNFaeMaEG6sHCnHyszzAVKGX9BgxBubm1Li19jMaWGJ0+XemN
         OB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7Cam1ATgPa3L9mdQh/5uTPHzPf/5snkwT0tQj2CzaI=;
        b=hHczqMKO+JLcck7LpopoENxHTkAHLnTTreWSkrLmBGCdl9W49Sk7xKCWJPbh8QXgXY
         vJh6j0oMG0lNQhylAslrR+fj3L5iTmnikq1sUg3i9dNJD9K+BCgdaD/iJWwWF4zbGix7
         cPiuliaeocChaX4mHdAbrL1Ue5YtIxlcmLn71Ttk27nfAiIn6M2bhus7iZTX6R0I9b/j
         fA83EApobzBuUMerSXU3Xn8aAYY0m0K2BIEtdI7VKjtDRDtRNBb0kiQ3IVE2eiGubVtk
         uiSul17XElxFDk3MZoXZGF0+ElFDdo5kFev8s7E58sPfz/TtujY/H7QAq/HJX06gpX60
         xoig==
X-Gm-Message-State: AHQUAua2OrrkZVqlJIudfU1EOmzQVYJdN5lYWvX1E1b1PD6sbr31LH9k
        /cdNWavbynOAqHANcgSxnpRKmkzjUrY=
X-Google-Smtp-Source: AHgI3IZWqLXFd8xSRk/IQe0zFuHlZhLuunLeFDIHrU0+rztOUENlW2pCyXQediXbrVV6VosqOyV/GQ==
X-Received: by 2002:a1c:400a:: with SMTP id n10mr10606195wma.56.1551106871184;
        Mon, 25 Feb 2019 07:01:11 -0800 (PST)
Received: from [192.168.0.41] (5.22.136.77.rev.sfr.net. [77.136.22.5])
        by smtp.googlemail.com with ESMTPSA id j41sm29458728wre.9.2019.02.25.07.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:01:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
 <d315736a-2aa0-3c8d-f3cf-f73b60e7ebe0@linaro.org>
 <CAJZ5v0ishtmAJ4vyosedTY6ZY+RcenpP_yzwVAgGybONGU6Zsw@mail.gmail.com>
Message-ID: <e3421211-c59d-a372-2e27-68f452f4f8b1@linaro.org>
Date:   Mon, 25 Feb 2019 16:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ishtmAJ4vyosedTY6ZY+RcenpP_yzwVAgGybONGU6Zsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 22/02/2019 11:35, Rafael J. Wysocki wrote:
> On Thu, Feb 21, 2019 at 6:40 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/02/2019 17:18, Rafael J. Wysocki wrote:
>>> On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> Predicting the next event on the current CPU is implemented in the
>>>> idle state selection function, thus the selection logic and the
>>>> prediction are tied together and it is hard to decorrelate both.
>>>>
>>>> The following change introduces the cpuidle function to give the
>>>> opportunity to the governor to store the guess estimate of the
>>>> different source of wakeup and then reuse them in the selection
>>>> process. Consequently we end up with two separate operations clearly
>>>> identified.
>>>>
>>>> As the next events are stored in the cpuidle device structure it is
>>>> easy to propagate them in the different governor callbacks.
>>>
>>> Can you explain a bit how you would use this new callback in a governor?
>>
>> Sure.
>>
>> Today we have the selection and the prediction tied together. The
>> prediction is modulated with some inputs coming from the governor's
>> policy (eg. performance multiplier).
>>
>> It is hard to know if the prediction is correct or not, hard to know the
>> duration of the computation for the next event and hard to know if the
>> idle state selection succeeded because of a good prediction or a good
>> governor policy.
>>
>> I propose to provide the callback where we fill the guess estimated next
>> events on the system, so we can trace them and benchmark the computation
>> time.
>>
>> The selection of the idle state becomes an separate action where we can
>> apply any specific governor heuristic or policy.
>>
>> By separating the selection and the prediction, we can identify where
>> the weakness is in our test scenario: the prediction or the governor
>> selection policy.
> 
> I'm not quite convinced about the idea that the "prediction" and
> "selection" parts can be entirely separate.
> 
> Besides, this new callback doesn't return anything, it goes before
> ->select and the latter is invoked unconditionally anyway.  That's
> extra overhead (even if small) for no real gain.  I don't see why it
> is better to do the split in the core rather than in the governor
> itself.  You can always design a governor ->select() to call two
> separate functions, one after another, internally, so why to do that
> in the core and inflict that particular design choice on everybody?

It is a way to clearly identify what is part of the prediction and what
is part of the decision in order to easily spot the weakness of the
governor. We may be doing good predictions but bad decisions or the
opposite.

I agree we are not forced to create a new callback for this and we can
create a prediction function directly inside the governor. I don't have
a strong preference actually and I'm fine with your proposal.

> For example, there's no "predict" part running before the "select" one
> in the TEO governor at all.  There is something like that in menu, but
> splitting it off would be rather artificial IMO.
> 
> Next, the cpuidle_predict structure.  I'm not even sure why it is there at all.
> 
> Presumably, the purpose of it is to pass some data from ->predict to
> ->select, but why does it have to be there in struct cpuidle_device?
> The governor appears to be the only user of it anyway, so wouldn't it
> be better to store that information in the governor's internal data
> structures if really needed?

At one moment we will need the prediction information from the scheduler
in order to optimize the cpu selection for the wakeup. I thought the
cpuidle device structure can be a place where we can store it.

There are a lot of optimizations we can do after knowing when a CPU is
expected to wakeup.

Do you have a suggestion where to store the next wakeup for a CPU?

> Moreover, why does it include the next_hrtimer and next_timer fields?
> It looks like you'd need to do some nohz code surgery to separate the
> two and would that be useful even?  And even so, these values need not
> be predicted. 

I agree they don't need to be predicted but they are part of the sources
of wake up with a deterministic behavior and fall under the prediction
umbrella as they are part of the equation for the next event.

The purpose of filling these fields is to give the select callback all
the clues to take its decision.

But regarding your POV, which is valid, we can consider using an
internal prediction function and just export the next event without a
full description of the different wake up source categories.

> It is known when the next timer event is going to
> occur, both with and without the scheduler tick included, and that's
> why there is tick_nohz_get_sleep_length().

The next hrtimer and the next timer are the deadline versions of
tick_nohz_get_sleep_length(), respectively the delta_time parameter and
the returned value.

I massaged the tick_nohz_get_sleep_length() to return the deadline
rather than the remaining time. The changes will come with the patches
Ulf is about to send. IMHO, it helps to understand the code by splitting
in two functions rather than passing an extra parameter.


> If you want to do a similar thing for non-timer interrupts in order to
> use the IRQ stats, you can simply provide a function similar to
> tick_nohz_get_sleep_length() for that, but that's available already,
> isn't it?

Actually, I'm interested in deadlines not in relative remaining time
because we need later to compare those when we are about to wake up a
CPU or enter the cluster state.

Indeed, the irq timings is already available but with the limitation of
predicting regular intervals. I rewrote the code to handle both regular
and repeating pattern. I'll post the series as soon as I have the numbers.


> Also, I'm not really sure what next_resched is and how exactly it is
> going to be computed.


The next_resched estimation is to handle the situation where you have
one CPU handling IO related interrupts for a specific device waking up
another CPU with the io blocked task. It is very similar to the avg_idle
value.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

