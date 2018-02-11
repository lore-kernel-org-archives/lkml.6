Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeBLBqo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:46:44 -0500
Received: from [198.137.202.136] ([198.137.202.136]:47133 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbeBLBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:46:43 -0500
Date: Sun, 11 Feb 2018 04:13:29 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-92d22ce1a5f079a2c62d51d4084ece5926dd8ff2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org
In-Reply-To: <20180211111013.16888-2-linux@dominikbrodowski.net>
References: <20180211111013.16888-2-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] selftests/x86: Fix build bug caused by the 5lvl
 test which has been moved to the VM directory
Git-Commit-ID: 92d22ce1a5f079a2c62d51d4084ece5926dd8ff2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  92d22ce1a5f079a2c62d51d4084ece5926dd8ff2
Gitweb:     https://git.kernel.org/tip/92d22ce1a5f079a2c62d51d4084ece5926dd8ff2
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 12:10:09 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:24:47 +0100

selftests/x86: Fix build bug caused by the 5lvl test which has been moved to the VM directory

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Fixes: 235266b8e11c "selftests/vm: move 128TB mmap boundary test to generic directory"
Link: http://lkml.kernel.org/r/20180211111013.16888-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 10ca46d..ce2615a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt ptrace_sysc
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip 5lvl
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
 
 TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY)
 TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_64BIT_ONLY)
