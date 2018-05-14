Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeENOHD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:07:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932413AbeENOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:06:57 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: [PATCH v2 6/6] x86/stacktrace: orc, mark it as reliable
Date: Mon, 14 May 2018 16:06:53 +0200
Message-Id: <20180514140653.23678-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514140653.23678-1-jslaby@suse.cz>
References: <20180514140653.23678-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SUSE, we need a reliable stack unwinder for kernel live patching, but
we do not want to enable frame pointers for performance reasons. So
after the previous patches to make the ORC reliable, mark ORC as a
reliable stack unwinder on x86.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 47e7f582f86a..e4199fbcc7f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -181,7 +181,7 @@ config X86
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
+	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
-- 
2.16.3
