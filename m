Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D53C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C4E215E6
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FvOrbNY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C4E215E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbeIVGLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:11:02 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:44478 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392168AbeIVGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575584; bh=OWbjbkt+snNEhCUmrmjIci3hCL14wj7C75UEtPPSZ3U=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=FvOrbNY8/XEbuZcP/Cd5ZS0wZ5JN3NrTngkMftn+oMOJnapMQL6G3nrbzTPVLTYPl3wK12DLkxjviUxzIEHVU/1xY2DvVonSSQ3uVNywoWE2ExOqMOw6XfbaUIa3ushk0GTUTyUbx1lVhvgIePfez/CH50cRj7aC0XozFpuVEYv5IpKBur7anhSXcpA6vDSlJJIM68fD20cdMu00hZPawLvHs4zoX0NF541r33jl8mKj6jFt9hf2SN+hnDpHxUtsZyReL/jSDaMukIIywa/8Mv57BXXLfeBxpG0l+fDNKmCEy2JyyUbfuFBXj+tijPYSOzGFPbMlwNpClWON42mWMw==
X-YMail-OSG: VyCpJWsVM1kP2ObNOWJumZBnBHyTwunzkRhk_v6EtD_xug60lTEHxVCPtSyu0.M
 yA1mmnE2s3laz7vgqpSyeGklHhhhi7yvVVSIji4E0sW70KMjgmCmv1iGV3NiBk9X7HPu8OQigL15
 Z5b9457r_4x9ozusuY48onHn1KRO5dSbps0Jga8TAFTrVd4G5l5Q2huPQiPddrPzqy26mZD2.7Iq
 aMt74HFZrJ0kFXZT7r_TTo0iBdL4_hljVBJrLgY5.S0HPH04sHVhCiyrTXU1gQKGzekxfetUsrpu
 sxbmVS0cwbJSns4147XrBbIVs3WeRMhDg87STL_tJ64pd2LSkhayDSHb.h7PbOJSlfZ1KfYfLyQj
 KvOgPo9do5mbo8uVOZvTKLPfvqPQRaPzECCAaqoxrNaFVmTfNidM374uB0jIXWTiZUCDCW1eA4I.
 toeUUEAvpO8gmkGQhs4DwvoWA8dw_V8p34NBz2PuOR6RFmg_7nW8hcOJSQD2ACHm.kf1G90tKwrY
 h.nVCBRzd.0oTwOeYNmHy3M2GkMtVQhAqUd.PEB.kSJ6uGv5H72OAeNJH06ktW827e7DY2j8s2wp
 JTRgeQkyh7qmh2d833.TKHHMQarLMB9mcB8ietMEtTjBPh3eqb0_ph.v52M4OD7E0VbIhRms07Jr
 X2UYg6HOTiVxdBDch2XIGwdFwOXV2Kr6KPppz49e7jvDXOEmEDsukwBhtRDDsU2CBDXAuhUYBVAj
 Y5gAj2g1a6DxpOBv9a5vcP3qyGWBuaunUoCari7eaVm26aTDB1bcrxen7aToj2estyGzNBMOgXy0
 DYTrkJOL.DZfmzb6kEblCohWscvZqoP9fThOoRwmHznL5P3VGw4vU6egwnsTgmq3zvZz2_HUoH68
 thW3FSeCuBT3g_IG7ohBPYtCAuLypQnC..eyyuydzcgRelFWvZ.9HulOaKYN7avauX2eUVpO7cHp
 nyQcIjIEPkJpo5q52hACsmj2WgKhFIcbJddZT6v57xswm3VZgNfjA20PEAUrYQSioHwOI0Iu._Lr
 dgPeWvlO8mopBjdUn8rDgz6R_k7Vyg4b3oR5hQIB_Aw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:19:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2da6bf2e7da10257b8d53ab831bafb85;
          Sat, 22 Sep 2018 00:19:42 +0000 (UTC)
Subject: [PATCH v4 15/19] LSM: Infrastructure management of the task security
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
Message-ID: <c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:19:37 -0700
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

