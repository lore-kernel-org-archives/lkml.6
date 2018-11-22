Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6434FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC820865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="G81ulrNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438318AbeKWGRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:17:15 -0500
Received: from mail.efficios.com ([167.114.142.138]:34940 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbeKWGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:17:15 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 426A17B11E;
        Thu, 22 Nov 2018 14:36:26 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id PrYYPdd2Jijd; Thu, 22 Nov 2018 14:36:25 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 92DE37B119;
        Thu, 22 Nov 2018 14:36:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 92DE37B119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542915385;
        bh=PIumVTXYQXvbWQfPyOMf00cNIJ33l9bzdm07kjzbotg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=G81ulrNfbZBBg0cjnuzlGV1kQcgig7fZG+5heOii0BD2CMhhjnGOeu49YFJ2aV/+Y
         zcWmY7cJP8SkRhhi+WWZy4t+nXJnvcfmLbCI76T6W1wR6zrhYfvJWb67yfXM90gNrl
         4sGZ7a8HyFwDKn9WNZC7DN/4ORv02ZIz6BfJHoKTqBimGPsQaIskix+lOkZsezfFsJ
         SQejHvoUIm5pbgiXspPyrxS/SIQ1uM60cV4Mm061ipW8W3Xbb19eIyBaeTq/63yLCY
         7jQ+fSDGohTVo38gN3KR4FeMkyHDPfjP1HwgCmwG6lDNEXOpzsaHBCwkuhuttjPFbb
         O8dgBubqQ0hNw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id NsKJOeenbhex; Thu, 22 Nov 2018 14:36:25 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 700F47B10D;
        Thu, 22 Nov 2018 14:36:25 -0500 (EST)
Date:   Thu, 22 Nov 2018 14:36:25 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>,
        carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1705791029.10494.1542915385130.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181122190143.GI23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <87a7m1ywni.fsf@oldenburg.str.redhat.com> <20181122151710.GF23599@brightrain.aerifal.cx> <875zwpyw81.fsf@oldenburg.str.redhat.com> <1306224240.10055.1542900799576.JavaMail.zimbra@efficios.com> <7032ab45-8314-b85d-5b4d-f83b41dab5b6@arm.com> <1602745030.10426.1542911744479.JavaMail.zimbra@efficios.com> <20181122190143.GI23599@brightrain.aerifal.cx>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: QmI0bEoeb/5TqaWLKcni1VnrANiv0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 22, 2018, at 2:01 PM, Rich Felker dalias@libc.org wrote:

> On Thu, Nov 22, 2018 at 01:35:44PM -0500, Mathieu Desnoyers wrote:
>> ----- On Nov 22, 2018, at 11:24 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>> 
>> > On 22/11/18 15:33, Mathieu Desnoyers wrote:
>> >> ----- On Nov 22, 2018, at 10:21 AM, Florian Weimer fweimer@redhat.com wrote:
>> >>> Right, but in case of user-supplied stacks, we actually free TLS memory
>> >>> at this point, so signals need to be blocked because the TCB is
>> >>> (partially) gone after that.
>> >> 
>> >> Unfortuntately, disabling signals is not enough.
>> >> 
>> >> With rseq registered, the kernel accesses the rseq TLS area when returning to
>> >> user-space after _preemption_ of user-space, which can be triggered at any
>> >> point by an interrupt or a fault, even if signals are blocked.
>> >> 
>> >> So if there are cases where the TLS memory is freed while the thread is still
>> >> running, we _need_ to explicitly unregister rseq beforehand.
>> > 
>> > i think the man page should point this out.
>> 
>> Yes, I should add this to the proposed rseq(2) man page.
>> 
>> > 
>> > the memory of a registered rseq object must not be freed
>> > before thread exit. (either unregister it or free later)
>> > 
>> > and ideally also point out that c language thread storage
>> > duration does not provide this guarantee: it may be freed
>> > by the implementation before thread exit (which is currently
>> > not observable, but with the rseq syscall it is).
>> 
>> How about the following wording ?
>> 
>>   Memory of a registered rseq object must not be freed before the
>>   thread exits. Reclaim of rseq object's memory must only be
>>   done after either an explicit rseq unregistration is performed
>>   or after the thread exit. Keep in mind that the implementation
>>   of the Thread-Local Storage (C language __thread) lifetime does
>>   not guarantee existence of the TLS area up until the thread exits.
> 
> This is all really ugly for application/library code to have to deal
> with. Maybe if the man page is considered as documenting the syscall
> only, and not something you can use, it's okay,

This is indeed for the rseq(2) manpage targeting the man-pages project,
which documents system calls.

> but "until the thread
> exits" is not well-defined in the sense you want it here. It's more
> like "until the kernel task for the thread exits", and the whole point
> is that there is some interval in time between the abstract thread
> exit and the kernel task exit that is not observable without rseq but
> is observable if the rseq is wrongly left installed.

It's important to clear a possible misunderstanding here: from the
point where the thread issues the "exit" system call, the kernel won't
touch the registered rseq TLS area anymore.

So the point where the thread exits is actually well defined, even from
a user-space perspective.

The problematic scenario arises when glibc frees the TLS memory
before invoking exit() when the thread terminates. In this kind of
scenario, we need to explicitly invoke rseq unregister before TLS
memory reclaim.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
