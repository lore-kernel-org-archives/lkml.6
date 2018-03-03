Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520107261; cv=none;
        d=google.com; s=arc-20160816;
        b=EKHfJfKdCvYqjC5vt+DH93bEJWhthYfYU1H6o9sTn8GsiKWFNKdOkoxMTCa9EQ4/2m
         R6doKzktz9Fva+0BlwX9eSDtKHJTLlfZCqyNm/UP4FSgPfysZdhGMOsndkMhVbKrwYdG
         8j3bjoCrvUQQbTWAPy6pr5fi4mKBRTn+AIA1FUZmCGy0F7N6W0XjT8Rl8hkbmdlZN5d5
         R8VTxiXc6wxROYMuwzkuEHwfGbdLJkkP4Ty5gKbMV/EfFfeX7OQgKaNRYmQVS16V3Wli
         C/1AVSP3NuIJkTQv4cxPk3GnByYHNtsnCq1RL+Y0ZalXMUQ8xHPjJEWh5Mb6TY+n/pJB
         48Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=9EurYOra3Ue2MJQCiNPXthWw/UoRvl7zB3QouAgHt3M=;
        b=iwrxymU1xGvkYmzHseR/kKpsjO57U1jIzCr0/4+zIAJXYq4+v2tHLnyK9g9As3dYbw
         QbyyDSDPezRvzSOhTzdMhclEeK8pVOc2H9agKLm7gRVxtznrn+DYPnM8ZjbqST4Lrqmu
         y6+TZPKiupho9Efurp2o0knE9NgWrE0PX3a5ydYbS/2fIMtzxcXVcOxpAcsCwFLjEJZc
         AO0dilrSr8JRg8zIO8pxDP7cMTzo/r5qvdpg5r1+4AbJXGT3r1hCvzyiLDynfNlrVrTG
         Ii/uKrFlP6c6IgF/59tRjG4fwYFXjPtkLEH8XQWg+yE5XKy70SK1NUC0FtYS/fqk4jl+
         QZbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AG47ELvHjj75FAJ2UDhbZ7ahbUHcIcjmLBZ41pzU1KLqt/M3MDVoQHwb9Y8vCLD3uhkApUJAxPeVZw==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	alex.popov@linux.com
Subject: [PATCH RFC v9 6/7] fs/proc: Show STACKLEAK metrics in the /proc file system
Date: Sat,  3 Mar 2018 23:00:31 +0300
Message-Id: <1520107232-14111-7-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947991573343180?=
X-GMAIL-MSGID: =?utf-8?q?1593947991573343180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce CONFIG_STACKLEAK_METRICS providing STACKLEAK information about
tasks via the /proc file system. In particular, /proc/<pid>/stack_depth
shows the maximum kernel stack consumption for the current and previous
syscalls. Although this information is not precise, it  can be useful for
estimating the STACKLEAK performance impact for your workloads.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 arch/Kconfig                     | 12 ++++++++++++
 arch/x86/entry/entry_32.S        |  4 ++++
 arch/x86/entry/entry_64.S        |  4 ++++
 arch/x86/include/asm/processor.h |  3 +++
 arch/x86/kernel/asm-offsets.c    |  3 +++
 arch/x86/kernel/process_32.c     |  3 +++
 arch/x86/kernel/process_64.c     |  3 +++
 fs/proc/base.c                   | 18 ++++++++++++++++++
 8 files changed, 50 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index a4a8fba..42ebfb9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -572,6 +572,18 @@ config STACKLEAK_TRACK_MIN_SIZE
 	  frame size greater than or equal to this parameter.
 	  If unsure, leave the default value 100.
 
+config STACKLEAK_METRICS
+	bool "Show STACKLEAK metrics in the /proc file system"
+	depends on GCC_PLUGIN_STACKLEAK
+	depends on PROC_FS
+	help
+	  If this is set, STACKLEAK metrics for every task are available in
+	  the /proc file system. In particular, /proc/<pid>/stack_depth
+	  shows the maximum kernel stack consumption for the current and
+	  previous syscalls. Although this information is not precise, it
+	  can be useful for estimating the STACKLEAK performance impact for
+	  your workloads.
+
 config HAVE_CC_STACKPROTECTOR
 	bool
 	help
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 068dde6..f5236b3 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -134,6 +134,10 @@ ENTRY(erase_kstack)
 	mov	%esp, %ecx
 	sub	%edi, %ecx
 
+#ifdef CONFIG_STACKLEAK_METRICS
+	mov	%edi, TASK_prev_lowest_stack(%ebp)
+#endif
+
 	cmp	$THREAD_SIZE_asm, %ecx
 	jb	.Lgood_counter
 	ud2
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9b360f8..c82cdbd 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -119,6 +119,10 @@ ENTRY(erase_kstack)
 	 */
 	or	$2 * 8, %rdi
 
+#ifdef CONFIG_STACKLEAK_METRICS
+	mov	%rdi, TASK_prev_lowest_stack(%r11)
+#endif
+
 	/*
 	 * Check whether we are on the thread stack to prepare the counter
 	 * for stack poisoning.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0c87813..bca1074 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -496,6 +496,9 @@ struct thread_struct {
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long		lowest_stack;
+# ifdef CONFIG_STACKLEAK_METRICS
+	unsigned long		prev_lowest_stack;
+# endif
 #endif
 
 	unsigned int		sig_on_uaccess_err:1;
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ef5d260..f48197a 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -41,6 +41,9 @@ void common(void) {
 	OFFSET(TASK_addr_limit, task_struct, thread.addr_limit);
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	OFFSET(TASK_lowest_stack, task_struct, thread.lowest_stack);
+# ifdef CONFIG_STACKLEAK_METRICS
+	OFFSET(TASK_prev_lowest_stack, task_struct, thread.prev_lowest_stack);
+# endif
 #endif
 
 	BLANK();
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 6d256ab..48993fe 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -139,6 +139,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	p->thread.lowest_stack = (unsigned long)task_stack_page(p) +
 						2 * sizeof(unsigned long);
+# ifdef CONFIG_STACKLEAK_METRICS
+	p->thread.prev_lowest_stack = p->thread.lowest_stack;
+# endif
 #endif
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6dc55f6..0355fba 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -284,6 +284,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	p->thread.lowest_stack = (unsigned long)task_stack_page(p) +
 						2 * sizeof(unsigned long);
+# ifdef CONFIG_STACKLEAK_METRICS
+	p->thread.prev_lowest_stack = p->thread.lowest_stack;
+# endif
 #endif
 
 	savesegment(gs, p->thread.gsindex);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324..6a7f9bd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2914,6 +2914,21 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+#ifdef CONFIG_STACKLEAK_METRICS
+static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	unsigned long prev_depth = THREAD_SIZE -
+			(task->thread.prev_lowest_stack & (THREAD_SIZE - 1));
+	unsigned long depth = THREAD_SIZE -
+			(task->thread.lowest_stack & (THREAD_SIZE - 1));
+
+	seq_printf(m, "previous stack depth: %lu\nstack depth: %lu\n",
+							prev_depth, depth);
+	return 0;
+}
+#endif /* CONFIG_STACKLEAK_METRICS */
+
 /*
  * Thread groups
  */
@@ -3018,6 +3033,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
+#ifdef CONFIG_STACKLEAK_METRICS
+	ONE("stack_depth", S_IRUGO, proc_stack_depth),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
-- 
2.7.4
