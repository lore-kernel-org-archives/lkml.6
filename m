Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CDAC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE23C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE23C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeILLzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:55:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeILLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:55:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8C6qQF82538569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Sep 2018 23:52:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8C6qQT32538566;
        Tue, 11 Sep 2018 23:52:26 -0700
Date:   Tue, 11 Sep 2018 23:52:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-c72e6742f62d7bb82a77a41ca53940cb8f73e60f@git.kernel.org>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          naveen.n.rao@linux.vnet.ibm.com, tglx@linutronix.de,
          mhiramat@kernel.org, mingo@kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, anil.s.keshavamurthy@intel.com,
          davem@davemloft.net
In-Reply-To: <153666118298.21306.4915366706875652652.stgit@devbox>
References: <153666118298.21306.4915366706875652652.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Remove pointless BUG_ON() from
 add_new_kprobe()
Git-Commit-ID: c72e6742f62d7bb82a77a41ca53940cb8f73e60f
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

Commit-ID:  c72e6742f62d7bb82a77a41ca53940cb8f73e60f
Gitweb:     https://git.kernel.org/tip/c72e6742f62d7bb82a77a41ca53940cb8f73e60f
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Tue, 11 Sep 2018 19:19:43 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 12 Sep 2018 08:01:15 +0200

kprobes: Remove pointless BUG_ON() from add_new_kprobe()

Before calling add_new_kprobe(), aggr_probe's GONE
flag and kprobe GONE flag are cleared. We don't need
to worry about that flag at this point.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N . Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/153666118298.21306.4915366706875652652.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d1edd8d5641e..231569e1e2c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1259,8 +1259,6 @@ NOKPROBE_SYMBOL(cleanup_rp_inst);
 /* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
-	BUG_ON(kprobe_gone(ap) || kprobe_gone(p));
-
 	if (p->post_handler)
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
