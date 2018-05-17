Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882526-1526549544-2-18256196443915893338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526549543; b=Z4kx+Eqh/C17BNLI5vK3RXxE+Gzqf9K/edcXy7+1FWGOegOyqn
    mIlIYFOtGZT8Df2M6ltMOYuXnJP4CZZjUv0K5DvuXhtyKXzfEibSGC3s9qiGLuXZ
    R0vP1waCsRKRa++85xk8dOYs2DlWq2FKyAKzbaoVPs/DHTIz67wGXwsqzMzRe4MT
    BeGlro7nFk0iX3wcDP3Vod/YZmrPp5nRL/iqKjaUTaqogoKd8lZpp7O5YgqioCrm
    mmiOioB0kgyk9eorIuDkinE75lTeJyHy9dso2QYMt0KyshkHaH6yK/RXSPnVpATD
    LFeFATX+8Yb+LaG50p7WfCG20Y6vLUqhtkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526549543; bh=1ftq0LD9Di1ZeHLJEGo3THVP5J5upm
    ScXBYjOegZ970=; b=ac5b0mlgDTl3Ln0spyPU4p29EVQHTqgibABi+jepT3L25M
    yUmxw036ujyAqYcuNKaEIGp3C7RyL+O+/1ezwCyBh1qXc/mGbyOY7d0jisqr/Em7
    Dh+FJgHWaYdfbdRxHspvIYn+4lwSqq5SSF9knULlGkqJVWqtS0A5nLVX1RH7sBfW
    6roTmhpkNfAvYNSxXL9773rYJe+hlJEElt3kWHDufFh8DY9fl1tQG+qsrKHIobiG
    iwPl5sSleYkO3LEO6k4fIoFXz2JTMm0beIwRDlPy3UvFROMlpLiS9dMic3tyF1Ek
    bxaCFrJw8RcYwE5FeHuE1TlMCDSJTP5VQTUjRAeA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=x5lHMkHZ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=x5lHMkHZ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAuuuf5eDst1jnI9ky+4iM+oAIZC6515DaauwQDXAf4z2/wlqxDfdoUgFcVfnSIZLjvXjhm17JEpiy4nKxXcdfD4n6bY9ptyVeWJPsohkJIGZysFZupR
    BkDlaAwugQLbX+5xevyReW5BN40ZaUSppOJhL48wKJU5CUict/ZgvQGQ4ixAXTx03LZWKnkb/lFbRF7BSiDKVaMz335jHd7IRidLIUDHphVUgP8bUZopxEbI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=lZ6kzMzFitiRADRsB-oA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeEQJcU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:32:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeEQJcS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 05:32:18 -0400
Date: Thu, 17 May 2018 11:32:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, viresh.kumar@linaro.org,
        tglx@linutronix.de, efault@gmx.de, juri.lelli@redhat.com,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] sched/rt: fix call to cpufreq_update_util
Message-ID: <20180517093206.GP12235@hirez.programming.kicks-ass.net>
References: <1526541403-16380-1-git-send-email-vincent.guittot@linaro.org>
 <20180517090530.GO12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517090530.GO12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 11:05:30AM +0200, Peter Zijlstra wrote:
> Hurm.. I think this is also wrong. See how dequeue_rt_stack() is also
> called from the enqueue path. Also, nothing calls cpufreq_update_util()
> on the throttle path now.
> 
> And talking about throttle; I think we wanted to check rt_queued in that
> case.

Bah, clearly you also want to update on unthrottle.. but I think there's
more buggered wrt throtteling.
