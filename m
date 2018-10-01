Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4900AC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0296F20645
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0296F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeJAPmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:42:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47604 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:42:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6u8r-0002YV-Jv; Mon, 01 Oct 2018 03:05:25 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6u8q-0002zS-7V; Mon, 01 Oct 2018 03:05:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu\@openvz.org" <criu@openvz.org>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20180919205037.9574-1-dima@arista.com>
        <874lej6nny.fsf@xmission.com>
        <20180924205119.GA14833@outlook.office365.com>
        <874leezh8n.fsf@xmission.com>
        <20180925014150.GA6302@outlook.office365.com>
        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
        <87mus1ftb9.fsf@xmission.com>
        <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
Date:   Mon, 01 Oct 2018 11:05:12 +0200
In-Reply-To: <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Fri, 28 Sep 2018 21:32:15 +0200
        (CEST)")
Message-ID: <87zhvyxcjb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g6u8q-0002zS-7V;;;mid=<87zhvyxcjb.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uO2zZVDyX/GP9TIsHaBgWAfjPpSml1Vw=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Eric,
>
> On Fri, 28 Sep 2018, Eric W. Biederman wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> > On Wed, 26 Sep 2018, Eric W. Biederman wrote:
>> >> At the same time using the techniques from the nohz work and a little
>> >> smarts I expect we could get the code to scale.
>> >
>> > You'd need to invoke the update when the namespace is switched in and
>> > hasn't been updated since the last tick happened. That might be doable, but
>> > you also need to take the wraparound constraints of the underlying
>> > clocksources into account, which again can cause walking all name spaces
>> > when they are all idle long enough.
>> 
>> The wrap around constraints being how long before the time sources wrap
>> around so you have to read them once per wrap around?  I have not dug
>> deeply enough into the code to see that yet.
>
> It's done by limiting the NOHZ idle time when all CPUs are going into deep
> sleep for a long time, i.e. we make sure that at least one CPU comes back
> sufficiently _before_ the wraparound happens and invokes the update
> function.
>
> It's not so much a problem for TSC, but not every clocksource the kernel
> supports has wraparound times in the range of hundreds of years.
>
> But yes, your idea of keeping track of wraparounds might work. Tricky, but
> looks feasible on first sight, but we should be aware of the dragons.

Oh.  Yes.  Definitely.  A key enabler of any namespace implementation is
figuring out how to tame the dragons.

>> Please pardon me for thinking out load.
>> 
>> There are one or more time sources that we use to compute the time
>> and for each time source we have a conversion from ticks of the
>> time source to nanoseconds.
>> 
>> Each time source needs to be sampled at least once per wrap-around
>> and something incremented so that we don't loose time when looking
>> at that time source.
>> 
>> There are several clocks presented to userspace and they all share the
>> same length of second and are all fundamentally offsets from
>> CLOCK_MONOTONIC.
>
> Yes. That's the readout side. This one is doable. But now look at timers.
>
> If you arm the timer from a name space, then it needs to be converted to
> host time in order to sort it into the hrtimer queue and at some point arm
> the clockevent device for it. This works as long as host and name space
> time have a constant offset and the same skew.
>
> Once the name space time has a different skew this falls apart because the
> armed timer will either expire late or early.
>
> Late might be acceptable, early violates the spec. You could do an extra
> check for rescheduling it, if it's early, but that requires to store the
> name space time accessor in the hrtimer itself because not every timer
> expiry happens so that it can be checked in the name space context (think
> signal based timers). We need to add this extra magic right into
> __hrtimer_run_queues() which is called from the hard and soft interrupt. We
> really don't want to touch all relevant callbacks or syscalls. The latter
> is not sufficient anyway for signal based timer delivery.
>
> That's going to be interesting in terms of synchronization and might also
> cause substantial overhead at least for the timers which belong to name
> spaces.
>
> But that also means that anything which is early can and probably will
> cause rearming of the timer hardware possibly for a very short delta. We
> need to think about whether this can be abused to create interrupt storms.
>
> Now if you accept a bit late, which I'm not really happy about, then you
> surely won't accept very late, i.e. hours, days. But that can happen when
> settimeofday() comes into play. Right now with a single time domain, this
> is easy. When settimeofday() or adjtimex() makes time jump, we just go and
> reprogramm the hardware timers accordingly, which might also result in
> immediate expiry of timers.
>
> But this does not help for time jumps in name spaces because the timer is
> enqueued on the host time base.
>
> And no, we should not think about creating per name space hrtimer queues
> and then have to walk through all of them for finding the first expiring
> timer in order to arm the hardware. That cannot scale.
>
> Walking all hrtimer bases on all CPUs and check all queued timers whether
> they belong to the affected name space does not scale either.
>
> So we'd need to keep track of queued timers belonging to a name space and
> then just handle them. Interesting locking problem and also a scalability
> issue because this might need to be done on all online CPUs. Haven't
> thought it through, but it makes me shudder.

Yes.  I can see how this is a dragon that we need to figure out how to
tame.  It already exist somewhat for CLOCK_MONOTONIC vs CLOCK_REALTIME
but still.

>> I see two fundamental driving cases for a time namespace.
>
> <SNIP>
>
> I completely understand the problem you are trying to solve and yes, the
> read out of time should be a solvable problem.

There is simplified subproblem that I want to ask about but I will reply
separately for that.

>> Not that I think a final implementation would necessary look like what I
>> have described. I just think it is possible with extreme care to evolve
>> the current code base into something that can efficiently handle
>> multiple time domains with slightly different lenghts of second.
>
> Yes, it really needs some serious thoughts and timekeeping is a really
> complex place especially with NTP/PTP in play. We had quite some quality
> time to make it work correctly and reliably, now you come along and want to
> transform it into a multidimensional puzzle. :)

I thought it was Einstein who pointed out what a puzzle timekeeping is,
with the rest of us just playing catch up. ;-)

>> It does though sound like it is going to take some serious digging
>> through the code to understand how what everything does and how and why
>> everthing works the way it does.  Not something grafted on top with just
>> a cursory understanding of how the code works.
>
> I fully agree and I'm happy to help with explanations and ideas and being
> the one who shoots holes into yours.

Sounds good.

Eric
