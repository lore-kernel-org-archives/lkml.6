Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4CDA8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E9C208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SfCx/xSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E9C208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeFMQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:14:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:60876 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754509AbeFMQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:14:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A032A229AF0;
        Wed, 13 Jun 2018 12:14:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Lzwka1r-98HG; Wed, 13 Jun 2018 12:14:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 350EE229AED;
        Wed, 13 Jun 2018 12:14:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 350EE229AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528906459;
        bh=pHgN/cEVkus3vReyCzHkOHy3ZSDDsYE8eCigiIxac+s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SfCx/xSPyt+9OBl9An+vsmoif8QMZlwALV3SuKAX9u5QFyo58EWyhdssfxLy9972n
         KlRZeF48rSOAC0zPmbDRRf8vVYs2V6e1jbmUv/9t3XmwpxnbELZLup6pos2H2tYzPe
         jrl+8eYfVzUKGeQCudlcaBn8Gr9o76ayN10FVelftYBDpfFJMp7J/J8LdseT8mx8XJ
         Btjuyah13oSMxRBtfqKxtBBxvZmVijzslB5yNIIlQwJahCjkjX0Uqvorzo8Ib8mmVM
         8VF6fVSM8NWUM5DSVNVaK5AvTbup0WV4f6l4O2mz/w/tWxF0ll+bm3JfOkxoAHqoMA
         byjJSxtjgVQ7g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fOmiMVeQ7EWw; Wed, 13 Jun 2018 12:14:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1DA25229AE6;
        Wed, 13 Jun 2018 12:14:19 -0400 (EDT)
Date:   Wed, 13 Jun 2018 12:14:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     heiko carstens <heiko.carstens@de.ibm.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <1904010978.12481.1528906458944.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180613114811.GC4342@osiris>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <20180613114811.GC4342@osiris>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: 03097Zs90n0PWzBVhsrdocLBo0GNPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 13, 2018, at 7:48 AM, heiko carstens heiko.carstens@de.ibm.com wrote:

> On Mon, Jun 11, 2018 at 03:49:18PM -0400, Mathieu Desnoyers wrote:
>> Hi!
>> 
>> Good news! The restartable sequences (rseq) system call is now merged into the
>> master
>> branch of the Linux kernel within the 4.18 merge window:
>> 
>> https://github.com/torvalds/linux/commit/d82991a8688ad128b46db1b42d5d84396487a508
>> 
>> It would be important to discuss how we should proceed to integrate the library
>> part
>> of rseq (see tools/testing/selftests/rseq/rseq*.{ch}) into glibc, or if it
>> should
>> live in a standalone project.
> 
> Is there any documentation available of what is the exact semantics of the
> functions that have to be implemented for additional architectures?

It's documented on top of kernel/rseq.c:

/*
 *
 * Restartable sequences are a lightweight interface that allows
 * user-level code to be executed atomically relative to scheduler
 * preemption and signal delivery. Typically used for implementing
 * per-cpu operations.
 *
 * It allows user-space to perform update operations on per-cpu data
 * without requiring heavy-weight atomic operations.
 *
 * Detailed algorithm of rseq user-space assembly sequences:
 *
 *                     init(rseq_cs)
 *                     cpu = TLS->rseq::cpu_id_start
 *   [1]               TLS->rseq::rseq_cs = rseq_cs
 *   [start_ip]        ----------------------------
 *   [2]               if (cpu != TLS->rseq::cpu_id)
 *                             goto abort_ip;
 *   [3]               <last_instruction_in_cs>
 *   [post_commit_ip]  ----------------------------
 *
 *   The address of jump target abort_ip must be outside the critical
 *   region, i.e.:
 *
 *     [abort_ip] < [start_ip]  || [abort_ip] >= [post_commit_ip]
 *
 *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
 *   userspace that can handle being interrupted between any of those
 *   instructions, and then resumed to the abort_ip.
 *
 *   1.  Userspace stores the address of the struct rseq_cs assembly
 *       block descriptor into the rseq_cs field of the registered
 *       struct rseq TLS area. This update is performed through a single
 *       store within the inline assembly instruction sequence.
 *       [start_ip]
 *
 *   2.  Userspace tests to check whether the current cpu_id field match
 *       the cpu number loaded before start_ip, branching to abort_ip
 *       in case of a mismatch.
 *
 *       If the sequence is preempted or interrupted by a signal
 *       at or after start_ip and before post_commit_ip, then the kernel
 *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
 *       ip to abort_ip before returning to user-space, so the preempted
 *       execution resumes at abort_ip.
 *
 *   3.  Userspace critical section final instruction before
 *       post_commit_ip is the commit. The critical section is
 *       self-terminating.
 *       [post_commit_ip]
 *
 *   4.  <success>
 *
 *   On failure at [2], or if interrupted by preempt or signal delivery
 *   between [1] and [3]:
 *
 *       [abort_ip]
 *   F1. <failure>
 */

> I could look at rseq-skip.h and e.g. rseq-x86.h and try to figure out what
> would be the correct implementation for s390. But having that somewhere
> written down, e.g. as comments in one of the implementations, would be very
> helpful.

The first architecture implemented was rseq-x86.h. Boqun derived rseq-ppc.h
from it, and I derived rseq-arm.h from it. Feel free to start from whichever
architecture has the instruction set which is most similar to yours.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
