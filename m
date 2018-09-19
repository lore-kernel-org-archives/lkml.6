Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367C72083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PUKembXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367C72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbeISWcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:32:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:50434 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:32:05 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 94B2123FE12;
        Wed, 19 Sep 2018 12:53:15 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id FbZ5bGcgpbqu; Wed, 19 Sep 2018 12:53:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C67EF23FE04;
        Wed, 19 Sep 2018 12:53:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C67EF23FE04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537375994;
        bh=vPL2Q2AaGgRJFXwbevUjgDAkJjmRz+aOOpXAItzUHm0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PUKembXvkfGnvHSQsaatgRd5xsS41YEDOpyATAuqQ6Q6N+xJ9JwcUq9an7GMRDW0o
         bBc1Kx9eTG0DNL7fOv8qYydksO9UNbz+H8L3itV0pmg0NmKCHVd6hue//BUBasLxls
         ApapfzFMHHaTjfG5KmU92CCkg/PyeRkgxKxOcQeesTAcvtGjmjpK+3YDadGEP4pVTm
         d8zInY1X8O7/CPqHmIwBrZndSS3liYwnuHzL8ryklbAU+h02kEAoytsBsINssB3qCh
         AbGnlHP7YNPHuFPluZgipvU0AnUBLa98YKP+fTzCZLMnGBGxI8mc6daDjylSCQgGGC
         WFYSWgba/g67w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id FVzc21IrgR8a; Wed, 19 Sep 2018 12:53:14 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id AE78323FDF0;
        Wed, 19 Sep 2018 12:53:14 -0400 (EDT)
Date:   Wed, 19 Sep 2018 12:53:14 -0400 (EDT)
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
Message-ID: <67473000.8399.1537375994645.JavaMail.zimbra@efficios.com>
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
Thread-Index: TeRSFIkNT2ONAgHrmTf/5ZlK/KK5rA==
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

Certainly. I'm just not sure where I need to poke to update the ABI version
from 2.28 to 2.29 in my dev branch.

> 
>> diff --git a/sysdeps/unix/sysv/linux/rseq.h b/sysdeps/unix/sysv/linux/rseq.h
> 
> This looks like it's coming from the Linux kernel.  Can't the relevant
> uapi header just be used directly without copying into glibc (with due
> care to ensure that glibc still builds if the kernel headers used for the
> build are too old - you need such conditionals anyway if they don't define
> the relevant syscall number)?

This is indeed in the list of "things to consider" I've put in the patch
commit message. If the usual practice is to build against uapi kernel headers
outside of the glibc tree, I'm fine with that.

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
