Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672599-2-5830742072360926755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672598; b=a+BvEOmlOdxGQl3WZLl9P0RFRGPf4jncRFcdwjnKAxynZPOAm5
    Vw9/WKS+3jw+pCno8jkdhMR3Pj5jdmByWyQ0yeQCHiBjSxWpRRkSko/94w9ZtewS
    B7D3NnhbJ5w5cLiQSoYZkwUSf+Mc2Xl2eiAnYORki4Uopc2nid7fqK+4G8LnHxwG
    WR0+wXLm4frK4an8PoVFleHBc4GigDHRYOcXTBpnQo9j/WfbU+m2RCZ315ak8OTi
    kHi4h8j88XWHfsKtGecvQhjGTe79UgzYOU6PR75f8KYZ6KRmUnU+QUs0sAI13d87
    j30xQC5sgYWzULj+qG3e1uyE7IxH6VCVwyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672598; bh=
    L1Pl4PCYFDW1i6szpST3YDkp+2Kq61YsOb85kbPgieU=; b=DCDFLNOMpGbgYpQ3
    6+eFSlaERkjptNazaoVnFlbfLHNQrQ5i/WsKJidSagmhrO6yGWmGj6xZJYA6Kd+4
    ImP97n89Rh2jGG6vkzCm8xViFi3soldNtUU5vNHXgBhtANeVrsn42qbOAxUJNNc1
    PZO5ekJSELWaVgNzZX9sE2tOMypU5bz7Dv3Y+2+JwWFbxY7jZ6d+8eNzaR9AYQHI
    s1B24Qe59JUgINv0e2nwdk+s9S8o5wrJEwzy5J+GL7Y2JtJZk0b28sN60XbJEq5X
    SQzhqNMIRb8WC8vpX4Sp8DzNe32BT8/T13ZfAKVm3x9QBGG2Z5rIn6ejfDyQmCXH
    /HBDng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMenWxrvF+r8zavIVWkV5N6IvtfI5BKD5zwD+FVht/J8PP4aku0gLRYm5m9n/XfB2jZYg+upju7I8GqFLeRn7AZsekyne7Znm7QHCLRfllPYFpwixxPX
    NvasNmX3M5RAbah4IShTU5dblIhpw48bWtnA74KnA784+NXqKQS1rP/mC989IgS95s8OipgWCp9qrGP2kerBXeutKHbakh3F7S7Dcoe9cJckgGwgGzy899pG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=vI9DNMBNjRLdc3p7jbwA:9 a=58sF-UeEibTFovSW:21 a=cnCd836_CDpkl5cW:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755435AbeDYQJf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:09:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755814AbeDYQEj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 09/17] y2038: futex: Move compat implementation into futex.c
Date: Wed, 25 Apr 2018 18:03:03 +0200
Message-Id: <20180425160311.2718314-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:wZ+zXlcyCjZP1K2dp4wqrnGdWGCZy4+tPZuKazDHDgR22bt562Z
 OysOsmdbAN5/AYkwhHaizLferE+EznIGegvfg0HYnboXGjg6A8ECxiq0YT5eXKZ6nR0gDsx
 EjWOahyiR7b7Elvu0KcL1Qb+0/k/WQ/Si2Cs1WrpMYoKpFmMwmEL0urf4Fdhvdd/H6PdjEI
 md6WE1kYH258dUoRiwdEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Dx9tbvNdcU=:DLKJ34fO+EkEFrcIMVIGDQ
 bhXFlMCmb4f/q5mgw0a0CDSh4kpRejCxRO33JxaV42xJBSIz7qfEZK5TTc0uW3TMuU4A9sifQ
 ZnVU2L2q3eMu2o8L5Hfx+1c3KaIpVpAGWU3biqkyOuWgSzoaDVHw79qFWz4nDgf9xSefdhxpo
 pem2We4WsloY/hE5dEYmYEsaq53Om9y59eqArQEE1XoXGfuPndfvFIX4zqQIZXxKPBg7TrBgY
 AcE1SbeLBg8pO7BJ+CpI6fv9V7WoKKGxUBF11q1vh1TpQZCCkAuORJYMRoBRaJkDHB4KQyhfQ
 131F1Bz268UI0hIgPGBstaRWlv6w2naTYJ+w2y3PYQ2G9bTenLppQyjW5isGY4tTbjj1MCqYy
 w21SQPmay3gRpk3caSKdF3kBKjA8cdVKWkNk10eOsKhlZxx7eST5fos4Y/4YFWnvEG/zu9Cw2
 RkuWQuV9cafbxoePkVXSxUBZs7nTeFP7ruQZTjps+zz95svIrvezOq9ywdgKyopxbfzuk19YH
 gaafOWTd4FqHgzcIORUUMgfN+Et9dPm7VRxtzKXTeuyOXTtN8DKLwLOeVbA/4FpScelDGvVbB
 om1BfUhzbipz6WYFzJ0bT4z/SnR14hirIcnIoxQ5m4OoqnZen/I0yiR9uyqEktK1OezX4v7qu
 wF+8C7IdbLzxuVKn2aS/pXkP3/Fwf2rYi+XbTPF77NI7hwPDIQVaXOKEk8jwY45DCRyI=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are going to share the compat_sys_futex() handler between 64-bit
