Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-76056-1520332546-2-5583825278055105239
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
    t=1520332546; b=bcATGF4P93zQRikqu/8ZgZR0qMgO1hFWlP/aVri6aUFfH1X
    muDwSJZyX9+c7X1jqSbc29enFcfyRxT4FoHfBN8+dYxvZ3Zv0NjHVpgEkDGmSK9W
    XfYvCXcKHCMPuSO/JLUQn5TKKLcXyFGEsorzyKq6TG8AxYPKoyHpbqY+WHRD9B0K
    aiR6BjEeg4oIpNxrCWDqVDa4oNJfijQyfNuifKqrhNGSrYsbV/HrSdwdJXQ+tkoZ
    gu387bFPP118CcWk+KKtYS/R1X9t/nTNhfDBH/QWk3w23NtTCwbKEhG8ZTbSRhOn
    bfr0O/+EdtGsTY4FvVBqvZVZ8J8O2XA6BkXHjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520332546; bh=MdevHwXk84Gd6QYc4MVyZ9YeYM
    AX0Ungfm56/8v6fE0=; b=ALqtoMIC6hifa6mUEtqqPSw3bRUESyyo2OgSyzIFA6
    KRDQlKsddJkEAxhKavEPlHOGub68gYTTuxnmA2VnlryFIuHyFU6jFIi5IFlmxJQq
    vcCbFt6SpqpIA4bCOAsSzJNdl/JUrT/b9ArHr4af89QhbTPF0TJ+FE14i46ZO8fX
    XZoK1nxBiE4dL8400QdrgJEhNoxyN7EwxzeqUWdOoQ5PxsQ2ddJZ9g8Y4C+ZQNjQ
    RaGzUoY74rfkx7Ah0y9aYkN44D9rS3TVHbhO/PV6+0hDqxRwv/C83O0nT/SmXxaW
    AJMN7K6avwQBxslxQg3PdR6wnRY9+xHF4t2CJEzJcZTg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=D41ppkdt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=D41ppkdt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeCFKfo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 05:35:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKfn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 05:35:43 -0500
Date: Tue, 6 Mar 2018 11:35:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        torvalds@linux-foundation.org, mingo@kernel.org,
        rostedt@goodmis.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf, tracing: introduce bpf raw tracepoints
Message-ID: <20180306103531.GB25201@hirez.programming.kicks-ass.net>
References: <20180301041957.399230-1-ast@kernel.org>
 <9bb38939-c357-4db5-6cf4-7b42187f6c7c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb38939-c357-4db5-6cf4-7b42187f6c7c@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 02:36:07PM +0100, Daniel Borkmann wrote:
> On 03/01/2018 05:19 AM, Alexei Starovoitov wrote:
> > This patch set is a different way to address the pressing need to access
> > task_struct pointers in sched tracepoints from bpf programs.
> > 
> > The first approach simply added these pointers to sched tracepoints:
> > https://lkml.org/lkml/2017/12/14/753
> > which Peter nacked.
> > Few options were discussed and eventually the discussion converged on
> > doing bpf specific tracepoint_probe_register() probe functions.
> > Details here:
> > https://lkml.org/lkml/2017/12/20/929
> 
> Ping, Peter/Steven. If you have a chance, please review the series.

This series doesn't really touch anything I maintain, but the general
appraoch seems sane to me. I like the first patch that ensures
structures are passed by reference.

The rest is all tracepoint/bpf glue and I never really got into the bpf
internals, so I don't think I've got anything useful to say there.
