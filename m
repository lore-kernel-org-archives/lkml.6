Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-285901-1522177846-2-12857226588190406072
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
    t=1522177846; b=XnmOymhMvVjrRbBEIsf3ig1KcOs2vzt5GPv0n47eg8OtVtE
    6hcmU36Ppv51bG6iA1xLNTBjK4UYtMNl8GWFL4ExfuO++6Q9/ykDtlWKCkcZqJrB
    0Yooy9oQTAhSQ+ieWX+faz4BTzIjp6YUXJQ49V6/rsAkZTu64ihnLUhpAqi3rx+t
    v1Hn3k2m1w1t0DQGPSMAk8bl5cTkrOqYLlX3H9+Wc7uWjWN065Izl1aAX6JaugTn
    dvVzFI357z04dMt6ISkvB1CeIbaKv/PY0VJi3iiQksSYe7Iw5XqOCo2l3vWJMvdm
    G8OQRvaqAgih3VhkDMzFTANxC/UbgBRYmRI7Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522177846; bh=3r/nFTjWGjqUgy1lnFEl+yLtpq
    9FPh6mJuIaj6B0AtU=; b=ZO53cOmK1SlAy5hqQMmOLqovzhchGxyv76itdR2gSe
    NfZVjQmp0CQO1mClj6JPU7gFepD9TKe9LfmO2YPhMwvAC3NYSkVQAAVXEjYnUbe1
    U9IvOLx1jCbEj+VsC3q/bDL19zp1h1VQfN/Oi/aKY4vHXcBuUaEOXPsonPeFgek/
    UZeizADDKqCvsFbQYAGilDzfAQfE40ay+xmdphaFx1DNmymiq0PqK8Rr6oQwX3Qx
    2HojnOr5Qq3SWIgDSEdM1B48SQf9vidsviJgguIij8tKIsGs/XIF08LSLEjeS7JN
    4eZXQmW4vF0flVHZTptaBMztgM8iLbxm8WQ8QUmQ6MGA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=OsF5oQNl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=OsF5oQNl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJjYdezKFeWu1+v/3I5eEvX1XX1GdOkfurTnIK64lFcDdGo3SsyfmSE4Khu76Yke9yBYnNir/q33PoScbEabkS0Z0bq1syuCQEPfFkri1Xrvt2+gm6HQ
    e1nfDrJIFUk+Y/00LnkYperK/NSSAtFf3mCG9HKnqAh4p8oUjJLpTF0Kc9kJpAFMosp3UQmt5pZWhs7KjygZYvT1f5fnPYPvkLT0nVN8zhaur8h19p3lCXoo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=K41ZfkMPw36q9YXvzp0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751046AbeC0TKn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 15:10:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeC0TKm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 15:10:42 -0400
Date: Tue, 27 Mar 2018 21:09:25 +0200
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
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC PATCH for 4.17 00/21] Restartable sequences and CPU op
 vector
Message-ID: <20180327190925.GN4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 12:05:21PM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> I'm respinning this series for another RFC round. It is based on the
> v4.16-rc7 tag. I am now targeting the 4.17 merge window.

I'll go over the thing again in more detail, but I'm basically ok with
rseq, but I hate that cpu_opv thing with a passion (as you well know).
