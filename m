Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4FBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C85720870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WT4e0857"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C85720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGPSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:51:50 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:39446
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbeGPSvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765392; bh=9BqMBBxV7+jCTehg6sVVKs93rcJrPgB+xNQG1vtiJyI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WT4e0857Vv7qEpj4wGdCosuV01chazDXcv8ThFbfNEdrw+X7aaP2p/xo4vPxW1BL7usENLarXktSwFpsyQcjnQEN+qKV38rDAZHSS4MYjsHJKSTkmAk6GLmj+Kzjei9RJPvbdiM3m6Cl08Cm5JKCjDD9LhEJjeJL2D3UJqnUr5juZUCkXDqACo6qFlETTf5T/EOtjZvxtQfsi5qWkIvkzrUOApfYzMdnvUMfo3uPfO/BWTXTqC4W3bEeBpnijTufc58BGxN3UGidFqC9HNln8EbG8aXQY6711E0PRD6TXknITWoDuSdXCTyCRXcdQZvbKXIJAoVdJ91O4ALEzjA6sw==
X-YMail-OSG: jI_LXBwVM1nEul6.7sNcVOBlAs_59108ILtt0Pn_3Ykfil4c_EQ89DNp0sIM47g
 Bz5TYs4qLqXgEStF9gNsfU8UpX0t0xVzZZhMO5_HHiQoSGPRCl4LFsXh8tPA0K6F3C60iOWJGRpi
 SetkCYcqS6wq9IIkWPKpsw6a5UNEjFyLl_vQF8.phwdygtTiIOXtVPACSeW06vY6erW_sJDr3kdt
 ZGzsYWUjknJNzxL5VsFRp57MZvUVSjwAbAijvL6qm4Tjgt_MPRpvxAm9hs7S5hyfURT1Ie6KcncE
 uF9ms8OwcdV3C.ciDQ3duzGIof6.PqBIFeHRio6_LP110_9rFCg.HioxEgrm2G.En3orepW91Qm_
 Ws6iLAuziK14OaHRu7N_CHvIif8GB3xx1vGLQHOuyaiJ4OlUVSBvCLaVYdhgdGPVPtNhtljR65U4
 Yj9cA11z8_COajn.HZ3Gz6Exb3lcx.fGHj.ZFNJrw_izi6FcWGMkS9U7rb7v6ywKGl44ztI4msww
 MXrL0I2s0hjbU_6KT14CJpQbpeSXisQxFj2kPbrl.umoYGHbTTtn5cLs.pJlU7MqnI311GJ6I_dI
 nHZnrVX1pcYCV58QBZFXZmdPC9TvweoDLb4n.LjEjPlSHulxClA9rWOCgMWeJp2cgmXgNENFrXES
 Ey1imutg2Di1FOpogyx7Aje9cgxIdiTp.FDVPr8srLcw8jjGfFCfVMsHYQ3mNKMCtkVqf6Ur6668
 KDyAsWpgUd6.YaKumROys08B.7JqUYPASa2mbmmD0NGgpQKv._Zw_6WA_VM_MEMLNslMralStBJ5
 wDM495g4rhy3yuYQq9eza3GS_tGlDOyZBr8cax6q3bztGpC7R9Hu6lzt.Sh3f63P6Cr6EBtjBmhL
 AiiP3qPgse2zvFTHNynBS3NlQEJMabD4PXfcPp_Pwjkvs2bMtBGDJC5YxGJ4KE7wUE3mCKFkqgmi
 ON6xouLR15xs_IIpg_N8L6oqu4PQlmzGkFrKmiXbc.xMFAw8e7ihUK_KbpLs.HCZ28eb5SGcA8ZR
 4MWHuQde3vfoi.J9k29r3eS0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:23:12 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c6c1622c02b147bc46c9f4505c6f136e;
          Mon, 16 Jul 2018 18:23:10 +0000 (UTC)
Subject: PATCH v1 08/22] SELinux: Abstract use of inode security blob
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
Message-ID: <d1112037-0aae-76e7-9b2c-bbc7c1fc3f67@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:23:07 -0700
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

SELinux: Abstract use of inode security blob

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/hooks.c          | 26 +++++++++++++-------------
 security/selinux/include/objsec.h |  6 ++++++
 security/selinux/selinuxfs.c      |  4 ++--
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ea9557ad7b7a..aafd1506fe6b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -276,7 +276,7 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	might_sleep_if(may_sleep);
 
@@ -297,7 +297,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
@@ -307,7 +307,7 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 	error = __inode_security_revalidate(inode, NULL, !rcu);
 	if (error)
 		return ERR_PTR(error);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -316,14 +316,14 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 static struct inode_security_struct *inode_security(struct inode *inode)
 {
 	__inode_security_revalidate(inode, NULL, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -334,7 +334,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	struct inode *inode = d_backing_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
@@ -347,7 +347,7 @@ static void inode_free_rcu(struct rcu_head *head)
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
 	/*
@@ -1502,7 +1502,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
@@ -1803,7 +1803,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = selinux_inode(inode);
 
 	return avc_has_perm(&selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3031,7 +3031,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3131,7 +3131,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4138,7 +4138,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 sid = task_sid(p);
 
 	spin_lock(&isec->lock);
@@ -6517,7 +6517,7 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	spin_lock(&isec->lock);
 	isec->initialized = LABEL_INVALID;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2586fbc7e38c..3304a1ee58a4 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -172,4 +172,10 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
 	return file->f_security;
 }
 
+static inline struct inode_security_struct *selinux_inode(
+						const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a0faf54c00b9..b1847b520772 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1386,7 +1386,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 		if (len >= PAGE_SIZE)
 			goto out;
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = selinux_inode(inode);
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
@@ -1949,7 +1949,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 
 	inode->i_ino = ++fsi->last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = selinux_inode(inode);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = LABEL_INITIALIZED;
-- 
2.17.1


