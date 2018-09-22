Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64872156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FdAG7Yri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64872156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391692AbeIVGIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:08:24 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:33880 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbeIVGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575426; bh=jHBtr0AdnC7HFoorw5G0+KjOkREodldpcutS/tFxros=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=FdAG7YriFXOxj9hVM0L0mh8vUJodJygEMWQMv212Go+HXvdpfw4GGr4z7ZVbmUO9AAjIGP9jF/NTVULoQqf6d8t63Di5Ha0Ej34mO2aHHoEgKv2TcUKkZdnxbrW4LYJTekry3q/NwLRLG2Urkey/Jv1AsA8V6WgnsBzVoNFasACwaXmDUnbuiF2w007dJkyxTxcS0IvGBsfkpW5YvEk45vcb2BWJZpyCKYKVkDM8SL4seVD7uxcqDPYSvkMMdC+86ge8VZ5jUixkBZilh+6elC4pTU7jLAFqSyeGgV392nRuke/GMoYTFOV5p3PxI6vX2t5lyph/WrX38fLESOXKAQ==
X-YMail-OSG: e6PIVnEVM1k7TjjkI0Og4ZaYbDTORr4c5SW0ltMJo0kh.1OHLUmz0gFssqVtC6N
 YKJmANtUFk9eQZlq_.1RvI59rkIk4cgjTKwiCvnRw1mxP7hX20of0SeGF7fqR4sOrak4gBiTtCES
 6ek7NbCwxfiTRXandtj8GI5g7XBQgVsZLq1I1S7evyorE0REphy8tBeQ.t8po0wvRW8XGBAS_2id
 Ygr0cK6J4lQt6dk2SVwFKIdo6CVMwIH_Pgrva1P_e65AE6vQt2uUXQ0hqsQszDTnj1a6MbAYaN6G
 LmaHtoV9JGpm5fcsjS8mu6M93zZzZRRMaGbLG8SGmeAOJSiwCUv93wgKV.lxkJZWelR0UFBQUq8F
 mvKB4ZM7hgRNz.98IT5_qB2Ea.4KUeRgUzsm5WFZJKBFSXfnKuSQWJ72E7IOYQz2XDo63B.AXmBi
 eNtv1iszyoWF21zoGl0KtI2iDgMZQRCCywNOaEcc4VtjmZV43Pzzl_hAfTa0REkQ2aBdfKtvc79H
 jzhwRxAWzkzEidMHsUqupwhW.O.1aG5hAFMz.IuOAV4MPP8IcRK4dSHkxd4gFYR07asVbt1lEKvZ
 NTcU2j1ZjxJU8dC9okOMA8Di6C07x6Q.hY674zAy8Ws8hSosEADPmuxnjRYuecmuJiGUQYtq3h14
 PZ53NQH0M4im1g9kgIwfPnGnAPC27IGwsfDjG9TLSOS0rSafNJjipp87xTYWJNfwprqMkbsuGpJw
 Dtm.OYdKZLgN8mIT2FLyHrAvRYmJi5JT.1c.43nFRurRxYP1_PY1qgb7kcWd7I0BnQbd6KYTf4Pg
 b5up1gLLAJ4J_z41Lm84.Bfd7GO3YEcQB2fiArW2ktm5MPlddiF1TQd1m.C0z64dB1B3XpE0eu7j
 IcULUrr_WJXB9PRvPVW7c91SS3acrbpBStt51YYSxVhtekthy5dxMbe7zdsseZGFWdyecWE0_vtw
 ZqqOnN60JNAqnxljxb6oBagPF6qZxEoB4zvFUG2M52GYlvZFFdDjCT8BGWQ_uTvggJkirjFABl1J
 msRt8tau3WkYQBPVatizL1YXOuA.ShI0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:17:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3614f4a7d4c794340334f868c447edd8;
          Sat, 22 Sep 2018 00:17:04 +0000 (UTC)
Subject: [PATCH v4 01/19] procfs: add smack subdir to attrs
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5f2520f2-fddd-3af8-2142-e89ca402ea5b@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:16:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2007 I made what turned out to be a rather serious
mistake in the implementation of the Smack security module.
The SELinux module used an interface in /proc to manipulate
the security context on processes. Rather than use a similar
interface, I used the same interface. The AppArmor team did
likewise. Now /proc/.../attr/current will tell you the
security "context" of the process, but it will be different
depending on the security module you're using.

This patch provides a subdirectory in /proc/.../attr for
Smack. Smack user space can use the "current" file in
this subdirectory and never have to worry about getting
SELinux attributes by mistake. Programs that use the
old interface will continue to work (or fail, as the case
may be) as before.

The proposed S.A.R.A security module is dependent on
the mechanism to create its own attr subdirectory.

The original implementation is by Kees Cook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/LSM/index.rst | 13 +++--
 fs/proc/base.c                          | 64 +++++++++++++++++++++----
 fs/proc/internal.h                      |  1 +
 include/linux/security.h                | 15 ++++--
 security/security.c                     | 24 ++++++++--
 5 files changed, 96 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index c980dfe9abf1..9842e21afd4a 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -17,9 +17,8 @@ MAC extensions, other extensions can be built using the LSM to provide
 specific changes to system operation when these tweaks are not available
 in the core functionality of Linux itself.
 
-Without a specific LSM built into the kernel, the default LSM will be the
-Linux capabilities system. Most LSMs choose to extend the capabilities
-system, building their checks on top of the defined capability hooks.
+The Linux capabilities modules will always be included. This may be
+followed by any number of "minor" modules and at most one "major" module.
 For more details on capabilities, see ``capabilities(7)`` in the Linux
 man-pages project.
 
