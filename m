Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E826C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2887D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyF+CZFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfANKjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:39:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40953 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANKjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:39:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so22213804wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KxmXm1eNNs5tX/9G9/ryBykkzLE8g5ML5StxvWSPyjM=;
        b=AyF+CZFtob1h68eCdqBxTkT9MBrnPGFRwWdvRMN7+G0i+xCVogEyNmgxblvK/3r0Kg
         sTBxhYMdynqVwQ39yY7zKBIOmg9gyVaZBicUkwPHZtb241BM9GFCSVVZlprUFlWw25HO
         EouSM1PRU8PUvpA97JW0hVmK6sXLVHRPFKV20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxmXm1eNNs5tX/9G9/ryBykkzLE8g5ML5StxvWSPyjM=;
        b=VwOM5j9ExpxhJRfluJgSzSeFrc5cVd8iQACzklBWEW940xhrdxuWKY9njvbSx5l75d
         NMOrD5LYY8/oL0wHRWwSm08nIZP3+F61q3FeKF3Yjq0f2Ykrs7OFQPwIMmW1s85klTfM
         OHp3Iq/13F1b/j+g022mvCOf3pPZCFx9YCi9W120PVXrItUr00DhGQ10Dj5S5PTi7yYT
         R73PG6vzFH/ynaWNM8naZGV6L+CY0/ucHx+MQ0XheNmLIhUxA8k+2M/rlA6NQxf0QtSO
         IS4dEt2qH2vfzpDUQVX88+ltRzBWQbrD407UU9s4KI3PXp5r7zCqnDMy6IX12de46BcR
         FX6Q==
X-Gm-Message-State: AJcUukeIuFVa8gS9i+bGklIsteGU8T0MzGHvbME2ba8xx66Gk+nlemxJ
        PxD8iFpfiEoITI8oYvUppSA/Xw==
X-Google-Smtp-Source: ALg8bN6vUGFKBwmIiQghI75Ww9RNt0hg85t1rWfjnQBWQybEXiwRhRsS21GvFP8R9pgaEpnQqyAfPw==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr24730957wrf.164.1547462352080;
        Mon, 14 Jan 2019 02:39:12 -0800 (PST)
Received: from [192.168.0.41] (45.70.136.77.rev.sfr.net. [77.136.70.45])
        by smtp.googlemail.com with ESMTPSA id o8sm62881399wrx.15.2019.01.14.02.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:39:11 -0800 (PST)
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
 <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
 <CAJZ5v0hPnoLzJPRgE43NrB2Vt4BZYx=jgw_-WHoAiBQvhviY1A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8e1593ee-5a68-c0a1-50e4-6fedb6f3ec5a@linaro.org>
Date:   Mon, 14 Jan 2019 11:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hPnoLzJPRgE43NrB2Vt4BZYx=jgw_-WHoAiBQvhviY1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

sorry for the delay.

On 10/01/2019 11:20, Rafael J. Wysocki wrote:

[ ... ]

>>>       if (entered_state >= 0) {
>>> +             s64 diff, delay = drv->states[entered_state].exit_latency;
>>> +             int i;
>>> +
>>>               /*
>>>                * Update cpuidle counters
>>>                * This can be moved to within driver enter routine,
>>> @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
>>>               dev->last_residency = (int)diff;
>>
>> Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?
> 
> No.
> 
>> Otherwise the 'last_residency' accumulates the effective sleep time and
>> the time to wakeup. We are interested in the sleep time only for
>> prediction and metrics no ?
> 
> Yes, but 'delay' is the worst-case latency and not the actual one
> experienced, most of the time, and (on average) we would underestimate
> the sleep time if it was always subtracted.

IMO, the exit latency is more or less constant for the cpu power down
state. When it is the cluster power down state, the first cpu waking up
has the worst latency, then the others have the same has the cpu power
down state.

If we can model that, the gray area you mention below can be reduced.
There are platform where the exit latency is very high [1] and not
taking it into account will give very wrong metrics.

> The idea here is to only count the wakeup as 'above' if the total
> 'last_residency' is below the target residency of the idle state that
> was asked for (as in that case we know for certain that the CPU has
> been woken up too early) and to only count it as 'below' if the
> difference between 'last_residency' and 'delay' is greater than or
> equal to the target residency of a deeper idle state (as in that case
> we know for certain that the CPU has been woken up too late).
> 
> Of course, this means that there is a "gray area" in which we are not
> really sure if the sleep time has matched the idle state that was
> asked for, but there's not much we can do about that IMO.

There is another aspect of the metric which can be improved, the 'above'
and the 'below' give an rough indication about the correctness of the
prediction but they don't tell us which idle state we should have
selected (we can be constantly choosing state3 instead of state1 for
example).

It would be nice to add a 'missed' field for each idle states, so when
we check if there is a 'above' or a 'below' condition, we increment the
idle state 'missed' field for the idle state we should have selected.

  -- Daniel

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hi3660.dtsi#n199


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

