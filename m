Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3868303-1522706276-2-6000157247319212268
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522706275; b=MYvfzQe4GjwP3tevZpcQThRxise4Oo2CD8TaTHA+F2WTTYtCZH
    sgJCkTVxgefscsZBIT1rODNVWoCwRduSRmcwLaMEuL0CsVhl/k/pHgHokhvidmUM
    BWpUsH9vZKaOFWbByNeBshuwDSWh9WrU6i3VULOpMFtbTFgoX79lXtwbgaYToTw5
    +8EjYXdUfesQsGBAlvQeqKBMaW0ZnZQaKMhkO0E/oS2izeSoOnYU088/MaTO7wSG
    JQHvxFPhgwQYhaZU5rwsojabIEMJ1tlJSx3euWPlovCJk7KHeeZLfwiW+S5He69K
    IMeJJpCqkuZld40XZQf9VHlXqnde3QCfbATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522706275; bh=PcI5T/ZYFZJ1JO1vIvizL+PB5LvlBv
    ttgxAKaDXTAEE=; b=lz86UtvMDZhD6c6j2NPREEqMXF+9Eoq4KGXG/W2RclfoeR
    3p4Ou/wZ1hj3LD103kj7v5SRbkk3NgWPltAIVtrwfwWmCEdJ+wUWhApmQr1JmBrj
    sjsYkkljqgIs/yKMoraJX61MmDHA0ccU+zDc4vF8ONBBKmpKx97ckPm1VkjIcRVU
    sOF2OnMuP2HyPBMXINI7mFqw2jRZK/ISAXfzdaT4MpNRs+Gd1pTx3qRLQpnA4bU5
    dbZa8nxcDnDRhexzA2BXD7nU+TdDY9JKAaEGd/DmyljsK8fFcJyZVyXUp3jDiVPS
    a4GO+itEk3PvjqApvJAeuoZ5+raJMyaPzlSL/clw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=asQ63RrQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=asQ63RrQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF26x1iTTb16gqCymw2/XoRX1/oBddC2wBRLR74JkdDJSSEn8jzh1VrbwZBgrUsZuR/PRBNvaIwGQ136wZEl/p1tYJlVXSmrBjS7AG/T+1Vt3pTk9UIS
    m/rS9tKZbLZQLlu2LI+bKGEl5eck8HIBoVyTQnYEQoly+KzEMifEZppibI8pNEbgtH5RIT0T+vKiteW7INkWagoAQTq0acVSeKTRCIfGTkGM0CN+i0jl2LRW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=6R7veym_AAAA:8
    a=yPCof4ZbAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=cxH8rMpE-Z2fSWl3ltAA:9
    a=x8gzFH9gYPwA:10 a=ILCOIF4F_8SzUMnO7jNM:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeDBV5y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 17:57:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45016 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754512AbeDBV5x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 17:57:53 -0400
From: nagarathnam.muthusamy@oracle.com
To: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, khlebnikov@yandex-team.ru
Cc: akpm@linux-foundation.org, serge.hallyn@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, jannh@google.com,
        nagarathnam.muthusamy@oracle.com, prakash.sangappa@oracle.com
Subject: [RESEND PATCH V4] pidns: introduce syscall translate_pid
Date: Mon,  2 Apr 2018 15:57:29 -0600
Message-Id: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=45 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804020229
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pid_t translate_pid(pid_t pid, int source, int target);

This syscall converts pid from source pid-ns into pid in target pid-ns.
If pid is unreachable from target pid-ns it returns zero.

Pid-namespaces are referred file descriptors opened to proc files
/proc/[pid]/ns/pid or /proc/[pid]/ns/pid_for_children. Negative argument
refers to current pid namespace, same as file /proc/self/ns/pid.

Kernel expose virtual pids in /proc/[pid]/status:NSpid, but backward
translation requires scanning all tasks. Also pids could be translated
by sending them through unix socket between namespaces, this method is
slow and insecure because other side is exposed inside pid namespace.

Examples:
translate_pid(pid, ns, -1)      - get pid in our pid namespace
translate_pid(pid, -1, ns)      - get pid in other pid namespace
translate_pid(1, ns, -1)        - get pid of init task for namespace
translate_pid(pid, -1, ns) > 0  - is pid is reachable from ns?
translate_pid(1, ns1, ns2) > 0  - is ns1 inside ns2?
translate_pid(1, ns1, ns2) == 0 - is ns1 outside ns2?
translate_pid(1, ns1, ns2) == 1 - is ns1 equal ns2?

Error codes:
EBADF    - file descriptor is closed
EINVAL   - file descriptor isn't pid-namespace
ESRCH    - task not found in @source namespace

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
---

