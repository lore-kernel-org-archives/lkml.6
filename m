Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE81C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8DC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M+Z5gy55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8DC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeK0Kij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:38:39 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:42800
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727695AbeK0Kij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275768; bh=ynlFBU/OJkeApIeJxkFCkcN4bhspcm3eSha5ckjlfaw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=M+Z5gy55rgcpbGfaOvu3J48UwHrUNFAli5LEhUx082CiylHkFeivwg8eyoPE30kRcOGqv7hr5GlC/Ok60NrOfGjQ7RlVN+GWJedZJAKbwNQ9lkwNRvhIFkF7sp7i6vCyYRDXqYkBPXXWegrGEZpVht31Zu5H4t5D6n3x9wTnmtPCSevHjgMeeiQmAHnm9SgwjHHHYoaCat0yU+SvAXSQoqMfAdC2bI51uu/a/OVdj7amZhf7DWBh4/Qeeg5Q25qGZHEdnpgw4DG0BWk5Xld51vdyxSxitVcErHzeLyX66akUEL05aKHHRy2Aq2+LgzQVuxmdhCZYJetCGe9Vysa+iw==
X-YMail-OSG: f7j3oaAVM1kJAUnB9kwmOBEXQksyHXkmtHrlY3AyWaBE0vpSMJyE9XDUiflzycf
 JZ.lTrosQoZxaOq8C_WAz3LyfMY8NBmd3M45AAC53QIomZ8vX0Rzz3kn8OPKD0Ix5kCkDSeSXgB7
 f2MO29VVL_cucIXzHEjjLLSE2b8kUts9Ys2T1Hx9SxyQXGGFwPd.zOD06J29eL4oQn0ytdd0Y8g7
 EmfN.WlOxsGExCCk9fIs_s2Xsn0npweGG.Vc_GMdS.Bm5EM7R20QE2gX0gmgAT575Vq9xxJmx1Oi
 YUGP1BBGCDAvFF2J7firynlk56v7CDo..oY9Woc0q_2dw0BycHAzi6MjlsvZj3T1R3rotM51WAQB
 vtu169hOzxVnhgLO7pnFs3LXZYPbx73tst9ucnRb5bwRUp4yejHToJZSulZxTR5Is_fkZGTKF1jD
 .gDGkupix18qVAvMDgrhjdz1g5wTa75lF8.OgS.9LrMiYahdaje33MgpGuoIc9q_JjpMmsV6TKVe
 h5dHglGzr7.jXp0UB7tq7ZdZ4oBxwWzNk8wuKflr.t7vCofhYR2y2ImRDOCyHt0l99tttO0wUCDT
 u1MLSTvPJ1W_4fgAyw1u0WbN76a9aa3eFjBdxcP3ld89J8489ovMmehiUaS88Dk.G.1m4191_3YT
 t3qJTspX7IL7oB.qZEz0Lzo_U5Ua8huXsw07B0pzpanbTqs6LrOhgpPLBwMsk16ChD2Hh2UMPBzb
 bDxT158EHXu0zUYgWqwfOAK.ULMA_F8HNAB0X3bWl06ByitssH5gghnS0Ya981xLolJTBiWMjdxc
 sg1Y1R3HLtHOFXqNWCsJqb0kDuhh.uk7pu51Ku3p0IwYppCrYtF52b1B_XQd8lmXtXpdnwktpMnn
 jHnc1WM9bNkt1A6ZkPcNSe7Q0zs7KsHOGKiwv9Wf22HaPewpChW2lee7nIYNMy2MCBv_RkGsGceb
 kQyX6XFBwIlYQYhi9oBK_KCpwocgNUtxq9GYPDOkDvfrrU03xWBvF.bAGPCBcrqXSPOiAMcgAkhF
 mijM3cARzMiCNpIA99lv1Q60cuNaO_ndGXQ1fC0IbtnAHfEZ8r4EuARtQBz2lokDIzR4BSI_m_hu
 D3TK_wIGbf.WhRsn2pdkaOSDCNdtqBWac0Ydto6uDTpA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:42:48 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID af3255a040c4ce8a37c0a3ecf478d867;
          Mon, 26 Nov 2018 23:42:47 +0000 (UTC)
Subject: [PATCH v5 21/38] Smack: Abstract use of cred security blob
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f92dc7c6-0ab1-7042-416c-5d36a75c694c@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:42:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/smack/smack.h        | 17 ++++++++++---
 security/smack/smack_access.c |  4 +--
 security/smack/smack_lsm.c    | 57 +++++++++++++++++++++----------------------
 security/smack/smackfs.c      | 18 +++++++-------
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
index 849426ac6a6c..f34117b8c3be 100644
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
@@ -431,7 +431,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 
 	rcu_read_lock();
 	tracercred = __task_cred(tracer);
