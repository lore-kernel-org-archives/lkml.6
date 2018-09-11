Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11154C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96BD20881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="toYH8YvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96BD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeIKVmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:42:18 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:33840
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbeIKVmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536684129; bh=lICyCWulOZ4Jep4XyvkhNDAi/ddudeTeAtoyTXRT+6o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=toYH8YvYi5gQYtYuBy8qSa1XeIsXFTDOslPonfsZRz9YNweDsycTfUuoTsR0YT0IX9H5Hr7CMT5CtVcCZ/6zAxVB1mEVQS53tubajltfbRKxAzh+1xF0ouvYymevz0heOMfqeOUElaqivRzhYhfP+8qcIkhIHIbgSnKW4F0sXdL5a+g82A3cNHZiQ/LkfoLoWyT2vT/LIZb/EMlVYJqPs7NyDv9C6a0EKpLzdeyVr11bFONQJ1NH40oqX465DqiZQSMTtlqdXeijnziplt4hGcXAP0GoZqf1LvKirocatIkVFMg9pyFa0FNrQggpniWJUW3YjPIx0Ee4UHQRVliLtg==
X-YMail-OSG: o8_QGGUVM1mb7PyDtRRM2Fwroe9qzYLBDjW4d.jUHzr4XDPsw84dpXBRFVMWgMK
 QgvfqHlJA8QjkpRXxbk_sxyors1MRUwru8kGNtF0winaQGhLVbysopFnA2T3eWZhTjQUarCOlcZq
 ADehaosnjD8D8_JiIrtePOfnIfoXlQJBW6hMwyz2ZQrAN_uKocTmw0ET7a6uNeiVvgbmiE9JxPHM
 3QjKcRdZQPPMFWMDcWXuREAhAUKhpLclB.5mAy3ALU.5EsEEFhX3wp05bEBRnG.Xw6MMBDJTqb18
 3H4peKF_sSr0nCZyf6zuqGKlrmw06KzlRkmzl7FTCEAhEnIQpqyXBdMwd1L93Gv1HuM4wuJFZn.C
 ZietRf17PP_AET2K01nMhify6r5Ly5eUuyDoN6FGAlMwrsDvQY1IHdwk22Ly.HNZvdv2inHv8yK7
 oeZhFTSPZcGIS9SBtWxSjrzyFnn3oJUw7IwpDpvPFQXcYVltRbqLcsShowo9HClB_G5gUeHBxoUW
 pF5W0G_2WjBVZSL4kUev_WOLSQK03ot8KYA9wjb25f_Akh73kWEL_nOAE0nphJLhxmbNBCoR.3SW
 swEyM.RcNVtQAVtpS6EMbWqm3t6XqDmyPM95lvdhzFWz9z_EjhE.u2FqT67c4myUxUamzYcKGBho
 0kQKPVOq84qCoC.e2v6XZplnm.8COAlobbXpm87hzS25pud9PGiN9VIRfPvLc.yYMOjURKzRwW25
 xPvuXHwxmVD7zpHKjludXGA7cn75A.LptmhKACEydSpnzudrorK_uGvVRVL4rf2y0dQhE2QbyfUt
 8ptEDyI9huZ.8kJk8g_dtIS7uK1_yOc0eEWg13xhqCVfGYrDWBFL6uwwvzZ9jOp3LMIXsHMgjb6_
 tylhtvh5tJR35wFY.xyHVOixQep7gAHFp65KpN.FAw_Emae9FN9ev3V6A7BtNr0DK8N4AeLpRpEy
 y8vJPDg2nloVa0C4yY0uedRRu9Q.wDcUCjld_dzlhguiLQj0g39w5TyRxjwDDuXig_sNjPhci1i0
 4BMHfIlOMLSHX0qkK.KaW_DIDvusu3s0coU6MLQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Sep 2018 16:42:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fd7ec437b937cec6fc58432a9a969757;
          Tue, 11 Sep 2018 16:42:08 +0000 (UTC)
Subject: [PATCH 07/10] SELinux: Abstract use of inode security blob
To:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
Date:   Tue, 11 Sep 2018 09:42:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
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
---
 security/selinux/hooks.c          | 26 +++++++++++++-------------
 security/selinux/include/objsec.h |  6 ++++++
 security/selinux/selinuxfs.c      |  4 ++--
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3468b4592036..2720fe3ebf5f 100644
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
@@ -1501,7 +1501,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
@@ -1801,7 +1801,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = selinux_inode(inode);
 
 	return avc_has_perm(&selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3029,7 +3029,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3129,7 +3129,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4150,7 +4150,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 sid = task_sid(p);
 
 	spin_lock(&isec->lock);
@@ -6529,7 +6529,7 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 
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
index b5665bdc29fc..cc434e45eaae 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1379,7 +1379,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 			goto out;
 		}
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = selinux_inode(inode);
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
@@ -1954,7 +1954,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	inode->i_ino = ++fsi->last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = selinux_inode(inode);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = LABEL_INITIALIZED;
-- 
2.17.1


