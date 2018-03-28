Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2097833-1522236180-2-11095179833378817093
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
    t=1522236179; b=OKiwqA3+3ahHVdQX9mlSIiHsCVJwNfzqWtV5vDUOeJEWlHu
    iLwMHCjG17qZ/520XwrgrCACBXlxx9gL3iqK1sfJelACbhxu9knhmyxIJl/qKWew
    JgVe9DvsEkezR9tWOrgNhB/hjAPMxOjkacrQV1ZdDP8ni+3ofsYGWywCct4iBgo1
    tQHTkT7fWnYTZ+KlERloG3GTvO7Pd4/9BpTRR9DekePPgqaANAzZ8hl4OCuBpYav
    29Qn/fjQaNcsNMIOhojusn6RKcZ5xgMX9gpmG3kLx5HrBw5mWDT6QNdPUa7YgrUm
    TFiWcGzEvBqaM4xb2yUyfMTf/ahw6I4wn3LMW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522236179; bh=JUXZoZbg1lruUdHE++KJwJHaKK
    F9ApNaXfIMLrpmrZA=; b=DX1zMqJW29V9cMRFEF61WP3W0KyxmMC6AibPpj/wdz
    vKcmZ6Fi2LZ5dSrqaJ+kcQCk8FMRPsYaeYbBJ4dF5xX6yCq/lI+BrhY6tYREU9CN
    rIHq0g5nHsjNm2XnhV175wbrcPpyOEn2u2o1AvTAua7cCyss1Dvdnob4bsM74LMM
    xqKYfmn8AkRk34rFUIv06liYKw0ccRN3H7vz44CTpXVVUSHfhIXvdbE8vVZxduUt
    mzJ8OvNjhZwwjcHmUdpRHioXz3nlfX9z7KSs3ucE0gkZ19xmkJJOEeZb9Bs8j1Fn
    BJ4dfuRukwFrvcPVvyVH/Ot9xNCx1xqzrDrpgm5m+s9g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SByRa7E7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SByRa7E7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLA23KV46DyQfxOVBU43QkGQQLesYdeOU06hN2iCStFPFXf5uNvG7xwHNNLE4xLwEEL2cEUFDkHYN2eEyMg6Ce/TYZNRG3ueDO01Z67Zuos24K+Gj8j/
    dhoYb9vr77Y0F42KmWNshLqHDU1pTRl20k1u70M5eWU4BUx+m6KUupW0XPSPfnNI2NnsozGs/2OmHKueqi81Oa/T5AGlM/abg6WPhZ5XxXAs3kQLiHSCUMYk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=-DfrwTSxZ32i9PUAwxkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeC1LWs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 07:22:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeC1LWo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 07:22:44 -0400
Date: Wed, 28 Mar 2018 13:22:25 +0200
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
Message-ID: <20180328112225.GT4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
> +/*
> + * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
> + * contained within a single cache-line. It is usually declared as
> + * link-time constant data.
> + */
> +struct rseq_cs {
> +	/* Version of this structure. */
> +	uint32_t version;
> +	/* enum rseq_cs_flags */
> +	uint32_t flags;
> +	LINUX_FIELD_u32_u64(start_ip);
> +	/* Offset from start_ip. */
> +	LINUX_FIELD_u32_u64(post_commit_offset);
> +	LINUX_FIELD_u32_u64(abort_ip);
> +} __attribute__((aligned(4 * sizeof(uint64_t))));

What's with the uint32_t ? The normal Linux API type is __u32 afaik.
