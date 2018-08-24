Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36453C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31AC21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/hfSGjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31AC21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHXUmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:42:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43083 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHXUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:42:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so8041507wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O7AvYH16Mb9zpfPteJmMR7P5Dtd+QnYlEJnLD8ryva4=;
        b=D/hfSGjkv3Jpp7knU3daqSiMhV38vtEda7FatVQqsURmgHH7c3KAflLKM0VDZYGLrT
         mFhrrwvZMElRMof5HGWEwF+Rh/eYArOjX/YyF4DoVJARcQO03yj94MN1e2aVDS59CMS9
         dMd+pTBedcPlnc7bGrIPSxwucvj+e2T/hOwvhB5Z6QiD0W5NImpGp/2g75Qw36fbgXE5
         RN6M6yMaurCNS/fzmPG/nM5gnN+4kiqrxjV++oP5A+bnJPfsfRP1PgXOzTmDDcOT3+kA
         f6X+iXN2gPKjCm71LiYF7U2vMi6Z1VI2e3zBep5FQ3BKQqW8B7bNoZZIkZT0mr+a0GhZ
         wkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O7AvYH16Mb9zpfPteJmMR7P5Dtd+QnYlEJnLD8ryva4=;
        b=JmqaBG0cQl9cIYhjYgysjhoFUAvV0e28o/+Opt980Bbc1ohxQ+byW0xXlHItnDCQFA
         /tERXPiqfNCh1eDrH63IerabK/006yaZQ8p+Y61BpdBcxuNe/WImbY4k16gkG3FQv/71
         TlbvlDWk0Z2ceYIf3DBDryGIwzQivmTUn9lQoV/O1OUAhN4eNoq1z1+8OaQBh+IcBRBk
         4/cntPyxj9lgHj/iGAPYm1CBLRC5fVrbw25rYNimHjxp47HlbsncdNQEkTSUJg2UhPJE
         c54rLGUsQ2Adc7ar5lC8X6R/6HK48Tj94rmhHAa9RsQt94/wSlkzl9B/D6NlbsoR0f+s
         C1vA==
X-Gm-Message-State: APzg51BmxsatWr1kf12hMu+6+EgvdHmKGegQ8LvvhXpuxb/JjjjJJi86
        kbaJT8eojxaDLdu37BQj6lk=
X-Google-Smtp-Source: ANB0VdamWMOu/JLhnISYskzFTXYjWv5fAvskFF60llEGSZpAaK3mUNXZxp9ujJq7P6EQHu0Q2CJmeA==
X-Received: by 2002:a5d:62c2:: with SMTP id o2-v6mr1919569wrv.83.1535130400670;
        Fri, 24 Aug 2018 10:06:40 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:a828:17f:1f11:4ac0? (p200300EA8BD4D600A828017F1F114AC0.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:a828:17f:1f11:4ac0])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm9807750wrr.68.2018.08.24.10.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 10:06:40 -0700 (PDT)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
Date:   Fri, 24 Aug 2018 19:06:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824143056.GC2730@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2018 16:30, Frederic Weisbecker wrote:
> On Fri, Aug 24, 2018 at 10:01:35AM +0200, Thomas Gleixner wrote:
>> On Fri, 24 Aug 2018, Heiner Kallweit wrote:
>>> On 24.08.2018 06:12, Frederic Weisbecker wrote:
>>>> On Thu, Aug 16, 2018 at 08:13:03AM +0200, Heiner Kallweit wrote:
>>>>> Recently I started to get warning "NOHZ: local_softirq_pending 202" and
>>>>> I think it's related to mentioned commit (didn't bisect it yet).
>>>>> See log from suspending.
>>>>>
>>>>> I have no reason to think the fix is wrong, it may just have revealed
>>>>> another issue which existed before and was hidden by the bug.
>>>>>
>>>>> Rgds, Heiner
>>>>>
>>>>> [   75.073353] random: crng init done
>>>>> [   75.073402] random: 7 urandom warning(s) missed due to ratelimiting
>>>>> [   78.619564] PM: suspend entry (deep)
>>>>> [   78.619675] PM: Syncing filesystems ... done.
>>>>> [   78.653684] Freezing user space processes ... (elapsed 0.002 seconds) done.
>>>>> [   78.656094] OOM killer disabled.
>>>>> [   78.656113] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>>>> [   78.658177] Suspending console(s) (use no_console_suspend to debug)
>>>>> [   78.663066] nuvoton-cir 00:07: disabled
>>>>> [   78.671817] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>>> [   78.672210] sd 0:0:0:0: [sda] Stopping disk
>>>>> [   78.786651] ACPI: Preparing to enter system sleep state S3
>>>>> [   78.789613] PM: Saving platform NVS memory
>>>>> [   78.789759] Disabling non-boot CPUs ...
>>>>> [   78.805154] NOHZ: local_softirq_pending 202
>>>>> [   78.805182] NOHZ: local_softirq_pending 202
>>>>> [   78.807102] smpboot: CPU 1 is now offline
>>>>
>>>> I've tried to reproduce with suspend on disk but got unsuccessful.
>>>>
>>>> A small question as I see someone is having a similar issue with a stable
>>>> release only. On which kernel did you trigger that: upstream or stable?
>>>>
>>>> I'll continue investigating.
>>>>
>>>> Thanks.
>>>>
>>> Affected is recent linux-next, after the commit mentioned in the subject.
>>> I can work around the warning (not sure whether it's a proper fix),
>>> see here:
>>> https://lkml.org/lkml/2018/8/18/272
>>
>> Can you try the one I posted in this thread:
>>
>>  https://lkml.kernel.org/r/alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de
>>
>> Also below for reference.
>>
>> Thanks,
>>
>> 	tglx
>>
>> 8<----------------
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 5b33e2f5c0ed..6aab9d54a331 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -888,7 +888,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>>  	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
>>  		static int ratelimit;
>>  
>> -		if (ratelimit < 10 &&
>> +		if (ratelimit < 10 && !in_softirq() &&
>>  		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
>>  			pr_warn("NOHZ: local_softirq_pending %02x\n",
>>  				(unsigned int) local_softirq_pending());
> 
> I fear it may not work in his case because it happens in -next and we don't stop
> the idle tick from IRQ tail anymore. So we shouldn't be interrupting a softirq
> in this path. Still it's worth trying, I may well be missing something.
> 
> Thanks.
> 
I tested it and Frederic is right, it doesn't help. Can it be somehow related to
the cpu being brought down during suspend? Because I get the warning only during
suspend when the cpu is inactive already (but still online).
