Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA13C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93A208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IQMHkiHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B93A208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966460AbeFORoP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:44:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:50084 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965774AbeFORoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:44:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 13F8722B57F;
        Fri, 15 Jun 2018 13:44:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LUvfjFM0lhIE; Fri, 15 Jun 2018 13:44:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ACD7F22B57C;
        Fri, 15 Jun 2018 13:44:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ACD7F22B57C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529084651;
        bh=8LIXkrcNnNvC/ci3aa+clX2Eh+q62XhHuyvhklum/UY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IQMHkiHgC6Yqnp6lEL//T3rYXVHIiRFZk6y6dWYzuaGkFLd772SalhmX+BN1+o1OJ
         I9wawQdxcFO28go9WRYzTX0+Ot4JWGjJEdDrcTpuI1YwbRxNjHF0b9QHYkfWNielBy
         TB1jGwwNVSdJ/ZnOutnIvS+luwihN4YV8JmWT2oCb9rPa+O1W9giYwCUSDmX4Cx5qx
         ASu7cZwIzxZ5N9DxN6zs6X6DFv1nJOfLfYaQEud880eVxHGu6sh6DqgILS/UYVAceb
         UJlz3/ihT5bx6ZOu7tIEIYno3bK4JOCxmU7vmFnP0AToWW6N+K5VUOQMtQCoxUW11P
         M9O2vCzfO8M6g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 9M4QhlGDStib; Fri, 15 Jun 2018 13:44:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 97BBB22B575;
        Fri, 15 Jun 2018 13:44:11 -0400 (EDT)
Date:   Fri, 15 Jun 2018 13:44:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <1069078546.14418.1529084651587.JavaMail.zimbra@efficios.com>
In-Reply-To: <fffe36dd-a7f1-36fb-561b-b6a30ba9e11d@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com> <20180614122759.GB8798@amd> <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com> <20180614132557.GA15201@amd> <1110f198-88c2-544d-6836-f901b8e90f98@redhat.com> <1399480624.13011.1528984006717.JavaMail.zimbra@efficios.com> <fffe36dd-a7f1-36fb-561b-b6a30ba9e11d@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: vpZQClJITZWB/94iLaieeeaI9quhzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 15, 2018, at 1:10 AM, Florian Weimer fweimer@redhat.com wrote:

> On 06/14/2018 03:46 PM, Mathieu Desnoyers wrote:
>> This would allow registering various TLS data structures with a single
>> system call without hindering flexibility on the user-space side. For
>> instance, we could still use initial-exec and the __rseq_abi symbol for
>> rseq with this approach.
>> 
>> Thoughts ?
> 
> Isn't this just a very narrow case of the usual batched syscalls
> proposal? 8-)

Pretty much. But let's not go there unless this is really needed.
It looks like the added syscall on thread creation is not an issue
so far.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
