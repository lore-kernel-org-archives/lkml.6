Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C9C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF3321569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PptiLM5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF3321569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbeIVGK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:26 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:40655 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbeIVGK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575548; bh=JIf7CL6j6urC08obUO8Fk1nZ8ihdTdkjl2bn5zhLBT8=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=PptiLM5AxkJN5w7yk3cU8N1QU/FPK8QWP81Xr53nIDe7gfC2izQ6o654ulYFmNWgHFML7Yr8NGiTzmx9wyfzeuWEMRaSiOeJBF84F/K1Dn6ipFCQ8wz/ND8VXVNsVdYa6oHwaOfGTVZJHE7gDWuxCHk3DrW7T38mlDVbaqb8oNwibYXSnBxUWPHHq7xxSWqVZT0JDRttEiu8yWCq9ucMgxKWh11FOMPPU2eQhtqtNsGpVoqvuH6WIul+LnhFVAa8zgcloG0vcfd3xSM6ilkBO8nUu1etW5GSEx+ceWV8DazBne3PvMBdtNlX9MZllkj/H5RNhZgGHh0ptBMpvqzm0A==
X-YMail-OSG: vXTT9_cVM1kGZYstgkStR58ztDs4K.meNMQkcdtswrAYQWl0THUdchtAX0ZzADZ
 ySleFutCmLHX2y2ol8PB5J3z3M0kxNrzt0oGNdjcD6x8AQJLYhmvQ7AqlBGesiKq9HXL1hv9Ymm.
 TLkDSzy2atStFQ.XDqyZonixHh4VSbR_ItjO9GMX9RknsyUKk3qSz3lvegM5PlPzHcl.zoDD6Q6Q
 PauWIY1c8k.RQikznLMD3hocEvu461Jb8MKwFGYqFX1NN49Jx_9eLP1DhLu0RmX1kkZbuKB56qGh
 OWtu675wlVUmpC_D2iRP8qL3HTTxrInLy30Q.qwvv58e2aXVRlsvVS6RlXDvTZ06oLUJvy6o.gjg
 22zoVI3y7Lyy4lEunQun_2V9l7lDqdiAE.h7Ljaqe41kp_1kEZKn9c.l1EpHZ436kYl7UZ.R8Twj
 6cmpPp2231m4nAlwv1qh9fRwWI5tPGtyUs_9SKv6Kqhelg1XYCIPbyrr41PPz4n0hFc1JFv0xUAf
 pv0fG2ijdWSlNVog4bFX3fhnccE8Tsry7KzrP380.FEKc.1_dO7oPoVP7DezG5XUt_beDOwuHWVV
 bfwoQ2.W8EMBXBwbFLIxOOZW6vJr8z34VTUr58CwanG17ihpeEJDnrpHnSsAwZ.WZBIowYvmUGRr
 _MlrxTyDxAyB8gjGF3VUI.7_oZP9B3f.UZzo_nOVAPqe7TnvjYfnwNmiwmalikTJr55BNEMuTUwo
 uoTJlsdxegbVgTFkMW4xRusOYvXViOsUMG2GdPvEklyiPF0.HfVGk_ecVDc7AzQvLl75gKsWBNp3
 frMn0sOi2_sqZ1ZJul5z0a1FWMZieJImrCgTqhQEzyN4WDZtX0WsUY6G4ZGR98PTMpk4U0qjFAcp
 2FwR5XGWNzHRU7cn4NWjLjgi82lnd_YNhlo9imeX9lKjjylhK.v4BE5h7bduLKAFgMy9WrryhGLr
 JRGD2VW_9L0XvqP3GIWQEnbWDaQBrLlMIBe.j57li4Uw7UpaJoLc0eo2rzWz8zd9rqf_pBpUtOcV
 pOnNMROGz9tIGbPQoT.qGnbCtobkJbIRfGIWbpyeg3A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:19:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d63621613b76c90661f1c74afe6e1004;
          Sat, 22 Sep 2018 00:19:06 +0000 (UTC)