@@ -30,6 +29,14 @@ order in which checks are made. The capability module will always
 be first, followed by any "minor" modules (e.g. Yama) and then
 the one "major" module (e.g. SELinux) if there is one configured.
 
+Process attributes associated with "major" security modules should
+be accessed and maintained using the special files in ``/proc/.../attr``.
+A security module may maintain a module specific subdirectory there,
+named after the module. ``/proc/.../attr/smack`` is provided by the Smack
+security module and contains all its special files. The files directly
+in ``/proc/.../attr`` remain as legacy interfaces for modules that provide
+subdirectories.
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ccf86f16d9f0..bd2dd85310fe 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -140,9 +140,13 @@ struct pid_entry {
 #define REG(NAME, MODE, fops)				\
 	NOD(NAME, (S_IFREG|(MODE)), NULL, &fops, {})
 #define ONE(NAME, MODE, show)				\
-	NOD(NAME, (S_IFREG|(MODE)), 			\
+	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_single_file_operations,	\
 		{ .proc_show = show } )
+#define ATTR(LSM, NAME, MODE)				\
+	NOD(NAME, (S_IFREG|(MODE)),			\
+		NULL, &proc_pid_attr_operations,	\
+		{ .lsm = LSM })
 
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
@@ -2503,7 +2507,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
 				      (char*)file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2552,7 +2556,9 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(file->f_path.dentry->d_name.name, page, count);
+	rv = security_setprocattr(PROC_I(inode)->op.lsm,
+				  file->f_path.dentry->d_name.name, page,
+				  count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 out_free:
 	kfree(page);
@@ -2566,13 +2572,53 @@ static const struct file_operations proc_pid_attr_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+#define LSM_DIR_OPS(LSM) \
+static int proc_##LSM##_attr_dir_iterate(struct file *filp, \
+			     struct dir_context *ctx) \
+{ \
+	return proc_pident_readdir(filp, ctx, \
+				   LSM##_attr_dir_stuff, \
+				   ARRAY_SIZE(LSM##_attr_dir_stuff)); \
+} \
+\
+static const struct file_operations proc_##LSM##_attr_dir_ops = { \
+	.read		= generic_read_dir, \
+	.iterate	= proc_##LSM##_attr_dir_iterate, \
+	.llseek		= default_llseek, \
+}; \
+\
+static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
+				struct dentry *dentry, unsigned int flags) \
+{ \
+	return proc_pident_lookup(dir, dentry, \
+				  LSM##_attr_dir_stuff, \
+				  ARRAY_SIZE(LSM##_attr_dir_stuff)); \
+} \
+\
+static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
+	.lookup		= proc_##LSM##_attr_dir_lookup, \
+	.getattr	= pid_getattr, \
+	.setattr	= proc_setattr, \
+}
+
+#ifdef CONFIG_SECURITY_SMACK
+static const struct pid_entry smack_attr_dir_stuff[] = {
+	ATTR("smack", "current",	0666),
+};
+LSM_DIR_OPS(smack);
+#endif
+
 static const struct pid_entry attr_dir_stuff[] = {
-	REG("current",    S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("prev",       S_IRUGO,	   proc_pid_attr_operations),
-	REG("exec",       S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("fscreate",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("keycreate",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("sockcreate", S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	ATTR(NULL, "current",		0666),
+	ATTR(NULL, "prev",		0444),
+	ATTR(NULL, "exec",		0666),
+	ATTR(NULL, "fscreate",		0666),
+	ATTR(NULL, "keycreate",		0666),
+	ATTR(NULL, "sockcreate",	0666),
+#ifdef CONFIG_SECURITY_SMACK
+	DIR("smack",			0555,
+	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
+#endif
 };
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f6a51e..d4f9989063d0 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -81,6 +81,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
+	const char *lsm;
 };
 
 struct proc_inode {
diff --git a/include/linux/security.h b/include/linux/security.h
index 75f4156c84d7..418de5d20ffb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -390,8 +390,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, char *name, char **value);
-int security_setprocattr(const char *name, void *value, size_t size);
+int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+			 char **value);
+int security_setprocattr(const char *lsm, const char *name, void *value,
+			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1139,15 +1141,18 @@ static inline int security_sem_semop(struct kern_ipc_perm *sma,
 	return 0;
 }
 
-static inline void security_d_instantiate(struct dentry *dentry, struct inode *inode)
+static inline void security_d_instantiate(struct dentry *dentry,
+					  struct inode *inode)
 { }
 
-static inline int security_getprocattr(struct task_struct *p, char *name, char **value)
+static inline int security_getprocattr(struct task_struct *p, const char *lsm,
+				       char *name, char **value)
 {
 	return -EINVAL;
 }
 
-static inline int security_setprocattr(char *name, void *value, size_t size)
+static inline int security_setprocattr(const char *lsm, char *name,
+				       void *value, size_t size)
 {
 	return -EINVAL;
 }
diff --git a/security/security.c b/security/security.c
index 736e78da1ab9..3dfe75d0d373 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1288,14 +1288,30 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, char *name, char **value)
+int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+				char **value)
 {
-	return call_int_hook(getprocattr, -EINVAL, p, name, value);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
+		if (lsm != NULL && strcmp(lsm, hp->lsm))
+			continue;
+		return hp->hook.getprocattr(p, name, value);
+	}
+	return -EINVAL;
 }
 
-int security_setprocattr(const char *name, void *value, size_t size)
+int security_setprocattr(const char *lsm, const char *name, void *value,
+			 size_t size)
 {
-	return call_int_hook(setprocattr, -EINVAL, name, value, size);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
+		if (lsm != NULL && strcmp(lsm, hp->lsm))
+			continue;
+		return hp->hook.setprocattr(name, value, size);
+	}
+	return -EINVAL;
 }
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.17.1