Move management of the task_struct->security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.
The only user of this blob is AppArmor. The AppArmor use
is abstracted to avoid future conflict.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  2 ++
 security/apparmor/include/task.h | 18 +++--------
 security/apparmor/lsm.c          | 15 ++-------
 security/security.c              | 54 +++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 416b20c3795b..6057c603b979 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2031,6 +2031,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_task;
 };
 
 /*
@@ -2098,6 +2099,7 @@ extern int lsm_inode_alloc(struct inode *inode);
 #ifdef CONFIG_SECURITY
 void lsm_early_cred(struct cred *cred);
 void lsm_early_inode(struct inode *inode);
+void lsm_early_task(struct task_struct *task);
 #endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 55edaa1d83f8..039c1e60887a 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -14,7 +14,10 @@
 #ifndef __AA_TASK_H
 #define __AA_TASK_H
 
-#define task_ctx(X) ((X)->security)
+static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
+{
+	return task->security;
+}
 
 /*
  * struct aa_task_ctx - information for current task label change
@@ -36,17 +39,6 @@ int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
 
-/**
- * aa_alloc_task_ctx - allocate a new task_ctx
- * @flags: gfp flags for allocation
- *
- * Returns: allocated buffer or NULL on failure
- */
-static inline struct aa_task_ctx *aa_alloc_task_ctx(gfp_t flags)
-{
-	return kzalloc(sizeof(struct aa_task_ctx), flags);
-}
-
 /**
  * aa_free_task_ctx - free a task_ctx
  * @ctx: task_ctx to free (MAYBE NULL)
@@ -57,8 +49,6 @@ static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
 		aa_put_label(ctx->nnp);
 		aa_put_label(ctx->previous);
 		aa_put_label(ctx->onexec);
-
-		kzfree(ctx);
 	}
 }
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 15716b6ff860..c97dc3dbb515 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -91,19 +91,14 @@ static void apparmor_task_free(struct task_struct *task)
 {
 
 	aa_free_task_ctx(task_ctx(task));
-	task_ctx(task) = NULL;
 }
 
 static int apparmor_task_alloc(struct task_struct *task,
 			       unsigned long clone_flags)
 {
-	struct aa_task_ctx *new = aa_alloc_task_ctx(GFP_KERNEL);
-
-	if (!new)
-		return -ENOMEM;
+	struct aa_task_ctx *new = task_ctx(task);
 
 	aa_dup_task_ctx(new, task_ctx(current));
-	task_ctx(task) = new;
 
 	return 0;
 }
@@ -1132,6 +1127,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 struct lsm_blob_sizes apparmor_blob_sizes = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
 	.lbs_file = sizeof(struct aa_file_ctx),
+	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1457,15 +1453,10 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 static int __init set_init_ctx(void)
 {
 	struct cred *cred = (struct cred *)current->real_cred;
-	struct aa_task_ctx *ctx;
-
-	ctx = aa_alloc_task_ctx(GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
 
 	lsm_early_cred(cred);
+	lsm_early_task(current);
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
-	task_ctx(current) = ctx;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index a8f00fdff4d8..7e11de7eec21 100644
--- a/security/security.c
+++ b/security/security.c
@@ -117,6 +117,7 @@ int __init security_init(void)
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
 	return 0;
@@ -301,6 +302,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /**
@@ -364,6 +366,46 @@ void lsm_early_inode(struct inode *inode)
 		panic("%s: Early inode alloc failed.\n", __func__);
 }
 
+/**
+ * lsm_task_alloc - allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_task_alloc(struct task_struct *task)
+{
+	if (blob_sizes.lbs_task == 0) {
+		task->security = NULL;
+		return 0;
+	}
+
+	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
+	if (task->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_early_task - during initialization allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules if it's not already there
+ */
+void lsm_early_task(struct task_struct *task)
+{
+	int rc;
+
+	if (task == NULL)
+		panic("%s: task cred.\n", __func__);
+	if (task->security != NULL)
+		return;
+	rc = lsm_task_alloc(task);
+	if (rc)
+		panic("%s: Early task alloc failed.\n", __func__);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1196,12 +1238,22 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
-	return call_int_hook(task_alloc, 0, task, clone_flags);
+	int rc = lsm_task_alloc(task);
+
+	if (rc)
+		return rc;
+	rc = call_int_hook(task_alloc, 0, task, clone_flags);
+	if (unlikely(rc))
+		security_task_free(task);
+	return rc;
 }
 
 void security_task_free(struct task_struct *task)
 {
 	call_void_hook(task_free, task);
+
+	kfree(task->security);
+	task->security = NULL;
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-- 
2.17.1


