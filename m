Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277F3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C119B214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TvvQ7xkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C119B214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeI0EMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:12:25 -0400
Received: from sonic312-28.consmr.mail.gq1.yahoo.com ([98.137.69.209]:44514
        "EHLO sonic312-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbeI0EMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537999042; bh=Tdp1We+wEypbt3F1eaqEY5pAEm2ABPyQrs7MsfsqAmQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=TvvQ7xkM9qPMD1Cc5clCaaNzjKBPLfrQM91/guwBjaRygKA5FaxM/WjI4BcUByjyRwZeiRI1Ts83Lmz0LfTdAFMZjgNanTs9Rsqw9D4uiUEk5HUO06H8RfQqApdX4YqusXC+1SBDCtXICrEq78P8bAoOHXkfvsqlaV8C3lO6B1cLs7W4EiBXHboSTuFPq0cWV2jIr+m0l2/luIVB4MkhMWDGwoXMSznprdknHT+Inb91iMv1REl+nAL+ZJJcG45qdvZQFaC3g9OqRVAbcSiya4aT/PMGUgk+OD6dvc6bQb1v22UllkebSqcYqVPkK+AjP9omPseKmHnDEk939NkYPg==
X-YMail-OSG: 0SsUm7kVM1mSbRWzyKgSAg8hqb7O6mITwUOLv66omgkUam_iw0fWgPNXVrrW3zJ
 nVE5aAnMKODstbRkpEhCLgqxOODzXmZP565IjEYzARsl01EcOv8qzzfQ0oLlSfwKdYmn4iZMjwhn
 eZSJI2tRxs75DxxMLC31jdianDEiMA84hnvnFdrLWBqhdskmXYBKh_tUuymg2mLM7fr4pCGNwq0C
 Z3YaHpeBcTDPpxdVGh_aENELrA5r0gNW03MwZ1eJ1mtb6nzdw.ZWA_KBaIrZYroaazt.P6BCdrKs
 N36IJo1POV7ArcFL0RC.elYwIujTQk4sgr5LsDDz_XYBYvQhUUmE5dmYwYF_OeICsZdZQ5VP3n90
 5FoqcElUsiRF9WrMvPveoq4tMo9lQ1kHGWLgfLB2P9HdTdxgfJMna9jG9NEjGnmJit0En1PbXEO.
 jqPb99tjJ9qb1AHT6jaMV_rEQ3PIYT4uIAzx470pldQB05MmicDLRAQ57auJ9ueV61Yx6zLZnSo6
 1YKNbYcOovyW8OUR_AdBMapaecB4uaS8AaR.a0r9kgaibfputswCOxmVumI5LLu0troxdXh0e33r
 G7XjDIHbc8YbrcCrNkQ8qz7PT1aekByDeNtLfCtlDk0aphRbhfyeuroC5H_hcPxBIP1j4QeORXFP
 XaeLlYMACfBnDi50_TuDv_z0hYaTD6myMaNEG1fH6bXRwKkIAEu2jexjT_RGlcp11iy38fnH_gXe
 1OTw0AqzwgKC2V0qS7cmH4jBrjgvicNaiLdrF_WwxymRqE7OUm2y2xwYvuZ_Lvvyvcxoh80KKLy5
 CrF2U2YA3Z9pGpRMYuYyoQ.sFh_yPo31_FXbu.v_meEZd2buMJykSUD1_A6MGq2JSgXBBKHaEr8G
 AJAfhcTaGtDtphzQ3YcRPLGlaMyCVzcQQ4554lxCMudAY1NUE1yZ4TjDzGVJxX.JEi5F05gf.eIS
 O.Ho34s5h7eSs9TpYw02hilur2T02OSUQneSp2.Ko_PVsp4CdD4I9tALR12Bc.bKF5GRNl5k2tU5
 9qlVWNmIV_uR_Q6KjQf4xJSbCo.BxsH2UBU646g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Sep 2018 21:57:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a43c3c0b1d4660336ba3c3c22c649da;
          Wed, 26 Sep 2018 21:57:19 +0000 (UTC)
Subject: [PATCH 21/19] LSM: Cleanup and fixes from Tetsuo Handa
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
Message-ID: <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com>
Date:   Wed, 26 Sep 2018 14:57:20 -0700
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

lsm_early_cred()/lsm_early_task() are called from only __init functions.

lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .

lsm_early_inode() should be avoided because it is not appropriate to
call panic() when lsm_early_inode() is called after __init phase.

Since all free hooks are called when one of init hooks failed, each
free hook needs to check whether init hook was called.

The original changes are from Tetsuo Handa. I have made minor
changes in some places, but this is mostly his code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  6 ++----
 security/security.c               | 27 ++++-----------------------
 security/selinux/hooks.c          |  5 ++++-
 security/selinux/include/objsec.h |  2 ++
 security/smack/smack_lsm.c        |  8 +++++++-
 5 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7e8b32fdf576..80146147531f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2095,13 +2095,11 @@ void __init loadpin_add_hooks(void);
 static inline void loadpin_add_hooks(void) { };
 #endif
 
-extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 extern int lsm_inode_alloc(struct inode *inode);
 
 #ifdef CONFIG_SECURITY
-void lsm_early_cred(struct cred *cred);
-void lsm_early_inode(struct inode *inode);
-void lsm_early_task(struct task_struct *task);
+void __init lsm_early_cred(struct cred *cred);
+void __init lsm_early_task(struct task_struct *task);
 #endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 76f7dc49b63c..d986045dd4c0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -267,7 +267,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
 {
 	if (blob_sizes.lbs_cred == 0) {
 		cred->security = NULL;
@@ -286,7 +286,7 @@ int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
  *
  * Allocate the cred blob for all the modules if it's not already there
  */
-void lsm_early_cred(struct cred *cred)
+void __init lsm_early_cred(struct cred *cred)
 {
 	int rc;
 
@@ -344,7 +344,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_file_alloc(struct file *file)
+static int lsm_file_alloc(struct file *file)
 {
 	if (!lsm_file_cache) {
 		file->f_security = NULL;
@@ -378,25 +378,6 @@ int lsm_inode_alloc(struct inode *inode)
 	return 0;
 }
 
-/**
- * lsm_early_inode - during initialization allocate a composite inode blob
- * @inode: the inode that needs a blob
- *
- * Allocate the inode blob for all the modules if it's not already there
- */
-void lsm_early_inode(struct inode *inode)
-{
-	int rc;
-
-	if (inode == NULL)
-		panic("%s: NULL inode.\n", __func__);
-	if (inode->i_security != NULL)
-		return;
-	rc = lsm_inode_alloc(inode);
-	if (rc)
-		panic("%s: Early inode alloc failed.\n", __func__);
-}
-
 /**
  * lsm_task_alloc - allocate a composite task blob
  * @task: the task that needs a blob
@@ -466,7 +447,7 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
  *
  * Allocate the task blob for all the modules if it's not already there
  */
-void lsm_early_task(struct task_struct *task)
+void __init lsm_early_task(struct task_struct *task)
 {
 	int rc;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 44337d2349d9..e54b7dbac775 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -332,8 +332,11 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 static void inode_free_security(struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct superblock_security_struct *sbsec;
 
+	if (!isec)
+		return;
+	sbsec = inode->i_sb->s_security;
 	/*
 	 * As not all inode security structures are in a list, we check for
 	 * empty list outside of the lock to make sure that we won't waste
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ee4471213909..8231ae02560e 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -180,6 +180,8 @@ static inline struct inode_security_struct *selinux_inode(
 						const struct inode *inode)
 {
 #ifdef CONFIG_SECURITY_STACKING
+	if (unlikely(!inode->i_security))
+		return NULL;
 	return inode->i_security + selinux_blob_sizes.lbs_inode;
 #else
 	return inode->i_security;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 784300406b97..b0b40454174b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -750,6 +750,13 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
 		return 0;
 
+	if (inode->i_security == NULL) {
+		int rc = lsm_inode_alloc(inode);
+
+		if (rc)
+			return rc;
+	}
+
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
 		/*
 		 * Unprivileged mounts don't get to specify Smack values.
@@ -818,7 +825,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	lsm_early_inode(inode);
 	init_inode_smack(inode, sp->smk_root);
 
 	if (transmute) {
-- 
2.17.1


