Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93519C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6072148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYU0u+oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbeL0XL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:11:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37928 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeL0XLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:11:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so19559113wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 15:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZbGq0ITxwispgPUkYaifH5YISFAbCyxZHg+q2KYQdWM=;
        b=ZYU0u+oRU0OEUsCMJBbbcbS4QyY6qMpGDpbaZBC18z8igzewu44iejMSMtF94XT1Av
         LHOYvqPgMHpBlcQtM5xMn/qM1qDZQPrRzo9CqSv++B5ke/Oli8AcJxxFjRYKoHmhjVFP
         FBR1EKxRM30Y3g7syp9IXHEATWwAmp1M9VM4Q1/UaTiNlq5WMiE8FUdungz9xGjOvdQn
         SliT17GbGQBw9CbrPhd7kxgui/D0+Mxe4vbH0MPIrXETl4sD6jYTHhEpAenvrqTM/6jn
         s5iyzWj3huP564qpc/bGC1mMqksZNVPPGRmaxkeLEEil1yisiSey+1p1q6duSdModoXt
         /GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZbGq0ITxwispgPUkYaifH5YISFAbCyxZHg+q2KYQdWM=;
        b=V0EWXbgsgJWmIgRXOIAYXhuWk1Wn5cUwuKC4k6o55M3F2+Z/CkOT+D8ec8TOivObMk
         T8q4pB8rp5yDRWmeCHHWtQRFSrP28lIVEaUs+aNrFIp38mXwQf7X6W1b9Gfg3Jj6rPaM
         GGltxWbH+kCxcGWsjQRiNvc/1MICLhbZ07yTaNOtBYfj61sDzR1AlcwDblxxI/PuPmtU
         ZuBMRIRcy88dg1r+rvuemVWbYZ0paHwmgaf36DqehdZwsT77MnuAUNTqy5WmTb6EREPJ
         44IULFKesUfNrKlbHjpDuPv8mxMNMrHEWuyxAyksk3fwAUivGtKtqS2xpY5wsHVX7DzR
         HacA==
X-Gm-Message-State: AJcUukcufqRhsKn06WUS00D7bh7g5jqiu9NNOedKdoUhx83IGc/gARDc
        /CPguVEy9EaMuW4esYgtA3Q=
X-Google-Smtp-Source: ALg8bN5uRqIw2Fp5iwIrMDXOWbRp93NE96zaMEdyURwtfQL7p7Z6TJ3gPhNVuM2z74VROgM87ddRBQ==
X-Received: by 2002:adf:92c7:: with SMTP id 65mr22287703wrn.228.1545952282907;
        Thu, 27 Dec 2018 15:11:22 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:25c7:a0bd:faa6:5840? (p200300EA8BCFE30025C7A0BDFAA65840.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:25c7:a0bd:faa6:5840])
        by smtp.googlemail.com with ESMTPSA id k3sm47813034wrm.7.2018.12.27.15.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 15:11:21 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
