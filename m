Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C483D2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="K2lPJ3cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbfA3SDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:03:50 -0500
Received: from mail.efficios.com ([167.114.142.138]:55452 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfA3SDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:03:49 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 03DFC9E4A4;
        Wed, 30 Jan 2019 13:03:48 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id QuW9I1GAiEOH; Wed, 30 Jan 2019 13:03:47 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 30D8A9E49E;
        Wed, 30 Jan 2019 13:03:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 30D8A9E49E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548871427;
        bh=uUsDbd1WHpkZTr21/ymIBW3iMqvtmfAknPUj3BifJAQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=K2lPJ3cveLqkqF04BGQuRHsc8BL2nTHLLALg0/SocG6ldirCl5P7XsiW/zlel2PGf
         JlBobwjS8cnLS3CMM5Jr4rE9S5fsFkAkXUGvKOXAnUitXuuVUBCPiVAvs1H0N2Kt5o
         hgwhMFj7hHy5twiNpOoiWJwTrnssersK63GNl5X0HwQMYzZmvktX0v8ADDgydYm/YI
         KZBfI3HkwfRhiI1XaCt1CHxv87zcl/WqY8gEuwEf3cSJOKIVmh2ztvvgY7XwC5voKJ
         DssyMyAei26gxetBAqjZCj5JREuGp/JHwWx98dXW3lJfgx5isKVG4kgWvsrFL3BEO3
         bae3e7Rn1R5GQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id SyIbtafStXY1; Wed, 30 Jan 2019 13:03:47 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0F86B9E492;
        Wed, 30 Jan 2019 13:03:47 -0500 (EST)
Date:   Wed, 30 Jan 2019 13:03:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1832200535.4162.1548871426959.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1901300231210.24454@digraph.polyomino.org.uk>
References: <20190121213530.23803-1-mathieu.desnoyers@efficios.com> <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901292153190.24454@digraph.polyomino.org.uk> <596949707.3888.1548812359874.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901300231210.24454@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v6)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v6)
Thread-Index: sulJ8M5QtxdcyhSLifF52HPUsS3biA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 29, 2019, at 9:40 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Tue, 29 Jan 2019, Mathieu Desnoyers wrote:
> 
>> My thinking was to put the #error in the generic header, so architectures that
>> are not supported yet cannot build against rseq.h at all, so we don't end up
>> in a broken upgrade scenario. I'm open to alternative ways to do it though, as
>> long as we don't let not-yet-supported architectures build broken code.
> 
> Any case with #error in installed glibc headers needs special-casing in
> check-installed-headers.sh (and, thus, such errors are to be discouraged).

One alternative to #error would be to have an empty generic bits/rseq.h
that does _not_ define RSEQ_SIG. This way, it would be possible to
include sys/rseq.h from an architecture that does not define RSEQ_SIG
yet, but it would not cause any build failure. It's only if the code
try to use RSEQ_SIG that it would fail to compile because undefined.

> Cases where architectures commonly need their own bits/ headers,
> especially where those are likely to need updating for new kernel
> versions, are also discouraged.

The per-arch bits/rseq.h headers, once they define a specific value for
RSEQ_SIG, should never ever change that value.

> Furthermore, a normal check for glibc
> headers updates needed for a new kernel version would only involve
> examining uapi headers (and the non-uapi linux/socket.h for new address
> families, an unfortunate existing wart in this area).  As far as I can
> see, this value isn't defined in any uapi header, which makes it
> especially likely to be missed in such a check.  Furthermore, I'm hoping
> to add more glibc tests for consistency of such constants between glibc
> and the kernel, to ensure any such updates missing are caught
> automatically through test failures - but that doesn't work if the
> constants in question aren't in a uapi header.
> 
> If this constant were in a uapi header, the glibc header could just
> include that - is the issue that it's not actually an interface between
> glibc and the kernel at all, but some kind of purely-userspace interface?

The rseq uapi headers do not enforce the value of RSEQ_SIG. The role of the
kernel wrt signature is to receive it as sys_rseq argument, and then validate
that abort targets are prefixed with the signature before moving the
instruction pointer there.

Therefore, it's up to user-space to agree on the RSEQ_SIG value across
all code using rseq within a process. Since glibc will be registering
rseq and exposing public headers, it appears that glibc would be the
appropriate project to define the RSEQ_SIG value for each architecture.

> 
> We very definitely wish to keep to a minimum the cases where updates need
> to be done separately in glibc by each architecture maintainer (that's
> just a recipe for some updates getting missed accidentally) - meaning that
> there needs to be a clear way in which someone can tell, globally for all
> architectures, whether the set of such architecture-specific headers for
> this constant in glibc is complete and current, and when it needs updating
> (and this should be as similar to possible to such checks for any other
> header constant).

Currently, I use #ifdef __NR_rseq from uapi unistd.h to check whether the
kernel headers implement the rseq system call for the target architecture.

With the approach of having an empty bits/rseq.h for architecture not yet
supporting rseq in glibc, one way to check that glibc implements RSEQ_SIG
for all architectures that have the rseq system call wired up in uapi would
be:

#include <unistd.h>
#include <sys/rseq.h>

#if defined (__NR_rseq) && !defined (RSEQ_SIG)
# error "UAPI headers support rseq system call, but glibc does not define RSEQ_SIG."
#endif

Would that take care of your concerns ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
