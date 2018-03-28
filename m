Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2462495-1522247533-2-12532778321834895759
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522247533; b=pF86hZUbALT8/OFWw8IgDlSOppzCIReuaQR0j/g5HclalAS
    MKzk5fzlL2cy5oJMIPPpjGTgdVGZlxi07jJPjgS2Dnj9zAg/kBgaSLg8Fc1ajJx+
    rlVlMzjiHuIRQ73s8VSPsna1zcrCNLPhUa3YJqa6jQg6zr/zsruAgaaUZNjc9cMK
    lwM7hD+nmxJegS+87ni2uDO47jRGVfgi5dtGsxoFmIKr2+xJ9H0okl0Z5K5odXKO
    X7Y3G9zKX1oVxI2pkxjfiBZUWCngF7n/JvOq/xgWafTD2QB+GFAyQRPfkJt01Yt3
    tyMLVyxHrrTocVPNyheiN5DNluWuWZGfh1mKQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522247533; bh=WhCDxQ+F+Rw9yCOrM6DPlmj1DmHdhCXO1m8Q9qiNCsg=; b=R
    7OdRe/HY8GhkwzfLzkxQJkQ5wPfj4KfVrO6GrwwVSKf/YDZ42i9ysFm3QnQcYJ0P
    SSLWjH11+W8gFxtZXYcAJoQwM2yU4nKbhCzGLJoQ8qVWsezedE+CeF6F5wK/Vrry
    QP7pUjY+crkM2oRiH3eIn3DECli83usRmxS8LbjdWBtv2TTfNd8NDPH2uTPQ9cCZ
    GpGUSMlLNa0Q0lLKnM5V/gVo3n5OLtvl9BpI6qldXRzgKrolWgXkDJ9Uj6hjVP/j
    Z3ZPNy2VLnZtJHmV7TWRDgPTLc0zDVxAMfhSK4oOXK3acqPwM6Xh9IjrN56t/kQZ
    knmNhYjusYlriztAFslNA==
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
X-CM-Envelope: MS4wfCip5f7HrECb5x9NO6d+UmPR1fBTELGW3p4OY6GvhftAi8A1dfmWmLRuhIZ36ilLk8syQZmyyMPiHBzo+xnrLB2O0iYir+aOQRXSINY1D6t7tEjQx99H
    Ft0UbIFxcX0b2derJxl/Ne4Q7G+MQ/09C6ANjz4OPX/64zp3SqyHrSGpXHJlng2Nb2eb8CKYEqhec2FGPzwIK89A25thEdxoiIkNc0f03Pfa8sK7WGgV0NJu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=7d_E57ReAAAA:8
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=fz6hhV-ijj0hRcObFkMA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753523AbeC1Obo convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Mar 2018 10:31:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:37622 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeC1Obl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 10:31:41 -0400
Date: Wed, 28 Mar 2018 10:31:39 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
Message-ID: <991996685.2091.1522247499415.JavaMail.zimbra@efficios.com>
In-Reply-To: <777590253.2016.1522245960189.JavaMail.zimbra@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328064703.56hsuicmikejg7np@tardis> <777590253.2016.1522245960189.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: giprJFg0sw1tC1sJYpw5uUx6Rdd1NHz1S5NN
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 10:06 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Mar 28, 2018, at 2:47 AM, Boqun Feng boqun.feng@gmail.com wrote:
> 
>> On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
>> [...]
>>> Changes since v11:
>>> 
>>> - Replace task struct rseq_preempt, rseq_signal, and rseq_migrate
>>>   bool by u32 rseq_event_mask.
>> [...]
>>> @@ -979,6 +980,17 @@ struct task_struct {
>>>  	unsigned long			numa_pages_migrated;
>>>  #endif /* CONFIG_NUMA_BALANCING */
>>>  
>>> +#ifdef CONFIG_RSEQ
>>> +	struct rseq __user *rseq;
>>> +	u32 rseq_len;
>>> +	u32 rseq_sig;
>>> +	/*
>>> +	 * RmW on rseq_event_mask must be performed atomically
>>> +	 * with respect to preemption.
>>> +	 */
>>> +	unsigned long rseq_event_mask;
>> 
>> s/unsigned long/u32
> 
> good point, fixed.
> 

Actually, by having a u32 instead of unsigned long here, it triggers those
warnings:

In file included from ./include/linux/bitops.h:38:0,
                 from ./include/linux/kernel.h:11,
                 from certs/system_keyring.c:13:
./arch/x86/include/asm/bitops.h:73:1: note: expected ‘volatile long unsigned int *’ but argument is of type ‘u32 *’
 set_bit(long nr, volatile unsigned long *addr)
 ^

I suspect that casting the u32 * to a unsigned long * is not a safe approach, because
the code can generate a load/store on unallocated memory (kasan might complain).

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
