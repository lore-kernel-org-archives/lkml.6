Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C9ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D621522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mTDx/4Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6D621522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbeITGCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:02:01 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:42106 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387687AbeITGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402893; bh=xIENXakuwNBCgedFr9ew6XSYZJxkbJjzQLSZWOsXIhE=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=mTDx/4UowT7m7+sj64YCyZA/apAoUpBKSdNzRcoUjZG7w1ctK5pgcVhPEuEU3bsPQ+SsbgRWtm8lRHC+vZRHuHkcGI/uqiJb/VYFdV7FTCSLfK82diU1YiX0g7UK75KxLVZj8NpP7amgHlUYMPriPz1H2xadIE4o+4ZpPX/LLuB4LXdmGkK1ZFJPDAKIe2sgG5t51sCUxvHwaoXmg0Et/xdnMy4u7qFYwud0hX4qmtrBaHJu9luF0VRob3gC0BIQhHhPLzaWErcjjyGBPPH66joDNZW0UB3iJnhaS7uDG0C36v2bqMLhNa2qswg/3KqNd4UOYjcf/Qpze7wYv64IUw==
X-YMail-OSG: LDFNlR8VM1kRay_ipbOEg0tTay5eJflWQOUPzqYBRVxUL8SW4pc0GYvJxdn3QJR
 qQvGliaAc9HGfrRbsEYnbgcIL2mGbp1iLEPRnZ945lX8IcIL4ahlgKknHVcSZbj0wpSeBXJq6_VF
 L5GMlYDvG5iJgUBvfKWDPzPINf37MzAbmd3vZIpEI_GS782KVDdsJeoc1Cwo2zWts9HvslRGGcai
 iWNWsorPq9DDGrdcOOQJi8N9JTE.TXxv_1xBAf1AhoKLJdkpGJSDJ65GZB6qoNvyuGFuyGKLt1os
 NkBeGfV1E6bDhLelxSR4O4zQFudgU6FZ5zhfS3mUnuHjN4V2IGLJoD9WhhhyB4sCbM0msukLnELI
 92AAgEFPbuay2OijhMZNJBuL_ztePwEX1erTpVcZGXWjTZKjuUj5eJwyUwT08VTnWv_ma2pHzNfD
 IlHKWS5BiJTrAVnPSasMjfEcwPkfGEsTnmRtVI6qMNtd.ftTDw.SER84cX28Tl4Mono.xCWEJC.k
 Ya1gl0VBezLu_BKUAEkoV.dOni0HNZjH7sogiNuoisA8KgSnhrofqY_lDXm8ORNUROPYM0ngtfSM
 t74gXOdb8siZsUG2NxQa5XpQqLHCXy.CyjkFYGTPB7b4nImUgne3lbFgyOHS6mKRpUrwbZ_gQTY_
 rJ9EFFfl0P7musqV54rTALIG.zUX1bXLVCp9_vHuoZNG3xD4z7qkXQOdTcVB_gc.ZkrZh_iTzWEj
 _5z.4nVacZnmAWcV5MmuovX2tcRIKZA.BbixNRHHacQIqxBE3HvI2d76GFr5jnNe75dpVfeIqxY1
 aMQgKU7J67D50ano7JBVA3zsIzCjd0uTBEJIBNzVaZmescvpMvsxTJfc36VXC64uBWqyMCP.pGBR
 LvweJsNld0SzLKaAdKfMTvyfs_N6gdF33FUz4rnNTZKK7bKfd6ETe1dn3CjSDZqhw2G2YLOoN8ob
 nS5vxXl_nxHpBKOvjPZJN1QdsYyqoZ8pqEtcHbHSAq8oWRWNHmgvgSv33yfvqPPOao7847DfU.Q5
 1SF.W8k6ht_P_adEtYIuxEFN7tVtxNencHogFBdtQFg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:21:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c1166888c94a02a36adf5e21e37695d4;
          Thu, 20 Sep 2018 00:21:30 +0000 (UTC)
Subject: [PATCH v3 13/16] LSM: Infrastructure management of the inode security
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
Message-ID: <78bb04a6-6e94-2bd3-9bf4-7d61903927c1@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:21:27 -0700
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

LSM: Infrastructure management of the inode security

