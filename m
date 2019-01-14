Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Hlamzhx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfANTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:02:02 -0500
Received: from mail.efficios.com ([167.114.142.138]:57206 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:02:01 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 89090A3B4F;
        Mon, 14 Jan 2019 14:02:00 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id VmOpdNKrEumz; Mon, 14 Jan 2019 14:01:59 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D7666A3B45;
        Mon, 14 Jan 2019 14:01:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D7666A3B45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547492519;
        bh=O7tI5ra2w61kVTQD0TEDlOJraxV4ukwxWdz4a9U5mCQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Hlamzhx7pKZLzYSRup3bNnkBuGiZTwEknIp5BDfyhT8y3DQifdxckmV4vC4IzBd4q
         2g/UkpJIqVX1DDUreHu/yZlpl6gjy10pFs30xzyoReZiPYjzQkHWqlR80ziVS8aaDE
         T7+9du1yP2C95y5fSGxnOWSWDpci/fZ42w8qL89gqsxd+E5Yx4HwusuIH2yeIS7naV
         U9u/jk6QO8ml7dcoyXPEwk6LqSyuNVqAk9vBGJqJ9vc+s7+0yaMBTfg+R9RvW9Qwfk
         FQcZTzDktbS2DrM54+Tqoz0trRzln0kVXFqaxWA3K2rWrNggDS4n6M8xw5IFqqeqlo
         q7zTQ1EIsm24w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id peofCYc2XyB9; Mon, 14 Jan 2019 14:01:59 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BDFDEA3B38;
        Mon, 14 Jan 2019 14:01:59 -0500 (EST)
Date:   Mon, 14 Jan 2019 14:01:59 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1383390417.474.1547492519675.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.9.6 and 0.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Index: v8iN8IMeFh/Dzbe2PIRDtZRL6kc2PA==
Thread-Topic: Userspace RCU 0.9.6 and 0.10.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Those are bugfix releases of liburcu 0.9 and 0.10 stable branches.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Changelog:

2019-01-14 Userspace RCU 0.10.2
        * Fix: only wait if work queue is empty in real-time mode
        * Fix: don't wait after completion of a work queue job batch
        * Fix: don't wait after completion of job batch if work queue is empty
        * Fix: workqueue: struct urcu_work vs rcu_head mixup
        * Cleanup: workqueue: update comments referring to call-rcu
        * Fix: mixup between URCU_WORKQUEUE_RT and URCU_CALL_RCU_RT
        * test_rwlock: Add per-thread count to verbose output
        * Add *.exe to gitignore for Cygwin
        * Fix: pthread_rwlock initialization on Cygwin
        * Fix: compat_futex_noasync on Cygwin

2019-01-14 Userspace RCU 0.9.6
        * test_rwlock: Add per-thread count to verbose output
        * Add *.exe to gitignore for Cygwin
        * Fix: pthread_rwlock initialization on Cygwin
        * Fix: compat_futex_noasync on Cygwin

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
