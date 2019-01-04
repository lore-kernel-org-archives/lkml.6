Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD64218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfADQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:49:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfADQtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:49:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE91EBD;
        Fri,  4 Jan 2019 08:49:52 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46B023F5D4;
        Fri,  4 Jan 2019 08:49:50 -0800 (PST)
Subject: Re: [PATCH v3 3/3] arm64: Early boot time stamps
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
 <20181226164509.22916-4-pasha.tatashin@soleen.com>
 <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
 <CA+CK2bA_006YGu3dtJM24pN1ZGgcJZnF2oEeWKkq3QBrcCbB6Q@mail.gmail.com>
 <86bm4wbff9.wl-marc.zyngier@arm.com>
 <CA+CK2bCZHCp7d3SyiE2UpZr=K-NMPcGPVS0d-iU_7_tfcVmaGw@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <54caed52-2859-df94-1e3b-223397d42602@arm.com>
Date:   Fri, 4 Jan 2019 16:49:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CA+CK2bCZHCp7d3SyiE2UpZr=K-NMPcGPVS0d-iU_7_tfcVmaGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2019 16:23, Pavel Tatashin wrote:

Hi Pavel,

>>> We could limit arm64 approach only for chips where cntvct_el0 is
>>> working: i.e. frequency is known, and the clock is stable, meaning
>>> cannot go backward. Perhaps we would start early clock a little later,
>>> but at least it will be available for the sane chips. The only
>>> question, where during boot time this is known.
>>
>> How do you propose we do that? Defective timers can be a property of
>> the implementation, of the integration, or both. In any case, it
>> requires firmware support (DT, ACPI). All that is only available quite
>> late, and moving it earlier is not easily doable.
> 
> OK, but could we at least whitelist something early with expectation
> that the future chips won't be bogus?

Just as I wish we had universal world peace. Timer integration is
probably the most broken thing in the whole ARM ecosystem (clock
domains, Gray code and general incompetence do get in the way). And as I
said above, retecting a broken implementation usually relies on some
firmware indication, which is only available at a later time (and I'm
trying really hard to keep the errata handling in the timer code).

>>> Another approach is to modify sched_clock() in
>>> kernel/time/sched_clock.c to never return backward value during boot.
>>>
>>> 1. Rename  current implementation of sched_clock() to sched_clock_raw()
>>> 2. New sched_clock() would look like this:
>>>
>>> u64 sched_clock(void)
>>> {
>>>    if (static_branch(early_unstable_clock))
>>>       return sched_clock_unstable();
>>>    else
>>>       return sched_clock_raw();
>>> }
>>>
>>> 3. sched_clock_unstable() would look like this:
>>>
>>> u64 sched_clock_unstable(void)
>>> {
>>> again:
>>>   static u64 old_clock;
>>>   u64 new_clock = sched_clock_raw();
>>>   static u64 old_clock_read =   READ_ONCE(old_clock);
>>>   /* It is ok if time does not progress, but don't allow to go backward */
>>>   if (new_clock < old_clock_read)
>>>     return old_clock_read;
>>>    /* update the old_clock value */
>>>    if (cmpxchg64(&old_clock, old_clock_read, new_clock) != old_clock_read)
>>>       goto again;
>>>    return new_clock;
>>> }
>>
>> You now have an "unstable" clock that is only allowed to move forward,
>> until you switch to the real one. And at handover time, anything can
>> happen.
>>
>> It is one thing to allow for the time stamping to be imprecise. But
>> imposing the same behaviour on other parts of the kernel that have so
>> far relied on a strictly monotonic sched_clock feels like a bad idea.
> 
> sched_clock() will still be strictly monotonic. During switch over we
> will guarantee to continue from where the early clock left.

Not quite. There is at least one broken integration that results in
large, spurious jumps ahead. If one of these jumps happens during the
"unstable" phase, we'll only return old_clock. At some point, we switch
early_unstable_clock to be false, as we've now properly initialized the
timer and found the appropriate workaround. We'll now return a much
smaller value. sched_clock continuity doesn't seem to apply here, as
you're not registering a new sched_clock (or at least that's not how I
understand your code above).

>> What I'm proposing is that we allow architectures to override the hard
>> tie between local_clock/sched_clock and kernel log time stamping, with
>> the default being of course what we have today. This gives a clean
>> separation between the two when the architecture needs to delay the
>> availability of sched_clock until implementation requirements are
>> discovered. It also keep sched_clock simple and efficient.
>>
>> To illustrate what I'm trying to argue for, I've pushed out a couple
>> of proof of concept patches here[1]. I've briefly tested them in a
>> guest, and things seem to work OK.
> 
> What I am worried is that decoupling time stamps from the
> sched_clock() will cause uptime and other commands that show boot time
> not to correlate with timestamps in dmesg with these changes. For them
> to correlate we would still have to have a switch back to
> local_clock() in timestamp_clock() after we are done with early boot,
> which brings us back to using a temporarily unstable clock that I
> proposed above but without adding an architectural hook for it. Again,
> we would need to solve the problem of time continuity during switch
> over, which is not a hard problem to solve, as we do it already in
> sched_clock.c, and everytime clocksource changes.
> 
> During early boot time stamps project for x86 we were extra careful to
> make sure that they stay the same.

I can see two ways to achieve this requirement:

- we allow timestamp_clock to fall-back to sched_clock once it becomes
non-zero. It has the drawback of resetting the time stamping in the
middle of the boot, which isn't great.

- we allow sched_clock to inherit the timestamp_clock value instead of
starting at zero like it does now. Not sure if that breaks anything, but
that's worth trying (it should be a matter of setting new_epoch to zero
in sched_clock_register).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
