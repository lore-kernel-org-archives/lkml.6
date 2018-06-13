Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06E1BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01B4208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TCXmlJj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01B4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935584AbeFMTxl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:53:41 -0400
Received: from mail.efficios.com ([167.114.142.138]:43412 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935206AbeFMTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:53:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6BB7622A902;
        Wed, 13 Jun 2018 15:53:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id U3iqaLrO-PSA; Wed, 13 Jun 2018 15:53:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0A3F522A8FF;
        Wed, 13 Jun 2018 15:53:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0A3F522A8FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528919619;
        bh=yd/eeBmKIprsrTxSBO5JeaYBDaAjWghXodKUtL+RhIw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=TCXmlJj3Ta0gUj3y0wgLFrNUa6Hvq8IVq8pXy/Ewha11h1kDrl14uZpydU3YnRxMv
         nnsuQy3ad7TEGs1qe1LdKvwcctO9nusuX1U7qgvptzHLwpxWuKWFnLAsYd7yS/YLMJ
         rByUqhymT7I0RUnoho+rzTy5UgcudtFLCHvz+xaZ2JdVDCN159unyostnT8KGzLlNk
         PulT8kvnSr7a7NRbHcI8Lz6EeEcwQguEazVYD67vpQq2OsEtBEM9G52dSLSJeMnFFv
         Bau6BkqnRWtqMA5vjrlll18FRKkWF7uiDfTtAnfaPJc+xSFWbvvJIWZXYa9TIbTe67
         MBkG+yXZ49zWA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7A0e2L4c-NyH; Wed, 13 Jun 2018 15:53:38 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E8B5922A8F8;
        Wed, 13 Jun 2018 15:53:38 -0400 (EDT)
Date:   Wed, 13 Jun 2018 15:53:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     heiko carstens <heiko.carstens@de.ibm.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <410804326.12703.1528919618748.JavaMail.zimbra@efficios.com>
In-Reply-To: <1904010978.12481.1528906458944.JavaMail.zimbra@efficios.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <20180613114811.GC4342@osiris> <1904010978.12481.1528906458944.JavaMail.zimbra@efficios.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: 03097Zs90n0PWzBVhsrdocLBo0GNP4y7Ih5R
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 13, 2018, at 12:14 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jun 13, 2018, at 7:48 AM, heiko carstens heiko.carstens@de.ibm.com
> wrote:
[...]
>> 
>> Is there any documentation available of what is the exact semantics of the
>> functions that have to be implemented for additional architectures?
> 
> It's documented on top of kernel/rseq.c:
> 

[...]

> 
> The first architecture implemented was rseq-x86.h. Boqun derived rseq-ppc.h
> from it, and I derived rseq-arm.h from it. Feel free to start from whichever
> architecture has the instruction set which is most similar to yours.

One more thing: adding full support for your architecture to the rseq selftests
also requires to extend tools/testing/selftests/rseq/param_test.c to implement
the RSEQ_INJECT_INPUT, INJECT_ASM_REG, RSEQ_INJECT_CLOBBER and RSEQ_INJECT_ASM
macros for your architecture. Those are simply defining the inline asm operands
and assembly code needed to inject delay loops within the rseq critical sections,
which greatly facilitates testing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
