Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13B65C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B8208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uSeA7nyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4B8208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965706AbeFNOgX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:36:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:45824 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965108AbeFNOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:36:19 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BFEF91AC96F;
        Thu, 14 Jun 2018 10:36:18 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id h-5uerIsT4if; Thu, 14 Jun 2018 10:36:18 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 757861AC96C;
        Thu, 14 Jun 2018 10:36:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 757861AC96C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528986978;
        bh=2So+3ljRdLSAwb69BSmH3Z+I95gnknoSzzwM8z7wSkU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uSeA7nyUVNcT7vH5wjYWgE3fnZa+hPb6qZ5zPvc4VdGdcBM8Wynx4HL5gNxRJNUYB
         lIGe/5TepIkUwugfMbptsb97yNLbv0EjBFo9xM2MTlsT4vcS1WwZmb8o2uVhiHRXIN
         iA4OzSgkC9AY5p2KrtXTZAT7szG11fxCFmBCgak354Bh1DzgUGemIQdCYZPV1C1+Ze
         JklNdaGvnYREbiKI+DTAdQKJkpymQcexAuVEikrHiBBpzCG3WKOyK81q7XOReBaRh8
         SJ+gLxQE94T5oVPql1w5P+GZF2DfrUxixfabKu0JiVtUY/OJbwqjSQjmXpAHixCA0v
         ebKICZjOQVZeA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id s2h6evubCwkS; Thu, 14 Jun 2018 10:36:18 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5F2111AC962;
        Thu, 14 Jun 2018 10:36:18 -0400 (EDT)
Date:   Thu, 14 Jun 2018 10:36:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <263666353.13077.1528986978282.JavaMail.zimbra@efficios.com>
In-Reply-To: <48a0d905-2568-51b8-80c9-a20ecaa25f9b@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com> <20180614122759.GB8798@amd> <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com> <20180614132557.GA15201@amd> <956816108.13001.1528983496098.JavaMail.zimbra@efficios.com> <20180614134959.GA4084@amd> <48a0d905-2568-51b8-80c9-a20ecaa25f9b@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: MjPvCH86nvU2YiJ9sNEdiK56YHV4+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2018, at 10:00 AM, Florian Weimer fweimer@redhat.com wrote:

> On 06/14/2018 03:49 PM, Pavel Machek wrote:
>> Hi!
>> 
>>>>> - rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RESUME thread
>>>>>    flag, so rseq_handle_notify_resume() can check whether it's in a rseq critical
>>>>>    section when returning to user-space,
>>>>> - rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume() checks
>>>>>    whether it's in a rseq critical section,
>>>>> - rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as well,
>>>>
>>>> Yes, this is not likely to be noticeable.
>>>>
>>>> But the proposal wanted to add a syscall to thread creation, right?
>>>> And I believe that may be noticeable.
>>>
>>> Fair point! Do we have a standard benchmark that would stress this ?
>> 
>> Web server performance benchmarks basically test clone() performance
>> in many cases.
> 
> Isn't that fork?  I expect that the rseq arena is inherited on fork and
> fork-type clone, otherwise it's going to be painful.

On fork or clone creating a new process, the rseq tls area is inherited
from the thread that does the fork syscall.

On creation of a new thread with clone, there is no such inheritance.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
