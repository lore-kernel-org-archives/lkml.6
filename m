Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4159ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DCD2156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kNU8VtAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DCD2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbeIVGIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:08:36 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:46480 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391699AbeIVGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575437; bh=MnqnWnzHOkd2XlWvfSIXxqEnsufnVOpiMDOJOGJfGRs=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=kNU8VtAMsKpcs6Za5W7rEgKtBdP7l7QRnfTAUk84xUS1X6v8gKIzmj+kU28XgDcQLkqbIq3TwFGObxpgBnvAwsdDmx38SGa64O1Kr+kNWYE3vKYtZHf3j3MEhe+FFRf0YPlHxTWqoJ9wPZccfTTLyrgHnwJxNMsHYiwpew6BYLlGTn8i6QvcExMiUXHpnOYpeLFyY0a93HvPTyNMlw6uklAYCHJlG3liQcnvlA7wYM/55RU3YwcJMjjZewdow9OANWLncGr6x2LHQh+uqIFvfwYV+FjW7EyVu20DrDLzeKJPRCvh8a1QeNIG+drXBLS3yKa/QxJ2tjVT19YIp0XoxA==
X-YMail-OSG: 6R7mYVAVM1lOIATux6udexBjqaMA7hAHv.zLMEsz545qcp1fZQkmBkpSXhoHfFv
 wUWxMLoNr.lB.eiCTJMOuPzAGg8A.gbi1TE8OfT6Y13TVvE.gEMQhdWfnbRzwyKHagSRVIEmkUVj
 1ggvSjDptEGS8xcsSYXc3dGCckZLKvIbKOPAd45TcFpiza7HZvXpHhqeHWXWqNn0Yoq6aEoG2zpu
 rJT5LGuIY8BvbzbiOJ4J0KOJ1ohy4W.gHGNkNg79xOmF5PvKtdk7uSpEjmSOZwavhWUpeQ2IiG6u
 PewIcq26dCP0ksBGhqKhtsguA21B5aDtyd1IIPy7PaXDze0rucpOtUEJf2JKeeH2V1wPK.kctOXd
 Bwekvcg_Z0PkKNdcO.6Lsqo20d15guF_AxCFiOdfI8PX.i.eWFpMxnE829ketc8FZZ1.vinSoJoe
 fEI5FGGThf7basZP1qfY5oazRfi0DyhcnYg8gTa7w7tYAeimWvG9DvhDdX4G5dgUC4N2kaA8KtNT
 tsFuZ5Br4DHy3tZXvLFsmnOEkm101lqYqth4SdchKb5bLp2LoBSSaojsxfKzNVEBSD0BeP_hDZGq
 H4Ju8UAO07qUGVcomV9JR_DhmME.tFvrw8sNUzjCrKOAfF_ByYoMONJnvQDEU6KIIkOHmK0aKyke
 jIO4ZuR4DBmtHFzDyiLhPmqHyyEuo5SnYwiL7mnMenJ8WAbsgpUIdD_YwbL2ycppR2DrsoPrFQP8
 1f4mQWYr3R9FuEzhx0xcx.4.hOlpOAP_gjIo4f8JhxGgJpUxNMSgFS_dHjgqUEwabtXCitfmWYEF
 gAlqzOZC_wnwuVhSoNiLuuB5stULscAtxTFfhMO22._vrDObifwxvCHufCH0Jwo5vD5fgxOAFF2B
 38u.2XGa_dbpctwWZk5AL6Nf3wje2Xs48n0bRVwc4T3ro8Vhxvfa390bfMFf4wqtAyy4NyyaGF_q
 6Athu8PhJ540GtzS_mIZiA7xhZZFmrEjeWBOz6KSiiAF7MQmuWkOi13AhP9A.GYsL60wPbBUMv21
 lc_v7H1WslyZILiwkcWOyrum2RxXjk3Gd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:17:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 684c4260c9ce7e69931b3535a90e1556;
          Sat, 22 Sep 2018 00:17:13 +0000 (UTC)
Subject: [PATCH v4 02/19] Smack: Abstract use of cred security blob
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
Message-ID: <03191752-22d3-4066-3d3a-8fbe209447e5@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:17:08 -0700
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