v1: https://lkml.org/lkml/2015/9/15/411
v2: https://lkml.org/lkml/2015/9/24/278
 * use namespace-fd as second/third argument
 * add -pid for getting parent pid
 * move code into kernel/sys.c next to getppid
 * drop ifdef CONFIG_PID_NS
 * add generic syscall
v3: https://lkml.org/lkml/2015/9/28/3
 * use proc_ns_fdget()
 * update description
 * rebase to next-20150925
 * fix conflict with mlock2
v4:
 * rename into translate_pid()
 * remove syscall if CONFIG_PID_NS=n
 * drop -pid for parent task
 * drop fget-fdget optimizations
 * add helper get_pid_ns_by_fd()
 * wire only into x86
---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  1 +
 kernel/pid_namespace.c                 | 66 ++++++++++++++++++++++++++++++++++
 kernel/sys_ni.c                        |  3 ++
 5 files changed, 72 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 448ac21..257d839 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -391,3 +391,4 @@
 382	i386	pkey_free		sys_pkey_free
 383	i386	statx			sys_statx
 384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
+385	i386	translate_pid		sys_translate_pid
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5aef183..1ebdab8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -339,6 +339,7 @@
 330	common	pkey_alloc		sys_pkey_alloc
 331	common	pkey_free		sys_pkey_free
 332	common	statx			sys_statx
+333	common	translate_pid		sys_translate_pid
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d..6467ebc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -901,6 +901,7 @@ asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
 asmlinkage long sys_setns(int fd, int nstype);
+asmlinkage long sys_translate_pid(pid_t pid, int source, int target);
 asmlinkage long sys_process_vm_readv(pid_t pid,
 				     const struct iovec __user *lvec,
 				     unsigned long liovcnt,
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 773b2b3..bb56a78 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -13,6 +13,7 @@
 #include <linux/user_namespace.h>
 #include <linux/syscalls.h>
 #include <linux/cred.h>
+#include <linux/file.h>
 #include <linux/err.h>
 #include <linux/acct.h>
 #include <linux/slab.h>
@@ -380,6 +381,71 @@ static void pidns_put(struct ns_common *ns)
 	put_pid_ns(to_pid_ns(ns));
 }
 
+static struct pid_namespace *get_pid_ns_by_fd(int fd)
+{
+	struct pid_namespace *pidns;
+	struct ns_common *ns;
+	struct file *file;
+
+	file = proc_ns_fget(fd);
+	if (IS_ERR(file))
+		return ERR_CAST(file);
+
+	ns = get_proc_ns(file_inode(file));
+	if (ns->ops->type == CLONE_NEWPID)
+		pidns = get_pid_ns(to_pid_ns(ns));
+	else
+		pidns = ERR_PTR(-EINVAL);
+
+	fput(file);
+	return pidns;
+}
+
+/*
+ * translate_pid - convert pid in source pid-ns into target pid-ns.
+ * @pid:    pid for translation
+ * @source: pid-ns file descriptor or -1 for active namespace
+ * @target: pid-ns file descriptor or -1 for active namesapce
+ *
+ * Returns pid in @target pid-ns, zero if task have no pid there,
+ * or -ESRCH if task with @pid does not found in @source pid-ns.
+ */
+SYSCALL_DEFINE3(translate_pid, pid_t, pid, int, source, int, target)
+{
+	struct pid_namespace *source_ns, *target_ns;
+	struct pid *struct_pid;
+	pid_t result;
+
+	if (source >= 0) {
+		source_ns = get_pid_ns_by_fd(source);
+		result = PTR_ERR(source_ns);
+		if (IS_ERR(source_ns))
+			goto err_source;
+	} else
+		source_ns = task_active_pid_ns(current);
+
+	if (target >= 0) {
+		target_ns = get_pid_ns_by_fd(target);
+		result = PTR_ERR(target_ns);
+		if (IS_ERR(target_ns))
+			goto err_target;
+	} else
+		target_ns = task_active_pid_ns(current);
+
+	rcu_read_lock();
+	struct_pid = find_pid_ns(pid, source_ns);
+	result = struct_pid ? pid_nr_ns(struct_pid, target_ns) : -ESRCH;
+	rcu_read_unlock();
+
+	if (target >= 0)
+		put_pid_ns(target_ns);
+err_target:
+	if (source >= 0)
+		put_pid_ns(source_ns);
+err_source:
+	return result;
+}
+
 static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
 {
 	struct pid_namespace *active = task_active_pid_ns(current);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index b518976..bf6ef46 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -259,3 +259,6 @@ asmlinkage long sys_ni_syscall(void)
 cond_syscall(sys_pkey_mprotect);
 cond_syscall(sys_pkey_alloc);
 cond_syscall(sys_pkey_free);
+
+/* pid namespace */
+cond_syscall(sys_translate_pid);
-- 
1.8.3.1

