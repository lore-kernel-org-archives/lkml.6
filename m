Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05FD1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F6C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="shrYRREw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F6C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeFKTtV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:49:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:47410 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934347AbeFKTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:49:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 807181BC5CF;
        Mon, 11 Jun 2018 15:49:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id R8Ojig0b47pf; Mon, 11 Jun 2018 15:49:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EC9EE1BC5CC;
        Mon, 11 Jun 2018 15:49:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EC9EE1BC5CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528746559;
        bh=onpme0irgk/PAatiLRHk5inGwCqrfC8BxU9D1FLcDB4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=shrYRREwXsIj0wLsx/nianaj1BjY/pl1ckVmHK61VRLYAsYLoTWP8QZUMWB46ysbr
         MwFkRom3Yo/kPIyYEgzHjIWf0RfWdflATifiwh8SC1PQ8wIJzKe6Cm5vxDUurhz+bM
         FWaC0+BfP4OSV2SMvQFKa/T3Gu0SHuxd23/v4+Lv+RItKN59R8ifbFrjSLu6ckXM+m
         Vwn0cRN26E4qsf2xO6T+jUsO+IUQ9seBa/tTCRtDk9vt1ClMJjBUyi8D46HAIvkJMn
         kbATRKbNbmligs/UGZkO7LeEbAQ5OB3+IXDJ4kdIKxwf9mpwD+HEI7rtW2sgWEyyKj
         poKrKZODR9KiQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 77MTc6G90N38; Mon, 11 Jun 2018 15:49:18 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D74B41BC5C1;
        Mon, 11 Jun 2018 15:49:18 -0400 (EDT)
Date:   Mon, 11 Jun 2018 15:49:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
Subject: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Index: Ji+Ih2ToZVzsN7nm//LhgOxKDWsqWA==
Thread-Topic: Restartable Sequences system call merged into Linux
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Good news! The restartable sequences (rseq) system call is now merged into the master
branch of the Linux kernel within the 4.18 merge window:

https://github.com/torvalds/linux/commit/d82991a8688ad128b46db1b42d5d84396487a508

It would be important to discuss how we should proceed to integrate the library part
of rseq (see tools/testing/selftests/rseq/rseq*.{ch}) into glibc, or if it should
live in a standalone project.

It should be noted that there can be only one rseq TLS area registered per thread,
which can then be used by many libraries and by the executable, so this is a
process-wide (per-thread) resource that we need to manage carefully.

Thoughts ?

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
