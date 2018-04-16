Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeDPGps (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:45:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51309 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeDPGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:45:47 -0400
Date: Sun, 15 Apr 2018 23:44:41 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nqozcv8loq40tkqpfw997993@git.kernel.org>
Cc: aryabinin@virtuozzo.com, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, adrian.hunter@intel.com, luto@kernel.org,
        glider@google.com, peterz@infradead.org, mingo@kernel.org,
        dsahern@gmail.com, arnd@arndb.de, yhs@fb.com,
        alexei.starovoitov@gmail.com, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, daniel@iogearbox.net, wangnan0@huawei.com,
        dvyukov@google.com, miguel.bernal.marin@linux.intel.com,
        mka@chromium.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org
Reply-To: dsahern@gmail.com, luto@kernel.org, glider@google.com,
        peterz@infradead.org, mingo@kernel.org, aryabinin@virtuozzo.com,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        adrian.hunter@intel.com, mka@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        dvyukov@google.com, miguel.bernal.marin@linux.intel.com,
        alexei.starovoitov@gmail.com, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, daniel@iogearbox.net, arnd@arndb.de, yhs@fb.com
In-Reply-To: <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
References: <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] Revert "x86/asm: Allow again using asm.h when
 building for the 'bpf' clang target"
Git-Commit-ID: fd97d39b0aa49a4beb429aec344604c1b689f089
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

Commit-ID:  fd97d39b0aa49a4beb429aec344604c1b689f089
Gitweb:     https://git.kernel.org/tip/fd97d39b0aa49a4beb429aec344604c1b689f089
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 11 Apr 2018 18:03:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:27 -0300

Revert "x86/asm: Allow again using asm.h when building for the 'bpf' clang target"

This reverts commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248.

Newer clang versions accept that asm(_ASM_SP) construct, and now that
the bpf-script-test-kbuild.c script, used in one of the 'perf test LLVM'
subtests doesn't include ptrace.h, which ended up including
arch/x86/include/asm/asm.h, we can revert this patch.

Suggested-by: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com
Acked-by: Yonghong Song <yhs@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nqozcv8loq40tkqpfw997993@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/include/asm/asm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 386a6900e206..219faaec51df 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -136,7 +136,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#ifndef __BPF__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
@@ -146,6 +145,5 @@
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif
-#endif
 
 #endif /* _ASM_X86_ASM_H */
