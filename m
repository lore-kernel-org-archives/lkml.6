Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeDHKGV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 06:06:21 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:36206 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeDHKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 06:06:19 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Fix style, spelling, and grammar in siginfo_build_tests()
Date: Sun,  8 Apr 2018 12:06:11 +0200
Message-Id: <1523181971-21536-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 4be33329d46f80e8 ("m68k: Verify the offsets in struct siginfo never change.")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/signal.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 61a65fa374e5d006..d12b84f1ae312779 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -576,41 +576,42 @@ static inline int rt_save_fpu_state(struct ucontext __user *uc, struct pt_regs *
 
 static inline void siginfo_build_tests(void)
 {
-	/* This needs to be tested on m68k as it has a lesser
-	 * alignment requirment than x86 and that can cause surprises.
+	/*
+	 * This needs to be tested on m68k as it has a lesser
+	 * alignment requirement than x86 and that can cause surprises.
 	 */
 
 	/* This is part of the ABI and can never change in size: */
 	BUILD_BUG_ON(sizeof(siginfo_t) != 128);
 
-	/* Ensure the know fields never change in location */
+	/* Ensure the known fields never change in location */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_signo) != 0);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_errno) != 4);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_code)  != 8);
 
 	/* _kill */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid) != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_pid) != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_uid) != 0x10);
 
 	/* _timer */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_tid)     != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_tid)     != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_overrun) != 0x10);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_value)   != 0x14);
 
 	/* _rt */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)   != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)   != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_uid)   != 0x10);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_value) != 0x14);
 
 	/* _sigchld */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)    != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_pid)    != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_uid)    != 0x10);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_status) != 0x14);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_utime)  != 0x18);
-	BUILD_BUG_ON(offsetof(siginfo_t, si_stime)  != 0x1C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_stime)  != 0x1c);
 
 	/* _sigfault */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x0c);
 
 	/* _sigfault._mcerr */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_addr_lsb) != 0x10);
@@ -623,11 +624,11 @@ static inline void siginfo_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x12);
 
 	/* _sigpoll */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_fd)     != 0x10);
 
 	/* _sigsys */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_call_addr) != 0x0C);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_call_addr) != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_syscall)   != 0x10);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_arch)      != 0x14);
 
-- 
2.7.4
