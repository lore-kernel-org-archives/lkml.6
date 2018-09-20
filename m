Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1CBECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12121522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ekQh6Uny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA12121522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbeITGBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:01:46 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:46204 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387645AbeITGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402878; bh=lDn2TZnl47IkvDsRZQmyI5nIEhttnVnyaZY5OBTFSzA=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=ekQh6UnyJA80hcF2VSecbjRmxRNIMlhSQSXs/Hnswi3Z55CIFpPf5ukXeUSORjx4pfyl/+p9ElYHfPpBvKNr0iyRgaTOQKYqV8UJ/UKHgXN3D+1adc1EKmeGPv5N+hajJXRVb+NzDCt35SUQpevugGl+sAfReihgJ4fnMI5xp+2VZommhHw4UwZ1Fop/4lE4t48Z4K4StsaAK6CcZagtXL3cqVcACqgz+Aptr+iMlOLaQm6IqXPLvpYCx568cCEOiOQYPEIDPJsgI+lghKfbu+InfPq3V6JdpyuJlvVIFD4SHnzKVmHYDKauviRlR1uV2ebqqbzIU5kOIeoCD6Dp+w==
X-YMail-OSG: 4GI39OMVM1mQN855hYEBWo71_Q3rRiE3gawxC85cURzPQmTbWDDongljfMPLQLM
 50zm.HF7252i.ZF2oVblDAmp3wh1OCbVBKwkbIdTVxD8LxkJ3uGXJ2UCQmZVKRA1KcF1bQ9uLaXc
 Q6KkGw1uUq1t5ZJAk_tVCtb5fIUWRjLNBj5361RgHSQ9hAdEvjUc7BdV5GQA7nxDEC7Hp8PjODOO
 hihuUn8IJFLrD4RLR7ouMlgPHIlH5vVr4aVu6nLqOtCJQhtEUdg5fYybRdpX05Cbs.Kgx.z4Pmoe
 bAx_QcyIwNipk6rfgh0tOs8kjT80BPuQm2v7L3Zo0fbOKscbnNK8UMglfs8WohTf9x_HV1nFrXp1
 .nBEEIYk1gIRdw1Viy_mjD__aFGlb7RlbOesIL2kFdIVqIlDdwNE1uVrgJRlsF6D1.B48GIppl_N
 4ivLp4LXYQoPUcrR.L5ZNcUdk4IVW9tiKkmNJOc3Yjt33Vvdlbu.mhyFB6exYIyabP_cVUghSWom
 6rzaD3jcHy7F5sOXhhDbpd7snwwrUWT.SO9Yc4VQqXXary9aLxzJJ2rFK7eQcFDaLiyoRQ5E4QNO
 dKpkrVbQuud0qg6ZEogs1U2RojJJxAmYe8NDRdh1FwXjAGlWQEvIqQSfjRchoa1eirMW3KE7uRcf
 _fxjqjCdjmp4pXhkJasAyfVom_SN_2M9VF3GEds2xz6oBkkB6COD5Fb7WQty4IztlHHAsywDQw7P
 UcQWaZTojuh1NT.LROdIRROmJslblFQ0tCmJ.s0QE2..yCkvaD1P8.i9yMQh2cRwRLrWEYfOHHFf
 exSY2F2Ot3fV6VNbUDG9GIORQhu4ALkopB8qaWtq9SNVQkGp0R2U.ba7lzg02W7HQzmkO7djsiV4
 HKb7BdHa1IzVxsEDUpsLgqHKEFkZNVxMoSdUJ50EcWoLxTtBNUcbLptUMieRiQNnFU.pbpecJZbx
 oejGc.mJEZPZvHIrjuNIYlbvasf5sKWzv7_xjGg3JprFZBSo9U90bp66tObjgBTM2vHytTuO2HUn
 9QAonj0tqo81aaHzpklp2KYlg7t6H44hS3PVkrZMqYak-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:21:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d7aafc99d96b41bd5270f3948311290;
          Thu, 20 Sep 2018 00:21:13 +0000 (UTC)
Subject: [PATCH v3 11/16] SELinux: Abstract use of inode security blob
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
Message-ID: <95742603-9696-55e5-52ca-0d9950af89d9@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:21:10 -0700
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


