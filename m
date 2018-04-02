Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243475-1522683193-2-13602773892722987479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522683193; b=qZPuS+wTE5wTZ4begKj20oX8U66P95ll0miost9kuDkQY+9r4m
    Nz9Cha9AQODNUq01nMbP+jIh7wGvqtdHStHMGTIBY6FHDZRLqHMOTAyMIGxFsY7P
    OTQyTZPjeZZUVdkFYpEktLYrQqcC0rRTT4oSQOLJai4zy+FggMgoBPF9kgeNQXAk
    al7eMJpfcLcY0h55lJSuWkf8eV3Z2tHMhTflOQg5qhtJ+jE5ArdifTFgw9LShRiN
    apJcvTkzuuAopygCBAuhwNkmEeGiP3Ila6tP8/K4J7qx1jusvXZUKhojrrb8f9//
    f70WcbbApswxS1CmNHoEKZmnGX0NP/LvFPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522683193;
    bh=mSbe0gElCgmZobXPJdffRaJhrwisz+uzjAL90uhMuyQ=; b=J41cO3SaXAx5
    DL5XMpU1QyY2aDdIDIVDGMKXaXZtAkiPH8oHr3qwSZgHBjb+HKWIdszcu9BaOzhO
    XVDxnF5cBe+MMlqmVrME/Hn86zvk1nKKFjzsAqbIpDN2kgtnVkL1Qa8IeCl703w1
    Qyuj/IkOagpl5gVNK8afoldLIL68eX1kjhAEr7MB+tdeDHd45vviA5YoT1YDQ4m2
    pADVDo7rXpTnKYyV1TGQMhNJkrfxG4Dw+y1devxa6X3p3+R66zD38Qq8U6PsVp+L
    vj4/7VvB7vTk8jZA+xZTSl9ks8DJxE8V6uHe6SQ1BhqlkNHuC7dFOoq27S3ouwYu
    maskBiyTzQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFjMbIQiXy4xITLdboMmDxIEcOljqnXHjkMXgAzoEwLgWg3FGJffMZYzad9WnNKh+Jzy8wgLmnI39KDJri/YjV+X/gkoJE1PO0oIRB2UYbCiuPRpRZiq
    M5lVm9ctuiljihQDZNU3/4+y/SUZdRQDnQfYTG9XgAewFvXdtebHrxvV2fUHCQCTg66xbwcXC6HySd1maCbzCDeYO8aVKYZOrYh49LWTEwqvXAc9xbBEgnMm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=z1H5ADGQAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=7Mxw4j_g1qxxZE322xEA:9
    a=MHWwOosqOYjsmSay:21 a=XLBHivsqxjZ8mY8t:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeDBPdL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 11:33:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:51794 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeDBPdK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 11:33:10 -0400
Date: Mon, 2 Apr 2018 11:33:08 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <1890356924.1736.1522683188833.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180401171356.085a2a33@alans-desktop>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180401171356.085a2a33@alans-desktop>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: ZlI8yYRhtR4Zm8XQBnk6z8Kg2ePiGg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 1, 2018, at 12:13 PM, One Thousand Gnomes gnomes@lxorguk.ukuu.org.uk wrote:

> On Tue, 27 Mar 2018 12:05:23 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Expose a new system call allowing each thread to register one userspace
>> memory area to be used as an ABI between kernel and user-space for two
>> purposes: user-space restartable sequences and quick access to read the
>> current CPU number value from user-space.
> 
> What is the *worst* case timing achievable by using the atomics ? What
> does it do to real time performance requirements ?

Given that there are two system calls introduced in this series (rseq and
cpu_opv), can you clarify which system call you refer to in the two questions
above ?

For rseq, given that its userspace works pretty much like a read seqlock
(it retries on failure), it has no impact whatsoever on scheduler behavior.
So characterizing its worst case timing does not appear to be relevant.

> For cpu_opv you now
> give an answer but your answer is assuming there isn't another thread
> actively thrashing the cache or store buffers, and that the user didn't
> sneakily pass in a page of uncacheable memory (eg framebuffer, or GPU
> space).

Are those considered as device pages ?

> 
> I don't see anything that restricts it to cached pages. With that check
> in place for x86 at least it would probably be ok and I think the sneaky
> attacks to make it uncacheable would fail becuase you've got the pages
> locked so trying to give them to an accelerator will block until you are
> done.
> 
> I still like the idea it's just the latencies concern me.

Indeed, cpu_opv touches pages that are shared with user-space with
preemption off, so this one affects the scheduler latency. The worse-case
timings I measured for cpu_opv were with cache-cold memory. So I expect that
another thread actively trashing the cache would be in the same ballpark
figure. It does not account for a concurrent thread thrashing the store
buffers though.

The checks enforcing which pages can be touched by cpu_opv operations are
done within cpu_op_check_page(). is_zone_device_page() is used to ensure no
device page is touched with preempt disabled. I understand that you would
prefer to disallow pages of uncacheable memory as well, which I'm fine with.
Is there an API similar to is_zone_device_page() to check whether a page is
uncacheable ?

> 
>>        Restartable sequences are atomic  with  respect  to  preemption
>>        (making  it atomic with respect to other threads running on the
>>        same CPU), as well as  signal  delivery  (user-space  execution
>>        contexts nested over the same thread).
> 
> CPU generally means 'big lump with legs on it'. You are not atomic to the
> same CPU, because that CPU may have 30+ cores with 8 threads per core.
> 
> It could do with some better terminology (hardware thread, CPU context ?)

Would you be OK with Christoph's terminology of "Hardware Execution Context" ?

> 
>>        In  a  typical  usage scenario, the thread registering the rseq
>>        structure will be performing  loads  and  stores  from/to  that
>>        structure.  It  is  however also allowed to read that structure
>>        from other threads.  The rseq field updates  performed  by  the
>>        kernel  provide  relaxed  atomicity  semantics, which guarantee
>>        that other threads performing relaxed atomic reads of  the  cpu
>>        number cache will always observe a consistent value.
> 
> So what happens to your API if the kernel atomics get improved ? You are
> effectively exporting rseq behaviour from private to public.

Relaxed atomics is pretty much the loosest kind of consistency we can
provide before we start allowing the compiler to do load/store tearing
(it's basically a volatile store of a word-aligned word). It does not
involve any kind of memory barrier whatsoever. I expect that the atomics
that may evolve in the future will be those with release/acquire and
implicit barriers semantics. The relaxed atomicity does not cover any of
these.

Thanks,

Mathieu

> 
> Alan

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
