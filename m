Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBCFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0783B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbeLQSUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:20:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeLQSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:20:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIK50X2560967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:20:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIK4v42560963;
        Mon, 17 Dec 2018 10:20:04 -0800
Date:   Mon, 17 Dec 2018 10:20:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-8162b3d1a728cf63abf54be4167dd9beec5d9d37@git.kernel.org>
Cc:     anil.s.keshavamurthy@intel.com, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, yhs@fb.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        righi.andrea@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bp@alien8.de, mhiramat@kernel.org,
        peterz@infradead.org, luto@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          righi.andrea@gmail.com, peterz@infradead.org, luto@kernel.org,
          bp@alien8.de, mhiramat@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, hpa@zytor.com,
          anil.s.keshavamurthy@intel.com, yhs@fb.com, davem@davemloft.net,
          naveen.n.rao@linux.vnet.ibm.com
In-Reply-To: <154503491354.26176.13903264647254766066.stgit@devbox>
References: <154503491354.26176.13903264647254766066.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes/x86: Remove unneeded
 arch_within_kprobe_blacklist from x86
Git-Commit-ID: 8162b3d1a728cf63abf54be4167dd9beec5d9d37
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

Commit-ID:  8162b3d1a728cf63abf54be4167dd9beec5d9d37
Gitweb:     https://git.kernel.org/tip/8162b3d1a728cf63abf54be4167dd9beec5d9d37
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Mon, 17 Dec 2018 17:21:53 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 17:48:40 +0100

kprobes/x86: Remove unneeded arch_within_kprobe_blacklist from x86

Remove x86 specific arch_within_kprobe_blacklist().

Since we have already added all blacklisted symbols to the
kprobe blacklist by arch_populate_kprobe_blacklist(),
we don't need arch_within_kprobe_blacklist() on x86
anymore.

Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lkml.kernel.org/r/154503491354.26176.13903264647254766066.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6011a4a90f0a..d5f88fe57064 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1026,14 +1026,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
-bool arch_within_kprobe_blacklist(unsigned long addr)
-{
-	return  (addr >= (unsigned long)__kprobes_text_start &&
-		 addr < (unsigned long)__kprobes_text_end) ||
-		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
-}
-
 int __init arch_populate_kprobe_blacklist(void)
 {
 	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
