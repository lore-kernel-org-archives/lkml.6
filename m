Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933951AbeBMJGS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:06:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53845 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933797AbeBMJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:06:12 -0500
Date: Tue, 13 Feb 2018 01:05:52 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-7f95122067ab26fb8344b2a9de64ffbd0fea0010@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        linux@dominikbrodowski.net, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, linux@dominikbrodowski.net,
        torvalds@linux-foundation.org
In-Reply-To: <20180211111013.16888-2-linux@dominikbrodowski.net>
References: <20180211111013.16888-2-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86: Fix build bug caused by the 5lvl test
 which has been moved to the VM directory
Git-Commit-ID: 7f95122067ab26fb8344b2a9de64ffbd0fea0010
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

Commit-ID:  7f95122067ab26fb8344b2a9de64ffbd0fea0010
Gitweb:     https://git.kernel.org/tip/7f95122067ab26fb8344b2a9de64ffbd0fea0010
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 12:10:09 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:05:32 +0100

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
index 5d4f10a..91fbfa8 100644
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
