Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A6DC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683CA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A9cC061G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683CA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeK0Krf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:47:35 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:41243
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727647AbeK0Kre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276301; bh=kRBO5gYSD2+Kt+mgu48Ix2zGEOe/PuFqithweguD1I4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=A9cC061Gasia0s+FoR+xr/BJDJVstjDEi4qytsE0dlqkRv9y+3FO3LFigkKaGRCEMXXSF6YhfQ5Et3BOh33qXkR6OFl3xBfG/H1R0EyWPG+3FXrSYvIMuNpnAMQzsyYeo7tUKGAMDS5uVCqAUO2xo5y2FdwDfXfUn8fnwm69Qp3VZ+9WPlzfT2A6WnaLCVJxd4wC6JEZ0vL7wpWdUubiIS8pX1kBPBIZdavDR99dUMbRmJLXU556g+pmX7p95McpjK1YWI4nuBXsfIWT4Ajxn4I2YYf9vV3jBG6vvxOkNRw0y2fvdVUvxT86eVZq0dBIZdP8GOVim1uC0NNcdRS5Ag==
X-YMail-OSG: mDgSz0EVM1lAm6wwmq8RZmIbMM__9Xekk7Q3RXNWdPg4MQ75AI0LLaK19u_mSM5
 OsMygER_wwaf5XmOihdiOcHDoGvKljNiFGgdjicjJVG0CBtQWvy6x.XZnduVtc1n3zLDPmnLbZzs
 7Xdn7NtDjoGj8roNxCVzS7._1fLdnkWF5uBH9bDmTHomijWhqY19KmcettDbTlVtUMfRwy9Fj3e5
 FS9VvLXxf2DEVR2TgZNEuT9VPC.lfPIcDpJG9e05I3K6lT_fy7VCmyvlQEJnFwPkGMn8i.vb3NYw
 pZ4voOCHS6Ur_ypbR2xKYnQC2q1kcyDdI43uL0taKYwkcBWnhhd_F4MWIBoe3zWNR4mApK9pIaUy
 FTVUWE1m37mbstOhcIe9IltKRqVi8KTGbT5AHO_qDpaNhCrhoF7CtyGTC8hfHIPF.Fw0FPwv6qsL
 g8EEZdNmn6siQlxr0CvU2e_rCiCBCnPGLiAZfmJ_UVN2nBtmIcpOy9j.4rO_RohXaqUnGsYXpDx3
 iLUU7xM1eFQ.iuHniiJN5Hw3qsXJFY56iDq6sJWobaUD3bFWPncF9rtOBZO9MIrpL4nIvNoJPVDt
 LEjXwmZWpYoIGt4NaanOYPDBGTZ.0CYgwBmvgTOtSn7xmhbick_oqrIx9747Kd91qakh4twgCiD9
 CJK2OBH1itjkgnUtV1lG9bXTEsbQpPHx5penyAV1vkrBJ55BAFsjc9rTjvnDB7fs6k6hZfrizeq_
 rgCLUU.zPKVPy2L5YmePiXfy2rwNICyWbTn37y3xbeisT5NZ588GBJDbLEt6bNNPNL8FPPfaaBwl
 4RTOi3PIg3BLWE0vfjO2cnPeuWoo7kS43sLKYlYkIfB75.hgeuM4jXjW2DFdOmwJeMwtRtvmrhQk
 qWgPdmLtvDCbJnxlbUVtAvgrBrsCAfQM5fjFR7Or9nZnDYXOhvmWGXSJHk04B2qsXsXtxNX.ktjd
 TKce49PHL1fZonwK4hLxy61ZlXbhmv6X2YKFy0CFnDYPyOwiuqRPuz4GoRgthCfIE_zGmhqJXaEP
 fFtW86fuJVh0ue.EkPIPo_unB7PbXUySUDiBZFNJfSPeEQSF007lfDOK3woCbMW6axxosYbjdgWC
 f6.091XIintB6iuVMITLGOjZdLauBgpbmtrngkqiMMXI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:51:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2b76954c17c3ee032e6dcada42fe8ec;
          Mon, 26 Nov 2018 23:51:38 +0000 (UTC)
Subject: [PATCH v5 31/38] SELinux: Abstract use of inode security blob
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
Message-ID: <2a48377d-caeb-c126-3044-b74b58693185@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:51:35 -0800
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
 security/selinux/hooks.c          | 26 +++++++++++++-------------
 security/selinux/include/objsec.h |  6 ++++++
 security/selinux/selinuxfs.c      |  4 ++--
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9669a059ce0f..3069e95d86e6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -272,7 +272,7 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	might_sleep_if(may_sleep);
 
@@ -293,7 +293,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
@@ -303,7 +303,7 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 	error = __inode_security_revalidate(inode, NULL, !rcu);
 	if (error)
 		return ERR_PTR(error);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -312,14 +312,14 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
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
@@ -330,7 +330,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	struct inode *inode = d_backing_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
@@ -343,7 +343,7 @@ static void inode_free_rcu(struct rcu_head *head)
 
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
@@ -1802,7 +1802,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = selinux_inode(inode);
 
 	return avc_has_perm(&selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3030,7 +3030,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3130,7 +3130,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4150,7 +4150,7 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
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
index 96374dbf4ace..26b4ff6b4d81 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -170,4 +170,10 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
 	return file->f_security + selinux_blob_sizes.lbs_file;
 }
 
+static inline struct inode_security_struct *selinux_inode(
+						const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3a5a138a096..145ee62f205a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1378,7 +1378,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 			goto out;
 		}
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = selinux_inode(inode);
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
@@ -1953,7 +1953,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	inode->i_ino = ++fsi->last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = selinux_inode(inode);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = LABEL_INITIALIZED;
-- 
2.14.5


