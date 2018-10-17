Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F01AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100B21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6100B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeJQRFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:05:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:05:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9H99sZF277654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 02:09:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9H99rBm277651;
        Wed, 17 Oct 2018 02:09:53 -0700
Date:   Wed, 17 Oct 2018 02:09:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-5ac33bcb25ad30200c4e6d11802e9e7664463529@git.kernel.org>
Cc:     mingo@kernel.org, bigeasy@linutronix.de,
        torvalds@linux-foundation.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        luto@kernel.org, dave.hansen@linux.intel.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, bigeasy@linutronix.de,
          mingo@kernel.org, peterz@infradead.org,
          dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20181016202525.29437-3-bigeasy@linutronix.de>
References: <20181016202525.29437-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu: Remove second definition of fpu in
 __fpu__restore_sig()
Git-Commit-ID: 5ac33bcb25ad30200c4e6d11802e9e7664463529
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

Commit-ID:  5ac33bcb25ad30200c4e6d11802e9e7664463529
Gitweb:     https://git.kernel.org/tip/5ac33bcb25ad30200c4e6d11802e9e7664463529
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 16 Oct 2018 22:25:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 17 Oct 2018 08:07:41 +0200

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
 
