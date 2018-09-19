Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7637EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE387206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cpGXzsJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE387206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeITClM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:41:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:38846 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeITClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:41:10 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7D0C923F8E1;
        Wed, 19 Sep 2018 17:01:27 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LEiAUoBpUIzJ; Wed, 19 Sep 2018 17:01:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AD5BA23F8DE;
        Wed, 19 Sep 2018 17:01:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AD5BA23F8DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537390886;
        bh=PPqi4ua3SQpcWRLkxRbFFLNnhA+VogMRh1uZ5sTFFDA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cpGXzsJS9WnXrFeGaA2ZqIKEmo6Xp3E3k1aY9HLDU/LVzmecoIJaDHmpnqF48TVf4
         PpMZXSplOlSMeRvUxZ69AY99+cK5uZNL8lGbpzPKRX1xfiMIFiSzsIsVi7OlKDhzAz
         oFE8zDgqfv0wwtNK/XL7nLRjPXfQneRyWQULuPWsWJgxzlHelw6mLphGV9VpMDZOhe
         hCupvZ7KV45ex+ILQHlh53GILjwYZ/C0VqVg1hQEc3/7RhBnzCYSyR/t0MagNK54fR
         FLbW22nRH3q90fuCvzLrmbj/f4NEabJNtVj5/ZJQZEH2AhWkZsZ1W7BNU3oI2rNxla
         ygWkKSDkMp8aA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 2h4-UX_ai-Ot; Wed, 19 Sep 2018 17:01:26 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 95F7B23F8CC;
        Wed, 19 Sep 2018 17:01:26 -0400 (EDT)
Date:   Wed, 19 Sep 2018 17:01:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        nd <nd@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <2052751374.8654.1537390886450.JavaMail.zimbra@efficios.com>
In-Reply-To: <c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@arm.com>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@arm.com>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: gM/MBV+hIIWpXNC6c9G2xv/rGbnH9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 19, 2018, at 1:38 PM, Szabolcs Nagy szabolcs.nagy@arm.com wrote:

> On 19/09/18 15:44, Mathieu Desnoyers wrote:
>> Things to consider:
>> 
>> - Move __rseq_refcount to an extra field at the end of __rseq_abi to
>>    eliminate one symbol. This would require to wrap struct rseq into
>>    e.g. struct rseq_lib or such, e.g.:
>> 
>> struct rseq_lib {
>>    struct rseq kabi;
>>    int refcount;
>> };
>> 
>> All libraries/programs which try to register rseq (glibc, early-adopter
>> applications, early-adopter libraries) should use the rseq refcount.
>> It becomes part of the ABI within a user-space process, but it's not
>> part of the ABI shared with the kernel per se.
>> 
>> - Restructure how this code is organized so glibc keeps building on
>>    non-Linux targets.
>> 
>> - We do not need an atomic increment/decrement for the refcount per
>>    se. Just being atomic with respect to the current thread (and nested
>>    signals) would be enough. What is the proper API to use there ?
>>    Should we expose struct rseq_lib in a public glibc header ? Should
>>    we create a rseq(3) man page ?
>> 
>> - Revisit use of "weak" symbol for __rseq_abi in glibc. Perhaps we
>>    want a non-weak symbol there ? (and let all other early user
>>    libraries use weak)
>> 
> 
> i don't think there is precedent for exposing tls symbol in glibc
> (e.g. errno is exposed via __errno_location function) so there
> might be issues with this (but i don't have immediate concerns).
> 
>> diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
>> index fe75d04113..20ee197d94 100644
>> --- a/nptl/pthread_create.c
>> +++ b/nptl/pthread_create.c
>> @@ -52,6 +52,13 @@ static struct pthread *__nptl_last_event __attribute_used__;
>>   /* Number of threads running.  */
>>   unsigned int __nptl_nthreads = 1;
>>   
>> +__attribute__((weak, tls_model("initial-exec"))) __thread
>> +volatile struct rseq __rseq_abi = {
>> +	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
>> +};
>> +
>> +__attribute__((weak, tls_model("initial-exec"))) __thread
>> +volatile int __rseq_refcount;
>>  
> 
> note that libpthread.so is built with -ftls-model=initial-exec

Which would indeed make these annotations redundant. I'll remove
them.

> (and if it wasn't then you'd want to put the attribute on the
> declaration in the internal header file, not on the definition,
> so the actual tls accesses generate the right code)

This area is one where I'm still uneasy on my comprehension of
the details, especially that it goes in a different direction than
what you are recommending.

I've read through https://www.akkadia.org/drepper/tls.pdf Section 5
"Linker Optimizations" to try to figure it out, and I end up being
under the impression that applying the tls_model("initial-exec")
attribute to a symbol declaration in a header file does not have
much impact on the accesses that use that variable. Reading through
that section, it seems that the variable definition is the one that
matters, and then the compiler/linker/loader are tweaking the sites
that reference the TLS variable through code rewrite based on the
most efficient mechanism that each phase knows can be used at each
stage.

What am I missing ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
