Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2532849-1522249420-2-11056647701470183256
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
    t=1522249417; b=RaIFu1jRDCDb/DczUeHREXCPM2Bc7k1FIf9SrKgu5d6YlSY
    k5jq53+vYH8dI0jnhfjFvNCxV1YLZZW0cNCe3GBj8k+Ry7M4RYDneaXeqlK6xhiG
    L2h2fI5o2I4AFemgfpS/n17gLi2MvaRr3RiRGiODZpFrGI1JvMsNZM06eTDElEB5
    5b5RzeHUcvixOIV5dv0/DdttmOGEBXDF7gQfOlSnOTrmw5MJAGMhVurJo3elecVf
    0j+xEE72kg8mxFJWsTCReEa4A3NPY6/8+hv28slCrIf5/Nczr9ZIXmVqBGjpMU9P
    qa21qIDs5bxh0Yltb474XyN85UDFk23tjDKEx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522249417; bh=REc7tMVNv3w8JSR8op/AKAR7E849wcFIlPm+EPZc3eg=; b=b
    yGKIDLZs8+N9bD0I7KBtY6y4+sQkBulG7DNYDr5WCd9RlRipUi4yhB5yKoIvFDw3
    q3tGYTM3oRL29BcbSgztze7I/5tzkYOyJU8r8pe0G/6i0ocQbTRA4g+bHZQmavFb
    6/conrjnF3ArlwbT8LihQ3c/efEXU2FhLTnTltW1lB8t8Y3agd3KUJk2nMGq6aJ1
    mv/OyzvVtAFKWzVMaknva7leo1uf0isicu+Fs2gu9jQL8focGUcz+GrPDMb3mbb+
    koATVFQ+zIItKsaIs9mojf8qxjqgHgURG/9WUJKMMp8zaQlCJK8ZMf9YJXb1G8iE
    zWWAkcxRqP2e6KaxNAB6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfAfATaRDAC2PX6AOUGU8VHrH/wUmkpv+SU3STumisoD/FHEiCDk9VSZrhklHKZ53b/JXdlF7xGyYK+71nrXQRPqHIo3ISeYSx7veI/t3MajDyN3YYzXf
    O/CAPndoB4sVQU5TIvrdSLCDwZfrJ7AG+cQT5Qx5O1IXXLA/+CCc/SPhERkOFzxyU84tOpLpbKMMnES+i3pja7SzcQiyxLVT23OWSR/FWNTd3h5y2ZOZRxzv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=lPh2HEaMl50ZQ_9VVY8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeC1PDf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:03:35 -0400
Received: from mail.efficios.com ([167.114.142.138]:39190 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeC1PDe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 11:03:34 -0400
Date: Wed, 28 Mar 2018 11:03:33 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
Message-ID: <49066300.2176.1522249413336.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328125216.GF4129@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328122946.GU4043@hirez.programming.kicks-ass.net> <20180328125216.GF4129@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: 8pO+aFtj8q0XB7AMrsQCaF2stdX26A==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 8:52 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Mar 28, 2018 at 02:29:46PM +0200, Peter Zijlstra wrote:
>> > +static int rseq_get_rseq_cs(struct task_struct *t,
>> > +			    unsigned long *start_ip,
>> > +			    unsigned long *post_commit_offset,
>> > +			    unsigned long *abort_ip,
>> > +			    uint32_t *cs_flags)
>> > +{
> 
>> 
>> > +
>> > +	*cs_flags = rseq_cs.flags;
>> > +	*start_ip = rseq_cs.start_ip;
>> > +	*post_commit_offset = rseq_cs.post_commit_offset;
>> > +	*abort_ip = rseq_cs.abort_ip;
>> 
>> Then this becomes a straight struct assignment.
> 
> I initially suggested passing a structure instead of many arguments, but
> then recondidered, mostly because it will be inlined (due to having only
> the one caller) anyway. Still, maybe a struct will work better, I dunno.

I find the result of struct pointer argument cleaner indeed. I'll go for that
approach.

I'll memset rseq_cs to 0 in the following case though, because the caller
expects the content of the structure to be set when rseq_get_rseq_cs() succeeds.

static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
{
        struct rseq_cs __user *urseq_cs;
        unsigned long ptr;
        u32 __user *usig;
        u32 sig;
        int ret;

        ret = __get_user(ptr, &t->rseq->rseq_cs);
        if (ret)
                return ret;
        if (!ptr) {
                memset(rseq_cs, 0, sizeof(*rseq_cs));
                return 0;
        }

[...]

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
