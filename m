Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3818D21471
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3818D21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJCLiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:38:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47386 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJCLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:38:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g7Z7y-0000PW-Cy; Tue, 02 Oct 2018 22:51:14 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g7Z7i-00067m-BM; Tue, 02 Oct 2018 22:51:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, avagin@virtuozzo.com,
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
        the arch/x86 maintainers <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
References: <20180919205037.9574-1-dima@arista.com>
        <874lej6nny.fsf@xmission.com>
        <20180924205119.GA14833@outlook.office365.com>
        <874leezh8n.fsf@xmission.com>
        <20180925014150.GA6302@outlook.office365.com>
        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
        <87mus1ftb9.fsf@xmission.com>
        <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
        <877ej2xc23.fsf_-_@xmission.com>
        <alpine.DEB.2.21.1810012047520.32062@nanos.tec.linutronix.de>
        <CAK8P3a2zTqrCGURE3XVpn3_w6C4R5O+cq8TdtbyKCMGyRk9_jw@mail.gmail.com>
        <alpine.DEB.2.21.1810022205080.1435@nanos.tec.linutronix.de>
Date:   Wed, 03 Oct 2018 06:50:47 +0200
In-Reply-To: <alpine.DEB.2.21.1810022205080.1435@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 2 Oct 2018 22:06:28 +0200 (CEST)")
Message-ID: <87in2jskew.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g7Z7i-00067m-BM;;;mid=<87in2jskew.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mS1JiCwgOdrpjqu0CL+pXRPwZtQcbesw=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Setting monotonic time?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 2 Oct 2018, Arnd Bergmann wrote:
>> On Mon, Oct 1, 2018 at 8:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > On Mon, 1 Oct 2018, Eric W. Biederman wrote:
>> > > In the context of process migration there is a simpler subproblem that I
>> > > think it is worth exploring if we can do something about.
>> > >
>> > > For a cluster of machines all running with synchronized
>> > > clocks. CLOCK_REALTIME matches. CLOCK_MONOTNIC does not match between
>> > > machines.   Not having a matching CLOCK_MONOTONIC prevents successful
>> > > process migration between nodes in that cluster.
>> > >
>> > > Would it be possible to allow setting CLOCK_MONOTONIC at the very
>> > > beginning of time?  So that all of the nodes in a cluster can be in
>> > > sync?
>> > >
>> > > No change in skew just in offset for CLOCK_MONOTONIC.
>> > >
>> > > There are also dragons involved in coordinating things so that
>> > > CLOCK_MONOTONIC gets set before CLOCK_MONOTONIC gets used.  So I don't
>> > > know if allowing CLOCK_MONOTONIC to be set would be practical but it
>> > > seems work exploring all on it's own.
>> >
>> > It's used very early on in the kernel, so that would be a major surprise
>> > for many things including user space which has expectations on clock
>> > monotonic.
>> >
>> > It would be reasonably easy to add CLOCK_MONONOTIC_SYNC which can be set in
>> > the way you described and then in name spaces make it possible to magically
>> > map CLOCK_MONOTONIC to CLOCK_MONOTONIC_SYNC.
>> >
>> > It still wouldn't allow to have different NTP/PTP time domains, but might
>> > be a good start to address the main migration headaches.
>> 
>> If we make CLOCK_MONOTONIC settable this way in a namespace,
>> do you think that should include device drivers that report timestamps
>> in CLOCK_MONOTONIC base, or only the timekeeping clock and timer
>> interfaces?
>
> Uurgh. That gets messy very fast.
>
>> Examples for drivers that can report timestamps are input, sound, v4l,
>> and drm. I think most of these can report stamps in either monotonic
>> or realtime base, while socket timestamps notably are always in
>> realtime.
>> 
>> We can probably get away with not setting the timebase for those
>> device drivers as long as the checkpoint/restart and migration features
>> are not expected to restore the state of an open character device
>> in that way. I don't know if that is a reasonable assumption to make
>> for the examples I listed.
>
> No idea. I'm not a container migration wizard.

Direct access to hardware/drivers and not through an abstraction like
the vfs (an abstraction over block devices) can legitimately be handled
by hotplug events.  I unplug one keyboard I plug in another.

I don't know if the input layer is more of a general abstraction
or more of a hardware device.  I have not dug into it but my guess
is abstraction from what I have heard.

The scary difficulty here is if after restart input is reporting times
in CLOCK_MONOTONIC and the applications in the namespace are talking
about times in CLOCK_MONOTONIC_SYNC.  Then there is an issue.  As even
with a fixed offset the times don't match up.

So a time namespace absolutely needs to do is figure out how to deal
with all of the kernel interfaces reporting times and figure out how to
report them in the current time namespace.

Eric