Subject: [PATCH v4 11/19] LSM: Infrastructure management of the file security
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
Message-ID: <1ca14e0b-6a95-4efe-7a23-e82d7562df26@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:19:00 -0700
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

Move management of the file->f_security blob out of the
individual security modules and into the infrastructure.
The modules no longer allocate or free the data, instead
they tell the infrastructure how much space they require.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/apparmor/lsm.c    | 19 +++++++-------
 security/security.c        | 54 +++++++++++++++++++++++++++++++++++---
 security/selinux/hooks.c   | 25 ++----------------
 security/smack/smack.h     |  2 +-
 security/smack/smack_lsm.c | 14 +---------
 6 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0bef312efd45..167ffbd4d0c0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2029,6 +2029,7 @@ struct security_hook_list {
  */
 struct lsm_blob_sizes {
 	int	lbs_cred;
+	int	lbs_file;
 };
 
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c2566aaa138e..15716b6ff860 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -431,21 +431,21 @@ static int apparmor_file_open(struct file *file)
 
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
@@ -1131,6 +1131,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
  */
 struct lsm_blob_sizes apparmor_blob_sizes = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
+	.lbs_file = sizeof(struct aa_file_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index ff7df14f6db1..5430cae73cf6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -40,6 +40,8 @@
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+static struct kmem_cache *lsm_file_cache;
+
 char *lsm_names;
 static struct lsm_blob_sizes blob_sizes;
 
@@ -92,6 +94,13 @@ int __init security_init(void)
 	 */
 	do_security_initcalls();
 
+	/*
+	 * Create any kmem_caches needed for blobs
+	 */
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
 	/*
 	 * The second call to a module specific init function
 	 * adds hooks to the hook lists and does any other early
@@ -101,6 +110,7 @@ int __init security_init(void)
 
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
+	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 #endif
 
 	return 0;
@@ -277,6 +287,28 @@ static void __init lsm_set_size(int *need, int *lbs)
 void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+}
+
+/**
+ * lsm_file_alloc - allocate a composite file blob
+ * @file: the file that needs a blob
+ *
+ * Allocate the file blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_file_alloc(struct file *file)
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
 }
 
 /*
@@ -962,12 +994,28 @@ int security_file_permission(struct file *file, int mask)
 
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
+	if (!lsm_file_cache)
+		return;
+
 	call_void_hook(file_free_security, file);
+
+	blob = file->f_security;
+	file->f_security = NULL;
+	kmem_cache_free(lsm_file_cache, blob);
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1085,7 +1133,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
 }
@@ -1106,7 +1154,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 641a8ce726ff..fdda53552224 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -148,7 +148,6 @@ static int __init checkreqprot_setup(char *str)
 __setup("checkreqprot=", checkreqprot_setup);
 
 static struct kmem_cache *sel_inode_cache;
-static struct kmem_cache *file_security_cache;
 
 /**
  * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
@@ -380,27 +379,15 @@ static void inode_free_security(struct inode *inode)
 
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
@@ -3557,11 +3544,6 @@ static int selinux_file_alloc_security(struct file *file)
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
@@ -6855,6 +6837,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 
 struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_file = sizeof(struct file_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6925,7 +6908,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
@@ -7128,9 +7110,6 @@ static __init int selinux_init(void)
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
 					    0, SLAB_PANIC, NULL);
-	file_security_cache = kmem_cache_create("selinux_file_security",
-					    sizeof(struct file_security_struct),
-					    0, SLAB_PANIC, NULL);
 	avc_init();
 
 	avtab_cache_init();
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 22ca30379209..62a22ad8ce92 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -363,7 +363,7 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 
 static inline struct smack_known **smack_file(const struct file *file)
 {
-	return (struct smack_known **)&file->f_security;
+	return file->f_security;
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9ec595f0c3f1..d1430341798f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1577,18 +1577,6 @@ static int smack_file_alloc_security(struct file *file)
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
@@ -4630,6 +4618,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 
 struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_cred = sizeof(struct task_smack),
+	.lbs_file = sizeof(struct smack_known *),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4667,7 +4656,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, smack_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
-- 
2.17.1


