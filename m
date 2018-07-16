Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B204EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4246F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NaWOealQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4246F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeGPSux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:50:53 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:38473
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728437AbeGPSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765334; bh=d/vmz6vSDSMIVJV6IXMNPvqucG4HukPC64vAOkv0fjM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NaWOealQ/IJKdWn9WCRTOJvNK/gzvaipp1YVBfHuM2KifE2hhH/unrxOL2SqEaarQieZ4IrX5nIXEAuzDiEQ84sl9418bGbeDZd+/TS9O4aHXUFmKJCgxa185hZ1oeEMl5TzyNGPF++XsBK+FuelUzGUOIuRAkBJfbYJGdPm0dcTeT4KUbP+NIpwFirUvm8g0vwCoOzOHnSYp3b3wNS0XRyoELTQXAV5s4aPhsck5qPD8YuQ9gGGdnEldFerY7fru+I69gnP6U2P8yHJsK8/zBCo+wf1WKoF/rZQVBvWund0BWwhfOFug7P49an5JXc2lJ1UJMVvFbLDod/tMAjkhw==
X-YMail-OSG: DF3HyoAVM1kpkA5fkPJNdJjMXxRbLi0_9gRHfbs.zuZRHLvAQxlEdfRalhBNUYK
 8_O4cULXgEuGKL_I96atGSUBsF_uSOHvYFdrHYcBZU2pDPNQWvug7BRDV.zD8D89iG.hPm8_ACgU
 1lRUF9sEkW8e2tKswy7RJ2HFUYsPELx5FQFvg1wfSdkT.j0_yYzJWPeMUWnR9a2lUaA39wnnU1xr
 aT_9iKhva5y7r.8cvxNygAQIx0p3W28gps7E_4OXiKSU_5bXpGGDTCTpELO1ZBigEi885BNz3DAW
 NJ_YsAaLe00U1T6usCOj_W.JPYLpkbjdkXnADuHrNG54uG2nQSTwcAOTRI.zp5.xVtoxW7QQeUmf
 TMNCTP36o6wCBh6Lmihg9jHAYsVUAaW6uqWVqgsWOJa4T4JOaC8L7QZHxK.2KmLIkKOLgObCvxkp
 TwhxWz7WKBaiCkSnlzu_0piHALgWMjjCtX8KFyRBNpOoMHhLbnEJqvZhkV_H.Mut5A1P0S9vZeWF
 qWSZeplpUovSRSJxYbfQ6DdoOZQi5KzyhwnLgHsqPX93PuU8LIWsXpunNs_PKgizS7lxVuS9R5sf
 0GiL5RBfdXtbzwJdCGm.cdW1wFl36pMhsI8fha5DM97xVDaPO3h85D47Z6Ck8Y1VwVbiQB6fkJ2Z
 FK8Of2tpFpE4JnZV5_zMS77GPr34CgNGFU3nEydZHYbSSSJRO0pEhIGn2AKkDJgl5Cc_zKGI75DA
 GsuJeCiGLZpdJFGy6bSlkar7W8lVYihJGVw1hdshzIWDlqkbc8jstJjNpmwWjbgZUNFLuP1G2yCm
 KAPmvo0UBqAESs3TvS4qU_ioIv7iMMHuhzbswAlZvq241eDLBuLm0WrjYyyPyCnqsRQsXe3rYc0o
 wbfR8GOocdoUXoK0rfuuOjlHG1PHZDy53sFBk9jLFMeeY9kfwr6mRCDZpUZHCSCOSHRkZTyRq4CV
 P4kz5upYvxocQvp8ehMYBkna2GmpIlCr.7CMtOpAOLtu8kf9qron6gJQ.XrF2dwOeLss3T4mZpiw
 N36lr4g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:22:14 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7f32793b97b28b63a55e1d3e9dc6902e;
          Mon, 16 Jul 2018 18:22:13 +0000 (UTC)
Subject: [PATCH v1 01/22] procfs: add smack subdir to attrs
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8d4f0b29-7510-7957-d64a-935518a87e77@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:22:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

procfs: add smack subdir to attrs

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

The original implementation is by Kees Cook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst | 13 +++--
 fs/proc/base.c                          | 63 +++++++++++++++++++++----
 fs/proc/internal.h                      |  1 +
 include/linux/security.h                | 15 ++++--
 security/security.c                     | 24 ++++++++--
 5 files changed, 95 insertions(+), 21 deletions(-)

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
index aaffc0c30216..53af928c13cc 100644
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
@@ -2505,7 +2509,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
 				      (char*)file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2551,7 +2555,8 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (length < 0)
 		goto out_free;
 
-	length = security_setprocattr(file->f_path.dentry->d_name.name,
+	length = security_setprocattr(PROC_I(inode)->op.lsm,
+				      file->f_path.dentry->d_name.name,
 				      page, count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 out_free:
@@ -2568,13 +2573,53 @@ static const struct file_operations proc_pid_attr_operations = {
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
index da3dbfa09e79..acda9189d01e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -84,6 +84,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
+	const char *lsm;
 };
 
 struct proc_inode {
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..9bdb23799b03 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -368,8 +368,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1113,15 +1115,18 @@ static inline int security_sem_semop(struct kern_ipc_perm *sma,
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
index 68f46d849abe..2551c4778a09 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1267,14 +1267,30 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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