-	tsp = tracercred->security;
+	tsp = smack_cred(tracercred);
 	tracer_known = smk_of_task(tsp);
 
 	if ((mode & PTRACE_MODE_ATTACH) &&
@@ -498,7 +498,7 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
 	int rc;
 	struct smack_known *skp;
 
-	skp = smk_of_task(current_security());
+	skp = smk_of_task(smack_cred(current_cred()));
 
 	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
 	return rc;
@@ -915,7 +915,7 @@ static int smack_sb_statfs(struct dentry *dentry)
 static int smack_bprm_set_creds(struct linux_binprm *bprm)
 {
 	struct inode *inode = file_inode(bprm->file);
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = smack_cred(bprm->cred);
 	struct inode_smack *isp;
 	struct superblock_smack *sbsp;
 	int rc;
@@ -1746,7 +1746,7 @@ static int smack_mmap_file(struct file *file,
 		return -EACCES;
 	mkp = isp->smk_mmap;
 
-	tsp = current_security();
+	tsp = smack_cred(current_cred());
 	skp = smk_of_current();
 	rc = 0;
 
@@ -1842,7 +1842,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	const struct cred *tcred;
 	struct file *file;
 	int rc;
@@ -1895,7 +1895,7 @@ static int smack_file_receive(struct file *file)
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
 		ssp = sock->sk->sk_security;
-		tsp = current_security();
+		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
 		 * passed socket or if the passed socket can't
@@ -1937,7 +1937,7 @@ static int smack_file_receive(struct file *file)
  */
 static int smack_file_open(struct file *file)
 {
-	struct task_smack *tsp = file->f_cred->security;
+	struct task_smack *tsp = smack_cred(file->f_cred);
 	struct inode *inode = file_inode(file);
 	struct smk_audit_info ad;
 	int rc;
@@ -1984,7 +1984,7 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void smack_cred_free(struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_rule *rp;
 	struct list_head *l;
 	struct list_head *n;
@@ -2014,7 +2014,7 @@ static void smack_cred_free(struct cred *cred)
 static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
-	struct task_smack *old_tsp = old->security;
+	struct task_smack *old_tsp = smack_cred(old);
 	struct task_smack *new_tsp;
 	int rc;
 
@@ -2045,15 +2045,14 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
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
 
@@ -2064,12 +2063,12 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
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
@@ -2083,7 +2082,7 @@ static void smack_cred_getsecid(const struct cred *c, u32 *secid)
  */
 static int smack_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = smack_from_secid(secid);
 	return 0;
@@ -2101,7 +2100,7 @@ static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
 	struct inode_smack *isp = inode->i_security;
-	struct task_smack *tsp = new->security;
+	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
 	tsp->smk_task = tsp->smk_forked;
@@ -2285,7 +2284,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 	 * specific behavior. This is not clean. For one thing
 	 * we can't take privilege into account.
 	 */
-	skp = smk_of_task(cred->security);
+	skp = smk_of_task(smack_cred(cred));
 	rc = smk_access(skp, tkp, MAY_DELIVER, &ad);
 	rc = smk_bu_note("USB signal", skp, tkp, MAY_DELIVER, rc);
 	return rc;
@@ -3612,7 +3611,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
  */
 static int smack_setprocattr(const char *name, void *value, size_t size)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
 	struct smack_known_list_elem *sklep;
@@ -3653,7 +3652,7 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (new == NULL)
 		return -ENOMEM;
 
-	tsp = new->security;
+	tsp = smack_cred(new);
 	tsp->smk_task = skp;
 	/*
 	 * process can change its label only once
@@ -4298,7 +4297,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
-	struct smack_known *skp = smk_of_task(cred->security);
+	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
 	key->security = skp;
 	return 0;
@@ -4329,7 +4328,7 @@ static int smack_key_permission(key_ref_t key_ref,
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
-	struct smack_known *tkp = smk_of_task(cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(cred));
 	int request = 0;
 	int rc;
 
@@ -4598,7 +4597,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsp = new_creds->security;
+	tsp = smack_cred(new_creds);
 
 	/*
 	 * Get label from overlay inode and set it in create_sid
@@ -4626,8 +4625,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
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
index 06b517075ec0..faf2ea3968b3 100644
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
2.14.5


