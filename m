Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01158C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBFE21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cRfiObYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfA3BjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:39:23 -0500
Received: from mail.efficios.com ([167.114.142.138]:46924 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfA3BjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:39:22 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 01E391337E8;
        Tue, 29 Jan 2019 20:39:21 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id V9dOi7CdkeQr; Tue, 29 Jan 2019 20:39:20 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 111061337E1;
        Tue, 29 Jan 2019 20:39:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 111061337E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548812360;
        bh=I/++G+q197RJlGE/Cz5ygFnPD1AcWebX468LQ6HvJhE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cRfiObYi2+pPQL+B7lm3NAMxX3x+R8UH0hIDgI03JLbCBc8SDYvAPXWbokTtXH9Sc
         vuYTeFjIvwxblBR1WW341WV/IRyL0eqC99OxqrDcXdpXuVRV2WHhauozrcpqM4YsGQ
         e0aKhg/dlMvsbgqwr54HDFVHFhJVWgMqoJHJ3e09UPudcBvPNzdTyL7Pa6R+CwIeGP
         0tI3lknjzdCgaH5t40zu5BUz4ecVhMIGJTvvM+66Xpy9lYBDnt/2oHQeONO+VZEwzd
         wIRpRZxw7hvyVkYzkvjiSVWQk27eZAZqyyVh/VWxsJ7aRunUTGz2WnMc2H66xbFvfX
         kAvq4kP059Row==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id o8q8gvLYSUdQ; Tue, 29 Jan 2019 20:39:19 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E6FBA1337D6;
        Tue, 29 Jan 2019 20:39:19 -0500 (EST)
Date:   Tue, 29 Jan 2019 20:39:19 -0500 (EST)
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
Message-ID: <596949707.3888.1548812359874.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1901292153190.24454@digraph.polyomino.org.uk>
References: <20190121213530.23803-1-mathieu.desnoyers@efficios.com> <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901292153190.24454@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v6)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v6)
Thread-Index: 5DMoXo/hM2dRK1xrzqbpeCcPJF27ag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 29, 2019, at 4:56 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Tue, 29 Jan 2019, Mathieu Desnoyers wrote:
> 
>> I recalled that aarch64 defines RSEQ_SIG to a different value which maps to
>> a valid trap instruction. So I plan to move the RSEQ_SIG define to per-arch
>> headers like this:
>> 
>>  sysdeps/unix/sysv/linux/aarch64/bits/rseq.h                  |   24 ++
>>  sysdeps/unix/sysv/linux/arm/bits/rseq.h                      |   24 ++
>>  sysdeps/unix/sysv/linux/bits/rseq.h                          |   23 ++
>>  sysdeps/unix/sysv/linux/mips/bits/rseq.h                     |   24 ++
>>  sysdeps/unix/sysv/linux/powerpc/bits/rseq.h                  |   24 ++
>>  sysdeps/unix/sysv/linux/s390/bits/rseq.h                     |   24 ++
>>  sysdeps/unix/sysv/linux/x86/bits/rseq.h                      |   24 ++
>> 
>> where "bits/rseq.h" contains a #error:
>> 
>> # error "Architecture does not define RSEQ_SIG.
>> 
>> sys/rseq.h will now include <bits/rseq.h>.
> 
> We're trying to reduce the number of cases where most or all new glibc
> architecture ports need to provide a bits/ header, by making the generic
> headers handle the common case.  So a generic header with a #error, and
> lots of architecture-specific headers mostly with the same value for
> RSEQ_SIG, seems unfortunate.  I'd hope the generic header could use a
> generic value, with architecture-specific variants only for architectures
> with some reason for a different value.

The issue here is that it would require us to decide right away what RSEQ_SIG
is appropriate for all other Linux architectures supported by glibc. There are
a few reasons for which an architecture can be required to specify its own
RSEQ_SIG. For instance, it may need to map to an instruction defined in the
instruction set, thus ensuring objdump does not get confused, and in other
cases that the processor speculative execution happening just before the
RSEQ_SIG really stops at the signature (hence the trap instruction on aarch64).

I'm worried that if we introduce a "default" RSEQ_SIG value for architectures
currently not supported by RSEQ and we then introduce an architecture-specific
signature value in the future, some applications will try to build with
wrong signatures, and when the rseq system call gets eventually implemented for
those architecture and a end-user upgrades his kernel, those signatures won't
match between glibc rseq registration and the application rseq abort handlers,
thus leading to hard-to-reproduce segmentation faults delivered by the kernel
checking those signatures upon rseq abort.

This upgrade story is far from ideal.

My thinking was to put the #error in the generic header, so architectures that
are not supported yet cannot build against rseq.h at all, so we don't end up
in a broken upgrade scenario. I'm open to alternative ways to do it though, as
long as we don't let not-yet-supported architectures build broken code.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