Date:   Fri, 28 Dec 2018 00:11:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181227065321.GA3749@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.12.2018 07:53, Frederic Weisbecker wrote:
> On Mon, Oct 15, 2018 at 10:58:54PM +0200, Heiner Kallweit wrote:
>> On 28.09.2018 15:18, Frederic Weisbecker wrote:
>>> On Thu, Sep 27, 2018 at 06:05:46PM +0200, Thomas Gleixner wrote:
>>>> On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
>>>>> On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
>>>>>> I tested it and Frederic is right, it doesn't help. Can it be somehow related to
>>>>>> the cpu being brought down during suspend? Because I get the warning only during
>>>>>> suspend when the cpu is inactive already (but still online).
>>>>>
>>>>> It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
>>>>>
>>>>> Does this script eventually trigger it after some time?
>>>>
>>>> Any update to this?
>>>
>>> Heiner? Can you please test the script I sent to you?
>>>
>>> Thanks.
>>>
>> Sorry, took some time .. And yes, running your script triggers the message too.
>>
[...]
> 
> Sorry, I got sidetracked and almost forgot about it.
> 
> So this is triggered by CPU hotplug. At some point the CPU has an
> opportunity to go idle and for some reason the timer softirq is still
> pending. We need to know which timer this is about and why the timer
> softirq keeps pending.
> 
> I'm going to need your help again. Can you please run the following (possibly
> repeat until it triggers the bug) ?
> 
>    echo 1 > /sys/devices/system/cpu/cpu1/online
> 
>    # Pause and reset tracing
>    echo 0 > /sys/kernel/debug/tracing/tracing_on
>    echo > /sys/kernel/debug/tracing/trace
> 
>    # Turn on relevant events
>    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_*/enable
>    echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_*/enable
>    echo 1 > /sys/kernel/debug/tracing/tracing_on
> 
>    # Trigger
>    echo 0 > /sys/devices/system/cpu/cpu1/online
> 
>    echo 0 > /sys/kernel/debug/tracing/tracing_on
> 
> And please apply the following patch before. With all that I'll have the
> relevant informations stored in /sys/kernel/debug/tracing/per_cpu/cpu1/trace
> Please send its content to me. Thanks!
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 69e673b..0e57a3b 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -892,6 +892,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>  		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
>  			pr_warn("NOHZ: local_softirq_pending %02x\n",
>  				(unsigned int) local_softirq_pending());
> +			trace_dump_stack(0);
>  			ratelimit++;
>  		}
>  		return false;
> 
> 

OK, did as you advised and here comes the trace. That's the related dmesg part:

[ 1479.025092] x86: Booting SMP configuration:
[ 1479.025129] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 1479.094715] NOHZ: local_softirq_pending 202
[ 1479.096557] smpboot: CPU 1 is now offline

Hope it helps.
Heiner


# tracer: nop
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [001] d.h2  1479.099092: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.099098: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.099106: softirq_raise: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.099114: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.099120: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.099121: softirq_entry: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.099134: softirq_exit: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.099135: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.099141: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.100094: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.100109: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.100116: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.101091: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.101113: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.101118: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.102094: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.102114: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.102121: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.103091: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.103097: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.103105: softirq_raise: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.103114: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.103118: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.103119: softirq_entry: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.103131: softirq_exit: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.103132: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.103138: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.105092: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.105115: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.105119: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.106092: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.106112: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] .Ns2  1479.106144: softirq_exit: vec=9 [action=RCU]
         cpuhp/1-13    [001] d..2  1479.106279: timer_cancel: timer=0000000009a25653
          <idle>-0     [001] d.h2  1479.106965: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.106969: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.106974: softirq_raise: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.106981: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.106984: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.106985: softirq_entry: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.106994: softirq_exit: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.106995: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.106999: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.107996: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.108010: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.108014: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.109009: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.109013: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.109024: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.109028: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.109028: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.109033: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.110013: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.110033: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] ..s2  1479.110040: softirq_exit: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.111011: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.h2  1479.111017: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d.h2  1479.111026: softirq_raise: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.111035: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.111040: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] ..s2  1479.111040: softirq_entry: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.111052: softirq_exit: vec=7 [action=SCHED]
          <idle>-0     [001] ..s2  1479.111052: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] .Ns2  1479.111079: softirq_exit: vec=9 [action=RCU]
         cpuhp/1-13    [001] dNh2  1479.112930: softirq_raise: vec=1 [action=TIMER]
         cpuhp/1-13    [001] dNh2  1479.112935: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d..1  1479.113077: <stack trace>
 => can_stop_idle_tick.isra.14
 => tick_nohz_get_sleep_length
 => menu_select
 => cpuidle_select
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => secondary_startup_64
          <idle>-0     [001] .Ns2  1479.113110: softirq_entry: vec=1 [action=TIMER]
          <idle>-0     [001] .Ns2  1479.113114: softirq_exit: vec=1 [action=TIMER]
          <idle>-0     [001] .Ns2  1479.113115: softirq_entry: vec=9 [action=RCU]
          <idle>-0     [001] .Ns2  1479.113139: softirq_exit: vec=9 [action=RCU]
