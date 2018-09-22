Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311FECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BF821569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U8LYwSsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BF821569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391838AbeIVGKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:37 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:42733 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391823AbeIVGKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575558; bh=e5xnuvmG768OyriYI2Q3ymRBgxIuzqd5VowbgFQFpQs=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=U8LYwSsrlGYsVnrJodiQXH601VhkjYWXBE0sW5S3GZwABtsd7G6KrNcVPUL0b7yeY9eOLuwfcR+JgPRMf1NODQDjwTo4K2s82b6NGl8YMOoaizuqb12tP+UuZhGhEusULc4zPAJi8Ll/XUlKiGTn5Nj9/zNtgY9UyCP2Qeca6mG311MUUUI2kbCytNBFQDb4hqtAiD1tTNirTff6FxHOw8BnDgNLxwCn0cd71g1dN5lJySVgIyxYuVylRcqmhZOUHY5RZWZ+/nZVsGLK9zu1cxZKRu80VzcRL2cMMezpGUdpND2lbbUhmYTEqXkL5FvFAuj7Q+zrZU9SjQ90FSigyQ==
X-YMail-OSG: V3qHnYQVM1kcCrRO6gQd9s.3ePXXakiLVHBO66FuYv_KwK9JAIFacleDFKePO58
 mQW_GXhqtnBG5pyBoF2d6oiZdSIVx3xRf.y22ozwYcNNOK.rF_I_6Oi9nukGYOuD9ToSHqRzkQRM
 .zF0fLkQaF9aSz15kmUO.odB0.woxBgJTsuXxajOnADopz8Hmwd6CSc9tXmY_VpOc9Hp0IZybZFd
 VDRfMncmmcoQCghaGrI9u0Uefj71iF88Cs6gJsMJ8ePrDpc1fPnd3gVuNvYp6_ax.mJVQLtaHfjY
 JNhY1A5wKJnl1.su1ysRO0L9lZ4ROW4I5Foir6_paK2MST761YirNth3oN4.SJBi1QD_VX50iGsG
 fayWRb0gL9RzXJ_cLfD849AJwkaWctHdOQXjPTZO.Qu8lqXbJHCZB9vXrOCyHi3oNwSpRmMjjVvr
 uBh_Vp1ktzKjWp_JTjhNZyuFV.umCv8n1.ndbEn7Bo28x4XFTbcXrWcNFEAO214rZfSc4K0ZOxT9
 Sa5CYruPwE_hD4qIldeMuJi1p1.fvvWHMKnfltzVgR3gS7s_kTQW_WQqnGILvePN.rk_z58q9zQE
 p5WkmDe6gm.40rSDqQU79RIkK7KpE9UfWt1aeBauDXiqImk1WMeiXnkpdbmkBnUz6aLzQb.vZP4m
 wxTCHpbf65fO97qeFewKrJ4ph1CW5BLSIAu3CpbKL.3_7P1I6lYovSfwnzG5RTlJvne14NgdBRBK
 aXjyxxUlh6eScYE_nG.LnaeY9ODhiugdwNPxaR3RQMiBLrnQRtBLcqmes_HyqzFaxF0TUYA22eZj
 wzT44qNWsgj685ezNoeSP.lKtkKfI0Sm5_ui7yR_OCOxEQ52nBlbZXvxRAckv.2vcNmx62yCSceE
 qkrfdfOsZYLkBnF2R_YOt1IaU8CyiDIGhVK8J9F6PBSgadfVMI63lqUN6VqZlUhbrC5L.81GtI28
 GnS3Oksec5lAWyhmfo3PmSEQbCUdkisvdgktoy5fgBf9LhmoD.9jYiZVnN242Rd.PUhrcAYkijmq
 ARNwJb68a7szmJzNwrFfa_MgjyHEbhMq6iwLJVW2z8Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:19:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fa508117aad77ec105d372d13cfd6c60;
          Sat, 22 Sep 2018 00:19:16 +0000 (UTC)
Subject: [PATCH v4 12/19] SELinux: Abstract use of inode security blob
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
Message-ID: <0a85567d-fde1-8272-d79e-b15d5b094b47@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:19:11 -0700
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

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 26 +++++++++++++-------------
 security/selinux/include/objsec.h |  6 ++++++
 security/selinux/selinuxfs.c      |  4 ++--
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fdda53552224..248ae907320f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -275,7 +275,7 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	might_sleep_if(may_sleep);
 
@@ -296,7 +296,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
@@ -306,7 +306,7 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 	error = __inode_security_revalidate(inode, NULL, !rcu);
 	if (error)
 		return ERR_PTR(error);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -315,14 +315,14 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
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
@@ -333,7 +333,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	struct inode *inode = d_backing_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
@@ -346,7 +346,7 @@ static void inode_free_rcu(struct rcu_head *head)
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
 	/*
@@ -1500,7 +1500,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
@@ -1800,7 +1800,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = selinux_inode(inode);
 
 	return avc_has_perm(&selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3028,7 +3028,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3128,7 +3128,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4148,7 +4148,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 sid = task_sid(p);
 
 	spin_lock(&isec->lock);
@@ -6527,7 +6527,7 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	spin_lock(&isec->lock);
 	isec->initialized = LABEL_INVALID;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index cad8b765f6dd..ea1687e737ad 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -170,4 +170,10 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
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
2.17.1


