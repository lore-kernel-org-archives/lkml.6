Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825ABC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3805A2087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZRoOR5wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3805A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJOA2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 20:28:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:46526 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeJOA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 20:28:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1DBB81C125F;
        Sun, 14 Oct 2018 12:46:59 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZVef5BMy4gQi; Sun, 14 Oct 2018 12:46:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 75F801C125C;
        Sun, 14 Oct 2018 12:46:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 75F801C125C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539535618;
        bh=NX1K1imHwStr17YrQTbcXUwZ9c94ulJNkostcG9GdFQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZRoOR5wfwj+MOCEaHcRFi12dlgWofJOKZ9f3VwZM2cOdnGf7WlBcvoYg9v7oBsKt7
         UxRahJvDFJ05olZUd2Sgy90sLIoYuftLagP/53ppQXgzGY0NOT2wlauxOaVS/aXhCr
         i1PWU2xtWPn7jcRqTmxnZNu2WSSw1GF3HzTtUI/gbkh+gjeFz4Ovz61t5XkMX77fEH
         au6zYhLGgRdWR1kjx9XdZt8ZkeRtWUvHCEJys4PPORUfuEhvmisvITnINR3eTA4/Be
         Fyc7aVPYAbD3nSUbnc5rOXTA25ltA10H9tWtY1vLCJ366Y1TnHVxXSpjYmDpCrFZVz
         KpSAIcuX/UIHA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JtMm3D76xc6I; Sun, 14 Oct 2018 12:46:58 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5DFBC1C124D;
        Sun, 14 Oct 2018 12:46:58 -0400 (EDT)
Date:   Sun, 14 Oct 2018 12:46:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1913468383.3666.1539535618042.JavaMail.zimbra@efficios.com>
Subject: rseq system call incompletely wired up in microblaze
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3039)
Thread-Index: AtbzVJXkdlu1B6WW/1mYbWY/C9seLw==
Thread-Topic: rseq system call incompletely wired up in microblaze
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

I notice the following commit went into 4.18:

commit 54b0a2011dfcd2e3fe2c28062694fbbe3eb377a3
Author: Michal Simek <michal.simek@xilinx.com>
Date:   Thu Jun 14 08:24:39 2018 +0200

    microblaze: Add new syscalls io_pgetevents and rseq
    
    Wire up new syscalls io_pgetevents and rseq.
    
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>

It adds the rseq system call to the microblaze syscall list, but
does not add the required hooks in the architecture code, nor does
it select HAVE_RSEQ. So effectively, even though sys_rseq is reserved
on microblaze, it currently always returns ENOSYS.

Is your intent to simply reserve the system call number, or to
also get rseq to work on microblaze ?

A good example of the architecture changes required to
wire up rseq can be found here:

commit 9d6d99e3ac8ccfd0945edb3c83cd912838775056
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Sat Jun 30 10:54:15 2018 +0200

    s390: wire up rseq system call
    
    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Also, please make sure the tools/testing/selftests/rseq/ tests
pass before pushing a commit enabling it for your architecture.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
