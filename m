Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2300974-1522241578-2-7882972688836953996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522241578; b=a2qD2ytXl1+GJ1VPmHSmrnPcH0qaoTDeBBItUo20nXzPZ32
    nkull32zLzUDvCx7L27JJSAlFVLfLu8Pv6HBfIAGu6znj/Pk//6SkutrrlxBiQsJ
    9BawGjGTxE4iZRoLG0GS7PuuTh08SRsAPbv1zlCtP4Cnc+jilF44oYs66TTUWphr
    1Usnz9OXO/1NXhV1zIqSNuX024T2BpuIp0HYlddIjV0GShJxGzpIoXBNHJei+VUt
    8VHRe2ihnTvmW7Q453/bjOEnbjgv6Jg5VvFsVw5/XRCDpbKvD7Cgj7G8GNnDe57B
    I2HRoBseypVeraNkCvu8U365lhi0aXiGZ7FyC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522241578; bh=frrwNPs07LlQo9Jpg1qeHaFZu/
    NVky7V3FNs4GVGc7k=; b=WSUtVavI4PBSUQiw2uuOXPL9vrpgkMujAZ/RSobSHD
    ZTbjvoHdbZm+ndNqn1GfCQvz2Euzz7uKy0ds7wn0Xa1t9vTW8xuPJQ6qXd66D54K
    gl0ihsNLMzxienqXefO4rji5B+NsTUXL9dayVWzhQbzNp4sT7Ib2HiCXDI0JUhLL
    DMlfKnKhhe+ya2/8uDdeKD+lzZi6Q/jGgg0wnp5IJJMsl6A05SCWUxo6oBpzd2uN
    9+869vYNnyPf16x2f05y5YvtJRYwlBnLrgiFo6MygKKMd76s8639oCQVtBBlKWD/
    aZ/o8sq9dHQzYQZNjRuSkF866dbhVT98zKSdhGd9/PDQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=BOZGjfq+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=BOZGjfq+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0wtyTtZ+wip41V/VS37kVZEpnWbO/pT1nGk7Ji2f1i5U6NADd5Mxh1+0oLWv8LNCTyXAj7lo7SPNzgm/Y3J/PJz3t3+uYErmSE3sPM80VtubjG8g3v
    /buVyKYJOCqYLCRWkXfNejeREbL2xHnPIcdXUfAYDkTC7AqB8tEJX1ADIxWO7ferDd0w3nwFihl2tU4l4wG90QZV25siY3+JdvFAGwWRvVWg0Bg2ZZmZHP/S
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=Reg5GAGNvJml2SIQJ44A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeC1Mwm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 08:52:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeC1Mwh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 08:52:37 -0400
Date: Wed, 28 Mar 2018 14:52:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Message-ID: <20180328125216.GF4129@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
 <20180328122946.GU4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328122946.GU4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 02:29:46PM +0200, Peter Zijlstra wrote:
> > +static int rseq_get_rseq_cs(struct task_struct *t,
> > +			    unsigned long *start_ip,
> > +			    unsigned long *post_commit_offset,
> > +			    unsigned long *abort_ip,
> > +			    uint32_t *cs_flags)
> > +{

> 
> > +
> > +	*cs_flags = rseq_cs.flags;
> > +	*start_ip = rseq_cs.start_ip;
> > +	*post_commit_offset = rseq_cs.post_commit_offset;
> > +	*abort_ip = rseq_cs.abort_ip;
> 
> Then this becomes a straight struct assignment.

I initially suggested passing a structure instead of many arguments, but
then recondidered, mostly because it will be inlined (due to having only
the one caller) anyway. Still, maybe a struct will work better, I dunno.


