Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4111AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50AA208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O12wSs4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50AA208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeFNNB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:01:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:40570 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755027AbeFNNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:01:56 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3542822A5C1;
        Thu, 14 Jun 2018 09:01:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id hGawpuIfXYM2; Thu, 14 Jun 2018 09:01:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 35A5622A5B6;
        Thu, 14 Jun 2018 09:01:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 35A5622A5B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528981314;
        bh=zxotOBHu5J5jtSqWd/71oQTMfiBO+7CEFlP49hVjOU0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O12wSs4hJloHYybtZI3XW1G+jXphfnWrTPaFyIhW2b/uNDQLm1i9Zz2WrZjTCpd4a
         vn3MNLEwViMDfuQTPsBwQuRo+SegxhIEBReyNEulmSrNsA7v/a2nU2N5GDXRA88c4Y
         75MPUycRQzGgVB+UbP7iSkjY+ccTcyG65LOVZ+VFYZmCFUM5egyDV3WTanBnzp9WR1
         LtIaXHr/YG3MQZfRxJsHWoNk23+AjdDwMrrNeQ9dHD2i5Jaic/2+fhPLPVDwk3GXS6
         m7nmyfGxaMKK0UZgmpPRVABG6sgm7qgHcTeaQpwbR5BqptJeKIM81ke+6oPAgj5R1K
         lsl5xFg99m5Uw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QfxzugbcLw33; Thu, 14 Jun 2018 09:01:54 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1EC4C22A5AC;
        Thu, 14 Jun 2018 09:01:54 -0400 (EDT)
Date:   Thu, 14 Jun 2018 09:01:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180614122759.GB8798@amd>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com> <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com> <091061df-3482-8762-30e4-feaf3417be11@redhat.com> <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com> <20180614122759.GB8798@amd>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: OpJ2reEB6eAcL/fMfb8+gVNJRFXzdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2018, at 8:27 AM, Pavel Machek pavel@ucw.cz wrote:

> On Tue 2018-06-12 12:31:24, Mathieu Desnoyers wrote:
>> ----- On Jun 12, 2018, at 9:11 AM, Florian Weimer fweimer@redhat.com wrote:
>> 
>> > On 06/11/2018 10:04 PM, Mathieu Desnoyers wrote:
>> >> ----- On Jun 11, 2018, at 3:55 PM, Florian Weimer fweimer@redhat.com wrote:
>> >> 
>> >>> On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
>> >>>> It should be noted that there can be only one rseq TLS area registered per
>> >>>> thread,
>> >>>> which can then be used by many libraries and by the executable, so this is a
>> >>>> process-wide (per-thread) resource that we need to manage carefully.
>> >>>
>> >>> Is it possible to resize the area after thread creation, perhaps even
>> >>> from other threads?
>> >> 
>> >> I'm not sure why we would want to resize it. The per-thread area is fixed-size.
>> >> Its layout is here: include/uapi/linux/rseq.h: struct rseq
>> > 
>> > Looks I was mistaken and this is very similar to the robust mutex list.
>> > 
>> > Should we treat it the same way?  Always allocate it for each new thread
>> > and register it with the kernel?
>> 
>> That would be an efficient way to do it, indeed. There is very little
>> performance overhead to have rseq registered for all threads, whether or
>> not they intend to run rseq critical sections.
> 
> People with slow / low memory machines would prefer not to see
> overhead they don't need...

In terms of memory usage, if people don't want the extra few bytes of memory
used by rseq in the kernel, they should use CONFIG_RSEQ=n.

In terms of overhead, let's have a closer look at what it means: when a thread
is registered to rseq, but does not enter rseq critical sections, only this
extra work is done by the kernel:

- rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RESUME thread
  flag, so rseq_handle_notify_resume() can check whether it's in a rseq critical
  section when returning to user-space,
- rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume() checks
  whether it's in a rseq critical section,
- rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as well,

> 
>> I have a few possible approaches in mind (feel free to suggest other
>> options):
>> 
>> A) glibc exposes a strong __rseq_abi TLS symbol:
>> 
>>    - should ideally *not* be global-dynamic for performance reasons,
>>    - registration to kernel can either be handled explicitly by requiring
>>      application or libraries to call an API, or implicitly at thread
>>      creation,
> 
> ...so I'd prefer explicit API call.

I have use-cases where a library wants to link against librseq and have rseq
critical sections, without requiring the application to explicitly add rseq
registration calls on thread creation/destruction. Is there a way to register
callbacks to glibc which could be invoked on thread creation/destruction ?

Then if we include dynamic loading of libraries (dlopen/dlclose) in the
picture, this gets even worse, as we'd need to be able to iterate on all
existing threads to invoke registration/unregistration callbacks.

One alternative approach would be to let the user library lazily register rseq
when needed, and use a pthread_key for unregistration. However, this does not
allow dlclose of the user library without figuring a way to iterate on all
threads.

Another alternative would be to somehow let glibc handle the registration,
perhaps only doing it for applications expressing their interest for rseq.

Thoughts ?

Thanks,

Mathieu

> 
>> B) librseq.so exposes a strong __rseq_abi symbol:
> 
> Works for me.
>									Pavel
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
