Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523024587; cv=none;
        d=google.com; s=arc-20160816;
        b=BGZeD05ghvXisasj8VDnRNU6ThT7ebSjtNQ/kQfv4jp1n2VH2xSACSgfZVBKcKO6Qb
         tFqxRYGfGZnoepiATLSdvK8hk0dYZTcG8OQmWL+UGzAIwJ50uIgSferxXIKFpbDcsiFL
         RybMyRU4bppxvRBo/RhWY7aYKuirh2kCePjytGK1fPaw7LKfMF7XPjEEPtZxGfhMLze2
         x6xWVXKBZ5tODimoA51NphMrojUZe3o7cV3JNP4s/WoSq5/QhxaNuoFd5cfaYgUiF9Pe
         Z//DtmlBso42BYsuN6w1T3jMBgnh+yrf4fKBlhDbuUNJQPHhwnY2Oc+BMKUBXHd3xzGx
         sITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=vMk1EcWQ+M8jyWzfNTu+nWYduJExnILXv9OJ3umNbj0=;
        b=c6CFr7lCQQKgSIgsVXofBuW+dGSUHcxTaInXiW+jaSvaoQDwY5kd9jubiBh28O1NUh
         KeA4Qmg/Y2WwanKwxeMCytwEugxIulGRJVx/WZabG0uM4Gf4uw/gFTRRtWic4gW+/+lC
         TR32qTqA3SD6SRgeWZ6Ao8IYVNoyIksT7rtkkQvXUHN+f0ZtBFY0iqXMdyJXoTEQXOHo
         suGW/rgKYiCL5e/j11DXLolSnT2xlZ+jz91UGWSjUboFo5vlpTktIZ25i/tEgX4DJ7h3
         ubnAT3Paqh30EWDvebpDgOxya/WU23BZROlEBG37y5PpjnYBLtT++h/9YqLJkAiLubq7
         kUUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AIpwx4+PVC3tFv+WqZNmsTJjY9XHOvXves+qVIWdqiCAiGYbbUIDkTFNAQD5PdzRlHVp5yEF1zkWDQ==
From: Alexander Popov <alex.popov@linux.com>
To: kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	alex.popov@linux.com
Subject: [PATCH v11 4/6] lkdtm: Add a test for STACKLEAK
Date: Fri,  6 Apr 2018 17:22:24 +0300
Message-Id: <1523024546-6150-5-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007029578411626?=
X-GMAIL-MSGID: =?utf-8?q?1597007029578411626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce two lkdtm tests for the STACKLEAK feature: STACKLEAK_ALLOCA
and STACKLEAK_DEEP_RECURSION. Both of them check that the current task
stack is properly erased (filled with STACKLEAK_POISON).

STACKLEAK_ALLOCA tests that:
 - check_alloca() allows alloca calls which don't exhaust the kernel stack;
 - alloca calls which exhaust/overflow the kernel stack hit BUG() in
    check_alloca().

STACKLEAK_DEEP_RECURSION tests that exhausting the current task stack
with a deep recursion is detected by CONFIG_VMAP_STACK (which is implied
by CONFIG_GCC_PLUGIN_STACKLEAK).

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/misc/Makefile          |   3 +
 drivers/misc/lkdtm.h           |   4 ++
 drivers/misc/lkdtm_core.c      |   2 +
 drivers/misc/lkdtm_stackleak.c | 141 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/misc/lkdtm_stackleak.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c3c8624..2b11823 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -65,6 +65,9 @@ lkdtm-$(CONFIG_LKDTM)		+= lkdtm_perms.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_refcount.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_usercopy.o
+lkdtm-$(CONFIG_LKDTM)		+= lkdtm_stackleak.o
+
+KASAN_SANITIZE_lkdtm_stackleak.o := n
 
 KCOV_INSTRUMENT_lkdtm_rodata.o	:= n
 
diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
index 9e513dc..4b2b8e3 100644
--- a/drivers/misc/lkdtm.h
+++ b/drivers/misc/lkdtm.h
@@ -83,4 +83,8 @@ void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
 void lkdtm_USERCOPY_STACK_BEYOND(void);
 void lkdtm_USERCOPY_KERNEL(void);
 
+/* lkdtm_stackleak.c */
+void lkdtm_STACKLEAK_ALLOCA(void);
+void lkdtm_STACKLEAK_DEEP_RECURSION(void);
+
 #endif
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index 2154d1b..c37fd85 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -183,6 +183,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
 	CRASHTYPE(USERCOPY_KERNEL),
+	CRASHTYPE(STACKLEAK_ALLOCA),
+	CRASHTYPE(STACKLEAK_DEEP_RECURSION),
 };
 
 
