Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C93ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81D2208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gBCsQQB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81D2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeITBua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:50:30 -0400
Received: from mail.efficios.com ([167.114.142.138]:35962 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbeITBu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:50:29 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 01C3523EC63;
        Wed, 19 Sep 2018 16:10:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 8Wzw04EIz5MX; Wed, 19 Sep 2018 16:10:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2AA5923EC60;
        Wed, 19 Sep 2018 16:10:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2AA5923EC60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537387855;
        bh=wJezRLpvAQ8GjIAwhix5UZkF+lLcjAAdYEmpM9gNrLY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gBCsQQB33K/dxz9IwVM8LyTRA0TabQs5ceU41Cs2DGncWwX9xcBz5b96iQSqYEjiA
         XDNUufPe34rB21gbA43MDuXfiA3y3gBDYGyVgfQLcU1aJ70JDD14vZwIKenXDvukov
         sUFhEL9U+Y3IoEyrI0/CIqfQJwgCZGUOcvGQS0h1PbZ7ni2nmS0sbjqMzIw0T/bg1z
         rR2wW2BcnU0qEGVeMACY5hRTGezGECbgG1oIotJmw/eHPLPmytUBmAPTkofoH7Aj4p
         PQaggsGwlr66thnpQlVF5n0fl8ucDrEXgvdRCAT27wGtqNn6B/w7f4jOnvW28Q1E2X
         5Oywr29QDj24g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PdbR3cA4F3NV; Wed, 19 Sep 2018 16:10:55 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0FEDD23EC56;
        Wed, 19 Sep 2018 16:10:55 -0400 (EDT)
Date:   Wed, 19 Sep 2018 16:10:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <466724077.8623.1537387854947.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1809191944470.4536@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@arm.com> <alpine.DEB.2.21.1809191944470.4536@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: vItvTcgLizgp+BKg6lEwR5/B4jo/yw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 19, 2018, at 3:49 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Wed, 19 Sep 2018, Szabolcs Nagy wrote:
> 
>> i don't think there is precedent for exposing tls symbol in glibc
>> (e.g. errno is exposed via __errno_location function) so there
>> might be issues with this (but i don't have immediate concerns).
> 
> There have been suggestions to expose TLS errno - but also suggestions
> that use of __errno_location is more efficient, at least in terms of code
> size everywhere errno is accessed (for some ABIs, anyway).

AFAIU, the trade-off is different between the errno use-case and the
rseq use-case.

If my understanding is correct, errno is not supposed to be used in
fast-paths, only when an error is returned. So size is more important than
speed there.

Comparatively, rseq is _meant_ to speed up fast-paths. A per-cpu statistics
counter can be incremented in 2ns with rseq on a Intel E5-2630, which is faster
than a simple function call.

So for rseq, we should favor speed over space, which means the user applications
and libraries would need access to the TLS symbol without requiring an
accessor function. That's also why I'm using the initial-exec tls model
rather than the global-dynamic: I want to make sure no function call is
generated there.

> The ABI tests have code that would list .tbss symbols as "T" in ABI test
> baselines, but no existing ABI baselines use that.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
