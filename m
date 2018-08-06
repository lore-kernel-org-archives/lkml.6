Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E354320685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htEeBgvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E354320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbeHGABT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:01:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55616 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeHGABS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:01:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so15245839wmc.5;
        Mon, 06 Aug 2018 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OO1D2ZrLfuLSWwp+fI7tvekmye2OnK4bf27b9eWUK94=;
        b=htEeBgvXOUmE/dID4n3nMiPNr+2/Xr0552yZldYMiC9kJuCK/tdQ188UTqS+eWt1GF
         fP8axhaEBkT/2q2oMrKhKDue1+8X5iUwqCHDp5ElHzbBoG8MXLrlBUHuEXncWJGBtPlD
         jkHb2s5SMoM8KpMHLw7m8zZ6o8Ch/36Dpjs/FN/Hhri09RD/gwaXAYZM0+QFubQ4Tfn0
         gunfKD7VF2b3L7FaO8ROME68IC6Ikk6X7zeZGBGlRZqAGRD6mkz6DIh2U95ja25yIevq
         qCSz60e9tC56Xg4v3spNOp0oKqSqRaEFDCfUH36hCNbEQGIwjtomXx3262MhlvyOmPCM
         L2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OO1D2ZrLfuLSWwp+fI7tvekmye2OnK4bf27b9eWUK94=;
        b=Ij/GUGsJ+AcuMHsXtn6kek/+Uz+Vmvy5DOvCGnPj1AQnplYWHQZAFEZv4weei2WxSv
         BH7IJg2+fxgxRQ+Bb8OoQ4MAGsy9iJ7dbHPaPyql2TIOsEGxIQmr1HolQKlIWD/Yof8j
         fHR7sTFfEJUbn0YNqeAKoX0FroHs8boUujX3hAwduhXXrhnqOjZxXxqKaV0GaxNPjXf6
         TTpfUESL1yEiVADWk+0BYhRempBv7vx4rx0pVhLzB9A2ffe6qNjGgU9WCwn84AJvek8V
         X+FWOs7v2QV5HUoxeXOq/XEdcohSUfRMLmeIC5V1lNS9dHOlCjBI+plJc/iv+J/qgKdB
         IB6g==
X-Gm-Message-State: AOUpUlE2bb4QK/xFpqVXL7oiAbSA3XKA0IVlRaDq6TzL3tn/2sQMfv73
        Azt+Bj8VG+YWDIsM9RM33zQdJJKU
X-Google-Smtp-Source: AA+uWPwF8e/dXeUgdGZNkdE+ZFd3QC4pKj1Huoue9iUcElCPbvQ1KY8nquoLNxCLtXM3qFlaAc6thA==
X-Received: by 2002:a1c:5b09:: with SMTP id p9-v6mr11511wmb.0.1533592213042;
        Mon, 06 Aug 2018 14:50:13 -0700 (PDT)
