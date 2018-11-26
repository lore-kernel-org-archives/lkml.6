Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B65C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4354E20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K7Su9VJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4354E20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeK0KqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:46:06 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:41593
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbeK0KqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276213; bh=LLC+kO5vVrGkpb8+XiusWEcN5YP2bfPWb69cQmSh7Xk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=K7Su9VJL/2gHlH9njquniizsSHTh0h+GTxz+sgC02c/gfpbpuiV20WElXT0Q0ZbTgnq9/60qSgGOpPpuM7N7Re4JQ9dg19gyWyGOahggLHVulujcQruN+cpJyV4TUO9AG7JaU3W4mrAhNZS3So9G5O5djp7Q52h8QQ72xe4vQ+4eRDeTyGFalhIRJDckTCL+jtmty3U6sxxGcZsMYlPt/N5rjBOA6ix5hNG+2Aa5E9F+s03h0QU/hiwVdUEH4IWsVSaHQNuX3bVrcXdOX5bEHafG7vqyclTWTZmkrq7gZk2kneB5QEoZb0GnWWXZOJYiC2HyqeMxUil8vJXDKo1KwA==
X-YMail-OSG: AASD4k4VM1mj98rcTkTv.Yj6joqAFAHLOwijaeFA_RoVxp7BQFk.2cQrke.L8G2
 TIHzMeH0IsFDhJHM.G4j55Dbbviw4Xm7sHdXllVckqUwv0Tm3H2Im4o.5unx2ghbGMEL8TrBcrqr
 GGks9F5XiAx.y_65gg3JL37QtSutgmNc6S9ChV.bDwawkY4AYYWxw9OThnwLJ5Mz6mAe9jcXzSG2
 sGaauLOYYxo.fauwMf4oJv97qsj2dlEQ.ETPEBO1W9D3NDea84Xq.OXCNP2CNG28h56b5lQ4qlsY
 k2p1j.8VudKuUgkBXHGb5A.3Ewrug1lL.qHsnGT4Z2re0j0wM8Iq9HNVNFoUJgg5ujwyRg30fN19
 WO_n6g2v3xmgq_gJnaOSKm1nVjPW8W_BaM4dmAdTP3Y_yw4pi.KUIdWieliAMNPulGkdx64sL1Gd
 XZ_y9lMz81w_nGXTqxILb_iUn2eMJXctVS6GVqQJmCqh4Ylu5qmNrA2HfqARsT.Rj2_REMWrnGfS
 DZlrlVDGeP8sMvMHFUIQl5dFIjP7knsCrDSXdD1W6Ioz3twSZ6Da0Vs0EOp6XWEZVFhhD0_E4FYN
 vDUX4SRtxfN4E7F_C7V3jPH1GQIkAKq2C1gFVC6r6SW8vWDQ8fC4zsJisJBz1t9DX8FmDcRy.ikR
 7dxwSbILfP9PuXWOt6BPKd0LGwfcSJUskpEhvpfuKGysQVVTcUC4Mx7ahqGg5bicsilQQer3iuw0
 GohxZVBXi7f4F.jiSyh2FzLC52VTSNMtoWnEUA1XMcGxjlucMDoNwcfjRSjofwWCSv7d8xmtYfeC
 vUmlcJaNvtq7MxPnFZQofToa6hjt4DKyRxFYtMKTsHyVLV.utAX2L2jVqEzuY6uXuFcOi8wSoR2P
 rcnDWDPdFTmrjkiQEgZYIsWod3qt.fIFsJ6Q.DOExarVwl8rDZusCdO5UsridP.Oh0TZWDQStjXL
 rI8GElyvQ3I3vI_q3fqaUbNtFAtgTpHPynSi9xLPnbREFFBTkp7wg_Nf9Lk67_Xwf1xv2ivaTmIt
 HkPAe3Coel4xjW.sWUjt8p3buYQ4d_SmWWdkxaLioV4IX7GSkfC6pI0iNGa81jBAsBE9IE0Up9y.
 uc9c.BWYGVSCiPgNFAC743B3vyIUNZe4fmZAVKyg0Yy8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:50:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d4f539d08126b1dbcd7f23ac8540776c;
          Mon, 26 Nov 2018 23:50:13 +0000 (UTC)
