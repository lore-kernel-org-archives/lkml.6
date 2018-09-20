Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FB4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9021522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W6K5MzF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD9021522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbeITGBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:01:54 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:43063 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387665AbeITGBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402886; bh=Ck38vMEsKQbgFW3LjrrzhaGL3ruphoMZE25JWeXjeQs=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=W6K5MzF7sQ65skK8Rs4BNcdxWVjzFwjr0CwtDtFMkrkyPw+haMH2JdnzE4tTWBqFos1AJz6+L3gkgO+kKpjpo1/99YsW8ID82DFmIjK/oAGGMQb2FduOWLAVlehMlojTfkw8yaV8pWgof936eEdM7GTM09X73TtfzVLCuGYFptpOGtLrPcXbLfXmv6j5GaFxNjzSZF2ZREQdlg3cfohls4SvA3x5RaHoMgnNyDlAXZckHOuKHJEdbf3rBsi3X0DMcT4I1V+iTJNWsvPRn25aFaeyeT6GSFRpZfcp8xHnkqFoDzCZG6t0RkndooSNFAPa6fyJyGQ/GI5uWl2/ao1+1Q==
X-YMail-OSG: D3f6kPUVM1ktFo.yAvDxlFWf0T1PcBlkNeFRZn5scqJmQjaZplhnwLT9zE8pUPS
 3vlGQDKKIdg.NJdOxiboeHoTVNti.9.nJmN7i2a7C9Ue853g_sFhQKznJ0iruvAPXjPrrIVra1gX
 lhQL96WA397I7gJP38SXaKgjPiYp5E3EYehjA.vGGQIKPtENorvWd07Hl5NMpuj3GN0V3rE50J_G
 _QGcqRFHpj3U30D61AVmaD_AD9a2mPy1_ZKlAINfjjj.m7j_DbGxYcFBKRkoTbOXKpCicjJAMawn
 ZGwEEZHDkcIxz4iNlr5XhMgvv6Ue1GJvZRFYTN68qDxUbkZGglyJ9EIZnHom3sg0LDkJIK8zCWHO
 pUQrGjUsMhT0LJWSJe.HLIQL4G9LKiZMNEhleg8KOb.SmzLq4EYfbFXbLELI5LQaYQBSpi0OLt4x
 fNpOJgTK6J4xasm9fBtkLFmVVJVK45jnGKe8TwEZcwnoRQZvV1hWu_Y05CV0tL9n8AJMtk5UpTfJ
 PRrIJl_CeOEt0gzj4bjWNd3.6C14t724JRddffkSs2uPuy1j71gh_tv_J6FrVkXCM2Om54g.6v.u
 81y3tkpDZpOP3h9nTZu7Bvh6rnCteuOqL2bkGot0VZwfOwEgChnf94W5yq71SuOUFj77a2XYFwTe
 NYWF29yGiyA_gXFNFT8QxrQskUnVlx3XXsq16EF7B3xLTxmXIEkzyx6Ecg5wJY4r3Uv8sV_.xTSS
 _MjKdXiQncKTPQPb02w_0GsJPodvvt1vQwxl9w_TzzjzuqxCpN7IfUfGamzrHG4h0XqS3zNQiMVX
 xgx1KdC1b9AFhaX4SKGbT_t5KPTtxuV_.GD_jzv98GFGVMoiee0F6420D.NuUCB8UKI_2BgKoG3T
 _XooL_TiQB3VdH7j9Sg_9SgMciZ.T3Ur7isr_EUf8umKP9B51CC7W5Qf8KIWZ5YpC8MeaO9m1ER9
 KyZk5vdLt4mqmoHGHUpoOet47QAdJR7CWYLLR.RKyOrWaGap3LMg6mJPHRjnZPCrp2mZ85_U2IGC
 brtqy7GrTpwH4NwIWY0bKDzqPLVoc48GpMX0.jytURA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:21:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0265537e66f5c549077ee74d67914b96;
          Thu, 20 Sep 2018 00:21:22 +0000 (UTC)
Subject: [PATCH v3 12/16] Smack: Abstract use of inode security blob
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
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c26cab7f-1fe7-2723-158b-c5c3243ee73e@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:21:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
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
index 62a22ad8ce92..add19b7efc96 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -366,12 +366,17 @@ static inline struct smack_known **smack_file(const struct file *file)
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
 
@@ -380,7 +385,7 @@ static inline int smk_inode_transmutable(const struct inode *isp)
  */
 static inline struct smack_known *smk_of_inode(const struct inode *isp)
 {
-	struct inode_smack *sip = isp->i_security;
+	struct inode_smack *sip = smack_inode(isp);
 	return sip->smk_inode;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d1430341798f..364699ad55b9 100644
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
@@ -824,7 +824,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp == NULL) {
 		isp = new_inode_smack(sp->smk_root);
 		if (isp == NULL)
@@ -912,7 +912,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
@@ -992,7 +992,7 @@ static void smack_inode_free_rcu(struct rcu_head *head)
  */
 static void smack_inode_free_security(struct inode *inode)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 
 	/*
 	 * The inode may still be referenced in a path walk and
@@ -1020,7 +1020,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
-	struct inode_smack *issp = inode->i_security;
+	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -1358,7 +1358,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = d_backing_inode(dentry)->i_security;
+	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1439,7 +1439,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 	if (rc != 0)
 		return rc;
 
-	isp = d_backing_inode(dentry)->i_security;
+	isp = smack_inode(d_backing_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1714,7 +1714,7 @@ static int smack_mmap_file(struct file *file,
 	if (unlikely(IS_PRIVATE(file_inode(file))))
 		return 0;
 
-	isp = file_inode(file)->i_security;
+	isp = smack_inode(file_inode(file));
 	if (isp->smk_mmap == NULL)
 		return 0;
 	sbsp = file_inode(file)->i_sb->s_security;
@@ -2056,7 +2056,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
 static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
@@ -2256,7 +2256,7 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
  */
 static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct inode_smack *isp = inode->i_security;
+	struct inode_smack *isp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
@@ -2719,7 +2719,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 				   const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *nsp = inode->i_security;
+	struct inode_smack *nsp = smack_inode(inode);
 	struct socket_smack *ssp;
 	struct socket *sock;
 	int rc = 0;
@@ -3327,7 +3327,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (inode == NULL)
 		return;
 
-	isp = inode->i_security;
+	isp = smack_inode(inode);
 
 	mutex_lock(&isp->smk_lock);
 	/*
@@ -4559,7 +4559,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4596,7 +4596,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	/*
 	 * the attribute of the containing directory
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
 		rcu_read_lock();
-- 
2.17.1


