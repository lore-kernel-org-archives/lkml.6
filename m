Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB2CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD04220820
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JGVYB5xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfAaQhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:37:11 -0500
Received: from mail.efficios.com ([167.114.142.138]:39648 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388493AbfAaQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:37:11 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 87841B8940;
        Thu, 31 Jan 2019 11:37:09 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ktlY2zq3mSRe; Thu, 31 Jan 2019 11:37:08 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ACB2AB8938;
        Thu, 31 Jan 2019 11:37:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ACB2AB8938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548952628;
        bh=MuyUdN5+9nCwqgF5JdlYlas8dNCA60Xn7ZDEGE162hY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JGVYB5xEkP4q4QMXl6qiqRDEFOTMRbDSt+Lcr9k7UOkAk1uFFcaeoZDlWv/R+VG4v
         mWTctBDZmqu9+yNz/SI9yondoE889+Qu8UhX6BKKwG2j1z3PHk50FQdQ6dj0fjniXP
         nQ1D7O4I9mD6H86n6bn3WcGAsydFUSoO0YVkxXjCjStxZkJeF04BgRhhVhnkx7MAJs
         djYMUVoDZQ72wystMmQvuNtM7HL+VFURuEogRgC8SCIcpdABl3TSiT5yKrhAPezna7
         aU6JkL//MVS3AO+kw+prVo84lRoNMa2/1Wp8Gow3ryY2WV4WeOUQmo9CO3k2JuKoQN
         pbyLNRZvCJFvQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id npWBaDQJqV7U; Thu, 31 Jan 2019 11:37:08 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8D809B8931;
        Thu, 31 Jan 2019 11:37:08 -0500 (EST)
Date:   Thu, 31 Jan 2019 11:37:08 -0500 (EST)
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
Message-ID: <19276261.499.1548952628477.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1901302104360.16754@digraph.polyomino.org.uk>
References: <20190121213530.23803-1-mathieu.desnoyers@efficios.com> <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901292153190.24454@digraph.polyomino.org.uk> <596949707.3888.1548812359874.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901300231210.24454@digraph.polyomino.org.uk> <1832200535.4162.1548871426959.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901302104360.16754@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v6)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v6)
Thread-Index: Ob38kFgOPgYUZJdpZaND7zVYh0vhHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 30, 2019, at 4:10 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Wed, 30 Jan 2019, Mathieu Desnoyers wrote:
> 
>> #if defined (__NR_rseq) && !defined (RSEQ_SIG)
>> # error "UAPI headers support rseq system call, but glibc does not define
>> RSEQ_SIG."
>> #endif
>> 
>> Would that take care of your concerns ?
> 
> That would of course need appropriate conditionals based on the most
> recent kernel version for which a given glibc version has been updated, so
> that using new kernel headers with an existing glibc release does not make
> the build fail (cf. the test of syscall-names.list).

The test I hint at above would not be for the glibc build per se. It would
be for a check that glibc implements support for all the system calls
available in the kernel headers (if such a test target currently exists).

> And being able to
> write such a test only solves one half of the problem - it needs to be
> easy to determine what value to put in that header in glibc for an
> architecture that's newly gained support in the kernel, *without* needing
> any architecture expertise.

I'm afraid this requirement is incompatible with the nature of the RSEQ
signature. This signature may be required to be a specific trap instruction
by the architecture, so deciding on its value without architecture expertise
is not possible.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
