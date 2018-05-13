Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeEMTRQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbeEMTRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:17:14 -0400
Date: Sun, 13 May 2018 21:17:02 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [PATCH 01/18] kernel: Use pr_fmt
Message-ID: <20180513191701.2dhdxnzxdhfhbcyg@redbean>
References: <cover.1525964381.git.joe@perches.com>
 <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Joe Perches [10/05/18 08:45 -0700]:
>Sometime in the future, it would be useful to convert pr_fmt from a
>default simple define to use a default prefix with KBUILD_MODNAME.
>
>There are files in kernel/ that use pr_<level>, some with an embedded
>prefix, that also do not have a specific pr_fmt define.
>
>Add pr_fmt for those files.
>
>There are some differences in output as some messages are now prefixed
>with their KBUILD_MODNAME.
>
>Miscellanea:
>
>o Align multiline statements to open parenthesis
>o Wrap and realign arguments to 80 columns where sensible
>o Coalesce formats
>
>Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Jessica Yu <jeyu@kernel.org> (for module.c)

>---
> kernel/acct.c          |  2 ++
> kernel/async.c         | 14 ++++++------
> kernel/audit_tree.c    |  2 +-
> kernel/backtracetest.c |  8 +++----
> kernel/crash_core.c    | 29 ++++++++++++++-----------
> kernel/exit.c          |  2 ++
> kernel/hung_task.c     | 13 +++++------
> kernel/kprobes.c       | 20 ++++++++++-------
> kernel/module.c        | 59 +++++++++++++++++++++++---------------------------
> kernel/panic.c         |  3 +++
> kernel/params.c        | 13 ++++++-----
> kernel/pid.c           |  2 ++
> kernel/profile.c       |  2 ++
> kernel/range.c         |  2 +-
> kernel/relay.c         |  5 ++++-
> kernel/seccomp.c       |  4 +++-
> kernel/signal.c        | 10 +++++----
> kernel/smpboot.c       |  5 ++++-
> kernel/taskstats.c     |  4 +++-
> kernel/torture.c       |  6 +++--
> kernel/tracepoint.c    |  3 +++
> kernel/workqueue.c     |  2 ++
> 22 files changed, 122 insertions(+), 88 deletions(-)
>
>diff --git a/kernel/acct.c b/kernel/acct.c
>index addf7732fb56..c3d393655f11 100644
>--- a/kernel/acct.c
>+++ b/kernel/acct.c
>@@ -44,6 +44,8 @@
>  * a struct file opened for write. Fixed. 2/6/2000, AV.
>  */
>
>+#define pr_fmt(fmt) fmt
>+
> #include <linux/mm.h>
> #include <linux/slab.h>
> #include <linux/acct.h>
>diff --git a/kernel/async.c b/kernel/async.c
>index a893d6170944..9a6ab6016713 100644
>--- a/kernel/async.c
>+++ b/kernel/async.c
>@@ -120,8 +120,8 @@ static void async_run_entry_fn(struct work_struct *work)
> 	/* 1) run (and print duration) */
> 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
> 		pr_debug("calling  %lli_%pF @ %i\n",
>-			(long long)entry->cookie,
>-			entry->func, task_pid_nr(current));
>+			 (long long)entry->cookie,
>+			 entry->func, task_pid_nr(current));
> 		calltime = ktime_get();
> 	}
> 	entry->func(entry->data, entry->cookie);
>@@ -129,9 +129,9 @@ static void async_run_entry_fn(struct work_struct *work)
> 		rettime = ktime_get();
> 		delta = ktime_sub(rettime, calltime);
> 		pr_debug("initcall %lli_%pF returned 0 after %lld usecs\n",
>-			(long long)entry->cookie,
>-			entry->func,
>-			(long long)ktime_to_ns(delta) >> 10);
>+			 (long long)entry->cookie,
>+			 entry->func,
>+			 (long long)ktime_to_ns(delta) >> 10);
> 	}
>
> 	/* 2) remove self from the pending queues */
>@@ -300,8 +300,8 @@ void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain
> 		delta = ktime_sub(endtime, starttime);
>
> 		pr_debug("async_continuing @ %i after %lli usec\n",
>-			task_pid_nr(current),
>-			(long long)ktime_to_ns(delta) >> 10);
>+			 task_pid_nr(current),
>+			 (long long)ktime_to_ns(delta) >> 10);
> 	}
> }
> EXPORT_SYMBOL_GPL(async_synchronize_cookie_domain);
>diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>index 67e6956c0b61..f34f90b4a346 100644
>--- a/kernel/audit_tree.c
>+++ b/kernel/audit_tree.c
>@@ -739,7 +739,7 @@ static int audit_launch_prune(void)
> 	prune_thread = kthread_run(prune_tree_thread, NULL,
> 				"audit_prune_tree");
> 	if (IS_ERR(prune_thread)) {
>-		pr_err("cannot start thread audit_prune_tree");
>+		pr_err("cannot start thread audit_prune_tree\n");
> 		prune_thread = NULL;
> 		return -ENOMEM;
> 	}
>diff --git a/kernel/backtracetest.c b/kernel/backtracetest.c
>index 1323360d90e3..d10cc39b0134 100644
>--- a/kernel/backtracetest.c
>+++ b/kernel/backtracetest.c
>@@ -19,7 +19,7 @@
>
> static void backtrace_test_normal(void)
> {
>-	pr_info("Testing a backtrace from process context.\n");
>+	pr_info("Testing a backtrace from process context\n");
> 	pr_info("The following trace is a kernel self test and not a bug!\n");
>
> 	dump_stack();
>@@ -37,7 +37,7 @@ static DECLARE_TASKLET(backtrace_tasklet, &backtrace_test_irq_callback, 0);
>
> static void backtrace_test_irq(void)
> {
>-	pr_info("Testing a backtrace from irq context.\n");
>+	pr_info("Testing a backtrace from irq context\n");
> 	pr_info("The following trace is a kernel self test and not a bug!\n");
>
> 	init_completion(&backtrace_work);
>@@ -51,7 +51,7 @@ static void backtrace_test_saved(void)
> 	struct stack_trace trace;
> 	unsigned long entries[8];
>
>-	pr_info("Testing a saved backtrace.\n");
>+	pr_info("Testing a saved backtrace\n");
> 	pr_info("The following trace is a kernel self test and not a bug!\n");
>
> 	trace.nr_entries = 0;
>@@ -65,7 +65,7 @@ static void backtrace_test_saved(void)
> #else
> static void backtrace_test_saved(void)
> {
>-	pr_info("Saved backtrace test skipped.\n");
>+	pr_info("Saved backtrace test skipped\n");
> }
> #endif
>
>diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>index f7674d676889..4eda1ee9da8c 100644
>--- a/kernel/crash_core.c
>+++ b/kernel/crash_core.c
>@@ -6,6 +6,8 @@
>  * Version 2.  See the file COPYING for more details.
>  */
>
>+#define pr_fmt(fmt) "crashkernel: " fmt
>+
> #include <linux/crash_core.h>
> #include <linux/utsname.h>
> #include <linux/vmalloc.h>
>@@ -49,12 +51,12 @@ static int __init parse_crashkernel_mem(char *cmdline,
> 		/* get the start of the range */
> 		start = memparse(cur, &tmp);
> 		if (cur == tmp) {
>-			pr_warn("crashkernel: Memory value expected\n");
>+			pr_warn("Memory value expected\n");
> 			return -EINVAL;
> 		}
> 		cur = tmp;
> 		if (*cur != '-') {
>-			pr_warn("crashkernel: '-' expected\n");
>+			pr_warn("'-' expected\n");
> 			return -EINVAL;
> 		}
> 		cur++;
>@@ -63,18 +65,18 @@ static int __init parse_crashkernel_mem(char *cmdline,
> 		if (*cur != ':') {
> 			end = memparse(cur, &tmp);
> 			if (cur == tmp) {
>-				pr_warn("crashkernel: Memory value expected\n");
>+				pr_warn("Memory value expected\n");
> 				return -EINVAL;
> 			}
> 			cur = tmp;
> 			if (end <= start) {
>-				pr_warn("crashkernel: end <= start\n");
>+				pr_warn("end <= start\n");
> 				return -EINVAL;
> 			}
> 		}
>
> 		if (*cur != ':') {
>-			pr_warn("crashkernel: ':' expected\n");
>+			pr_warn("':' expected\n");
> 			return -EINVAL;
> 		}
> 		cur++;
>@@ -86,7 +88,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
> 		}
> 		cur = tmp;
> 		if (size >= system_ram) {
>-			pr_warn("crashkernel: invalid size\n");
>+			pr_warn("invalid size\n");
> 			return -EINVAL;
> 		}
>
>@@ -108,8 +110,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
> 				return -EINVAL;
> 			}
> 		}
>-	} else
>-		pr_info("crashkernel size resulted in zero bytes\n");
>+	} else {
>+		pr_info("size resulted in zero bytes\n");
>+	}
>
> 	return 0;
> }
>@@ -129,14 +132,14 @@ static int __init parse_crashkernel_simple(char *cmdline,
>
> 	*crash_size = memparse(cmdline, &cur);
> 	if (cmdline == cur) {
>-		pr_warn("crashkernel: memory value expected\n");
>+		pr_warn("memory value expected\n");
> 		return -EINVAL;
> 	}
>
> 	if (*cur == '@')
> 		*crash_base = memparse(cur+1, &cur);
> 	else if (*cur != ' ' && *cur != '\0') {
>-		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
>+		pr_warn("unrecognized char: %c\n", *cur);
> 		return -EINVAL;
> 	}
>
>@@ -167,18 +170,18 @@ static int __init parse_crashkernel_suffix(char *cmdline,
>
> 	*crash_size = memparse(cmdline, &cur);
> 	if (cmdline == cur) {
>-		pr_warn("crashkernel: memory value expected\n");
>+		pr_warn("memory value expected\n");
> 		return -EINVAL;
> 	}
>
> 	/* check with suffix */
> 	if (strncmp(cur, suffix, strlen(suffix))) {
>-		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
>+		pr_warn("unrecognized char: %c\n", *cur);
> 		return -EINVAL;
> 	}
> 	cur += strlen(suffix);
> 	if (*cur != ' ' && *cur != '\0') {
>-		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
>+		pr_warn("unrecognized char: %c\n", *cur);
> 		return -EINVAL;
> 	}
>
>diff --git a/kernel/exit.c b/kernel/exit.c
>index 68e1598d7931..679d4de9a5fa 100644
>--- a/kernel/exit.c
>+++ b/kernel/exit.c
>@@ -4,6 +4,8 @@
>  *  Copyright (C) 1991, 1992  Linus Torvalds
>  */
>
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/mm.h>
> #include <linux/slab.h>
> #include <linux/sched/autogroup.h>
>diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>index 32b479468e4d..c66278415811 100644
>--- a/kernel/hung_task.c
>+++ b/kernel/hung_task.c
>@@ -113,14 +113,13 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> 	if (sysctl_hung_task_warnings) {
> 		if (sysctl_hung_task_warnings > 0)
> 			sysctl_hung_task_warnings--;
>-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
>-			t->comm, t->pid, timeout);
>+		pr_err("INFO: task %s:%d blocked for more than %ld seconds\n",
>+		       t->comm, t->pid, timeout);
> 		pr_err("      %s %s %.*s\n",
>-			print_tainted(), init_utsname()->release,
>-			(int)strcspn(init_utsname()->version, " "),
>-			init_utsname()->version);
>-		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>-			" disables this message.\n");
>+		       print_tainted(), init_utsname()->release,
>+		       (int)strcspn(init_utsname()->version, " "),
>+		       init_utsname()->version);
>+		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\" disables this message\n");
> 		sched_show_task(t);
> 		hung_task_show_lock = true;
> 	}
>diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>index ea619021d901..0b8facde8dd0 100644
>--- a/kernel/kprobes.c
>+++ b/kernel/kprobes.c
>@@ -31,6 +31,9 @@
>  *		<jkenisto@us.ibm.com> and Prasanna S Panchamukhi
>  *		<prasanna@in.ibm.com> added function-return probes.
>  */
>+
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/kprobes.h>
> #include <linux/hash.h>
> #include <linux/init.h>
>@@ -985,7 +988,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
> 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
> 				   (unsigned long)p->addr, 0, 0);
> 	if (ret) {
>-		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
>+		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n",
>+			 p->addr, ret);
> 		return ret;
> 	}
>
>@@ -2198,7 +2202,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
> 		if (!kernel_text_address(entry) ||
> 		    !kallsyms_lookup_size_offset(entry, &size, &offset)) {
> 			pr_err("Failed to find blacklist at %p\n",
>-				(void *)entry);
>+			       (void *)entry);
> 			continue;
> 		}
>
>@@ -2281,8 +2285,8 @@ static int __init init_kprobes(void)
> 	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
> 					__stop_kprobe_blacklist);
> 	if (err) {
>-		pr_err("kprobes: failed to populate blacklist: %d\n", err);
>-		pr_err("Please take care of using kprobes.\n");
>+		pr_err("failed to populate blacklist: %d\n", err);
>+		pr_err("Please take care of using kprobes\n");
> 	}
>
> 	if (kretprobe_blacklist_size) {
>@@ -2488,10 +2492,10 @@ static int arm_all_kprobes(void)
> 	}
>
> 	if (errors)
>-		pr_warn("Kprobes globally enabled, but failed to arm %d out of %d probes\n",
>+		pr_warn("globally enabled, but failed to arm %d out of %d probes\n",
> 			errors, total);
> 	else
>-		pr_info("Kprobes globally enabled\n");
>+		pr_info("globally enabled\n");
>
> already_enabled:
> 	mutex_unlock(&kprobe_mutex);
>@@ -2531,10 +2535,10 @@ static int disarm_all_kprobes(void)
> 	}
>
> 	if (errors)
>-		pr_warn("Kprobes globally disabled, but failed to disarm %d out of %d probes\n",
>+		pr_warn("globally disabled, but failed to disarm %d out of %d probes\n",
> 			errors, total);
> 	else
>-		pr_info("Kprobes globally disabled\n");
>+		pr_info("globally disabled\n");
>
> 	mutex_unlock(&kprobe_mutex);
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 36543e382389..94624b46c9bd 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -16,6 +16,9 @@
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> */
>+
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/export.h>
> #include <linux/extable.h>
> #include <linux/moduleloader.h>
>@@ -523,21 +526,17 @@ static bool check_symbol(const struct symsearch *syms,
> 		if (syms->licence == GPL_ONLY)
> 			return false;
> 		if (syms->licence == WILL_BE_GPL_ONLY && fsa->warn) {
>-			pr_warn("Symbol %s is being used by a non-GPL module, "
>-				"which will not be allowed in the future\n",
>+			pr_warn("Symbol %s is being used by a non-GPL module, which will not be allowed in the future.\n",
> 				fsa->name);
> 		}
> 	}
>
> #ifdef CONFIG_UNUSED_SYMBOLS
> 	if (syms->unused && fsa->warn) {
>-		pr_warn("Symbol %s is marked as UNUSED, however this module is "
>-			"using it.\n", fsa->name);
>+		pr_warn("Symbol %s is marked as UNUSED, however this module is using it.\n",
>+			fsa->name);
> 		pr_warn("This symbol will go away in the future.\n");
>-		pr_warn("Please evaluate if this is the right api to use and "
>-			"if it really is, submit a report to the linux kernel "
>-			"mailing list together with submitting your code for "
>-			"inclusion.\n");
>+		pr_warn("Please evaluate if this is the right api to use and if it really is, submit a report to the linux kernel mailing list together with submitting your code for inclusion.\n");
> 	}
> #endif
>
>@@ -843,7 +842,7 @@ static int add_module_usage(struct module *a, struct module *b)
> {
> 	struct module_use *use;
>
>-	pr_debug("Allocating new usage for %s.\n", a->name);
>+	pr_debug("Allocating new usage for %s\n", a->name);
> 	use = kmalloc(sizeof(*use), GFP_ATOMIC);
> 	if (!use)
> 		return -ENOMEM;
>@@ -1265,7 +1264,7 @@ static int try_to_force_load(struct module *mod, const char *reason)
> {
> #ifdef CONFIG_MODULE_FORCE_LOAD
> 	if (!test_taint(TAINT_FORCED_MODULE))
>-		pr_warn("%s: %s: kernel tainted.\n", mod->name, reason);
>+		pr_warn("%s: %s: kernel tainted\n", mod->name, reason);
> 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
> 	return 0;
> #else
>@@ -1435,7 +1434,7 @@ resolve_symbol_wait(struct module *mod,
> 			!IS_ERR(ksym = resolve_symbol(mod, info, name, owner))
> 			|| PTR_ERR(ksym) != -EBUSY,
> 					     30 * HZ) <= 0) {
>-		pr_warn("%s: gave up waiting for init of module %s.\n",
>+		pr_warn("%s: gave up waiting for init of module %s\n",
> 			mod->name, owner);
> 	}
> 	return ksym;
>@@ -2224,8 +2223,7 @@ static int verify_export_symbols(struct module *mod)
> 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
> 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
> 			if (find_symbol(s->name, &owner, NULL, true, false)) {
>-				pr_err("%s: exports duplicate symbol %s"
>-				       " (owned by %s)\n",
>+				pr_err("%s: exports duplicate symbol %s (owned by %s)\n",
> 				       mod->name, s->name, module_name(owner));
> 				return -ENOEXEC;
> 			}
>@@ -2257,14 +2255,14 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
> 			   supposed to happen.  */
> 			pr_debug("Common symbol: %s\n", name);
> 			pr_warn("%s: please compile with -fno-common\n",
>-			       mod->name);
>+				mod->name);
> 			ret = -ENOEXEC;
> 			break;
>
> 		case SHN_ABS:
> 			/* Don't need to do anything */
> 			pr_debug("Absolute symbol: 0x%08lx\n",
>-			       (long)sym[i].st_value);
>+				 (long)sym[i].st_value);
> 			break;
>
> 		case SHN_LIVEPATCH:
>@@ -2454,7 +2452,7 @@ static void set_license(struct module *mod, const char *license)
>
> 	if (!license_is_gpl_compatible(license)) {
> 		if (!test_taint(TAINT_PROPRIETARY_MODULE))
>-			pr_warn("%s: module license '%s' taints kernel.\n",
>+			pr_warn("%s: module license '%s' taints kernel\n",
> 				mod->name, license);
> 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
> 				 LOCKDEP_NOW_UNRELIABLE);
>@@ -2717,7 +2715,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
> #ifdef CONFIG_DYNAMIC_DEBUG
> 	if (ddebug_add_module(debug, num, mod->name))
> 		pr_err("dynamic debug error adding module: %s\n",
>-			debug->modname);
>+		       debug->modname);
> #endif
> }
>
>@@ -2849,7 +2847,7 @@ static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
> static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
> {
> 	if (get_modinfo(info, "livepatch")) {
>-		pr_err("%s: module is marked as livepatch module, but livepatch support is disabled",
>+		pr_err("%s: module is marked as livepatch module, but livepatch support is disabled\n",
> 		       mod->name);
> 		return -ENOEXEC;
> 	}
>@@ -2863,7 +2861,7 @@ static void check_modinfo_retpoline(struct module *mod, struct load_info *info)
> 	if (retpoline_module_ok(get_modinfo(info, "retpoline")))
> 		return;
>
>-	pr_warn("%s: loading module not compiled with retpoline compiler.\n",
>+	pr_warn("%s: loading module not compiled with retpoline compiler\n",
> 		mod->name);
> }
>
>@@ -3037,8 +3035,8 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
>
> 	if (get_modinfo(info, "staging")) {
> 		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);
>-		pr_warn("%s: module is from the staging directory, the quality "
>-			"is unknown, you have been warned.\n", mod->name);
>+		pr_warn("%s: module is from the staging directory, the quality is unknown, you have been warned\n",
>+			mod->name);
> 	}
>
> 	err = check_modinfo_livepatch(mod, info);
>@@ -3089,8 +3087,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> 		 * This shouldn't happen with same compiler and binutils
> 		 * building all parts of the module.
> 		 */
>-		pr_warn("%s: has both .ctors and .init_array.\n",
>-		       mod->name);
>+		pr_warn("%s: has both .ctors and .init_array\n",
>+			mod->name);
> 		return -EINVAL;
> 	}
> #endif
>@@ -3227,7 +3225,7 @@ static int check_module_license_and_versions(struct module *mod)
> 				 LOCKDEP_NOW_UNRELIABLE);
>
> 	if (!prev_taint && test_taint(TAINT_PROPRIETARY_MODULE))
>-		pr_warn("%s: module license taints kernel.\n", mod->name);
>+		pr_warn("%s: module license taints kernel\n", mod->name);
>
> #ifdef CONFIG_MODVERSIONS
> 	if ((mod->num_syms && !mod->crcs)
>@@ -3459,8 +3457,7 @@ static noinline int do_init_module(struct module *mod)
> 		goto fail_free_freeinit;
> 	}
> 	if (ret > 0) {
>-		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
>-			"follow 0/-E convention\n"
>+		pr_warn("%s: '%s'->init suspiciously returned %d, it should follow 0/-E convention\n"
> 			"%s: loading module anyway...\n",
> 			__func__, mod->name, ret, __func__);
> 		dump_stack();
>@@ -3686,9 +3683,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
> #ifdef CONFIG_MODULE_SIG
> 	mod->sig_ok = info->sig_ok;
> 	if (!mod->sig_ok) {
>-		pr_notice_once("%s: module verification failed: signature "
>-			       "and/or required key missing - tainting "
>-			       "kernel\n", mod->name);
>+		pr_notice_once("%s: module verification failed: signature and/or required key missing - tainting kernel\n",
>+			       mod->name);
> 		add_taint_module(mod, TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
> 	}
> #endif
>@@ -3763,7 +3759,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> 		goto coming_cleanup;
> 	} else if (after_dashes) {
> 		pr_warn("%s: parameters '%s' after `--' ignored\n",
>-		       mod->name, after_dashes);
>+			mod->name, after_dashes);
> 	}
>
> 	/* Link in to sysfs. */
>@@ -3843,8 +3839,7 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
> 	if (err)
> 		return err;
>
>-	pr_debug("init_module: umod=%p, len=%lu, uargs=%p\n",
>-	       umod, len, uargs);
>+	pr_debug("init_module: umod=%p, len=%lu, uargs=%p\n", umod, len, uargs);
>
> 	err = copy_module_from_user(umod, len, &info);
> 	if (err)
>diff --git a/kernel/panic.c b/kernel/panic.c
>index 42e487488554..e34631818bb7 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -8,6 +8,9 @@
>  * This function is used through-out the kernel (including mm and fs)
>  * to indicate a major problem.
>  */
>+
>+#define pr_fmt(fmt) fmt
>+
> #include <linux/debug_locks.h>
> #include <linux/sched/debug.h>
> #include <linux/interrupt.h>
>diff --git a/kernel/params.c b/kernel/params.c
>index ce89f757e6da..757049bfa346 100644
>--- a/kernel/params.c
>+++ b/kernel/params.c
>@@ -15,6 +15,9 @@
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> */
>+
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/kernel.h>
> #include <linux/string.h>
> #include <linux/errno.h>
>@@ -141,8 +144,8 @@ static int parse_one(char *param,
> 			if (!val &&
> 			    !(params[i].ops->flags & KERNEL_PARAM_OPS_FL_NOARG))
> 				return -EINVAL;
>-			pr_debug("handling %s with %p\n", param,
>-				params[i].ops->set);
>+			pr_debug("handling %s with %p\n",
>+				 param, params[i].ops->set);
> 			kernel_param_lock(params[i].mod);
> 			param_check_unsafe(&params[i]);
> 			err = params[i].ops->set(val, &params[i]);
>@@ -496,8 +499,8 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
> 	const struct kparam_string *kps = kp->str;
>
> 	if (strlen(val)+1 > kps->maxlen) {
>-		pr_err("%s: string doesn't fit in %u chars.\n",
>-		       kp->name, kps->maxlen-1);
>+		pr_err("%s: string doesn't fit in %u chars\n",
>+		       kp->name, kps->maxlen - 1);
> 		return -ENOSPC;
> 	}
> 	strcpy(kps->string, val);
>@@ -763,7 +766,7 @@ static struct module_kobject * __init locate_module_kobject(const char *name)
> #endif
> 		if (err) {
> 			kobject_put(&mk->kobj);
>-			pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
>+			pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable\n",
> 				name, err);
> 			return NULL;
> 		}
>diff --git a/kernel/pid.c b/kernel/pid.c
>index 157fe4b19971..2ddd7adfa77d 100644
>--- a/kernel/pid.c
>+++ b/kernel/pid.c
>@@ -26,6 +26,8 @@
>  *
>  */
>
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/mm.h>
> #include <linux/export.h>
> #include <linux/slab.h>
>diff --git a/kernel/profile.c b/kernel/profile.c
>index 9aa2a4445b0d..e5cc8f360236 100644
>--- a/kernel/profile.c
>+++ b/kernel/profile.c
>@@ -14,6 +14,8 @@
>  *	Oracle, 2004
>  */
>
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/export.h>
> #include <linux/profile.h>
> #include <linux/bootmem.h>
>diff --git a/kernel/range.c b/kernel/range.c
>index d84de6766472..e828c950d401 100644
>--- a/kernel/range.c
>+++ b/kernel/range.c
>@@ -102,7 +102,7 @@ void subtract_range(struct range *range, int az, u64 start, u64 end)
> 				range[i].start = end;
> 			} else {
> 				pr_err("%s: run out of slot in ranges\n",
>-					__func__);
>+				       __func__);
> 			}
> 			range[j].end = start;
> 			continue;
>diff --git a/kernel/relay.c b/kernel/relay.c
>index c955b10c973c..02f3790af754 100644
>--- a/kernel/relay.c
>+++ b/kernel/relay.c
>@@ -12,6 +12,9 @@
>  *
>  * This file is released under the GPL.
>  */
>+
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/errno.h>
> #include <linux/stddef.h>
> #include <linux/slab.h>
>@@ -527,7 +530,7 @@ int relay_prepare_cpu(unsigned int cpu)
> 			continue;
> 		buf = relay_open_buf(chan, cpu);
> 		if (!buf) {
>-			pr_err("relay: cpu %d buffer creation failed\n", cpu);
>+			pr_err("cpu %d buffer creation failed\n", cpu);
> 			mutex_unlock(&relay_channels_mutex);
> 			return -ENOMEM;
> 		}
>diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>index 5386749cdd21..de696bc574b4 100644
>--- a/kernel/seccomp.c
>+++ b/kernel/seccomp.c
>@@ -14,6 +14,8 @@
>  *        of Berkeley Packet Filters/Linux Socket Filters.
>  */
>
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/refcount.h>
> #include <linux/audit.h>
> #include <linux/compat.h>
>@@ -1323,7 +1325,7 @@ static int __init seccomp_sysctl_init(void)
>
> 	hdr = register_sysctl_paths(seccomp_sysctl_path, seccomp_sysctl_table);
> 	if (!hdr)
>-		pr_warn("seccomp: sysctl registration failed\n");
>+		pr_warn("sysctl registration failed\n");
> 	else
> 		kmemleak_not_leak(hdr);
>
>diff --git a/kernel/signal.c b/kernel/signal.c
>index 0f865d67415d..4b93feddcdcd 100644
>--- a/kernel/signal.c
>+++ b/kernel/signal.c
>@@ -10,6 +10,8 @@
>  *		to allow signals to be sent reliably.
>  */
>
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/slab.h>
> #include <linux/export.h>
> #include <linux/init.h>
>@@ -235,7 +237,7 @@ static inline void print_dropped_signal(int sig)
> 		return;
>
> 	pr_info("%s/%d: reached RLIMIT_SIGPENDING, dropped signal %d\n",
>-				current->comm, current->pid, sig);
>+		current->comm, current->pid, sig);
> }
>
> /**
>@@ -1118,10 +1120,10 @@ static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
> static void print_fatal_signal(int signr)
> {
> 	struct pt_regs *regs = signal_pt_regs();
>-	pr_info("potentially unexpected fatal signal %d.\n", signr);
>+	pr_info("potentially unexpected fatal signal %d\n", signr);
>
> #if defined(__i386__) && !defined(__arch_um__)
>-	pr_info("code at %08lx: ", regs->ip);
>+	pr_info("code at %08lx:", regs->ip);
> 	{
> 		int i;
> 		for (i = 0; i < 16; i++) {
>@@ -1129,7 +1131,7 @@ static void print_fatal_signal(int signr)
>
> 			if (get_user(insn, (unsigned char *)(regs->ip + i)))
> 				break;
>-			pr_cont("%02x ", insn);
>+			pr_cont(" %02x", insn);
> 		}
> 	}
> 	pr_cont("\n");
>diff --git a/kernel/smpboot.c b/kernel/smpboot.c
>index 5043e7433f4b..17e129faf498 100644
>--- a/kernel/smpboot.c
>+++ b/kernel/smpboot.c
>@@ -1,6 +1,9 @@
> /*
>  * Common SMP CPU bringup/teardown functions
>  */
>+
>+#define pr_fmt(fmt) "SMP: " fmt
>+
> #include <linux/cpu.h>
> #include <linux/err.h>
> #include <linux/smp.h>
>@@ -54,7 +57,7 @@ static inline void idle_init(unsigned int cpu)
> 	if (!tsk) {
> 		tsk = fork_idle(cpu);
> 		if (IS_ERR(tsk))
>-			pr_err("SMP: fork_idle() failed for CPU %u\n", cpu);
>+			pr_err("fork_idle() failed for CPU %u\n", cpu);
> 		else
> 			per_cpu(idle_threads, cpu) = tsk;
> 	}
>diff --git a/kernel/taskstats.c b/kernel/taskstats.c
>index 4e62a4a8fa91..8973cb0a1eab 100644
>--- a/kernel/taskstats.c
>+++ b/kernel/taskstats.c
>@@ -16,6 +16,8 @@
>  *
>  */
>
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/kernel.h>
> #include <linux/taskstats_kern.h>
> #include <linux/tsacct_kern.h>
>@@ -690,7 +692,7 @@ static int __init taskstats_init(void)
> 		return rc;
>
> 	family_registered = 1;
>-	pr_info("registered taskstats version %d\n", TASKSTATS_GENL_VERSION);
>+	pr_info("registered version %d\n", TASKSTATS_GENL_VERSION);
> 	return 0;
> }
>
>diff --git a/kernel/torture.c b/kernel/torture.c
>index 3de1efbecd6a..da4f95c11bf9 100644
>--- a/kernel/torture.c
>+++ b/kernel/torture.c
>@@ -20,6 +20,9 @@
>  * Author: Paul E. McKenney <paulmck@us.ibm.com>
>  *	Based on kernel/rcu/torture.c.
>  */
>+
>+#define pr_fmt(fmt) fmt
>+
> #include <linux/types.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
>@@ -99,8 +102,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
> 		return false;
>
> 	if (verbose)
>-		pr_alert("%s" TORTURE_FLAG
>-			 "torture_onoff task: offlining %d\n",
>+		pr_alert("%s" TORTURE_FLAG "torture_onoff task: offlining %d\n",
> 			 torture_type, cpu);
> 	starttime = jiffies;
> 	(*n_offl_attempts)++;
>diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>index 1e37da2e0c25..d4753ff47738 100644
>--- a/kernel/tracepoint.c
>+++ b/kernel/tracepoint.c
>@@ -15,6 +15,9 @@
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>  */
>+
>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>+
> #include <linux/module.h>
> #include <linux/mutex.h>
> #include <linux/types.h>
>diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>index ca7959be8aaa..7f1f75abcf7c 100644
>--- a/kernel/workqueue.c
>+++ b/kernel/workqueue.c
>@@ -24,6 +24,8 @@
>  * Please read Documentation/core-api/workqueue.rst for details.
>  */
>
>+#define pr_fmt(fmt) fmt
>+
> #include <linux/export.h>
> #include <linux/kernel.h>
> #include <linux/sched.h>
>-- 
>2.15.0
>