Don't use the cred->security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h        | 17 +++++++++--
 security/smack/smack_access.c |  4 +--
 security/smack/smack_lsm.c    | 57 +++++++++++++++++------------------
 security/smack/smackfs.c      | 18 +++++------
 4 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..01a922856eba 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -356,6 +356,11 @@ extern struct list_head smack_onlycap_list;
 #define SMACK_HASH_SLOTS 16
 extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
+static inline struct task_smack *smack_cred(const struct cred *cred)
+{
+	return cred->security;
+}
+
 /*
  * Is the directory transmuting?
  */
@@ -382,13 +387,19 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
 	return tsp->smk_task;
 }
 
-static inline struct smack_known *smk_of_task_struct(const struct task_struct *t)
+static inline struct smack_known *smk_of_task_struct(
+						const struct task_struct *t)
 {
 	struct smack_known *skp;
+	const struct cred *cred;
 
 	rcu_read_lock();
-	skp = smk_of_task(__task_cred(t)->security);
+
+	cred = __task_cred(t);
+	skp = smk_of_task(smack_cred(cred));
+
 	rcu_read_unlock();
+
 	return skp;
 }
 
@@ -405,7 +416,7 @@ static inline struct smack_known *smk_of_forked(const struct task_smack *tsp)
  */
 static inline struct smack_known *smk_of_current(void)
 {
-	return smk_of_task(current_security());
+	return smk_of_task(smack_cred(current_cred()));
 }
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 9a4c0ad46518..489d49a20b47 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -275,7 +275,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
 int smk_curacc(struct smack_known *obj_known,
 	       u32 mode, struct smk_audit_info *a)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_tskacc(tsp, obj_known, mode, a);
 }
