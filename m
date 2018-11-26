Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B607C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E71F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y5iap5ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E71F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeK0KsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:48:23 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:37426
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727804AbeK0KsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276350; bh=yMQklFwhAM+SkyFA3GlpZ7nPGFc0LOqkP3jCwe0SRVI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Y5iap5htfMtPtVfffhjolKPpNnzPBx9+pRfCr1vUpOcBMPWrcsAFYcfFoBkiT+0FfQebdjXGtdczSpzNqzk8pL5bIeOd10lys4exDV2LCy6LQoGPvBChnWHaaFSZDvTZHDZ8ZGrwqBTq3gLmFlu1YLyVFGx+S+P/zUlGt9WB4vTfB4uaiDe9Dmdf63cevUwvTuUYWIhs5TaFoAdrdMkBmMv5ZH7PAhhDzajHxyW0V2tLDx2H1spbOrFMImeDK4TYZ2nIAh53GtdJSZBSucoOT23v9MJFlSuRbffhhRvj73W1pnWmOj87jxWiLIe1CKpNEIREQ3lfwyxxQMsJgyJ1vQ==
X-YMail-OSG: 1hcRh0wVM1mgYj03iFZmXetXvVkpPH94vS1x8.chuTDq6Phuqci.Etmg_X2fcfn
 I4gZMSoPwr_wcm99HOplTdX5SQJg3627N9HnsRSofzTOj0ZJ7UK.A.2CZduL6h8.TsZgee7rxiNm
 5oGwXJHUoDVLE.glnVt1ZYWEG.B8wvkda6mAMN47EEBdseSnG4tcP_uWSS1tvY6aiNX8UTGaeFdv
 f2nlDqfmsu7tWasmKw.yTFck206UmRuWUbImEYVk8_IlLFm1jmeuK6g5JHGLPcE1zNKx1k3_LBrC
 1KSFRONQ0U0eRuwEx440TmKDb9r.hdRiGfFdvMbVhK6pnu7Xe7doK63S0nGJO_CLvlkQEHtfoTrZ
 QnOkoDmBn_pRFVK_8r6I_2.4WTVBoP0thIe20LYgRkQEfVE4yCTn3qYE5VkBykgtUolmMPcUtxHp
 mq4kF50HlPwkyz4WqaH3_GRewG68g.RumSFsMfJ6qlXPyLq4PC95jZXBGf92iLPAy7._UdHSHXFp
 gQ6p3jn7kkXwgClO5VX1_A7UPBDLeoJhxybHc5e2WT4ZGUXWprYpbeP.RSMtyrLeMuBfbgWqWpEN
 wcmDGXKBB29Rdih5hKZaLJOiUXz9ZRIDdnO7YgDlfKfFgmeMB3KRTrMEzhPHOyUeINdoivenF6e9
 SQUWOZepnf5DAvbIxmIYvX66wXk8NC4Ew8D6Ji_i4MPMFere9Y6bbyi_CO.nCK21UbvwPwA4KTk_
 v4QFXy3n_UmdYMSURpuvcJYg1VlFZppz1h080X3I8fSZiDzyyPzYEFueMxy44PPV6GaegiQPx3.D
 mXUxdZTnF0RYTcH8iXG.0TSiYZv2MMlu_ZpE6h_te_YUVh35HoSd0YlJw4sZenM8NA26T47GzTkN
 G1Gs_V1BiHkF8nq7_dP0HnlM7cQNWSgEiCRv4cJobtcOM.5ZrMgRhA4CEwdiZyxKA0cTiZqMvRhX
 8.LbcAKEJBvl0qZitxggYefVafIjUtNMRW5NdA2acaX0wudggAmOi1tTRp_rOboSYMk91mAJNFDp
 k.KcMzFvbLdDoN2kwEDjhOa3c3osB6TQjaHFrgVKJb2deRItbY8fTbau5fsREfyt9yfJph1cFWDW
 _lxM_pO2ahRWOhadIMoT1QO7DJshzfvaZCTxHvQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:52:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a39d4583bbf572aff6c650070309ce87;
          Mon, 26 Nov 2018 23:52:27 +0000 (UTC)
Subject: [PATCH v5 32/38] Smack: Abstract use of inode security blob
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
Message-ID: <1195d035-fc2d-487b-148c-218716f9507d@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:52:23 -0800
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

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/smack/smack.h     |  9 +++++++--
 security/smack/smack_lsm.c | 32 ++++++++++++++++----------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 2007d38d0e46..436231dfae33 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -368,12 +368,17 @@ static inline struct smack_known **smack_file(const struct file *file)
 				       smack_blob_sizes.lbs_file);
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
 
@@ -382,7 +387,7 @@ static inline int smk_inode_transmutable(const struct inode *isp)
  */
 static inline struct smack_known *smk_of_inode(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return sip->smk_inode;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c560cb8e155c..c086110cba80 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -166,7 +166,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -198,7 +198,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -228,7 +228,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
@@ -826,7 +826,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp == NULL) {
 		isp = new_inode_smack(sp->smk_root);
 		if (isp == NULL)
@@ -914,7 +914,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -994,7 +994,7 @@ static void smack_inode_free_rcu(struct rcu_head *head)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -1022,7 +1022,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -1360,7 +1360,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = d_backing_inode(dentry)->i_security;
+	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1441,7 +1441,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 	if (rc != 0)
 		return rc;
 
-	isp = d_backing_inode(dentry)->i_security;
+	isp = smack_inode(d_backing_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1716,7 +1716,7 @@ static int smack_mmap_file(struct file *file,
 	if (unlikely(IS_PRIVATE(file_inode(file))))
 		return 0;
 
-	isp = file_inode(file)->i_security;
+	isp = smack_inode(file_inode(file));
 	if (isp->smk_mmap == NULL)
 		return 0;
 	sbsp = file_inode(file)->i_sb->s_security;
@@ -2063,7 +2063,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
@@ -2263,7 +2263,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
@@ -2726,7 +2726,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = smack_inode(inode);
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -3334,7 +3334,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -4566,7 +4566,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4603,7 +4603,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	/*
 	 * the attribute of the containing directory
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
 		rcu_read_lock();
-- 
2.14.5


