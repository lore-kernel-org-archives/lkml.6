Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CA5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC7920870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SZU48PTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC7920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeGPSwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:52:03 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:41188
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728639AbeGPSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765405; bh=BeeHq5jaAogts83+U5Xk4+mKYeNaDPtBt0OGA8fRFh4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SZU48PTxTeAbN1mAoAg5NQvotaTLe1OC9rOL5Yt1q0aD0jtsPNuU+8M0lHULoA0dWzgliBEFOMrs3VCvKR5kUtMiA/1sIpcO7woqoFq1BvuVjYRbFxFZSUrAGzxd2XYHyfv3doqEMWGu1m8bji7XWB9bPSphTqcbY0ws9SS8OxkmxGO/Gm+78F6q7jZbOqlBcj2iazimeu267ady0i7bSxACgS9gnLpY+dpw3S5UbHxCP8pZBjtk1/YcuD70pbX2ahF+naUqWsC8fkBLlhPHX5u+cQEb0NDYjYtkc2osQ01mJpo5fFwpgK/MZmwouqhF+hGmN8FodAaP41P1e7NkyQ==
X-YMail-OSG: n4UAEZEVM1k3pTdjBY28bD_Tt7zGaL7eaWkt23nZg__z84YY0sqppySx7.rZmSb
 gUBDONwtFKpsMtB3ITBlStHujkW3HqAo_wH4QcwfAILU_o9sGlaNiMGax.eW6ASYnNujuo9Rm3Rb
 cl5JXAHfEYnPHyyc96nT3htX2WNXtqcjmcs5yydg9_S01cBx02FbRlS801YCySYz1kFIkHLWSnOJ
 xAsWzcxVsnUqg7_FDPGNRufaxmH.ExubsTH.p88xad.ty0gM6iqHYQymN5gmelZVlAQ.VwL9PgJD
 knThq20d_eEpiJjxzt8shiteLGKmchyEZdq3b_BPHHgYAF5d2ud_mpgcI0H0pqbGtRwd4kbXU048
 EQZXXzYnAFaOBPqfbbLWQxdcne79mRysPpTFvzFizxbqJh4Vf2JMJa2kqE4gdi4e29j.m4b4eBUn
 zMJCXeNgbpuAhrUjAyMpIV0bE2dR8CWvhGdLhd0BPcMLJ1HvHqlJ.pbEh3iVe3T_hqx8brOu65xh
 8vN7GkIlAmv.Iu5Eu6gFKZ1UniYHc_6XoYFzohuFcjJ0gPFZBxmG2BBnPp7RLl.YrnBNr5lbQnwK
 SBxkeWFweTBKe2.0EnUuKfajr0XonXSCFywOaQ7.3xxXiDdiNxuSrqnJ8.aptwOVNnHZ_kHIl0Fs
 SUa19n7d88VuM.D6lkgzjLdCPs6gWCBI_3a2fqOivU5EaPx56zPpdXfiNQPqKxhSDzphKRkSEjI9
 hW2EQaRRTZ9iCEYR3DzpZt.k57ZjDEcSUx230kKUq5VUAf6mgyM_8B7REGSq7nitYsObSMw5w5ba
 xWNbuD2sfkfWmZucY63iEI2oqFf_27TpYTe3vAlQtLGIrwezJs1NpgVmwkVYFUprnjR34ElmavTS
 murC98E8L3405CC099Q5dRhGLigtfbTqM0XE4u27.m_BHptwhaPCJ27jGmu6NS9Z9DWN3kxikgD6
 bn1aq5Ck06cKobknUWQXp29Lw9PgYu39Lzyzi1c7cqWsUCB7ww8BBH2Zmkrnh4nMzqmgNNZ4beGK
 SXVJ5LqGKkaisb.TSUycEmnw05QoA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:23:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 041d5204f900f90dbb6d04b9826d704d;
          Mon, 16 Jul 2018 18:23:23 +0000 (UTC)
Subject: [PATCH v1 09/22] Smack: Abstract use of inode security blob
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
Message-ID: <079573f6-9edc-8821-736b-d398fb529638@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:23:20 -0700
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

Smack: Abstract use of inode security blob

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h     |  9 +++++++--
 security/smack/smack_lsm.c | 32 ++++++++++++++++----------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 043525a52e94..5da5bd1b9b47 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -367,12 +367,17 @@ static inline struct smack_known **smack_file(const struct file *file)
 	return file->f_security;
 }
 
+static inline struct inode_smack *smack_inode(const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 /*
  * Is the directory transmuting?
  */
 static inline int smk_inode_transmutable(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return (sip->smk_flags & SMK_INODE_TRANSMUTE) != 0;
 }
 
@@ -381,7 +386,7 @@ static inline int smk_inode_transmutable(const struct inode *isp)
  */
 static inline struct smack_known *smk_of_inode(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return sip->smk_inode;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d5c99ed8047d..23f1e62544bd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -165,7 +165,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -197,7 +197,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -227,7 +227,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -823,7 +823,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp == NULL) {
 		isp = new_inode_smack(sp->smk_root);
 		if (isp == NULL)
@@ -911,7 +911,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -991,7 +991,7 @@ static void smack_inode_free_rcu(struct rcu_head *head)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -1019,7 +1019,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -1357,7 +1357,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = d_backing_inode(dentry)->i_security;
+	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1438,7 +1438,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 	if (rc != 0)
 		return rc;
 
-	isp = d_backing_inode(dentry)->i_security;
+	isp = smack_inode(d_backing_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1713,7 +1713,7 @@ static int smack_mmap_file(struct file *file,
 	if (unlikely(IS_PRIVATE(file_inode(file))))
 		return 0;
 
-	isp = file_inode(file)->i_security;
+	isp = smack_inode(file_inode(file));
 	if (isp->smk_mmap == NULL)
 		return 0;
 	sbsp = file_inode(file)->i_sb->s_security;
@@ -2055,7 +2055,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
@@ -2255,7 +2255,7 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
@@ -2717,7 +2717,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = smack_inode(inode);
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -3325,7 +3325,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -4548,7 +4548,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4585,7 +4585,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	/*
 	 * the attribute of the containing directory
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
 		rcu_read_lock();
-- 
2.17.1