Move management of the inode->i_security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  3 ++
 security/security.c               | 83 ++++++++++++++++++++++++++++++-
 security/selinux/hooks.c          | 32 +-----------
 security/selinux/include/objsec.h |  5 +-
 security/smack/smack_lsm.c        | 70 ++++----------------------
 5 files changed, 98 insertions(+), 95 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 167ffbd4d0c0..416b20c3795b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2030,6 +2030,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int	lbs_inode;
 };
 
 /*
@@ -2092,9 +2093,11 @@ static inline void loadpin_add_hooks(void) { };
 #endif
 
 extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
+extern int lsm_inode_alloc(struct inode *inode);
 
 #ifdef CONFIG_SECURITY
 void lsm_early_cred(struct cred *cred);
+void lsm_early_inode(struct inode *inode);
 #endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 5430cae73cf6..2501cdcbebff 100644
--- a/security/security.c
+++ b/security/security.c
@@ -41,6 +41,7 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
+static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
 static struct lsm_blob_sizes blob_sizes;
@@ -101,6 +102,10 @@ int __init security_init(void)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
 						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_inode)
+		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
+						    blob_sizes.lbs_inode, 0,
+						    SLAB_PANIC, NULL);
 	/*
 	 * The second call to a module specific init function
 	 * adds hooks to the hook lists and does any other early
@@ -111,6 +116,7 @@ int __init security_init(void)
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
+	pr_info("LSM: inode blob size       = %d\n", blob_sizes.lbs_inode);
 #endif
 
 	return 0;
@@ -288,6 +294,13 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	/*
+	 * The inode blob gets an rcu_head in addition to
+	 * what the modules might need.
+	 */
+	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 }
 
 /**
@@ -311,6 +324,46 @@ int lsm_file_alloc(struct file *file)
 	return 0;
 }
 
+/**
+ * lsm_inode_alloc - allocate a composite inode blob
+ * @inode: the inode that needs a blob
+ *
+ * Allocate the inode blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_inode_alloc(struct inode *inode)
+{
+	if (!lsm_inode_cache) {
+		inode->i_security = NULL;
+		return 0;
+	}
+
+	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
+	if (inode->i_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_early_inode - during initialization allocate a composite inode blob
+ * @inode: the inode that needs a blob
+ *
+ * Allocate the inode blob for all the modules if it's not already there
+ */
+void lsm_early_inode(struct inode *inode)
+{
+	int rc;
+
+	if (inode == NULL)
+		panic("%s: NULL inode.\n", __func__);
+	if (inode->i_security != NULL)
+		return;
+	rc = lsm_inode_alloc(inode);
+	if (rc)
+		panic("%s: Early inode alloc failed.\n", __func__);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -557,14 +610,40 @@ EXPORT_SYMBOL(security_sb_parse_opts_str);
 
 int security_inode_alloc(struct inode *inode)
 {
-	inode->i_security = NULL;
-	return call_int_hook(inode_alloc_security, 0, inode);
+	int rc = lsm_inode_alloc(inode);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(inode_alloc_security, 0, inode);
+	if (unlikely(rc))
+		security_inode_free(inode);
+	return rc;
+}
+
+static void inode_free_by_rcu(struct rcu_head *head)
+{
+	/*
+	 * The rcu head is at the start of the inode blob
+	 */
+	kmem_cache_free(lsm_inode_cache, head);
 }
 
 void security_inode_free(struct inode *inode)
 {
 	integrity_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
+	/*
+	 * The inode may still be referenced in a path walk and
+	 * a call to security_inode_permission() can be made
+	 * after inode_free_security() is called. Ideally, the VFS
+	 * wouldn't do this, but fixing that is a much harder
+	 * job. For now, simply free the i_security via RCU, and
+	 * leave the current inode->i_security pointer intact.
+	 * The inode will be freed after the RCU grace period too.
+	 */
+	if (inode->i_security)
+		call_rcu((struct rcu_head *)inode->i_security,
+				inode_free_by_rcu);
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 248ae907320f..389e51ef48a5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -147,8 +147,6 @@ static int __init checkreqprot_setup(char *str)
 }
 __setup("checkreqprot=", checkreqprot_setup);
 
-static struct kmem_cache *sel_inode_cache;
-
 /**
  * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
  *
@@ -244,13 +242,9 @@ static inline u32 task_sid(const struct task_struct *task)
 
 static int inode_alloc_security(struct inode *inode)
 {
-	struct inode_security_struct *isec;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 sid = current_sid();
 
-	isec = kmem_cache_zalloc(sel_inode_cache, GFP_NOFS);
-	if (!isec)
-		return -ENOMEM;
-
 	spin_lock_init(&isec->lock);
 	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
@@ -258,7 +252,6 @@ static int inode_alloc_security(struct inode *inode)
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
 	isec->initialized = LABEL_INVALID;
-	inode->i_security = isec;
 
 	return 0;
 }
@@ -336,14 +329,6 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	return selinux_inode(inode);
 }
 
-static void inode_free_rcu(struct rcu_head *head)
-{
-	struct inode_security_struct *isec;
-
-	isec = container_of(head, struct inode_security_struct, rcu);
-	kmem_cache_free(sel_inode_cache, isec);
-}
-
 static void inode_free_security(struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
@@ -364,17 +349,6 @@ static void inode_free_security(struct inode *inode)
 		list_del_init(&isec->list);
 		spin_unlock(&sbsec->isec_lock);
 	}
-
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to selinux_inode_permission() can be made
-	 * after inode_free_security() is called. Ideally, the VFS
-	 * wouldn't do this, but fixing that is a much harder
-	 * job. For now, simply free the i_security via RCU, and
-	 * leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
-	call_rcu(&isec->rcu, inode_free_rcu);
 }
 
 static int file_alloc_security(struct file *file)
@@ -6838,6 +6812,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
+	.lbs_inode = sizeof(struct inode_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -7107,9 +7082,6 @@ static __init int selinux_init(void)
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 
-	sel_inode_cache = kmem_cache_create("selinux_inode_security",
-					    sizeof(struct inode_security_struct),
-					    0, SLAB_PANIC, NULL);
 	avc_init();
 
 	avtab_cache_init();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ea1687e737ad..591adb374d69 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -57,10 +57,7 @@ enum label_initialized {
 
 struct inode_security_struct {
 	struct inode *inode;	/* back pointer to inode object */
-	union {
-		struct list_head list;	/* list of inode_security_struct */
-		struct rcu_head rcu;	/* for freeing the inode_security_struct */
-	};
+	struct list_head list;	/* list of inode_security_struct */
 	u32 task_sid;		/* SID of creating task */
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 364699ad55b9..6617abb51732 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -288,24 +288,18 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 }
 
 /**
- * new_inode_smack - allocate an inode security blob
+ * init_inode_smack - initialize an inode security blob
+ * @isp: the blob to initialize
  * @skp: a pointer to the Smack label entry to use in the blob
  *
- * Returns the new blob or NULL if there's no memory available
  */