@@ -635,7 +635,7 @@ DEFINE_MUTEX(smack_onlycap_lock);
  */
 bool smack_privileged_cred(int cap, const struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *skp = tsp->smk_task;
 	struct smack_known_list_elem *sklep;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 340fc30ad85d..68ee3ae8f25c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -122,7 +122,7 @@ static int smk_bu_note(char *note, struct smack_known *sskp,
 static int smk_bu_current(char *note, struct smack_known *oskp,
 			  int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (rc <= 0)
@@ -143,7 +143,7 @@ static int smk_bu_current(char *note, struct smack_known *oskp,
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *smk_task = smk_of_task_struct(otp);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
@@ -165,7 +165,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *isp = inode->i_security;
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
@@ -195,7 +195,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_file(struct file *file, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
 	struct inode_smack *isp = inode->i_security;
@@ -225,7 +225,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 static int smk_bu_credfile(const struct cred *cred, struct file *file,
 				int mode, int rc)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
 	struct inode_smack *isp = inode->i_security;
@@ -429,7 +429,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 	}
 
 	rcu_read_lock();
-	tsp = __task_cred(tracer)->security;
+	tsp = smack_cred(__task_cred(tracer));
 	tracer_known = smk_of_task(tsp);
 
 	if ((mode & PTRACE_MODE_ATTACH) &&
@@ -496,7 +496,7 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
 	int rc;
 	struct smack_known *skp;
 
-	skp = smk_of_task(current_security());
+	skp = smk_of_task(smack_cred(current_cred()));
 
 	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
 	return rc;
@@ -913,7 +913,7 @@ static int smack_sb_statfs(struct dentry *dentry)
 static int smack_bprm_set_creds(struct linux_binprm *bprm)
 {
 	struct inode *inode = file_inode(bprm->file);
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = smack_cred(bprm->cred);
 	struct inode_smack *isp;
 	struct superblock_smack *sbsp;
 	int rc;
@@ -1744,7 +1744,7 @@ static int smack_mmap_file(struct file *file,
 		return -EACCES;
 	mkp = isp->smk_mmap;
 
-	tsp = current_security();
+	tsp = smack_cred(current_cred());
 	skp = smk_of_current();
 	rc = 0;
 
@@ -1840,7 +1840,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	struct file *file;
 	int rc;
 	struct smk_audit_info ad;
@@ -1888,7 +1888,7 @@ static int smack_file_receive(struct file *file)
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
 		ssp = sock->sk->sk_security;
-		tsp = current_security();
+		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
 		 * passed socket or if the passed socket can't
@@ -1930,7 +1930,7 @@ static int smack_file_receive(struct file *file)
  */
 static int smack_file_open(struct file *file)
 {
-	struct task_smack *tsp = file->f_cred->security;
+	struct task_smack *tsp = smack_cred(file->f_cred);
 	struct inode *inode = file_inode(file);
 	struct smk_audit_info ad;
 	int rc;
@@ -1977,7 +1977,7 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void smack_cred_free(struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_rule *rp;
 	struct list_head *l;
 	struct list_head *n;
@@ -2007,7 +2007,7 @@ static void smack_cred_free(struct cred *cred)
 static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
-	struct task_smack *old_tsp = old->security;
+	struct task_smack *old_tsp = smack_cred(old);
 	struct task_smack *new_tsp;
 	int rc;
 
@@ -2038,15 +2038,14 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void smack_cred_transfer(struct cred *new, const struct cred *old)
 {
-	struct task_smack *old_tsp = old->security;
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *old_tsp = smack_cred(old);
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = old_tsp->smk_task;
 	new_tsp->smk_forked = old_tsp->smk_task;
 	mutex_init(&new_tsp->smk_rules_lock);
 	INIT_LIST_HEAD(&new_tsp->smk_rules);
 
-
 	/* cbs copy rule list */
 }
 
@@ -2057,12 +2056,12 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_cred_getsecid(const struct cred *c, u32 *secid)
+static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
 {
 	struct smack_known *skp;
 
 	rcu_read_lock();
-	skp = smk_of_task(c->security);
+	skp = smk_of_task(smack_cred(cred));
 	*secid = skp->smk_secid;
 	rcu_read_unlock();
 }
@@ -2076,7 +2075,7 @@ static void smack_cred_getsecid(const struct cred *c, u32 *secid)
  */
 static int smack_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = smack_from_secid(secid);
 	return 0;
@@ -2094,7 +2093,7 @@ static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
 	struct inode_smack *isp = inode->i_security;
-	struct task_smack *tsp = new->security;
+	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
 	tsp->smk_task = tsp->smk_forked;
@@ -2278,7 +2277,7 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
 	 * specific behavior. This is not clean. For one thing
 	 * we can't take privilege into account.
 	 */
-	skp = smk_of_task(cred->security);
+	skp = smk_of_task(smack_cred(cred));
 	rc = smk_access(skp, tkp, MAY_DELIVER, &ad);
 	rc = smk_bu_note("USB signal", skp, tkp, MAY_DELIVER, rc);
 	return rc;
@@ -3605,7 +3604,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
  */
 static int smack_setprocattr(const char *name, void *value, size_t size)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
 	struct smack_known_list_elem *sklep;
@@ -3646,7 +3645,7 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (new == NULL)
 		return -ENOMEM;
 
-	tsp = new->security;
+	tsp = smack_cred(new);
 	tsp->smk_task = skp;
 	/*
 	 * process can change its label only once
@@ -4291,7 +4290,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
-	struct smack_known *skp = smk_of_task(cred->security);
+	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
 	key->security = skp;
 	return 0;
@@ -4322,7 +4321,7 @@ static int smack_key_permission(key_ref_t key_ref,
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
-	struct smack_known *tkp = smk_of_task(cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(cred));
 	int request = 0;
 	int rc;
 
@@ -4591,7 +4590,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsp = new_creds->security;
+	tsp = smack_cred(new_creds);
 
 	/*
 	 * Get label from overlay inode and set it in create_sid
@@ -4619,8 +4618,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 					const struct cred *old,
 					struct cred *new)
 {
-	struct task_smack *otsp = old->security;
-	struct task_smack *ntsp = new->security;
+	struct task_smack *otsp = smack_cred(old);
+	struct task_smack *ntsp = smack_cred(new);
 	struct inode_smack *isp;
 	int may;
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e53d55a..9d2dde608298 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2208,14 +2208,14 @@ static const struct file_operations smk_logging_ops = {
 
 static void *load_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2262,7 +2262,7 @@ static int smk_open_load_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_FIXED24_FMT);
@@ -2414,14 +2414,14 @@ static const struct file_operations smk_load2_ops = {
 
 static void *load_self2_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self2_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2467,7 +2467,7 @@ static int smk_open_load_self2(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_LONG_FMT);
@@ -2681,14 +2681,14 @@ static const struct file_operations smk_syslog_ops = {
 
 static void *relabel_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_relabel);
 }
 
 static void *relabel_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_relabel);
 }
@@ -2736,7 +2736,7 @@ static int smk_open_relabel_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	char *data;
 	int rc;
 	LIST_HEAD(list_tmp);
-- 
2.17.1


