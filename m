Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC36C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77E620652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77E620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJCNtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:49:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40040 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJCNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:49:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id e9-v6so4805530qtp.7;
        Wed, 03 Oct 2018 00:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTV6Ml8mc8MxZyRxjEeheDDG+IgugNa4MHVXNXTcwvw=;
        b=QMJYJjlz2CmqQqrtyXiFZ+7l6U53MuNEv4w2u786OL85sFhCQSNgsisH4m1RiJgOW+
         y7gKRz1rSERfa7R3QgupGQ/bcQj5j1ygN9y+LsMWz7L9c1Yhi667vMVflWtBWIlEAt/Z
         6fJCun1BN/PbO7dHmIXkqQp7GM3KRglqZA7ufkfYvn0heO7dl9nQchc1iF7ykfDvRH0S
         k5Bo6JzhsvADaWnSzir0yMYQIH0dXZea96Yv7sU2P9cTUXRNHJLLvk7bRjEWArShc4Lh
         2d1uvPZftmYkN25YsekWHssOUq1utYjBbDP7Dqvi/jOB0DHRkVFSYwkWXO/ZHqcT+JiT
         2DBQ==
X-Gm-Message-State: ABuFfoi97f9f1STIAJ+r7w0VRx2n7JWkeoZBx/9zHnrC2B8fmp/XhfTf
        pz5f3p8x4yReUDEU9kvPJD/scautkuArcDZmlfU=
X-Google-Smtp-Source: ACcGV617Ai7u95pPN0WddQXhOJl8Vyrcr2aniLUouYUVBBbaWkMLhr2iAiXG1/lbw5PK6F8WIo9woWLOH8R2y7US+EI=
X-Received: by 2002:a0c:ad8e:: with SMTP id w14-v6mr76399qvc.149.1538550137064;
 Wed, 03 Oct 2018 00:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com>
 <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com>
 <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
 <87mus1ftb9.fsf@xmission.com> <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
 <877ej2xc23.fsf_-_@xmission.com> <alpine.DEB.2.21.1810012047520.32062@nanos.tec.linutronix.de>
 <CAK8P3a2zTqrCGURE3XVpn3_w6C4R5O+cq8TdtbyKCMGyRk9_jw@mail.gmail.com>
 <alpine.DEB.2.21.1810022205080.1435@nanos.tec.linutronix.de>
 <87in2jskew.fsf@xmission.com> <alpine.DEB.2.21.1810030711520.1435@nanos.tec.linutronix.de>
 <87in2jo8u6.fsf@xmission.com>
In-Reply-To: <87in2jo8u6.fsf@xmission.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Oct 2018 09:02:00 +0200
Message-ID: <CAK8P3a2cM4AWKQ9VsZFzUu0qJ-fYiLK5fMXRoTsVcgmFwoeJxg@mail.gmail.com>
Subject: Re: Setting monotonic time?
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, avagin@virtuozzo.com,
        dima@arista.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        0x7f454c46@gmail.com, adrian@lisas.de,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        gorcunov@openvz.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>, xemul@virtuozzo.com,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:14 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Thomas Gleixner <tglx@linutronix.de> writes:
>
> > On Wed, 3 Oct 2018, Eric W. Biederman wrote:
> >> Direct access to hardware/drivers and not through an abstraction like
> >> the vfs (an abstraction over block devices) can legitimately be handled
> >> by hotplug events.  I unplug one keyboard I plug in another.
> >>
> >> I don't know if the input layer is more of a general abstraction
> >> or more of a hardware device.  I have not dug into it but my guess
> >> is abstraction from what I have heard.
> >>
> >> The scary difficulty here is if after restart input is reporting times
> >> in CLOCK_MONOTONIC and the applications in the namespace are talking
> >> about times in CLOCK_MONOTONIC_SYNC.  Then there is an issue.  As even
> >> with a fixed offset the times don't match up.
> >>
> >> So a time namespace absolutely needs to do is figure out how to deal
> >> with all of the kernel interfaces reporting times and figure out how to
> >> report them in the current time namespace.
> >
> > So you want to talk to Arnd who is leading the y2038 effort. He knowns how
> > many and which interfaces are involved aside of the obvious core timer
> > ones. It's quite an amount and the problem is that you really need to do
> > that at the interface level, because many of those time stamps are taken in
> > contexts which are completely oblivious of name spaces. Ditto for timeouts
> > and similar things which are handed in through these interfaces.
>
> Yep.  That sounds right.

Let's stay with the input event example for the moment: Here, we have a
character device, and a user calls read() to retrieve one or more records
of type 'struct input_event' using the evdev_read() function. The original
timestamp gets put there using this logic:

        ktime_t time;
        struct timespec64 ts;
        time = client->clk_type == EV_CLK_REAL ?
                        ktime_get_real() :
                        client->clk_type == EV_CLK_MONO ?
                                ktime_get() :
                                ktime_get_boottime();
        ts = ktime_to_timespec64(time);
        ev.input_event_sec = ts.tv_sec;
        ev.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;

clk_type can get set using an ioctl() to real, monotonic or
boottime. We have to stop using EV_CLK_REAL in the
future because that breaks in y2038, but I guess EV_CLK_MONO
and EV_CLK_BOOK should stay.

If we want this to work correctly in a namespace that has a
user defined CLOCK_MONOTONIC timebase, one way to
do it might be to always call ktime_get() when we record
the timestamp in the kernel-internal CLOCK_MONOTONIC
base, but then convert it to the correct base when copying to
user space.

Note that AFAIU practically all users of evdev do /not/ actually
care about the time base, they only care about the elapsed
time between intervals, e.g. to track how fast a pointer should
move based on input from a trackpad. I don't see any reason
why one would compare this timestamp to a clock_gettime()
value, but of course at the moment this has well-defined
behavior that would break if we change clock_gettime(), and
we have a process in the namespace that opens
/dev/input/eventX and relies on meaningful timestamps
relative to a particular base.

       Arnd