architectures and 32-bit architectures that need to deal with both 32-bit
and 64-bit time_t, and this is easier if both entry points are in the
same file.

In fact, most other system call handlers do the same thing these days, so
let's follow the trend here and merge all of futex_compat.c into futex.c.

In the process, a few minor changes have to be done to make sure everything
still makes sense: handle_futex_death() and futex_cmpxchg_enabled() become
local symbol, and the compat version of the fetch_robust_entry() function
gets renamed to compat_fetch_robust_entry() to avoid a symbol clash.

This is intended as a purely cosmetic patch, no behavior should
change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/futex.h |   8 --
 kernel/Makefile       |   3 -
 kernel/futex.c        | 195 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/futex_compat.c | 202 --------------------------------------------------
 4 files changed, 192 insertions(+), 216 deletions(-)
 delete mode 100644 kernel/futex_compat.c

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 821ae502d3d8..ccaef0097785 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -9,9 +9,6 @@ struct inode;
 struct mm_struct;
 struct task_struct;
 
-extern int
-handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi);
-
 /*
  * Futexes are matched on equal values of this key.
  * The key type depends on whether it's a shared or private mapping.
@@ -55,11 +52,6 @@ extern void exit_robust_list(struct task_struct *curr);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
-#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
-#define futex_cmpxchg_enabled 1
-#else
-extern int futex_cmpxchg_enabled;
-#endif
 #else
 static inline void exit_robust_list(struct task_struct *curr)
 {
diff --git a/kernel/Makefile b/kernel/Makefile
index f85ae5dfa474..fbebd38cef8f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -48,9 +48,6 @@ obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
 obj-$(CONFIG_FUTEX) += futex.o
-ifeq ($(CONFIG_COMPAT),y)
-obj-$(CONFIG_FUTEX) += futex_compat.o
-endif
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += smp.o
 ifneq ($(CONFIG_SMP),y)
diff --git a/kernel/futex.c b/kernel/futex.c
index 1f450e092c74..e9013d1e65a1 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -44,6 +44,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fs.h>
@@ -173,8 +174,10 @@
  * double_lock_hb() and double_unlock_hb(), respectively.
  */
 
-#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
-int __read_mostly futex_cmpxchg_enabled;
+#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
+#define futex_cmpxchg_enabled 1
+#else
+static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 
 /*
@@ -3360,7 +3363,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
  * Process a futex-list entry, check whether it's owned by the
  * dying task, and do notification if so:
  */
