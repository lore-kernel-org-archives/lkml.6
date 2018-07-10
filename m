Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19372C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88F8208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B/81kgN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88F8208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbeGJOvR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:51:17 -0400
Received: from mail.efficios.com ([167.114.142.138]:43612 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933248AbeGJOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:51:16 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B60D423291E;
        Tue, 10 Jul 2018 10:51:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2p9DwOWowcO4; Tue, 10 Jul 2018 10:51:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4515223291B;
        Tue, 10 Jul 2018 10:51:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4515223291B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531234273;
        bh=ODic+Lg+0ChzzV47acBOkHsASv1d2OnG7NruxF01/Bo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=B/81kgN7tD9FHh46BV9yCJWuhnvtDCMwcshI6ZWZfGcdDwuyWRwGoENFRksv+aVlr
         9TEStH+3OGlIQ+YRV3zZt7w87IldfO97U6Elp0exxK+Bm9msk84hN+aDRqsmrQUs32
         H0T+Dyl4fs9UibXKz8vD2O0e48ImTi/ovsOxfidJpjKwqjOu1JbrjxR7x0AsHWWoWg
         0//SOIqXUY5Ul2EZcU39SUE4gTp7poTi05y15qXoT3Dj4kcR2Yz8XU6F+ySJ5Y4Mg7
         s9k8YbI0l/LfpCAvEUOCr6ptH+PvfTbVrhxizKA3YYFkHXThH8ttV0tQmyiGZez9IO
         pQKehtN0JdpPg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Hr0YmVbxxmSa; Tue, 10 Jul 2018 10:51:13 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2EE20232911;
        Tue, 10 Jul 2018 10:51:13 -0400 (EDT)
Date:   Tue, 10 Jul 2018 10:51:13 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        peter maydell <peter.maydell@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <745627929.3050.1531234273058.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180710144907.GD9022@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com> <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com> <20180709165307.GB4689@arm.com> <1187011512.2158.1531156674389.JavaMail.zimbra@efficios.com> <20180710144907.GD9022@arm.com>
Subject: Re: [PATCH v2 0/3] Support rseq on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Support rseq on arm64
Thread-Index: GpPfAc5cZ9szojz/dzMaGMxuhyo3rw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 10, 2018, at 10:49 AM, Will Deacon will.deacon@arm.com wrote:

> On Mon, Jul 09, 2018 at 01:17:54PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 9, 2018, at 12:53 PM, Will Deacon will.deacon@arm.com wrote:
>> 
>> > On Mon, Jul 09, 2018 at 12:06:22PM -0400, Mathieu Desnoyers wrote:
>> >> ----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon@arm.com wrote:
>> >> 
>> >> > Hello,
>> >> > 
>> >> > This is version two of the patches previously posted here:
>> >> > 
>> >> > http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon@arm.com
>> >> > 
>> >> > Changes since v1 include:
>> >> > 
>> >> >  * Move abort handler in-line to avoid possibility of it being
>> >> >    out-of-range for conditional branch instructions
>> >> > 
>> >> > I've tested both native and compat (little-endian only) with the selftests
>> >> > and they pass successfully on my Seattle box.
>> >> 
>> >> For the whole series:
>> >> 
>> >> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > 
>> > Thanks, Mathieu! Are you ok with me taking this via the arm64 tree for
>> > 4.19 once I have an Ack for the asm-generic change, or would you rather
>> > this went via somewhere else?
>> 
>> Adding Thomas Gleixner in CC. He has been picking up the rseq bits for
>> 4.18. I've noticed it was rather easier to gather rseq stuff through a
>> single tree (less chances of confusion).
> 
> Whilst I can see that making some sense for the selftests (particularly
> if the ABI is liable to further changes before 4.18 is released), I'd
> prefer to take the arm64 bits via the arm64 tree, as they will conflict
> with some ongoing work to rewrite the syscall entry path in C which I
> plan to queue in the next week (pending final testing results).

Considering this, indeed going through the arm64 tree seems like the right
approach.

> 
>> Also, support for additional architectures (e.g. MIPS) was added to rseq
>> after rc1. Is it too late to merge arm64 support targeting 4.18 ?
> 
> Personally, I don't see the rush, but I won't stop anybody who wants to
> try steam-rollering them into mainline ;)

There is indeed no rush. 4.19 it is then.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
