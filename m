Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345C8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C149D20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Val5gFSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C149D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeGIQG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:06:26 -0400
Received: from mail.efficios.com ([167.114.142.138]:46388 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGIQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:25 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9313E2318D4;
        Mon,  9 Jul 2018 12:06:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Rsv3FZF3FSig; Mon,  9 Jul 2018 12:06:23 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0C9E92318CE;
        Mon,  9 Jul 2018 12:06:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0C9E92318CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531152383;
        bh=SKGJl0AzRGShMx9Ig2abLl2LxOz/GOWrwIJMA6dV+ZQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Val5gFSvFoLl4kmMPH4tToFsh5je+emJVM02xSmKIWf/frZ2fS0dLhXPjVAN0JFTk
         ICR1MgZjPjpKznhLhknmPKHAIupIiKpzbNIwVmWER7a9nlUO0HbOZ4rP+EgUfODxWy
         5iC8F3fFH/SYn+VS6hFaHCUTuWNvKszC4/8elgXzINc+6II1PavsYO+RHL7uPgH9xw
         D3Dfc8HasRZV4Y1YqPDN7E8N0w3uEIudJcsqlQRVuLTn7RRvZwmR0n+cJgSrOa88Zi
         9nV/W+KXukFjLUKBS98X5MICUM43mJQH4vIxF3iYACutpMdNNDTHkn/lTViTSQS264
         tNioDHQctCMEA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id rkocqFC4ggFZ; Mon,  9 Jul 2018 12:06:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E6F812318C5;
        Mon,  9 Jul 2018 12:06:22 -0400 (EDT)
Date:   Mon, 9 Jul 2018 12:06:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        peter maydell <peter.maydell@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
In-Reply-To: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
Subject: Re: [PATCH v2 0/3] Support rseq on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Support rseq on arm64
Thread-Index: tf5ds03EvQaPwjHEkKPpDqalLHEX5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon@arm.com wrote:

> Hello,
> 
> This is version two of the patches previously posted here:
> 
> http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon@arm.com
> 
> Changes since v1 include:
> 
>  * Move abort handler in-line to avoid possibility of it being
>    out-of-range for conditional branch instructions
> 
> I've tested both native and compat (little-endian only) with the selftests
> and they pass successfully on my Seattle box.

For the whole series:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> 
> Thanks,
> 
> Will
> 
> --->8
> 
> Will Deacon (3):
>  arm64: rseq: Implement backend rseq calls and select HAVE_RSEQ
>  asm-generic: unistd.h: Wire up sys_rseq
>  rseq/selftests: Add support for arm64
> 
> arch/arm64/Kconfig                        |   1 +
> arch/arm64/include/asm/unistd.h           |   2 +-
> arch/arm64/include/asm/unistd32.h         |   2 +
> arch/arm64/kernel/entry.S                 |   2 +
> arch/arm64/kernel/ptrace.c                |   2 +
> arch/arm64/kernel/signal.c                |   3 +
> include/uapi/asm-generic/unistd.h         |   4 +-
> tools/testing/selftests/rseq/param_test.c |  20 +
> tools/testing/selftests/rseq/rseq-arm64.h | 594 ++++++++++++++++++++++++++++++
> tools/testing/selftests/rseq/rseq.h       |   2 +
> 10 files changed, 630 insertions(+), 2 deletions(-)
> create mode 100644 tools/testing/selftests/rseq/rseq-arm64.h
> 
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
