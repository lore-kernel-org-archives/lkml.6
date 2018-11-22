Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA001C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7586820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dHL9CJrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7586820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405727AbeKWBoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:44:02 -0500
Received: from mail.efficios.com ([167.114.142.138]:51508 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeKWBoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:44:02 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7E3B02504CC;
        Thu, 22 Nov 2018 10:04:17 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id W2wSU6brnzaR; Thu, 22 Nov 2018 10:04:17 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 082972504B9;
        Thu, 22 Nov 2018 10:04:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 082972504B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542899057;
        bh=/jGcv3ikfocAK+t2x7GFxnhMfNd9oklnCzgNoZY7JQc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dHL9CJrMrXqdieDm5o+mEAgBq+bCJsMhBLoNFnq/fDMxi2KMSTodQRd3pLI98nj2l
         wOOWbMXfuJRX5Tw3NIGQFE2zZzhNcS5Wv8KKQ2s1QiGvdFu0Ts6G7HzUcFy7worGiL
         7dgFb9nxwOiOX/IU2FlusrEhbqj6i/E4axMm0+UX3TT3OjEDLF5aWmmpvkPKWFQpXw
         +eQrjT8VPjlGE063I91d/VV1yw4aNLLLqQsirmMAW1+1/8WjdHYW4pUWhcaCulVGlv
         +YZTAQosV90jzZum7orL0ON/bgBr9dhVZlqI0J3D8W9D6VOklTdMqamhxFc62wl/nx
         NNPEenWBFRnmw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id wV8wBdqjCTrL; Thu, 22 Nov 2018 10:04:16 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id DB5C72504B2;
        Thu, 22 Nov 2018 10:04:16 -0500 (EST)
Date:   Thu, 22 Nov 2018 10:04:16 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181122143603.GD23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <20181122143603.GD23599@brightrain.aerifal.cx>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: tTPuXGNepoFLbbnqmkjFnnTYo2v1fg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 22, 2018, at 9:36 AM, Rich Felker dalias@libc.org wrote:

> On Wed, Nov 21, 2018 at 01:39:32PM -0500, Mathieu Desnoyers wrote:
>> Register rseq(2) TLS for each thread (including main), and unregister
>> for each thread (excluding main). "rseq" stands for Restartable
>> Sequences.
> 
> Maybe I'm missing something obvious, but "unregister" does not seem to
> be a meaningful operation. Can you clarify what it's for?

There are really two ways rseq TLS can end up being unregistered: either
through an explicit call to the rseq "unregister", or when the OS frees the
thread's task struct.

You bring an interesting point here: do we need to explicitly unregister
rseq at thread exit, or can we leave that to the OS ?

The key thing to look for here is whether it's valid to access the
TLS area of the thread from preemption or signal delivery happening
at the very end of START_THREAD_DEFN. If it's OK to access it until
the very end of the thread lifetime, then we could do without an
explicit unregistration. However, if at any given point of the late
thread lifetime we end up in a situation where reading or writing to
that TLS area can cause corruption, then we need to carefully
unregister it before that memory is reclaimed/reused.

What we have below the current location for the __rseq_unregister_current_thread ()
call is as follows. I'm not all that convinced that it's valid to access the TLS
area up until __exit_thread () at the very end, especially after setting
setxid_futex back to 0.

Thoughts ?

  /* Unregister rseq TLS from kernel. */
  if (has_rseq && __rseq_unregister_current_thread ())
    abort();

  advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
                      pd->guardsize);

  /* If the thread is detached free the TCB.  */
  if (IS_DETACHED (pd))
    /* Free the TCB.  */
    __free_tcb (pd);
  else if (__glibc_unlikely (pd->cancelhandling & SETXID_BITMASK))
    {
      /* Some other thread might call any of the setXid functions and expect
         us to reply.  In this case wait until we did that.  */
      do
        /* XXX This differs from the typical futex_wait_simple pattern in that
           the futex_wait condition (setxid_futex) is different from the
           condition used in the surrounding loop (cancelhandling).  We need
           to check and document why this is correct.  */
        futex_wait_simple (&pd->setxid_futex, 0, FUTEX_PRIVATE);
      while (pd->cancelhandling & SETXID_BITMASK);

      /* Reset the value so that the stack can be reused.  */
      pd->setxid_futex = 0;
    }

  /* We cannot call '_exit' here.  '_exit' will terminate the process.

     The 'exit' implementation in the kernel will signal when the
     process is really dead since 'clone' got passed the CLONE_CHILD_CLEARTID
     flag.  The 'tid' field in the TCB will be set to zero.

     The exit code is zero since in case all threads exit by calling
     'pthread_exit' the exit status must be 0 (zero).  */
  __exit_thread ();

  /* NOTREACHED */

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