-static struct inode_smack *new_inode_smack(struct smack_known *skp)
+static void init_inode_smack(struct inode *inode, struct smack_known *skp)
 {
-	struct inode_smack *isp;
-
-	isp = kmem_cache_zalloc(smack_inode_cache, GFP_NOFS);
-	if (isp == NULL)
-		return NULL;
+	struct inode_smack *isp = smack_inode(inode);
 
 	isp->smk_inode = skp;
 	isp->smk_flags = 0;
 	mutex_init(&isp->smk_lock);
-
-	return isp;
 }
 
 /**
@@ -824,17 +818,13 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	/*
 	 * Initialize the root inode.
 	 */
-	isp = smack_inode(inode);
-	if (isp == NULL) {
-		isp = new_inode_smack(sp->smk_root);
-		if (isp == NULL)
-			return -ENOMEM;
-		inode->i_security = isp;
-	} else
-		isp->smk_inode = sp->smk_root;
+	lsm_early_inode(inode);
+	init_inode_smack(inode, sp->smk_root);
 
-	if (transmute)
+	if (transmute) {
+		isp = smack_inode(inode);
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
+	}
 
 	return 0;
 }
@@ -963,48 +953,10 @@ static int smack_inode_alloc_security(struct inode *inode)
 {
 	struct smack_known *skp = smk_of_current();
 
-	inode->i_security = new_inode_smack(skp);
-	if (inode->i_security == NULL)
-		return -ENOMEM;
+	init_inode_smack(inode, skp);
 	return 0;
 }
 
-/**
- * smack_inode_free_rcu - Free inode_smack blob from cache
- * @head: the rcu_head for getting inode_smack pointer
- *
- *  Call back function called from call_rcu() to free
- *  the i_security blob pointer in inode
- */
-static void smack_inode_free_rcu(struct rcu_head *head)
-{
-	struct inode_smack *issp;
-
-	issp = container_of(head, struct inode_smack, smk_rcu);
-	kmem_cache_free(smack_inode_cache, issp);
-}
-
-/**
- * smack_inode_free_security - free an inode blob using call_rcu()
- * @inode: the inode with a blob
- *
- * Clears the blob pointer in inode using RCU
- */
-static void smack_inode_free_security(struct inode *inode)
-{
-	struct inode_smack *issp = smack_inode(inode);
-
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to smack_inode_permission() can be made
-	 * after smack_inode_free_security() is called.
-	 * To avoid race condition free the i_security via RCU
-	 * and leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
-	call_rcu(&issp->smk_rcu, smack_inode_free_rcu);
-}
-
 /**
  * smack_inode_init_security - copy out the smack from an inode
  * @inode: the newly created inode
@@ -4619,6 +4571,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_cred = sizeof(struct task_smack),
 	.lbs_file = sizeof(struct smack_known *),
+	.lbs_inode = sizeof(struct inode_smack),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4637,7 +4590,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
-	LSM_HOOK_INIT(inode_free_security, smack_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, smack_inode_init_security),
 	LSM_HOOK_INIT(inode_link, smack_inode_link),
 	LSM_HOOK_INIT(inode_unlink, smack_inode_unlink),
-- 
2.17.1


