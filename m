Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F468C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516BF20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RlhlTkPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516BF20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeKCAko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:40:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:54552 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:40:44 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 60F63238983;
        Fri,  2 Nov 2018 11:33:15 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id lSSCUvp35teg; Fri,  2 Nov 2018 11:33:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C4604238980;
        Fri,  2 Nov 2018 11:33:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C4604238980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541172794;
        bh=l2u2aEDIyckpCLSwkKofB5l1GyyNvORkoByDMOObBD8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RlhlTkPnO/UHE/ZWJ5l2HWl13z/Kv9zTS5rhbjJPA/IWorhiYoRsgw8OC3r5ayU0p
         0t9CnAkwLzu2t/bPnxWis8cLn70/2gSiaubO0Op2/yoWallG8kO6xK1Hadz/tPJ1mQ
         v4FsAznivWHLzUmNdTSxt4bhX18eF75/qJFfTVOEafI5HpDOTEs/6iGxGTLdM/QrCy
         PI0l/EhNs2BwJIfCowqFllo0Io5a0i/8CnuWhjSZ9YNZP34eTqJAlEkvWwKB5GdwHj
         RUYkTC3IKtdosIand6zoKkCFpwsAYHZv1HI9pwZrqpmGgHyCN5kFyjCvIViG25AM04
         ZUfH6ZAKnEx8g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fXq2aTEBbNYM; Fri,  2 Nov 2018 11:33:14 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A52B6238972;
        Fri,  2 Nov 2018 11:33:14 -0400 (EDT)
Date:   Fri, 2 Nov 2018 11:33:14 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     libc-alpha <libc-alpha@sourceware.org>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1563326093.34.1541172794537.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrWG4j7R7jzuoPW6ifYVzwuQGMEHBp7Pb_k66_2hn1wUHg@mail.gmail.com>
References: <20181102115259.11383-1-mathieu.desnoyers@efficios.com> <CALCETrWG4j7R7jzuoPW6ifYVzwuQGMEHBp7Pb_k66_2hn1wUHg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] glibc: Perform rseq(2) registration at nptl
 init and thread creation (v3)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation (v3)
Thread-Index: cuSXnMD5lxR2dOHBtiUiNw7Wk9xNFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 2, 2018, at 4:20 PM, Andy Lutomirski luto@amacapital.net wrote:

> On Fri, Nov 2, 2018 at 4:53 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Here is a third round of prototype registering rseq(2) TLS for each
>> thread (including main), and unregistering for each thread (excluding
>> main). "rseq" stands for Restartable Sequences.
>>
>> Remaining open questions:
>>
>> - How early do we want to register rseq and how late do we want to
>>   unregister it ? It's important to consider if we expect rseq to
>>   be used by the memory allocator and within destructor callbacks.
>>   However, we want to be sure the TLS (__thread) area is properly
>>   allocated across its entire use by rseq.
>>
>> - We do not need an atomic increment/decrement for the refcount per
>>   se. Just being atomic with respect to the current thread (and nested
>>   signals) would be enough. What is the proper API to use there ?
>>
>> See the rseq(2) man page proposed here:
>>   https://lkml.org/lkml/2018/9/19/647
>>
> 
> Merely having rseq registered carries some small but nonzero overhead,
> right?

There is indeed a small overhead at thread creation/exit (total of 2
system calls) and one system call in nptl init. Once registered, there
is very small, infrequent, a hard to measure overhead at thread preemption
and signal delivery.

> Should this perhaps live in a librseq.so or similar (possibly
> built as part of libc) to avoid the overhead for programs that don't
> use it?

My second patch modifies sched_getcpu() to use rseq. Another use-case
glibc guys want is to use rseq for malloc(). Once that is done, there
will be pretty much no program left using glibc facilities that won't
use rseq when available.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
