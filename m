Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98898C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFFD2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gwJCYIxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFFD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934734AbeFLQb1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:31:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:38556 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933640AbeFLQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:31:25 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CAEC32292E8;
        Tue, 12 Jun 2018 12:31:24 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id UWcQH6xj7PlN; Tue, 12 Jun 2018 12:31:24 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 491C42292E1;
        Tue, 12 Jun 2018 12:31:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 491C42292E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528821084;
        bh=yBOoi91EzQEa9Q73mTLYbkKnKn+bN6EAn+3fn73MpZk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gwJCYIxD+q2SgD9eaNK8c6AqE9NxoCmm19ikjXw18dJB7a0txX9YCr4EAnFUj5kWA
         AcsbzorMjyTZ1zPlgiF/1Aa3yiBqzo+5SByGFAhQ+qYbh/V4INembekbbDFcRdNX00
         SkOYh3/jmboAvAN2RtYsOximGJvYWPlBOCxyJTkoT1I1z8ShEzXzy7mEuwH+sS2JjA
         LW72rHYBU4ZevnzPEUlmtLgvAAs6zpvhYVAN4Qak7Y9OQd5+C8OX5HNnOH83DG8Frl
         P4uPrTmD4g7Du7MI7TPGDF8aPmOzWbH/OeT5/41JtT9tYsodEGIpJEzUP6qYp2NsJM
         rZDKot6ddTUAg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id IqJwZyfHlA2R; Tue, 12 Jun 2018 12:31:24 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 339F22292D4;
        Tue, 12 Jun 2018 12:31:24 -0400 (EDT)
Date:   Tue, 12 Jun 2018 12:31:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
In-Reply-To: <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com> <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com> <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: 6g+JFMuw6m/7S6+/IUYOkRqtm5cSXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 12, 2018, at 9:11 AM, Florian Weimer fweimer@redhat.com wrote:

> On 06/11/2018 10:04 PM, Mathieu Desnoyers wrote:
>> ----- On Jun 11, 2018, at 3:55 PM, Florian Weimer fweimer@redhat.com wrote:
>> 
>>> On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
>>>> It should be noted that there can be only one rseq TLS area registered per
>>>> thread,
>>>> which can then be used by many libraries and by the executable, so this is a
>>>> process-wide (per-thread) resource that we need to manage carefully.
>>>
>>> Is it possible to resize the area after thread creation, perhaps even
>>> from other threads?
>> 
>> I'm not sure why we would want to resize it. The per-thread area is fixed-size.
>> Its layout is here: include/uapi/linux/rseq.h: struct rseq
> 
> Looks I was mistaken and this is very similar to the robust mutex list.
> 
> Should we treat it the same way?  Always allocate it for each new thread
> and register it with the kernel?

That would be an efficient way to do it, indeed. There is very little
performance overhead to have rseq registered for all threads, whether or
not they intend to run rseq critical sections.

> 
>> The ABI is designed so that all users (program and libraries) can interact
>> through this per-thread TLS area.
> 
> Then the user code needs just the address of the structure.

Yes.

> 
> How much coordination is needed between different users of this
> interface?  Looking at the the section hacks, I don't think we want to
> put this into glibc at this stage.  It looks more like something for
> which we traditionally require compiler support.

I really don't mind maintaining a separate project containing librseq
along with the headers needed to facilitate declaration of rseq critical
sections. This specifically does not need much coordination between users of
the interface.

The part which really requires coordination between users is registration
to the kernel (and ownership) of the rseq TLS area.

I have a few possible approaches in mind (feel free to suggest other
options):

A) glibc exposes a strong __rseq_abi TLS symbol:

   - should ideally *not* be global-dynamic for performance reasons,
   - registration to kernel can either be handled explicitly by requiring
     application or libraries to call an API, or implicitly at thread
     creation,
   - requires all rseq users to upgrade to newer glibc. Early rseq users
     (libs and applications) registering their own rseq TLS will conflict
     with newer glibc.

B) librseq.so exposes a strong __rseq_abi symbol:

   - should ideally *not* be global-dynamic for performance reasons, but
     testing shows that using initial-exec causes issues in situations where
     librseq.so ends up being dlopen'd (e.g. java virtual machine dlopening
     the lttng-ust tracer linked against librseq.so),
   - registration/unregistration of area to kernel can either be performed
     lazily on first use, destruction done using pthread_key, or require an
     explicit API call from application,
   - A per-thread refcount in a TLS could allow many users to call the
     registration/unregistration API, and lazy registration,
   - an early-user application which also exposes a __rseq_abi strong symbol
     would conflict with librseq.so.

C) __rseq_abi symbol declared weak within each user (application, librseq,
   other libraries, glibc):

   - should ideally *not* be global-dynamic for performance reasons,
     - however, initial-exec causes issues when librseq or early user libraries
       are dlopen'd (e.g. java runtime dlopening lttng-ust),
   - a weak symbol allow combining early user libs/apps with glibc/librseq
     exposing the same symbol,
   - considering that glibc is AFAIK never dlopen'd, does not cause exhaustion
     of initial-exec TLS entries in cases where librseq.so or early adopter
     libs are dlopen'd,
   - if glibc implicitly registers the rseq area, *and* librseq.so also wants
     to register it, *and* early adopters also want to register it, we should
     come up with a refcount scheme in the TLS ensuring that registration and
     unregistration is only done with the first/last user comes/goes away.

Thoughts ?

Thanks!

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
