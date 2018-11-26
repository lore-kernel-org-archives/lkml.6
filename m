Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79410C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31590208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hiL8M9pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31590208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeK0Ktu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:49:50 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:40548
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727615AbeK0Ktu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276437; bh=rtgbAY8v8bf2tMWocN4/v1BHGqtzr15pWf8snPHIIn8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=hiL8M9pp7QGkNkzmk1PczUQsGzwTkMSO7mAJE54hVfkbFz8rzg0czoE7nDqV7fhOVxTfqX5MUYkfqtKDctnSMIZsi3PiET0GEROo0AcBS/b1JkhvVUQR2GeHkO4UlEPTegwzWuKZXmJwCcWsUZFfVXkFbPAP5hdy47ZmHzN6J0Q9l3ypuiQEuUqdXY6l2dYK4k/7cjRbqqpeeUM0zll+joOzYQl6X2begBidsI0paI0y1/7X0UmI4fF4h+dlWETOdpwbK1h2NYnSuXT85rAojM1h94ArKUUnrpzrBFUaa9TL/JOZYu9sBiDQ0H7wLclozM4af+ceMMM0kAirBtOamw==
X-YMail-OSG: cpimlAgVM1kM37etYfkTzuwjiLrGfwo1pTY0AeY5tQTZDvTBTDAJFtqXUNQ68W4
 NXjIPq2i_dQ9xPw7kucBInWGOm66bf2V18zUylwQ_Hmkz0PGth7OjuUwU6yasKeJl1v5zr0DW3Qq
 bRuPE6PAdureogjFY5_zSM285ifPv.oHnz.8h5rmL1XVUiwKRT2e9BXQweoDwNUqc0TQ7d9tLbjV
 jPZT5Q2Bsz0R86spJkM9LizQ_irsSqWR0sAJY1IcZBuYIqBycTU8sCp.7Tb4v0PRhKxp1Q_qSjDY
 HqsvDXcLyRYf29Q8qGwQ7zngbcS0NCUhSt5pzc2L6A95XlK6Gsb7xrKeyGepgQzj73Qlgj8Y2Bvh
 agdO_NGnBVuOC_dtNHyGE_DlB08PFfykOGp3Wwc9IZO8.jhQzzmnjTQE3QwFw7LF_emmpkkdtjA8
 AeD5jcxk.10mE2kzwcKlIlmlfBCFNvLUTbx7BhMkgylKnUI4mkvejOfhDEwBQLNOWDr70_8SEs9I
 cgVLmhHuB5JscooTfEXLLfvvOdsKxsAup6B4f9RSVb5WDMBUK8ql7uHzuVyTN92TSMAxZA50yvd1
 40LE5VjtEVP6K0PDukNkZ_FK0qsecuOkjTx50fChfewHRWN6W21lOlP3LBpjiWwjbieUL_wONfdf
 Uuq1muHMVqYdKYhVVydZ4aTdVvAqwAEBha42IJqTn6kPSAHetdJT6u4hR2EonyfaqAMqFiPnoPmL
 t3m5R5FeCa.Jy8EcdO3Mc4AE3UShVoLFcjp2_hZZbdBuxE6UPSflBCs_tGkiyu_UgiL8PiFDJFPe
 PL3BUeDMMy3yzfQ22aW0HuEaZAdxnu0l0AMPR7H310w4Y7dnT3Vsk2wC6CXokHsUstTHgIqVyhnq
 OY.3x_1FjR8lwLPWRSGqf2tA9.5xN.1XtFFG7fPCH6EKCl_2ypIpLMvrxKoRcYD0QcO9BAlR.fcx
 b49NBZm43UXx1whNiM3aH8R5G7LVsyvFqz.eWofGrirSMJ0XofFoJteAXbA5LNJooo9Er9fHrENV
 OQAPPRmQpK1h7_MKRFT03UA8.O1_mf74mS.NwhUJq_BY8oJ_7tMLYVFg0JFIvgwKnJ3WiO6TaC42
 TsiKvKEbpE9pjxgO407eU8mmCZBL5JXc76yMTOrofhKw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:53:57 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ba0d3aeea1fafd7a99a705ec020acc4e;
          Mon, 26 Nov 2018 23:53:53 +0000 (UTC)
Subject: [PATCH v5 34/38] LSM: Infrastructure management of the task security
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
Message-ID: <f9472fed-648a-7817-a0f2-3a54cd91627f@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:53:50 -0800
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

Move management of the task_struct->security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.
The only user of this blob is AppArmor. The AppArmor use
is abstracted to avoid future conflict.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h        |  2 ++
 security/apparmor/include/task.h | 18 +++-----------
 security/apparmor/lsm.c          | 15 +++--------
 security/security.c              | 54 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 65440005ec92..243c7c6e181d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2031,6 +2031,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_task;
 };
 
 /*
@@ -2106,6 +2107,7 @@ extern int lsm_inode_alloc(struct inode *inode);
 
 #ifdef CONFIG_SECURITY
 void __init lsm_early_cred(struct cred *cred);
+void __init lsm_early_task(struct task_struct *task);
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
index 3ae8c902d740..83dc23f33a29 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -93,19 +93,14 @@ static void apparmor_task_free(struct task_struct *task)
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
@@ -1156,6 +1151,7 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
 	.lbs_file = sizeof(struct aa_file_ctx),
+	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1486,15 +1482,10 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
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
index 0cc48072eb3b..d3d3963d7914 100644
--- a/security/security.c
+++ b/security/security.c
@@ -169,6 +169,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /* Prepare LSM for initialization. */
@@ -292,6 +293,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
+	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -515,6 +517,46 @@ int lsm_inode_alloc(struct inode *inode)
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
+void __init lsm_early_task(struct task_struct *task)
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
@@ -1346,12 +1388,22 @@ int security_file_open(struct file *file)
 
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
2.14.5