diff --git a/drivers/misc/lkdtm_stackleak.c b/drivers/misc/lkdtm_stackleak.c
new file mode 100644
index 0000000..4706595
--- /dev/null
+++ b/drivers/misc/lkdtm_stackleak.c
@@ -0,0 +1,141 @@
+/*
+ * This code tests several aspects of the STACKLEAK feature:
+ *  - the current task stack is properly erased (filled with STACKLEAK_POISON);
+ *  - check_alloca() allows alloca calls which don't exhaust the kernel stack;
+ *  - alloca calls which exhaust/overflow the kernel stack hit BUG() in
+ *     check_alloca();
+ *  - exhausting the current task stack with a deep recursion is detected by
+ *     CONFIG_VMAP_STACK (which is implied by CONFIG_GCC_PLUGIN_STACKLEAK).
+ *
+ * Authors:
+ *   Tycho Andersen <tycho@tycho.ws>
+ *   Alexander Popov <alex.popov@linux.com>
+ */
+
+#include "lkdtm.h"
+#include <linux/sched.h>
+#include <linux/compiler.h>
+
+#ifndef CONFIG_STACKLEAK_TRACK_MIN_SIZE
+# define CONFIG_STACKLEAK_TRACK_MIN_SIZE 0
+#endif
+
+static noinline bool stack_is_erased(void)
+{
+	unsigned long *sp, left, found, i;
+	const unsigned long check_depth = STACKLEAK_POISON_CHECK_DEPTH /
+							sizeof(unsigned long);
+
+	/*
+	 * For the details about the alignment of the poison values, see
+	 * the comment in track_stack().
+	 */
+	sp = PTR_ALIGN(&i, sizeof(unsigned long));
+
+	left = ((unsigned long)sp & (THREAD_SIZE - 1)) / sizeof(unsigned long);
+	sp--;
+
+	/*
+	 * One long int at the bottom of the thread stack is reserved
+	 * and not poisoned.
+	 */
+	if (left > 1)
+		left--;
+	else
+		return false;
+
+	pr_info("checking unused part of the thread stack (%lu bytes)...\n",
+					left * sizeof(unsigned long));
+
+	/*
+	 * Search for check_depth poison values in a row (just like
+	 * erase_kstack() does).
+	 */
+	for (i = 0, found = 0; i < left && found <= check_depth; i++) {
+		if (*(sp - i) == STACKLEAK_POISON)
+			found++;
+		else
+			found = 0;
+	}
+
+	if (found <= check_depth) {
+		pr_err("FAIL: thread stack is not erased (checked %lu bytes)\n",
+						i * sizeof(unsigned long));
+		return false;
+	}
+
+	pr_info("first %lu bytes are unpoisoned\n",
+				(i - found) * sizeof(unsigned long));
+
+	/* The rest of thread stack should be erased */
+	for (; i < left; i++) {
+		if (*(sp - i) != STACKLEAK_POISON) {
+			pr_err("FAIL: thread stack is NOT properly erased\n");
+			return false;
+		}
+	}
+
+	pr_info("the rest of the thread stack is properly erased\n");
+	return true;
+}
+
+static noinline void do_alloca(unsigned long size)
+{
+	char buf[size];
+
+	/* So this doesn't get inlined or optimized out */
+	snprintf(buf, size, "testing alloca...\n");
+}
+
+void lkdtm_STACKLEAK_ALLOCA(void)
+{
+	unsigned long left = (unsigned long)&left & (THREAD_SIZE - 1);
+
+	if (!stack_is_erased())
+		return;
+
+	/* Try a small alloca to see if it works */
+	pr_info("try a small alloca of 16 bytes...\n");
+	do_alloca(16);
+	pr_info("small alloca is successful\n");
+
+	/* Try to hit the BUG() in check_alloca() */
+	pr_info("try a large alloca of %lu bytes (stack overflow)...\n", left);
+	do_alloca(left);
+	pr_err("FAIL: large alloca overstepped the thread stack boundary\n");
+}
+
+/*
+ * The stack frame size of recursion() is bigger than the
+ * CONFIG_STACKLEAK_TRACK_MIN_SIZE, hence that function is instrumented
+ * by the STACKLEAK gcc plugin and it calls track_stack() at the beginning.
+ */
+static noinline unsigned long recursion(unsigned long prev_sp)
+{
+	char buf[CONFIG_STACKLEAK_TRACK_MIN_SIZE + 42];
+	unsigned long sp = (unsigned long)&sp;
+
+	snprintf(buf, sizeof(buf), "testing deep recursion...\n");
+
+	if (prev_sp < sp + THREAD_SIZE)
+		sp = recursion(prev_sp);
+
+	return sp;
+}
+
+void lkdtm_STACKLEAK_DEEP_RECURSION(void)
+{
+	unsigned long sp = (unsigned long)&sp;
+
+	if (!stack_is_erased())
+		return;
+
+	/*
+	 * Exhaust the thread stack with a deep recursion. It should hit the
+	 * guard page provided by CONFIG_VMAP_STACK (which is implied by
+	 * CONFIG_GCC_PLUGIN_STACKLEAK).
+	 */
+	pr_info("try to exhaust the thread stack with a deep recursion...\n");
+	pr_err("FAIL: thread stack exhaustion (%lu bytes) is not detected\n",
+							sp - recursion(sp));
+}
-- 
2.7.4
