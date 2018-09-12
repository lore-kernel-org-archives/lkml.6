Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B0F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B0F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeILL4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:56:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48853 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeILL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:56:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8C6qxw62538629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Sep 2018 23:52:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8C6qwqt2538626;
        Tue, 11 Sep 2018 23:52:58 -0700
Date:   Tue, 11 Sep 2018 23:52:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-a6d18e65dff2b73ceeb187c598b48898e36ad7b1@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mhiramat@kernel.org, mingo@kernel.org,
        davem@davemloft.net, naveen.n.rao@linux.vnet.ibm.com,
        tglx@linutronix.de, anil.s.keshavamurthy@intel.com,
        peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mhiramat@kernel.org, davem@davemloft.net,
          mingo@kernel.org, tglx@linutronix.de,
          naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
          peterz@infradead.org
In-Reply-To: <153666121154.21306.17540752948574483565.stgit@devbox>
References: <153666121154.21306.17540752948574483565.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Remove pointless BUG_ON() from
 reuse_unused_kprobe()
Git-Commit-ID: a6d18e65dff2b73ceeb187c598b48898e36ad7b1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a6d18e65dff2b73ceeb187c598b48898e36ad7b1
Gitweb:     https://git.kernel.org/tip/a6d18e65dff2b73ceeb187c598b48898e36ad7b1
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Tue, 11 Sep 2018 19:20:11 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 12 Sep 2018 08:01:16 +0200

kprobes: Remove pointless BUG_ON() from reuse_unused_kprobe()

Since reuse_unused_kprobe() is called when the given kprobe
is unused, checking it inside again with BUG_ON() is
pointless. Remove it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N . Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/153666121154.21306.17540752948574483565.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 231569e1e2c8..277a6cbe83db 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -704,7 +704,6 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
 
-	BUG_ON(!kprobe_unused(ap));
 	/*
 	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
 	 * there is still a relative jump) and disabled.
