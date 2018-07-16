Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F713208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HDeTMCT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F713208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeGPSvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:51:45 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:44617
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729969AbeGPSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765387; bh=08wxO24PBI3e5/IMCEbsiJkDjkanUZHhLpI9ME/PyDg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HDeTMCT7rthj1pY5Aezius3Vy4qykZ8ktqmz+trjauk8RQriGl//ueR6+94UheRWxWlZqvW7sDWjEL51hslzt3zBSjq4Ks04nLPHVV7frQ45v3DTn+BXH50E+tvAtZ6VGCAYTSrJQqiR9QwdmT0gOd8aryqgAG9WnspSbFXEA89xoXE8NA21SktLstMb9spkoT0V6bzFxtFrvJdVDiUqDNbfPL3TIQUmLRtndxxnTVuQ0W7OrQrn2jQW6phaNs6FKlTZAP78EILNuY8vB1R5A4rdGHoxsQM9HXSZXlRmrGZKuK5OqIKNBwt6Pitv97/JwaBVsOkvV7I8hN3r6GM8Eg==
X-YMail-OSG: EzWLI6gVM1m0Fr7gAdelaj1we4eIeQIPkNa.P9JKXMJL80vHmQyz4fN1S14l7XZ
 7ZYlA5vC3BcjQcHI0v4Zn3vLm8DbBaSa2j1JBvrLBK9IQ3FRUpazEfyAMH_Ukkw8G164jzLBPIxE
 1zMMtTLvkm7Q5t3dT4gPCeqA3KAM3Algea5TIh.ZNmC0TxaG45YTmWkKE9CEdeKkCtXxP93Exnkh
 z8tmbBwpmcXIApc0pHyY1aA9bsaEnOM4XVwqeptrR9H.9g0Ly2wuILtdosG9vu5adsJgKZO1nPw_
 p4SoVCxTHwOEn18OpN.hipIXUoDc7bw7EoZl7O1uDAY.p18tFoqLkgsk2EmusYpeT.GBkG9g_FiQ
 Xm9bn3EdMF2PPe1Ivjdr_aaT58RLbXOPSXreYZUzReMS0f0M_mqhhBZKbSWN8wUBn3lJtp_oGbPK
 XN1zbok8Tf2La8PwQ2HE483FUIkqWirHjDcGE_b_TXvtKH_HjZcEqfklCm5EGoGn6836xYPuZ4yR
 ZPKt5GO7IlrynI7kXLEeHuicmIn8aN1rFqGyiDUnykymAAAK.RIwWuH0rf9AiE59RBPNxbw4HbBs
 R7fYoiGL6Zllfn1C10x1C8JWMWi5bqj5aCiortgkOMAmto804UyVpR9q2JdGqbxEypOsA._yXor3
 c5bKAoYATN_fzUlDGo41n6PxRwq.aipkgzMOdXQRx01Iix8HT9zTLgiSCEzoiCCRgaS6YG8nvelk
 q5VFn9HHGcUY3utlB79dNEwFV8oprokhWzYExQUhfLz1NUS.xgAmI8hNAPkWE3mNNiS_mRaqK64J
 InB6stanaQl5RjLtaWB2c5YF46L5ebnJWKIyXecKqYgnrZNMHx1l.3kvxEpPDSEepZCo6DeHeUjt
 qlkW9VJyhxv4f_EUrPPfkZYCwFmpGJrIMGR9PErH6oMkziEwYeAnmVI.gyqcoi3PB76ipbtjhiWG
 xsrBN.Kv7vJy5C6MLuRFwiGdlLIUCSs54A3pbV91tn3e2WxiHkEwXKSalWX6X3yfnhYHau7_t5Jf
 3w4J4kzs.QItUXljISmBp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:23:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5b9c95488b3f250528426e48e5db8f36;
          Mon, 16 Jul 2018 18:23:03 +0000 (UTC)
Subject: [PATCH v1 07/22] LSM: Infrastructure management of the task security
 blob
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
Message-ID: <6bc34d62-508c-eab7-4c67-cbeb240c794c@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:23:00 -0700
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

LSM: Infrastructure management of the task security blob

Move management of the task_struct->security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  2 ++
 security/apparmor/include/task.h | 18 +++--------
 security/apparmor/lsm.c          | 15 ++-------
 security/security.c              | 54 +++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ff8928dac619..00c6bdaf5cc1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2024,6 +2024,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int	lbs_task;
 };
 
 /*
@@ -2089,6 +2090,7 @@ extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 
 #ifdef CONFIG_SECURITY
 void lsm_early_cred(struct cred *cred);
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
index 271d96c39129..665dd723100f 100644
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
index cec46acb4061..40624fb81031 100644
--- a/security/security.c
+++ b/security/security.c
@@ -108,6 +108,7 @@ int __init security_init(void)
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
 	return 0;
@@ -283,6 +284,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /**
@@ -306,6 +308,46 @@ int lsm_file_alloc(struct file *file)
 	return 0;
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
@@ -1112,12 +1154,22 @@ int security_file_open(struct file *file, const struct cred *cred)
 
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


