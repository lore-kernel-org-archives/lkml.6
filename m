Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965117AbeBMP01 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:26:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964929AbeBMP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:26:25 -0500
Date: Tue, 13 Feb 2018 07:25:56 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-01684e72f16727e6ae0aeb1392f478e11ec5b8f7@git.kernel.org>
Cc: mhiramat@kernel.org, torvalds@linux-foundation.org, arnd@arndb.de,
        hpa@zytor.com, jbacik@fb.com, ast@kernel.org, nico@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, nico@linaro.org, ast@kernel.org, jbacik@fb.com,
        hpa@zytor.com, arnd@arndb.de, torvalds@linux-foundation.org,
        mhiramat@kernel.org
In-Reply-To: <20180202145634.200291-3-arnd@arndb.de>
References: <20180202145634.200291-3-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/error_inject: Make just_return_func() globally
 visible
Git-Commit-ID: 01684e72f16727e6ae0aeb1392f478e11ec5b8f7
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

Commit-ID:  01684e72f16727e6ae0aeb1392f478e11ec5b8f7
Gitweb:     https://git.kernel.org/tip/01684e72f16727e6ae0aeb1392f478e11ec5b8f7
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 2 Feb 2018 15:56:19 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 14:33:35 +0100

x86/error_inject: Make just_return_func() globally visible

With link time optimizations enabled, I get a link failure:

  ./ccLbOEHX.ltrans19.ltrans.o: In function `override_function_with_return':
  <artificial>:(.text+0x7f3): undefined reference to `just_return_func'

Marking the symbol .globl makes it work as expected.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 540adea3809f ("error-injection: Separate error-injection from kprobe")
Link: http://lkml.kernel.org/r/20180202145634.200291-3-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/lib/error-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 7b881d0..3cdf061 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -7,6 +7,7 @@ asmlinkage void just_return_func(void);
 
 asm(
 	".type just_return_func, @function\n"
+	".globl just_return_func\n"
 	"just_return_func:\n"
 	"	ret\n"
 	".size just_return_func, .-just_return_func\n"
