Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F986C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7EB2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7EB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJROW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:22:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeJROW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:22:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6MMc5708398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:22:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6MMUv708395;
        Wed, 17 Oct 2018 23:22:22 -0700
Date:   Wed, 17 Oct 2018 23:22:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-6aa676761d4c1acfa31320e55fa1f83f3fcbbc7a@git.kernel.org>
Cc:     bp@alien8.de, torvalds@linux-foundation.org, hpa@zytor.com,
        luto@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Reply-To: luto@kernel.org, bp@alien8.de, torvalds@linux-foundation.org,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com, peterz@infradead.org,
          bigeasy@linutronix.de, tglx@linutronix.de
In-Reply-To: <20181016202525.29437-3-bigeasy@linutronix.de>
References: <20181016202525.29437-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu: Remove second definition of fpu in
 __fpu__restore_sig()
Git-Commit-ID: 6aa676761d4c1acfa31320e55fa1f83f3fcbbc7a
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

Commit-ID:  6aa676761d4c1acfa31320e55fa1f83f3fcbbc7a
Gitweb:     https://git.kernel.org/tip/6aa676761d4c1acfa31320e55fa1f83f3fcbbc7a
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 16 Oct 2018 22:25:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 17 Oct 2018 12:30:31 +0200

x86/fpu: Remove second definition of fpu in __fpu__restore_sig()

Commit:

  c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")

introduced the 'fpu' variable at top of __restore_xstate_sig(),
which now shadows the other definition:

  arch/x86/kernel/fpu/signal.c:318:28: warning: symbol 'fpu' shadows an earlier one
  arch/x86/kernel/fpu/signal.c:271:20: originally declared here

Remove the shadowed definition of 'fpu', as the two definitions are the same.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")
Link: http://lkml.kernel.org/r/20181016202525.29437-3-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/fpu/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 23f1691670b6..61a949d84dfa 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -314,7 +314,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * thread's fpu state, reconstruct fxstate from the fsave
 		 * header. Validate and sanitize the copied state.
 		 */
-		struct fpu *fpu = &tsk->thread.fpu;
 		struct user_i387_ia32_struct env;
 		int err = 0;
 
