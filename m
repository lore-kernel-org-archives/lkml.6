Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA59C67863
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 01:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CAD2174D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 01:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRrF5EhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CAD2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJUJx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 05:53:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34471 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJUJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 05:53:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so17405660pgs.1;
        Sat, 20 Oct 2018 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ExEpd2qHl1mjVAEu7L3UVSs1+0SzhHwnFPIc3+aGNYk=;
        b=bRrF5EhMQEWOd9Cem6e2WTjLdL2FiJsPxY2JvZ48KOI5MZnNd12WI5ZZUbhRzwHcMp
         3Do9QhTE75NVXfAA/rP9BOgJel6pPuPjS9pZUQPKizgWHs80fXQuTgVmcXZjp1Kn767z
         BIT//8+pg4uyCGl3SgDfIRHLALzopzngihSxiD+UaBWw68Q66Olma9gTlhriN8tVp/4n
         t3UMOT/YdPTsfvqyPpZ9YsYeAC6uSXIdQ97u77G87800SVyuNs3n8WsyQSslklNTZXzD
         8UMb0avZFgqBO2YWpYMQq4vAShQGHDPirBHfuKYVReIJ491wm6mPZPmWSAwU8ZO+KGDe
         10IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ExEpd2qHl1mjVAEu7L3UVSs1+0SzhHwnFPIc3+aGNYk=;
        b=lSw1pRv7zIZjv9Gj/efYM4SttEDavJ32SFaQGj1BOoTaZAjmwkdyJAWP5v6IxkAUBT
         4dRziYyYs1UOheFyz3fISVt/Em8SVbVqRPciMPvhe0n1EYeN4DqAoVL1aHTJuWfj9+3y
         UanfRVmEB/1M5XKUi01b73K4SGyR2hEceTaDiERLd0u5/kZ4840ghvojQGH2pl7rjaeU
         vd/A4wwMCt5ncSX33S+tGVTNNbqexxL7WmFaWn6yEzl1GRjRK3m9DJar1/Ru3A2KrYw6
         oQj/aWqBVw4OX2pRPcPYboBTaH9W8M/XQ4h44agJeNFcR6UEGprm4Lfz/MK4F8jYzFmV
         QHzQ==
X-Gm-Message-State: ABuFfoglVf0NM2meklinNxMyWfB/mJB9xq0fYp9vIQYR74pEIasFn24R
        HYJDT4Ok6oweLHzWTrgCC58=
X-Google-Smtp-Source: ACcGV61T5oX+V/uLrJSDUq+t77zt6/LG6NH9Ei6Kxc8XpHu6DMOoN+1Px6U7kth65CImfh6mTXNlKQ==
X-Received: by 2002:a63:dd0a:: with SMTP id t10-v6mr37919608pgg.379.1540086087208;
        Sat, 20 Oct 2018 18:41:27 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id d18-v6sm29040436pgd.86.2018.10.20.18.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 18:41:26 -0700 (PDT)
Date:   Sat, 20 Oct 2018 18:41:23 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "criu@openvz.org" <criu@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
Message-ID: <20181021014121.GA23474@gmail.com>
References: <20180919205037.9574-1-dima@arista.com>
 <874lej6nny.fsf@xmission.com>
 <20180924205119.GA14833@outlook.office365.com>
 <874leezh8n.fsf@xmission.com>
 <20180925014150.GA6302@outlook.office365.com>
 <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
 <87mus1ftb9.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87mus1ftb9.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 07:03:22PM +0200, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Wed, 26 Sep 2018, Eric W. Biederman wrote:
> >> Reading the code the calling sequence there is:
> >> tick_sched_do_timer
> >>    tick_do_update_jiffies64
> >>       update_wall_time
> >>           timekeeping_advance
> >>              timekeepging_update
> >> 
> >> If I read that properly under the right nohz circumstances that update
> >> can be delayed indefinitely.
> >> 
> >> So I think we could prototype a time namespace that was per
> >> timekeeping_update and just had update_wall_time iterate through
> >> all of the time namespaces.
> >
> > Please don't go there. timekeeping_update() is already heavy and walking
> > through a gazillion of namespaces will just make it horrible,
> >
> >> I don't think the naive version would scale to very many time
> >> namespaces.
> >
> > :)
> >
> >> At the same time using the techniques from the nohz work and a little
> >> smarts I expect we could get the code to scale.
> >
> > You'd need to invoke the update when the namespace is switched in and
> > hasn't been updated since the last tick happened. That might be doable, but
> > you also need to take the wraparound constraints of the underlying
> > clocksources into account, which again can cause walking all name spaces
> > when they are all idle long enough.
> 
> The wrap around constraints being how long before the time sources wrap
> around so you have to read them once per wrap around?  I have not dug
> deeply enough into the code to see that yet.
> 
> > From there it becomes hairy, because it's not only timekeeping,
> > i.e. reading time, this is also affecting all timers which are armed from a
> > namespace.
> >
> > That gets really ugly because when you do settimeofday() or adjtimex() for
> > a particular namespace, then you have to search for all armed timers of
> > that namespace and adjust them.
> >
> > The original posix timer code had the same issue because it mapped the
> > clock realtime timers to the timer wheel so any setting of the clock caused
> > a full walk of all armed timers, disarming, adjusting and requeing
> > them. That's horrible not only performance wise, it's also a locking
> > nightmare of all sorts.
> >
> > Add time skew via NTP/PTP into the picture and you might have to adjust
> > timers as well, because you need to guarantee that they are not expiring
> > early.
> >
> > I haven't looked through Dimitry's patches yet, but I don't see how this
> > can work at all without introducing subtle issues all over the place.
> 
> Then it sounds like this will take some more digging.
> 
> Please pardon me for thinking out load.
> 
> There are one or more time sources that we use to compute the time
> and for each time source we have a conversion from ticks of the
> time source to nanoseconds.
> 
> Each time source needs to be sampled at least once per wrap-around
> and something incremented so that we don't loose time when looking
> at that time source.
> 
> There are several clocks presented to userspace and they all share the
> same length of second and are all fundamentally offsets from
> CLOCK_MONOTONIC.
> 
> I see two fundamental driving cases for a time namespace.
> 1) Migration from one node to another node in a cluster in almost
>    real time.
> 
>    The problem is that CLOCK_MONOTONIC between nodes in the cluster
>    has not relation ship to each other (except a synchronized length of
>    the second).  So applications that migrate can see CLOCK_MONOTONIC
>    and CLOCK_BOOTTIME go backwards.
> 
>    This is the truly pressing problem and adding some kind of offset
>    sounds like it would be the solution.  Possibly by allowing a boot
>    time synchronization of CLOCK_BOOTTIME and CLOCK_MONOTONIC.
> 
> 2) Dealing with two separate time management domains.  Say a machine
>    that needes to deal with both something inside of google where they
>    slew time to avoid leap time seconds and something in the outside
>    world proper UTC time is kept as an offset from TAI with the
>    occasional leap seconds.
> 
>    In the later case it would fundamentally require having seconds of
>    different length.
> 

I want to add that the second case should be optional.

When a container is migrated to another host, we have to restore its
monotonic and boottime clocks, but we still expect that the container
will continue using the host real-time clock.

Before stating this series, I was thinking about this, I decided that
these cases can be solved independently. Probably, the full isolation of
the time sub-system will have much higher overhead than just offsets for
a few clocks. And the idea that isolation of the real-time clock should
be optional gives us another hint that offsets for monotonic and
boot-time clocks can be implemented independently.

Eric and Tomas, what do you think about this? If you agree that these
two cases can be implemented separately, what should we do with this
series to make it ready to be merged?

I know that we need to:

* look at device drivers that report timestamps in CLOCK_MONOTONIC base.
* forbid changing offsets after creating timers

Anything else?

Thanks,
Andrei

> 
> A pure 64bit nanoseond counter is good for 500 years.  So 64bit
> variables can be used to hold time, and everything can be converted from
> there.
> 
> This suggests we can for ticks have two values.
> - The number of ticks from the time source.
> - The number of times the ticks would have rolled over.
> 
> That sounds like it may be a little simplistic as it would require being
> very diligent about firing a timer exactly at rollover and not losing
> that, but for a handwaving argument is probably enough to generate
> a 64bit tick counter.
> 
> If the focus is on a 64bit tick counter then what update_wall_time
> has to do is very limited.  Just deal the accounting needed to cope with
> tick rollover.
> 
> Getting the actual time looks like it would be as simple as now, with
> perhaps an extra addition to account for the number of times the tick
> counter has rolled over.  With limited precision arithmetic and various
> optimizations I don't think it is that simple to implement but it feels
> like it should be very little extra work.
> 
> For timers my inclination would be to assume no adjustments to the
> current time parameters and set the timer to go off then.   If the time
> on the appropriate clock has been changed since the timer was set and
> the timer is going off early reschedule so the timer fires at the
> appropriate time.
> 
> With the above I think it is theoretically possible to build a time
> namespace that supports multiple lengths of second, and does not have
> much overhead.
> 
> Not that I think a final implementation would necessary look like what I
> have described. I just think it is possible with extreme care to evolve
> the current code base into something that can efficiently handle
> multiple time domains with slightly different lenghts of second.
> 
> Thomas does it sound like I am completely out of touch with reality?
> 
> It does though sound like it is going to take some serious digging
> through the code to understand how what everything does and how and why
> everthing works the way it does.  Not something grafted on top with just
> a cursory understanding of how the code works.
> 
> Eric
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