Received: from [192.168.178.21] (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id j8-v6sm19586814wrp.11.2018.08.06.14.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 14:50:11 -0700 (PDT)
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180804152932.3861-1-gabriele.mzt@gmail.com>
 <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
 <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
 <cd2287153b369d88cc240068adc7d341ef675acf.camel@linux.intel.com>
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <7195d55c-373d-23db-2744-ef3b1b719a5b@gmail.com>
Date:   Mon, 6 Aug 2018 23:50:10 +0200
MIME-Version: 1.0
In-Reply-To: <cd2287153b369d88cc240068adc7d341ef675acf.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 18:49, Srinivas Pandruvada wrote:
> On Mon, 2018-08-06 at 10:30 +0200, Rafael J. Wysocki wrote:
>> On Sat, Aug 4, 2018 at 7:31 PM, Gabriele Mazzotta
>> <gabriele.mzt@gmail.com> wrote:
>>> On 04/08/2018 17:29, Gabriele Mazzotta wrote:
>>>> This change does not take into account that some BIOSes change
>>>> MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
>>>> If the turbo is disabled when the system boots, policy.max_freq
>>>> is set to pstate.max_pstate. However, if the BIOS later enables
>>>> the turbo, the CPU will never be able to run at
>>>> pstate.turbo_pstate.
>>>>
>>>> Since now intel_pstate_set_policy() does its calculations using
>>>> pstate.max_freq and pstate.turbo_freq, we can always calculate
>>>> cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
>>>> with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
>>>> speed when the turbo is enabled.
>>
>> Well, the problem with this approach is that always using
>> pstate.turbo_pstate as the max causes the governor to overestimate
>> the
>> target frequency when the turbo range is not available (the target
>> depends on the width of the entire available P-state range including
>> turbo, so if the turbo range is not available, the number take into
>> that computation is too large).
>>
>> Are we expected to get notified when the BIOS updates
>> MSR_IA32_MISC_ENABLE_TURBO_DISABLE?
> 
> Let's try this:
> - boot with kernel command line 
> 
> intel_pstate=support_acpi_ppc dyndbg="file processor_perflib.c +p"
> dyndbg="file intel_pstate.c +p"

Plugged -> Unplugged:

[   40.046116] CPU 0: _PPC is 6 - frequency  limited
[   40.046128] intel_pstate: policy->max > max non turbo frequency
[   40.046131] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 3000000
[   40.046134] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:30
[   40.046137] intel_pstate: cpu:0 global_min:8 global_max:30
[   40.046140] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8
[   40.162173] CPU 0: _PPC is 6 - frequency  limited
[   40.162186] intel_pstate: policy->max > max non turbo frequency
[   40.162190] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 3000000
[   40.162194] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:30
[   40.162197] intel_pstate: cpu:0 global_min:8 global_max:30
[   40.162200] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8
[   40.162215] CPU 0: _PPC is 6 - frequency  limited
[   40.162220] intel_pstate: policy->max > max non turbo frequency
[   40.162223] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 3000000
[   40.162226] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:30
[   40.162228] intel_pstate: cpu:0 global_min:8 global_max:30
[   40.162230] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8
[   40.162237] CPU 0: _PPC is 6 - frequency  limited
[   40.162241] intel_pstate: policy->max > max non turbo frequency
[   40.162243] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 3000000
[   40.162245] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:30
[   40.162247] intel_pstate: cpu:0 global_min:8 global_max:30
[   40.162249] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8
[   40.162257] CPU 0: _PPC is 6 - frequency  limited
[   40.162261] intel_pstate: policy->max > max non turbo frequency
[   40.162263] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 3000000
[   40.162265] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:30
[   40.162267] intel_pstate: cpu:0 global_min:8 global_max:30
[   40.162269] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8

Unplugged -> Plugged:

[   52.648535] CPU 0: _PPC is 6 - frequency  limited
[   52.648553] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 1700000
[   52.648558] intel_pstate: cpu:0 max_state 17 min_policy_perf:8 max_policy_perf:17
[   52.648562] intel_pstate: cpu:0 global_min:8 global_max:30
[   52.648566] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8
[   52.648583] CPU 0: _PPC is 6 - frequency  limited
[   52.648590] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 1700000
[   52.648595] intel_pstate: cpu:0 max_state 17 min_policy_perf:8 max_policy_perf:17
[   52.648598] intel_pstate: cpu:0 global_min:8 global_max:30
[   52.648602] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8
[   52.656093] CPU 0: _PPC is 6 - frequency  limited
[   52.656111] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 1700000
[   52.656116] intel_pstate: cpu:0 max_state 17 min_policy_perf:8 max_policy_perf:17
[   52.656120] intel_pstate: cpu:0 global_min:8 global_max:30
[   52.656123] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8
[   52.775577] CPU 0: _PPC is 6 - frequency  limited
[   52.775594] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 1700000
[   52.775598] intel_pstate: cpu:0 max_state 17 min_policy_perf:8 max_policy_perf:17
[   52.775601] intel_pstate: cpu:0 global_min:8 global_max:30
[   52.775604] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8
[   53.028620] CPU 0: _PPC is 6 - frequency  limited
[   53.028637] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 1700000
[   53.028643] intel_pstate: cpu:0 max_state 17 min_policy_perf:8 max_policy_perf:17
[   53.028647] intel_pstate: cpu:0 global_min:8 global_max:30
[   53.028651] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8

> and send dmesg after you change power sources.
> 
> - Also try with
> intel_pstate=disable dyndbg="file processor_perflib.c +p"

Nothing gets printed with this one.

Thanks,
Gabriele

> and send dmesg.
> 
> Thanks,
> Srinivas
> 
> 
