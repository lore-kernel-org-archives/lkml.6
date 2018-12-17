Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D6EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ACE20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbeLQST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:19:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbeLQST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:19:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIJUQh2560843
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:19:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIJURj2560839;
        Mon, 17 Dec 2018 10:19:30 -0800
Date:   Mon, 17 Dec 2018 10:19:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-fe6e65615415987629a2dda583b4495677d8c388@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, anil.s.keshavamurthy@intel.com, yhs@fb.com,
        bp@alien8.de, torvalds@linux-foundation.org, tglx@linutronix.de,
        righi.andrea@gmail.com, hpa@zytor.com, davem@davemloft.net,
        luto@kernel.org
Reply-To: righi.andrea@gmail.com, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.vnet.ibm.com,
          peterz@infradead.org, bp@alien8.de, yhs@fb.com,
          mhiramat@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, luto@kernel.org, davem@davemloft.net
In-Reply-To: <154503488425.26176.17136784384033608516.stgit@devbox>
References: <154503488425.26176.17136784384033608516.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes/x86: Show x86-64 specific blacklisted
 symbols correctly
Git-Commit-ID: fe6e65615415987629a2dda583b4495677d8c388
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

Commit-ID:  fe6e65615415987629a2dda583b4495677d8c388
Gitweb:     https://git.kernel.org/tip/fe6e65615415987629a2dda583b4495677d8c388
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Mon, 17 Dec 2018 17:21:24 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 17:48:39 +0100

kprobes/x86: Show x86-64 specific blacklisted symbols correctly

Show x86-64 specific blacklisted symbols in debugfs.

Since x86-64 prohibits probing on symbols which are in
entry text, those should be shown.

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
Link: http://lkml.kernel.org/r/154503488425.26176.17136784384033608516.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index c33b06f5faa4..6011a4a90f0a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1034,6 +1034,12 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 		 addr < (unsigned long)__entry_text_end);
 }
 
+int __init arch_populate_kprobe_blacklist(void)
+{
+	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
+					 (unsigned long)__entry_text_end);
+}
+
 int __init arch_init_kprobes(void)
 {
 	return 0;
