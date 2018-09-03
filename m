Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201CCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2F520652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2F520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeICRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:37:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:37:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83DGSvZ3313560
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 06:16:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83DGSxB3313557;
        Mon, 3 Sep 2018 06:16:28 -0700
Date:   Mon, 3 Sep 2018 06:16:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-76dee4a72849561f6ffacc357cfd0aa33336081a@git.kernel.org>
Cc:     anil.s.keshavamurthy@intel.com, linux-kernel@vger.kernel.org,
        bp@alien8.de, viro@zeniv.linux.org.uk, keescook@chromium.org,
        jannh@google.com, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, mhiramat@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, hpa@zytor.com
Reply-To: keescook@chromium.org, jannh@google.com,
          anil.s.keshavamurthy@intel.com, linux-kernel@vger.kernel.org,
          bp@alien8.de, viro@zeniv.linux.org.uk, mhiramat@kernel.org,
          davem@davemloft.net, naveen.n.rao@linux.vnet.ibm.com,
          hpa@zytor.com, mingo@kernel.org, luto@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180828201421.157735-3-jannh@google.com>
References: <20180828201421.157735-3-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/kprobes: Inline kprobe_exceptions_notify() into
 do_general_protection()
Git-Commit-ID: 76dee4a72849561f6ffacc357cfd0aa33336081a
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

Commit-ID:  76dee4a72849561f6ffacc357cfd0aa33336081a
Gitweb:     https://git.kernel.org/tip/76dee4a72849561f6ffacc357cfd0aa33336081a
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 22:14:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 15:12:08 +0200

x86/kprobes: Inline kprobe_exceptions_notify() into do_general_protection()

The opaque plumbing of #GP from do_general_protection() through
notify_die() into kprobe_exceptions_notify() makes it hard to understand
what's going on.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: dvyukov@google.com
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-3-jannh@google.com

---
 arch/x86/kernel/kprobes/core.c | 31 +------------------------------
 arch/x86/kernel/traps.c        | 10 ++++++++++
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b0d1e81c96bb..467ac22691b0 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1028,42 +1028,13 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		if (fixup_exception(regs, trapnr))
 			return 1;
 
-		/*
-		 * fixup routine could not handle it,
-		 * Let do_page_fault() fix it.
-		 */
+		/* fixup routine could not handle it. */
 	}
 
 	return 0;
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
-/*
- * Wrapper routine for handling exceptions.
- */
-int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
-			     void *data)
-{
-	struct die_args *args = data;
-	int ret = NOTIFY_DONE;
-
-	if (args->regs && user_mode(args->regs))
-		return ret;
-
-	if (val == DIE_GPF) {
-		/*
-		 * To be potentially processing a kprobe fault and to
-		 * trust the result from kprobe_running(), we have
-		 * be non-preemptible.
-		 */
-		if (!preemptible() && kprobe_running() &&
-		    kprobe_fault_handler(args->regs, args->trapnr))
-			ret = NOTIFY_STOP;
-	}
-	return ret;
-}
-NOKPROBE_SYMBOL(kprobe_exceptions_notify);
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	bool is_in_entry_trampoline_section = false;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..bf9ab1aaa175 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -556,6 +556,16 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
+
+		/*
+		 * To be potentially processing a kprobe fault and to
+		 * trust the result from kprobe_running(), we have to
+		 * be non-preemptible.
+		 */
+		if (!preemptible() && kprobe_running() &&
+		    kprobe_fault_handler(regs, X86_TRAP_GP))
+			return;
+
 		if (notify_die(DIE_GPF, "general protection fault", regs, error_code,
 			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
 			die("general protection fault", regs, error_code);
