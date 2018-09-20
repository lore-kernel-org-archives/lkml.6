Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD61C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D52147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jWzqXWo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5D52147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeIUBtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:49:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:53992 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbeIUBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:49:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 174D7240AFB;
        Thu, 20 Sep 2018 16:04:28 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Jd6WDegwnGXP; Thu, 20 Sep 2018 16:04:27 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2283B240AF7;
        Thu, 20 Sep 2018 16:04:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2283B240AF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537473867;
        bh=FKDbtBMGdRMQP1pI9M4peWUO1d5nRjqSunZvZ14ozLQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jWzqXWo1JAAr6PUqf6mWYE3jnzfJ0BBVVGRL5S4u9iGtSB0NMpW2KnmZGA1ocDqYp
         jjfgetrYf1YPVMKuyyCO2NB7mp49jMo1sP0dvhIIXcZziLGj9xhMRx0g/n2NClKqvk
         fGDf7DO36eT880iksvLpaHa07wbm/Gk5LW3biszinZN51V0GOn1dqCjikz5qtPlmsC
         qmir8xzDSXJB/GWKZyoFFD7GSra3XX37eIoVibVI6uHyT4zVjeMmm0OBEe8attXpXl
         Y6ajiMC5I1EJXN/3KxLiM/lYKt4kUgkrKtMxAtXMb2bz3cjluf6+uyAAgXWr6CJtmi
         B9p4jF5QyidcA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tfReVVDItLcw; Thu, 20 Sep 2018 16:04:27 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0882D240AF0;
        Thu, 20 Sep 2018 16:04:27 -0400 (EDT)
Date:   Thu, 20 Sep 2018 16:04:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <381061785.8994.1537473866841.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: psWJMi4/wKh/74j4G/pR5+hFK1ZtpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 19, 2018, at 12:37 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Wed, 19 Sep 2018, Mathieu Desnoyers wrote:
> 
>> Here is a rough prototype registering rseq(2) TLS for each thread
>> (including main), and unregistering for each thread (excluding
>> main). "rseq" stands for Restartable Sequences.
> 
> A final patch would need to add documentation and tests and a NEWS entry
> and fix various coding style issues.

Sure,

> 
>> diff --git a/nptl/Versions b/nptl/Versions
>> index e7f691da7a..7316c2815d 100644
>> --- a/nptl/Versions
>> +++ b/nptl/Versions
>> @@ -275,6 +275,7 @@ libpthread {
>>      mtx_init; mtx_lock; mtx_timedlock; mtx_trylock; mtx_unlock; mtx_destroy;
>>      call_once; cnd_broadcast; cnd_destroy; cnd_init; cnd_signal;
>>      cnd_timedwait; cnd_wait; tss_create; tss_delete; tss_get; tss_set;
>> +    __rseq_abi; __rseq_refcount;
> 
> That's the GLIBC_2.28 section, but 2.28 is already out.  New symbols would
> need to go in GLIBC_2.29 or later (and the ABI test baselines would all
> need updating).

OK

> 
>> diff --git a/sysdeps/unix/sysv/linux/rseq.h b/sysdeps/unix/sysv/linux/rseq.h
> 
> This looks like it's coming from the Linux kernel.  Can't the relevant
> uapi header just be used directly without copying into glibc (with due
> care to ensure that glibc still builds if the kernel headers used for the
> build are too old - you need such conditionals anyway if they don't define
> the relevant syscall number)?

Something like this in pthreadP.h ?

+#ifdef __NR_rseq
+#include <sysdeps/unix/sysv/linux/rseq-internal.h>
+#else
+#include <sysdeps/nptl/rseq-internal.h>
+#endif  /* __NR_rseq.  */

where sysdeps/unix/sysv/linux/rseq-internal.h contains the linux
implementation of rseq_register_current_thread () and
rseq_unregister_current_thread (), and sysdeps/nptl/rseq-internal.h
contains stubs.

Am I on the right track ?

Thanks,

Mathieu



> 
> --
> Joseph S. Myers
> joseph@codesourcery.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
