Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F38ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED9B21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="q5Np1/Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED9B21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbeIUWTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:19:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:54304 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUWTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:19:05 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 76E532408DA;
        Fri, 21 Sep 2018 12:29:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 6VevwSoySJ-r; Fri, 21 Sep 2018 12:29:24 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8B8862408D3;
        Fri, 21 Sep 2018 12:29:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8B8862408D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537547364;
        bh=KfMgBTAiikeLS4UMOVsKNbkuRGim7g93fkFtNITs0CY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=q5Np1/Hj4OHfvYPlfBoiOtQKdxKrFK3RAlVSCXOPY2CWtWF2mkRoXUIk2N9sKd6no
         QvdBDE/k8tRo+bnIWipldIi/JbzWqQUbNDkl4PeQg7AbrUWsBMbr0djtVPYTVbJV8q
         FhwMZAbFyvKUAk3NYJn0Kn0VK4Tu6lHC7eONYFYbGXMVzCTXjXD8xXrfzIdp+nLkaf
         RCBi1Fy+c9Fc0ulPoJA/pe8Z3LFrFJooNGyxXpSsAcclUfztCsG0olTZfnxerjJvAR
         3lZdQvghuAkLkGfHHK/XpFDftD2YwkyYhZq8IptwJkWawGxyw4gVoh7RZRMX38xJnX
         cCZpwBcbbuAxg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uW-upZBmzasc; Fri, 21 Sep 2018 12:29:24 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 728BF2408CA;
        Fri, 21 Sep 2018 12:29:24 -0400 (EDT)
Date:   Fri, 21 Sep 2018 12:29:24 -0400 (EDT)
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
Message-ID: <1370210961.9271.1537547364295.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1809202016270.17228@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk> <67473000.8399.1537375994645.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1809191706090.26757@digraph.polyomino.org.uk> <1619649568.9014.1537474457166.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1809202016270.17228@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: yIFg5vgy/fXCjSInfG+u1JXvEBmAUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- On Sep 20, 2018, at 4:20 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Thu, 20 Sep 2018, Mathieu Desnoyers wrote:
> 
>> Are you saying glibc has an explicit check for the kernel version visible
>> from /proc before using specific features ? If so, how can this work with
>> the variety of feature backports we find in the distribution kernels out
>> there ?
> 
> See sysdeps/unix/sysv/linux/dl-sysdep.c and
> sysdeps/unix/sysv/linux/dl-osinfo.h.  As I said, Carlos has proposed
> removing that check.

For the system calls I implement and maintain, I typically ensure there is
a set of parameters that can be used when issuing the system call so it
can either succeed or fail with ENOSYS without having side-effects. It's
specifically meant to be used for feature discovery in a library
initialization phase. It's especially useful if the application needs to
keep state around related to the system call across its execution, e.g.
robust futexes.

> 
>> For too-old headers at compile time, one possibility is that we don't event
>> expose the __rseq_abi TLS symbol. OTOH, if we need to keep exposing it anyway
>> for ABI consistency purposes, then we'd leave its cpu_id field at the initial
>> value (-1). But that would require that we copy linux/rseq.h into the glibc
>> source tree.
> 
> The ABI needs to be independent of the kernel headers used.  I don't think
> you need to copy linux/rseq.h; all you should need is to e.g. define an
> array of suitable size and alignment with the relevant member initialized
> and a suitable explanatory comment.

In that case, I'm thinking declaring a minimal structure in glibc code may be
clearer than the array, e.g.:

[pthreadP.h]

enum libc_rseq_cpu_id_state {
  LIBC_RSEQ_CPU_ID_UNINITIALIZED = -1,
  LIBC_RSEQ_CPU_ID_REGISTRATION_FAILED = -2,
};

/* linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
   size is 20 bytes. For support of multiple rseq users within a process,
   user-space defines an extra 4 bytes field as a reference count, for a
   total of 24 bytes.  */
struct libc_rseq {
  /* kernel-userspace ABI. */
  uint32_t cpu_id_start;
  uint32_t cpu_id;
  uint64_t rseq_cs;
  uint32_t flags;
  /* user-space ABI. */
  uint32_t refcount;
} __attribute__((aligned(4 * sizeof(uint64_t))));

[pthread_create.h]

__thread volatile struct libc_rseq __rseq_abi = {
  .cpu_id = LIBC_RSEQ_CPU_ID_UNINITIALIZED,
};

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
