Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C851C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3220F20864
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kqHH8VXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3220F20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436816AbeKXDu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:50:27 -0500
Received: from mail.efficios.com ([167.114.142.138]:41984 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbeKXDu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:50:26 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E227C80168;
        Fri, 23 Nov 2018 12:05:21 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 025FihbIMhMg; Fri, 23 Nov 2018 12:05:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4BE9E80160;
        Fri, 23 Nov 2018 12:05:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4BE9E80160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542992721;
        bh=j84pmQO+YKuw4w2kLWuU6d+VzTAtPPCWMpYC5OKCPjI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kqHH8VXWWiZmz9L5t23PWf93yz8DxwFlZOrhUB5n1FIwC7LB0qp6tsBafgh1gGWql
         TDsabUBQ+VXNe+s0EuGE/SIoyP/ItoPHzGPuDwMSC5QSZ5ECKKQCuBhDtsJGiRUQ50
         vziS0T1vRw+KSdrdnRJD9zwxdqjNcJTivPVMD4BTtzWaoCTI83jdcMniSVkyJlFEQ2
         Me3zH37VTO/iqpQwUKVTVn3cgzTJZ+nmGneXsXO8L1Y/hq15CL6ENHqENt2YFtbiS9
         yYhsXC2wwea9K11WOlZb5xjHVIyVSOkAJigDiIUVO5hC1VSF0h4Bcv08KUgvlYEbfn
         AJRHFlGFa4QJg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id v79uhz9ja7fd; Fri, 23 Nov 2018 12:05:21 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2CEC380158;
        Fri, 23 Nov 2018 12:05:21 -0500 (EST)
Date:   Fri, 23 Nov 2018 12:05:20 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181123142843.GJ23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com> <87wop5xeit.fsf@oldenburg.str.redhat.com> <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com> <87k1l5xd33.fsf@oldenburg.str.redhat.com> <20181122171010.GH23599@brightrain.aerifal.cx> <871s7cvt1l.fsf@oldenburg.str.redhat.com> <20181123142843.GJ23599@brightrain.aerifal.cx>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: ARgaREecntcbLPPp7zBSi7U8W/gzsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 23, 2018, at 9:28 AM, Rich Felker dalias@libc.org wrote:
[...]
> 
> Absolutely. As long as it's in libc, implicit destruction will happen.
> Actually I think the glibc code shound unconditionally unregister the
> rseq address at exit (after blocking signals, so no application code
> can run) in case a third-party rseq library was linked and failed to
> do so before thread exit (e.g. due to mismatched ref counts) rather
> than respecting the reference count, since it knows it's the last
> user. This would make potentially-buggy code safer.

OK, let me go ahead with a few ideas/questions along that path.

Let's say our stated goal is to let the "exit" system call from the
glibc thread exit path perform rseq unregistration (without explicit
unregistration beforehand). Let's look at what we need.

First, we need the TLS area to be valid until the exit system call
is invoked by the thread. If glibc defines __rseq_abi as a weak symbol,
I'm not entirely sure we can guarantee the IE model if another library
gets its own global-dynamic weak symbol elected at execution time. Would
it be better to switch to a "strong" symbol for the glibc __rseq_abi
rather than weak ?

If we rely on implicit unregistration by the exit system call, then we
need to be really sure that the __rseq_abi TLS area can be accessed
(load and store) from kernel preemption up to the point where exit
is invoked. If we have that guarantee with the IE model, then we should
be fine. This means the memory area with the __rseq_abi sits can only
be re-used after the tid field in the TLB is set to 0 by the exit system
call. Looking at allocatestack.c, it looks like the FREE_P () macro
does exactly that.

With all the above respected, we could rely on implicit rseq unregistration
by thread exit rather than do an explicit unregister. We could still need
to increment the __rseq_refcount upon thread start however, so we can
ensure early adopter libraries won't unregister rseq while glibc is using
it. No need to bring the refcount back to 0 in glibc though.

There has been presumptions about signals being blocked when the thread
exits throughout this email thread. Out of curiosity, what code is
responsible for disabling signals in this situation ? Related to this,
is it valid to access a IE model TLS variable from a signal handler at
_any_ point where the signal handler nests over thread's execution ?
This includes early start and just before invoking the exit system call.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
