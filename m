Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF024C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D720871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WRQP9JCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790D720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933726AbeGIRR5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:17:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:51124 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeGIRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:17:56 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 08549231AEB;
        Mon,  9 Jul 2018 13:17:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id OpEo6Jsi5_JM; Mon,  9 Jul 2018 13:17:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7BDC6231AE1;
        Mon,  9 Jul 2018 13:17:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7BDC6231AE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531156674;
        bh=+s0mmtfzrXKCtC09XTqck3IzJStdW+du+ajJhpRQHEM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WRQP9JCPAx+RSjb4YE8v0W4Zpqu9jSD1LkyuoxrtRai/r6V5xtvx5XNbaLlUtP3i6
         jgxoiWH0HKA/AnaB2FLG2GKwIjt4bq0vCnKU7OTrT22dyMfU9b9QcYjHC2pC3gM4Ks
         k59kWT97vM8tptNwhHuB0MbefU/MiyP3bXl6pTfoVSN0BMFaPwwsoQGQKPdsFsloTk
         4bUwKmT8pxcKawogNU7HnkYnAXrCWsrhlEof82Rw8QTx0815JJkq8T11R5QUACs8k/
         Gq7WJeTFE4WcV4aQ62/RI/Nm6z+YTsn4KBaUZriYEgSMrZXsSvNmPiJtRA8vhF6u/s
         OHZUwEuSz1nlw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7rWf8BFKBNqo; Mon,  9 Jul 2018 13:17:54 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 66156231AD8;
        Mon,  9 Jul 2018 13:17:54 -0400 (EDT)
Date:   Mon, 9 Jul 2018 13:17:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        peter maydell <peter.maydell@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1187011512.2158.1531156674389.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180709165307.GB4689@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com> <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com> <20180709165307.GB4689@arm.com>
Subject: Re: [PATCH v2 0/3] Support rseq on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Support rseq on arm64
Thread-Index: qV/BqwAkP0lRf3NeEjDROZExUO8U/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 9, 2018, at 12:53 PM, Will Deacon will.deacon@arm.com wrote:

> On Mon, Jul 09, 2018 at 12:06:22PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon@arm.com wrote:
>> 
>> > Hello,
>> > 
>> > This is version two of the patches previously posted here:
>> > 
>> > http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon@arm.com
>> > 
>> > Changes since v1 include:
>> > 
>> >  * Move abort handler in-line to avoid possibility of it being
>> >    out-of-range for conditional branch instructions
>> > 
>> > I've tested both native and compat (little-endian only) with the selftests
>> > and they pass successfully on my Seattle box.
>> 
>> For the whole series:
>> 
>> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Thanks, Mathieu! Are you ok with me taking this via the arm64 tree for
> 4.19 once I have an Ack for the asm-generic change, or would you rather
> this went via somewhere else?

Adding Thomas Gleixner in CC. He has been picking up the rseq bits for
4.18. I've noticed it was rather easier to gather rseq stuff through a
single tree (less chances of confusion).

Also, support for additional architectures (e.g. MIPS) was added to rseq
after rc1. Is it too late to merge arm64 support targeting 4.18 ?

Thanks,

Mathieu

> 
> Cheers,
> 
> Will

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