Subject: [PATCH v5 30/38] LSM: Infrastructure management of the file security
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
Message-ID: <06c9ef23-2846-c588-2f0a-95c6d2613bd4@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:50:10 -0800
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

Move management of the file->f_security blob out of the
individual security modules and into the infrastructure.
The modules no longer allocate or free the data, instead
they tell the infrastructure how much space they require.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h         |  1 +
 security/apparmor/include/file.h  |  5 +++-
 security/apparmor/lsm.c           | 19 +++++++-------
 security/security.c               | 54 ++++++++++++++++++++++++++++++++++++---
 security/selinux/hooks.c          | 25 ++----------------
 security/selinux/include/objsec.h |  2 +-
 security/smack/smack.h            |  3 ++-
 security/smack/smack_lsm.c        | 14 +---------
 8 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c9458280214e..64499c2d44cd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2029,6 +2029,7 @@ struct security_hook_list {
  */
 struct lsm_blob_sizes {
 	int	lbs_cred;
+	int	lbs_file;
 };
 
 /*
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 4c2c8ac8842f..8be09208cf7c 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -32,7 +32,10 @@ struct path;
 				 AA_MAY_CHMOD | AA_MAY_CHOWN | AA_MAY_LOCK | \
 				 AA_EXEC_MMAP | AA_MAY_LINK)
 
-#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
+static inline struct aa_file_ctx *file_ctx(struct file *file)
+{
+	return file->f_security + apparmor_blob_sizes.lbs_file;
+}
 
 /* struct aa_file_ctx - the AppArmor context the file was opened in
  * @lock: lock to update the ctx
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 70669e676212..3ae8c902d740 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -433,21 +433,21 @@ static int apparmor_file_open(struct file *file)
 
 static int apparmor_file_alloc_security(struct file *file)
 {
-	int error = 0;
-
-	/* freed by apparmor_file_free_security */
+	struct aa_file_ctx *ctx = file_ctx(file);
 	struct aa_label *label = begin_current_label_crit_section();
-	file->f_security = aa_alloc_file_ctx(label, GFP_KERNEL);
-	if (!file_ctx(file))
-		error = -ENOMEM;
-	end_current_label_crit_section(label);
 
-	return error;
+	spin_lock_init(&ctx->lock);
+	rcu_assign_pointer(ctx->label, aa_get_label(label));
+	end_current_label_crit_section(label);
+	return 0;
 }
 
 static void apparmor_file_free_security(struct file *file)
 {
-	aa_free_file_ctx(file_ctx(file));
+	struct aa_file_ctx *ctx = file_ctx(file);
+
+	if (ctx)
+		aa_put_label(rcu_access_pointer(ctx->label));
 }
 
 static int common_file_perm(const char *op, struct file *file, u32 mask)
@@ -1155,6 +1155,7 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
  */
 struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
+	.lbs_file = sizeof(struct aa_file_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index c49d4a18c75f..499842ece0fb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -40,6 +40,8 @@
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+static struct kmem_cache *lsm_file_cache;
+
 char *lsm_names;
 static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
 
@@ -158,6 +160,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		return;
 
 	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
 }
 
 /* Prepare LSM for initialization. */
@@ -279,6 +282,15 @@ static void __init ordered_lsm_init(void)
 		prepare_lsm(*lsm);
 
 	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
+
+	/*
+	 * Create any kmem_caches needed for blobs
+	 */
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
@@ -448,6 +460,27 @@ void __init lsm_early_cred(struct cred *cred)
 		panic("%s: Early cred alloc failed.\n", __func__);
 }
 
