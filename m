Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75188C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E37721534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LX03K84Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37721534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbeIUB7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:59:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:55632 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeIUB7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:59:30 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D02D2240D53;
        Thu, 20 Sep 2018 16:14:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id VMQGU6cY4IkF; Thu, 20 Sep 2018 16:14:17 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 632C5240D4F;
        Thu, 20 Sep 2018 16:14:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 632C5240D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537474457;
        bh=DLNd9uJlO5Zi7hCyclWW1GqemWcLa9Ms3SuhPklj/Gs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LX03K84ZLk2fxx961ha1C1ObtbqhHvZJDJwiEDOUwc0JvPik3xCGeZGhsOcS5HWTO
         JXX6Dn0IrkLnT2SPjvGGq2uR/Kk4fpypb4VrcKx9IQwAuZQgepEjmTczTBSKdrx3Af
         cEL0AeWkNmy3qSksvk44oBv+HVU23ZpSIy9tzATEvuthijulzJOYEFE75bnNrO0HVo
         mDnCu2O9mFpR/ezv282aZmHr2X8yQZ8MNbrYmCz/eQqM2/HW8tGeU4p6GMB/Pj7Bvn
         mQUZj7yUaiwDY+/jf3wcq508ocPgHKk6xe1109e0p415wVxno/KGxykzqsvy7dBQUN
         Bmkq+mZHfTKFg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id FbeHrp6lo8fn; Thu, 20 Sep 2018 16:14:17 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4B49A240D48;
        Thu, 20 Sep 2018 16:14:17 -0400 (EDT)
Date:   Thu, 20 Sep 2018 16:14:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <1619649568.9014.1537474457166.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1809191706090.26757@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk> <67473000.8399.1537375994645.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1809191706090.26757@digraph.polyomino.org.uk>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: tM1mCCVskfQXIsPWE9MXSeTmEFJDzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 19, 2018, at 1:10 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Wed, 19 Sep 2018, Mathieu Desnoyers wrote:
> 
>> > This looks like it's coming from the Linux kernel.  Can't the relevant
>> > uapi header just be used directly without copying into glibc (with due
>> > care to ensure that glibc still builds if the kernel headers used for the
>> > build are too old - you need such conditionals anyway if they don't define
>> > the relevant syscall number)?
>> 
>> This is indeed in the list of "things to consider" I've put in the patch
>> commit message. If the usual practice is to build against uapi kernel headers
>> outside of the glibc tree, I'm fine with that.
> 
> We build with, currently, 3.2 or later headers (since 3.2 is EOL there's a
> case for updating the minimum in glibc for both compile time and runtime,
> but I haven't proposed that since there isn't much cleanup that would
> enable and there's the open question of Carlos's proposal to eliminate the
> runtime check on the kernel version and just let things try to run anyway
> even if it's older than the configured minimum).

Are you saying glibc has an explicit check for the kernel version visible
from /proc before using specific features ? If so, how can this work with
the variety of feature backports we find in the distribution kernels out
there ?

Checking whether specific system calls return ENOSYS errors seems more
flexible.

> Functions depending on
> new syscalls may return ENOSYS errors if the headers used to build glibc
> were too old.  Since this patch is providing a data interface rather than
> functions that can set errno to ENOSYS, presumably you have some other way
> of signalling unavailability which would apply both with a too-old kernel
> at runtime and too-old headers at compile time.

For too-old kernel at runtime, having rseq registration return ENOSYS
leaves the the content of __rseq_abi->cpu_id at its initial value
(RSEQ_CPU_ID_UNINITIALIZED = -1).

For too-old headers at compile time, one possibility is that we don't event
expose the __rseq_abi TLS symbol. OTOH, if we need to keep exposing it anyway
for ABI consistency purposes, then we'd leave its cpu_id field at the initial
value (-1). But that would require that we copy linux/rseq.h into the glibc
source tree.

Thoughts ?

Thanks,

Mathieu

> 
> --
> Joseph S. Myers
> joseph@codesourcery.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