-int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
+static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
 {
 	u32 uval, uninitialized_var(nval), mval;
 
@@ -3587,6 +3590,192 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 
+#ifdef CONFIG_COMPAT
+/*
+ * Fetch a robust-list pointer. Bit 0 signals PI futexes:
+ */
+static inline int
+compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
+		   compat_uptr_t __user *head, unsigned int *pi)
+{
+	if (get_user(*uentry, head))
+		return -EFAULT;
+
+	*entry = compat_ptr((*uentry) & ~1);
+	*pi = (unsigned int)(*uentry) & 1;
+
+	return 0;
+}
+
+static void __user *futex_uaddr(struct robust_list __user *entry,
+				compat_long_t futex_offset)
+{
+	compat_uptr_t base = ptr_to_compat(entry);
+	void __user *uaddr = compat_ptr(base + futex_offset);
+
+	return uaddr;
+}
+
+/*
+ * Walk curr->robust_list (very carefully, it's a userspace list!)
+ * and mark any locks found there dead, and notify any waiters.
+ *
+ * We silently return on any sign of list-walking problem.
+ */
+void compat_exit_robust_list(struct task_struct *curr)
+{
+	struct compat_robust_list_head __user *head = curr->compat_robust_list;
+	struct robust_list __user *entry, *next_entry, *pending;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
+	unsigned int uninitialized_var(next_pi);
+	compat_uptr_t uentry, next_uentry, upending;
+	compat_long_t futex_offset;
+	int rc;
+
+	if (!futex_cmpxchg_enabled)
+		return;
+
+	/*
+	 * Fetch the list head (which was registered earlier, via
+	 * sys_set_robust_list()):
+	 */
+	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
+		return;
+	/*
+	 * Fetch the relative futex offset:
+	 */
+	if (get_user(futex_offset, &head->futex_offset))
+		return;
+	/*
+	 * Fetch any possibly pending lock-add first, and handle it
+	 * if it exists:
+	 */
+	if (compat_fetch_robust_entry(&upending, &pending,
+			       &head->list_op_pending, &pip))
+		return;
+
+	next_entry = NULL;	/* avoid warning with gcc */
+	while (entry != (struct robust_list __user *) &head->list) {
+		/*
+		 * Fetch the next entry in the list before calling
+		 * handle_futex_death:
+		 */
+		rc = compat_fetch_robust_entry(&next_uentry, &next_entry,
+			(compat_uptr_t __user *)&entry->next, &next_pi);
+		/*
+		 * A pending lock might already be on the list, so
+		 * dont process it twice:
+		 */
+		if (entry != pending) {
+			void __user *uaddr = futex_uaddr(entry, futex_offset);
+
+			if (handle_futex_death(uaddr, curr, pi))
+				return;
+		}
+		if (rc)
+			return;
+		uentry = next_uentry;
+		entry = next_entry;
+		pi = next_pi;
+		/*
+		 * Avoid excessively long or circular lists:
+		 */
+		if (!--limit)
+			break;
+
+		cond_resched();
+	}
+	if (pending) {
+		void __user *uaddr = futex_uaddr(pending, futex_offset);
+
+		handle_futex_death(uaddr, curr, pip);
+	}
+}
+
+COMPAT_SYSCALL_DEFINE2(set_robust_list,
+		struct compat_robust_list_head __user *, head,
+		compat_size_t, len)
+{
+	if (!futex_cmpxchg_enabled)
+		return -ENOSYS;
+
+	if (unlikely(len != sizeof(*head)))
+		return -EINVAL;
+
+	current->compat_robust_list = head;
+
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
+			compat_uptr_t __user *, head_ptr,
+			compat_size_t __user *, len_ptr)
+{
+	struct compat_robust_list_head __user *head;
+	unsigned long ret;
+	struct task_struct *p;
+
+	if (!futex_cmpxchg_enabled)
+		return -ENOSYS;
+
+	rcu_read_lock();
+
+	ret = -ESRCH;
+	if (!pid)
+		p = current;
+	else {
+		p = find_task_by_vpid(pid);
+		if (!p)
+			goto err_unlock;
+	}
+
+	ret = -EPERM;
+	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		goto err_unlock;
+
+	head = p->compat_robust_list;
+	rcu_read_unlock();
+
+	if (put_user(sizeof(*head), len_ptr))
+		return -EFAULT;
+	return put_user(ptr_to_compat(head), head_ptr);
+
+err_unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
+		struct compat_timespec __user *, utime, u32 __user *, uaddr2,
+		u32, val3)
+{
+	struct timespec ts;
+	ktime_t t, *tp = NULL;
+	int val2 = 0;
+	int cmd = op & FUTEX_CMD_MASK;
+
+	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
+		      cmd == FUTEX_WAIT_BITSET ||
+		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+		if (compat_get_timespec(&ts, utime))
+			return -EFAULT;
+		if (!timespec_valid(&ts))
+			return -EINVAL;
+
+		t = timespec_to_ktime(ts);
+		if (cmd == FUTEX_WAIT)
+			t = ktime_add_safe(ktime_get(), t);
+		tp = &t;
+	}
+	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
+	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
+		val2 = (int) (unsigned long) utime;
+
+	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+}
+#endif /* CONFIG_COMPAT */
+
 static void __init futex_detect_cmpxchg(void)
 {
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
diff --git a/kernel/futex_compat.c b/kernel/futex_compat.c
deleted file mode 100644
index 83f830acbb5f..000000000000
--- a/kernel/futex_compat.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/kernel/futex_compat.c
- *
- * Futex compatibililty routines.
- *
- * Copyright 2006, Red Hat, Inc., Ingo Molnar
- */
-
-#include <linux/linkage.h>
-#include <linux/compat.h>
-#include <linux/nsproxy.h>
-#include <linux/futex.h>
-#include <linux/ptrace.h>
-#include <linux/syscalls.h>
-
-#include <linux/uaccess.h>
-
-
-/*
- * Fetch a robust-list pointer. Bit 0 signals PI futexes:
- */
-static inline int
-fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
-		   compat_uptr_t __user *head, unsigned int *pi)
-{
-	if (get_user(*uentry, head))
-		return -EFAULT;
-
-	*entry = compat_ptr((*uentry) & ~1);
-	*pi = (unsigned int)(*uentry) & 1;
-
-	return 0;
-}
-
-static void __user *futex_uaddr(struct robust_list __user *entry,
-				compat_long_t futex_offset)
-{
-	compat_uptr_t base = ptr_to_compat(entry);
-	void __user *uaddr = compat_ptr(base + futex_offset);
-
-	return uaddr;
-}
-
-/*
- * Walk curr->robust_list (very carefully, it's a userspace list!)
- * and mark any locks found there dead, and notify any waiters.
- *
- * We silently return on any sign of list-walking problem.
- */
-void compat_exit_robust_list(struct task_struct *curr)
-{
-	struct compat_robust_list_head __user *head = curr->compat_robust_list;
-	struct robust_list __user *entry, *next_entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
-	compat_uptr_t uentry, next_uentry, upending;
-	compat_long_t futex_offset;
-	int rc;
-
-	if (!futex_cmpxchg_enabled)
-		return;
-
-	/*
-	 * Fetch the list head (which was registered earlier, via
-	 * sys_set_robust_list()):
-	 */
-	if (fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
-		return;
-	/*
-	 * Fetch the relative futex offset:
-	 */
-	if (get_user(futex_offset, &head->futex_offset))
-		return;
-	/*
-	 * Fetch any possibly pending lock-add first, and handle it
-	 * if it exists:
-	 */
-	if (fetch_robust_entry(&upending, &pending,
-			       &head->list_op_pending, &pip))
-		return;
-
-	next_entry = NULL;	/* avoid warning with gcc */
-	while (entry != (struct robust_list __user *) &head->list) {
-		/*
-		 * Fetch the next entry in the list before calling
-		 * handle_futex_death:
-		 */
-		rc = fetch_robust_entry(&next_uentry, &next_entry,
-			(compat_uptr_t __user *)&entry->next, &next_pi);
-		/*
-		 * A pending lock might already be on the list, so
-		 * dont process it twice:
-		 */
-		if (entry != pending) {
-			void __user *uaddr = futex_uaddr(entry, futex_offset);
-
-			if (handle_futex_death(uaddr, curr, pi))
-				return;
-		}
-		if (rc)
-			return;
-		uentry = next_uentry;
-		entry = next_entry;
-		pi = next_pi;
-		/*
-		 * Avoid excessively long or circular lists:
-		 */
-		if (!--limit)
-			break;
-
-		cond_resched();
-	}
-	if (pending) {
-		void __user *uaddr = futex_uaddr(pending, futex_offset);
-
-		handle_futex_death(uaddr, curr, pip);
-	}
-}
-
-COMPAT_SYSCALL_DEFINE2(set_robust_list,
-		struct compat_robust_list_head __user *, head,
-		compat_size_t, len)
-{
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
-	if (unlikely(len != sizeof(*head)))
-		return -EINVAL;
-
-	current->compat_robust_list = head;
-
-	return 0;
-}
-
-COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
-			compat_uptr_t __user *, head_ptr,
-			compat_size_t __user *, len_ptr)
-{
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
-	rcu_read_lock();
-
-	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
-
-	head = p->compat_robust_list;
-	rcu_read_unlock();
-
-	if (put_user(sizeof(*head), len_ptr))
-		return -EFAULT;
-	return put_user(ptr_to_compat(head), head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
-}
-
-COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
-		struct compat_timespec __user *, utime, u32 __user *, uaddr2,
-		u32, val3)
-{
-	struct timespec ts;
-	ktime_t t, *tp = NULL;
-	int val2 = 0;
-	int cmd = op & FUTEX_CMD_MASK;
-
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
-		if (compat_get_timespec(&ts, utime))
-			return -EFAULT;
-		if (!timespec_valid(&ts))
-			return -EINVAL;
-
-		t = timespec_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		tp = &t;
-	}
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (int) (unsigned long) utime;
-
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
-}
-- 
2.9.0

