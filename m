Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 302A6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81FC208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="STc7+x+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81FC208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbeFNNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:38:29 -0400
Received: from mail.efficios.com ([167.114.142.138]:42842 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755118AbeFNNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:38:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E358322AC88;
        Thu, 14 Jun 2018 09:38:16 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 53WxAswG-EQO; Thu, 14 Jun 2018 09:38:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5B80F22AC81;
        Thu, 14 Jun 2018 09:38:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5B80F22AC81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528983496;
        bh=2WFIOTylXb5yE1NqibIT6AU0/0Gh7zgova97vb1rxsw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=STc7+x+ZxbiOzq00KO7DE/xAmHkGe8i5KTjQsOiQBFmUzbo4ZriMTjwJVGem07uve
         Ayf0twwRoCCDFVQo8Dvdh9+0PvhwJknLb2rKUjILAE1V8id9sGd3WvBy3FBLBqY/OK
         bSUk311orIpyk48CUzzrwV/uajtITYTAV577Di4EtOhjnF5z+8SY1Kf39/tTO0/D5f
         pykhLqnSuzh3BRQaANg1dnkGxYlM9Z2mk63HDXrKVghx9Wos012wYoVqk25AbDsS86
         K2SV4A5/kNFAutTF62qYMFaUPMGbjXzTcU/iRaO7LWag1cRIle19Cscmoy6WYclWh/
         PYmY6mrVY5W1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id TJffIp0APlxC; Thu, 14 Jun 2018 09:38:16 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4574622AC79;
        Thu, 14 Jun 2018 09:38:16 -0400 (EDT)
Date:   Thu, 14 Jun 2018 09:38:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <956816108.13001.1528983496098.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180614132557.GA15201@amd>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com> <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com> <091061df-3482-8762-30e4-feaf3417be11@redhat.com> <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com> <20180614122759.GB8798@amd> <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com> <20180614132557.GA15201@amd>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: x2sRYZdO/gYUWkrSQC4dTHI8XgNdQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2018, at 9:25 AM, Pavel Machek pavel@ucw.cz wrote:

> Hi!
> 
>> >> >>>> It should be noted that there can be only one rseq TLS area registered per
>> >> >>>> thread,
>> >> >>>> which can then be used by many libraries and by the executable, so this is a
>> >> >>>> process-wide (per-thread) resource that we need to manage carefully.
>> >> >>>
>> >> >>> Is it possible to resize the area after thread creation, perhaps even
>> >> >>> from other threads?
>> >> >> 
>> >> >> I'm not sure why we would want to resize it. The per-thread area is fixed-size.
>> >> >> Its layout is here: include/uapi/linux/rseq.h: struct rseq
>> >> > 
>> >> > Looks I was mistaken and this is very similar to the robust mutex list.
>> >> > 
>> >> > Should we treat it the same way?  Always allocate it for each new thread
>> >> > and register it with the kernel?
>> >> 
>> >> That would be an efficient way to do it, indeed. There is very little
>> >> performance overhead to have rseq registered for all threads, whether or
>> >> not they intend to run rseq critical sections.
>> > 
>> > People with slow / low memory machines would prefer not to see
>> > overhead they don't need...
>> 
>> In terms of memory usage, if people don't want the extra few bytes of memory
>> used by rseq in the kernel, they should use CONFIG_RSEQ=n.
>> 
>> In terms of overhead, let's have a closer look at what it means: when a thread
>> is registered to rseq, but does not enter rseq critical sections, only this
>> extra work is done by the kernel:
>> 
>> - rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RESUME thread
>>   flag, so rseq_handle_notify_resume() can check whether it's in a rseq critical
>>   section when returning to user-space,
>> - rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume() checks
>>   whether it's in a rseq critical section,
>> - rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as well,
> 
> Yes, this is not likely to be noticeable.
> 
> But the proposal wanted to add a syscall to thread creation, right?
> And I believe that may be noticeable.

Fair point! Do we have a standard benchmark that would stress this ?

If it ends up being noticeable overhead, I wonder whether we could extend clone() with a
new CLONE_RSEQ flag so glibc could pass a pointer to the rseq TLS area through an extra
argument to the clone system call rather than do an extra syscall on thread creation ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