+/**
+ * lsm_file_alloc - allocate a composite file blob
+ * @file: the file that needs a blob
+ *
+ * Allocate the file blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_file_alloc(struct file *file)
+{
+	if (!lsm_file_cache) {
+		file->f_security = NULL;
+		return 0;
+	}
+
+	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
+	if (file->f_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1131,12 +1164,27 @@ int security_file_permission(struct file *file, int mask)
 
 int security_file_alloc(struct file *file)
 {
-	return call_int_hook(file_alloc_security, 0, file);
+	int rc = lsm_file_alloc(file);
+
+	if (rc)
+		return rc;
+	rc = call_int_hook(file_alloc_security, 0, file);
+	if (unlikely(rc))
+		security_file_free(file);
+	return rc;
 }
 
 void security_file_free(struct file *file)
 {
+	void *blob;
+
 	call_void_hook(file_free_security, file);
+
+	blob = file->f_security;
+	if (blob) {
+		file->f_security = NULL;
+		kmem_cache_free(lsm_file_cache, blob);
+	}
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1254,7 +1302,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
 }
@@ -1275,7 +1323,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ce1d37378eb5..9669a059ce0f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -145,7 +145,6 @@ static int __init checkreqprot_setup(char *str)
 __setup("checkreqprot=", checkreqprot_setup);
 
 static struct kmem_cache *sel_inode_cache;
-static struct kmem_cache *file_security_cache;
 
 /**
  * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
@@ -377,27 +376,15 @@ static void inode_free_security(struct inode *inode)
 
 static int file_alloc_security(struct file *file)
 {
-	struct file_security_struct *fsec;
+	struct file_security_struct *fsec = selinux_file(file);
 	u32 sid = current_sid();
 
-	fsec = kmem_cache_zalloc(file_security_cache, GFP_KERNEL);
-	if (!fsec)
-		return -ENOMEM;
-
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
-	file->f_security = fsec;
 
 	return 0;
 }
 
-static void file_free_security(struct file *file)
-{
-	struct file_security_struct *fsec = selinux_file(file);
-	file->f_security = NULL;
-	kmem_cache_free(file_security_cache, fsec);
-}
-
 static int superblock_alloc_security(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec;
@@ -3559,11 +3546,6 @@ static int selinux_file_alloc_security(struct file *file)
 	return file_alloc_security(file);
 }
 
-static void selinux_file_free_security(struct file *file)
-{
-	file_free_security(file);
-}
-
 /*
  * Check whether a task has the ioctl permission and cmd
  * operation to an inode.
@@ -6857,6 +6839,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 
 struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_file = sizeof(struct file_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6927,7 +6910,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
@@ -7112,9 +7094,6 @@ static __init int selinux_init(void)
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
 					    0, SLAB_PANIC, NULL);
-	file_security_cache = kmem_cache_create("selinux_file_security",
-					    sizeof(struct file_security_struct),
-					    0, SLAB_PANIC, NULL);
 	avc_init();
 
 	avtab_cache_init();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index e0ac2992e059..96374dbf4ace 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -167,7 +167,7 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
-	return file->f_security;
+	return file->f_security + selinux_blob_sizes.lbs_file;
 }
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 50854969a391..2007d38d0e46 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -364,7 +364,8 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 
 static inline struct smack_known **smack_file(const struct file *file)
 {
-	return (struct smack_known **)&file->f_security;
+	return (struct smack_known **)(file->f_security +
+				       smack_blob_sizes.lbs_file);
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3e11be8cce7e..c560cb8e155c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1579,18 +1579,6 @@ static int smack_file_alloc_security(struct file *file)
 	return 0;
 }
 
-/**
- * smack_file_free_security - clear a file security blob
- * @file: the object
- *
- * The security blob for a file is a pointer to the master
- * label list, so no memory is freed.
- */
-static void smack_file_free_security(struct file *file)
-{
-	file->f_security = NULL;
-}
-
 /**
  * smack_file_ioctl - Smack check on ioctls
  * @file: the object
@@ -4637,6 +4625,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 
 struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_smack),
+	.lbs_file = sizeof(struct smack_known *),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4674,7 +4663,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, smack_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
-- 
2.14.5


