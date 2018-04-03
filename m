Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1961259-1522773394-2-16455927053755630507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522773393; b=QNWtbr3XnunVROAJxEgwaL2V13MVptt2fFPrhPl57JXZTp/rsk
    slcZKaWIhb0Oh8wYszMLH0sAIoMKKNOZfXRl6qlNPZigZ1fLSryvSILFbgRNt/vR
    wvahjrUofRLLFCo2fYw/Br8bid0Yz0JRxei5rOhqSejpOSGpn0pP9xUv9hfI3k/h
    3voyUaCqBfTCiSaV71WctrP1a/vCSPKObdaMRj9JyL9BprYlViJ14QDl+j/x4+JP
    mXKDCBejAx93O0G0pDh4DFiOPskGWTlF+XldXLa1PW+6pe+ozsofIzd+AG5lzXbj
    ze7glmbGqtMArz339lg4d/SZGAHB0QVk8qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522773393;
    bh=osGI9ZZL6+Jy/FGZncmmRV+TpT9okPfnEg5VS1uYiCs=; b=iFupN5m6b5+t
    UcINaZGkbd4YSAFgCulcpsM8QhM9r1K39NcS+PBow98qIVBcomKHuBLJ6+csFQkW
    0ASd4cKlet5aq5oC8u3FWgAzixzt6BR4SJzVBNxtxbf41LfI/zA6VXksYSMJdlQY
    qDHxQ4CvrwbQtKf++odbuEOGxnLwHqZL5x1gAUHz4p0EyJTbg9ZQh2EORCrACX2G
    3O78zlsraLh2QPbBS4r2mHTnTtl8Y7LaBBZcWWDSd5LuRI25aj+LjtqtX4k/C/WI
    mWEJIuJFKBgc2BPYU6c+wyeF1rCACsDS/bRqAOzyF559WgjOkeV7SYFA9wZQLq5G
    7XSPnnHCHg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNdR8zLO4on9gWtgXinM16lhXb+S1G+BRDrN2rgoWgCedv35E4cJ79b6UQnCs02WSmpwkJE9ibb5D+5mrV+mrjl2aSt47YReXuaFLlFFR+ykSrlBjQKK
    CSbQoQ2FUk7CWYz2+MlxjqFqET0qT2WQrGUN+nTE0a7GVYCfhRPi4WYMkXDKfn+BwdkBeJ6xs5ZF3tKxSsE6qRN/f/wm0wdzTFQZlilQQJ1eW0PMFUdBsFR+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=7d_E57ReAAAA:8
    a=z1H5ADGQAAAA:8 a=VwQbUJbxAAAA:8 a=2ifpFOw5uJIE_SUrHQkA:9
    a=Y-Fq8NFzwYHeAQKc:21 a=tMKe9tWzIRP-b7fR:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=cNhwqobjEIRUxE0uuXBi:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDCQgb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 12:36:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:35518 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDCQg3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 12:36:29 -0400
Date: Tue, 3 Apr 2018 12:36:27 -0400 (EDT)
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
Message-ID: <17439540.2334.1522773387555.JavaMail.zimbra@efficios.com>
In-Reply-To: <1890356924.1736.1522683188833.JavaMail.zimbra@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180401171356.085a2a33@alans-desktop> <1890356924.1736.1522683188833.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: ZlI8yYRhtR4Zm8XQBnk6z8Kg2ePiGrPMLD+w
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 2, 2018, at 11:33 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 1, 2018, at 12:13 PM, One Thousand Gnomes
> gnomes@lxorguk.ukuu.org.uk wrote:
> 
>> On Tue, 27 Mar 2018 12:05:23 -0400
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>>> Expose a new system call allowing each thread to register one userspace
>>> memory area to be used as an ABI between kernel and user-space for two
>>> purposes: user-space restartable sequences and quick access to read the
>>> current CPU number value from user-space.
>> 
>> What is the *worst* case timing achievable by using the atomics ? What
>> does it do to real time performance requirements ?
> 
> Given that there are two system calls introduced in this series (rseq and
> cpu_opv), can you clarify which system call you refer to in the two questions
> above ?
> 
> For rseq, given that its userspace works pretty much like a read seqlock
> (it retries on failure), it has no impact whatsoever on scheduler behavior.
> So characterizing its worst case timing does not appear to be relevant.
> 
>> For cpu_opv you now
>> give an answer but your answer is assuming there isn't another thread
>> actively thrashing the cache or store buffers, and that the user didn't
>> sneakily pass in a page of uncacheable memory (eg framebuffer, or GPU
>> space).
> 
> Are those considered as device pages ?
> 
>> 
>> I don't see anything that restricts it to cached pages. With that check
>> in place for x86 at least it would probably be ok and I think the sneaky
>> attacks to make it uncacheable would fail becuase you've got the pages
>> locked so trying to give them to an accelerator will block until you are
>> done.
>> 
>> I still like the idea it's just the latencies concern me.
> 
> Indeed, cpu_opv touches pages that are shared with user-space with
> preemption off, so this one affects the scheduler latency. The worse-case
> timings I measured for cpu_opv were with cache-cold memory. So I expect that
> another thread actively trashing the cache would be in the same ballpark
> figure. It does not account for a concurrent thread thrashing the store
> buffers though.
> 
> The checks enforcing which pages can be touched by cpu_opv operations are
> done within cpu_op_check_page(). is_zone_device_page() is used to ensure no
> device page is touched with preempt disabled. I understand that you would
> prefer to disallow pages of uncacheable memory as well, which I'm fine with.
> Is there an API similar to is_zone_device_page() to check whether a page is
> uncacheable ?

Looking into this a bit more, I notice the following: The pgprot_noncached
(_PAGE_NOCACHE on x86) pgprot is part of the vma->vm_page_prot. Therefore,
in order to have userspace provide pointers to noncached pages as input
to cpu_opv, they need to be part of a userspace vma which has a
pgprot_noncached vm_page_prot.

The cpu_opv system call uses get_user_pages_fast() to grab the struct page
from the userspace addresses, and then passes those pages to vm_map_ram(),
with a PAGE_KERNEL pgprot. This creates a temporary kernel mapping to those
pages, which is then used to read/write from/to those pages with preemption
disabled.

Therefore, with the proposed cpu_opv implementation, the kernel is not
touching noncached mappings with preemption disabled, which should take
care of your latency concern.

Am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
