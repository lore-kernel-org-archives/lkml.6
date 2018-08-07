Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5EF21987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZbIdM6L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5EF21987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeHHAjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:39:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:35400 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeHHAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:39:15 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 22CB9238CF7;
        Tue,  7 Aug 2018 18:22:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id FxEfqq6g4DCd; Tue,  7 Aug 2018 18:22:42 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4CCDE238CF4;
        Tue,  7 Aug 2018 18:22:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4CCDE238CF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1533680562;
        bh=mxFg3A7hUcY/XmaQ7QkY7n0L8dWpc+D4m/2jWHdL63U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZbIdM6L2lVUH/EdVAG47zQDMoqNAaZuXNmCQP0sZsnJGyVwMRlL1ydn2H8o1vw83n
         EAT9LPIczUsan6Vv5+tG161kvTtYjVZdSZ61WRdpWVgzbrh61PUiSkb8JTy5nHClkU
         8XMvvYCd31Pj/+24fVBY2Y7ZC/8DhMAfGhtrxB/EZAwVNPLmLDraI56t3QEZhcEBaL
         Tm5ZVSleoA5kjjASfC12MxKbLAC3YuwNWebbohn4DDcTy3iVKqALYD1ZIRp89z850V
         Y/KsoC/Dr/4tjI0jnZ5Bpzg4PMEcvWTv9q6GZAMIkI3N8VuJoM635eUwEweA6EwwqP
         ZloBAEz//USow==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Ya-tUWzruBJl; Tue,  7 Aug 2018 18:22:42 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 34A46238CED;
        Tue,  7 Aug 2018 18:22:42 -0400 (EDT)
Date:   Tue, 7 Aug 2018 18:22:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     gor <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1178149993.10208.1533680561904.JavaMail.zimbra@efficios.com>
In-Reply-To: <cover.thread-5c3a1c.your-ad-here.call-01533555685-ext-8699@work.hours>
References: <cover.thread-5c3a1c.your-ad-here.call-01533555685-ext-8699@work.hours>
Subject: Re: [PATCH 0/1] rseq/selftests: add __rseq_abi misalignment check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_2055 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_2055)
Thread-Topic: rseq/selftests: add __rseq_abi misalignment check
Thread-Index: 0yARQxuK9A/6exDzFDG4cc57QxVFwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 6, 2018, at 7:47 AM, gor gor@linux.ibm.com wrote:

> While implementing rseq selftest for s390 a glibc problem with tls
> variables alignment has been discovered. It turned out to be a general
> problem affecting several architectures. The bug opened for this problem:
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=23403
> 
> There is no fix yet. On s390 __rseq_abi ends up aligned to 0x10 instead
> of 0x20 which makes rseq selftest fail every time.
> 
> The change proposed adds __rseq_abi misalignment check, produces user
> friendly message and skips the test.

That's a very unfortunate situation. I'm concerned about adding glibc-specific
error messages in rseq selftests though. I'm curious to hear what others think
about this.

I would have thought simply improving rseq registration error handling from
having the test program return nonzero to add a perror() in there would be
a more generic way to handle this.

Regarding the message printed by your check: "you need a fixed version of glibc to
run this test". I disagree with it. Someone can effectively run the test on
a bogus glibc and it serves its purpose: it reports that glibc is buggy.

I would understand adding this kind of test in an user-facing application or
library to detect bogus glibc (in fact I've used similar approaches in lttng-ust
to detect bogus compilers), but why add this to skip a selftest program, which
sole purpose is to test the stack underneath it ?

Thanks,

Mathieu

> 
> Vasily Gorbik (1):
>  rseq/selftests: add __rseq_abi misalignment check
> 
> tools/testing/selftests/rseq/rseq.c           | 19 +++++++++++++++++++
> .../testing/selftests/rseq/run_param_test.sh  |  4 ++--
> 2 files changed, 21 insertions(+), 2 deletions(-)
> 
> --
> 2.18.0.13.gd42ae10

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
