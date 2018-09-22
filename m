Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D4121569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ab6hHfVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D4121569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbeIVGJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:09:31 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:37382 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391783AbeIVGJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575493; bh=6JJNFyJJ4Jpz53edXUHhY0H9rbQ4SAcIBu2Nx3cW1Js=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Ab6hHfVAA5LqUBgumrqtE0ldbQb4aiDltAs3jjaSI10c8cy6suZEv9+oO4uCBrRMZaCKvno1/D3Q6/D5QqJlCUfZKlPyNgyLeROQYnqApUvY6Ho391BZBhZ/cAuFH4Btio8bZqsunW9ozz/+KgV6mSXX27yMumBM/6G+40qvBzZy0AN5zRv94XhDw3e9m6NdzEvHaVdcztrITeYoqlLofb/eO60nirF2B+aVIk+q+ScSQ+Jrf5TF4zS5oMDi/5s9kUIWqStjTzDb02QE4ZBJzV/3iI4rAzGVrgVj5d28pXvcqyhJyYRETmNVkrzbkIxjx0t8nFlCzYMisdFvCdJuow==
X-YMail-OSG: 2VpBGYsVM1laD_3_kM_3MMYuG2nCmFymCUJ8EZFeHNJu5c5MI3Jd6Uc.iL.lOFr
 69ZFCUOzO7zI_MY3k.RLMpatzjm70wiJm6qK_Ol3ZzY.mXJCpQOSpp4I55erGKmi78HIGP93Fl5X
 T_rI23UvHNovwbp86p0vldbGYvSScJ54vr54dwk88frf_K3zrSPD6lfU_Tex.lIL0Me0hj1XPaO6
 qBpB8CGwSf5LTZjtIgYY94jD9NytNuUEpVwWr.1jaRejthpF.p5rDTibf8_je0OxGvE1Jql1pDZY
 crXM_fW_qTnVCLFpRqQ8uzEbOwjxliGZxFbD28Dl8Z6ztdDBIklWdHjA0mkRGNeFRRtB4_aSgr4J
 XEj7gVpvpT4bOLKqNTOgFCUDQL0q1mEtHHG27cFSif9xkt6Z_tmzVBkNkK4rHfeOtaw6FQdSF.1p
 QNUk9LColQiDICCRZSEtuKUaRoACHy0WVNnavbyNIauxDdF3f66o8XkDvr6rfdivX.xP4nG4ND_I
 1BKlSpcT9Gc377mK8q5IMZFb1SM0Ds3ofu2rncxQhnHh08CoI00N1c5phdvPFmOeyXyqU_5TrZ9E
 IqCZ0M4HpysAZ.wdoCqXUSO_MypBIbWibxXqJYOUcGOeamoKHyUdfy8u_Q0kU_ktln.EbKTRdTKg
 7x39apv5x_KJ5SEXS1W5xvsDjnY0hjkLla7SKRjLNvAIQqk30RNwurihfRqQaGpWaw1Q63lLGRsm
 L3SidwvqYxK9ApNfW3XdjfzYGnzDfp1S6a3LxQr2vVJdW67F79v7qMcq..ppsBByl_X2BCzgoXh9
 ZqLB5rmRTnNgcpBtdVAY5orKpSkIgphNMO_dQNt2cHBrgBvqE9a75byEMs1voOc5vNYzm8XZDs0f
 xELUZHrcHmgMTcYZHM2ftiuIIRYjMY3Z71WC0kjp6wag4lFe.aLx9kCRu_aEEjDNoRH6iPYX5_D3
 B88jG1_NyjeGr_HfRz32lX9hi3qLEmalLAQegiMDE08HpaoxY6x9BR4D4CGYlwjgsaIpsSZn5osA
 Fok2Jaq9wMbwHzR_CpbnlKg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:18:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 220edde72bbc0d15c564ef59d15296bc;
          Sat, 22 Sep 2018 00:18:12 +0000 (UTC)
Subject: [PATCH v4 07/19] TOMOYO: Abstract use of cred security blob
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
Message-ID: <8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:18:07 -0700
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

Don't use the cred->security pointer directly.
Provide helper functions that provide the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/tomoyo/common.h        | 21 +++++++++++++++--
 security/tomoyo/domain.c        |  4 +++-
 security/tomoyo/securityfs_if.c | 15 +++++++++----
 security/tomoyo/tomoyo.c        | 40 +++++++++++++++++++++++++--------
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 539bcdd30bb8..c9d8c49e3210 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -29,6 +29,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/un.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
 #include <net/ip.h>
@@ -1062,6 +1063,7 @@ void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
 /********** External variable definitions. **********/
 
 extern bool tomoyo_policy_loaded;
+extern bool tomoyo_enabled;
 extern const char * const tomoyo_condition_keyword
 [TOMOYO_MAX_CONDITION_KEYWORD];
 extern const char * const tomoyo_dif[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
@@ -1196,6 +1198,17 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
 		atomic_dec(&group->head.users);
 }
 
+/**
+ * tomoyo_cred - Get a pointer to the tomoyo cred security blob
+ * @cred - the relevant cred
+ *
+ * Returns pointer to the tomoyo cred blob.
+ */
+static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
+{
+	return (struct tomoyo_domain_info **)&cred->security;
+}
+
 /**
  * tomoyo_domain - Get "struct tomoyo_domain_info" for current thread.
  *
@@ -1203,7 +1216,9 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info *tomoyo_domain(void)
 {
-	return current_cred()->security;
+	struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
+
+	return *blob;
 }
 
 /**
@@ -1216,7 +1231,9 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
 static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
 							    *task)
 {
-	return task_cred_xxx(task, security);
+	struct tomoyo_domain_info **blob = tomoyo_cred(get_task_cred(task));
+
+	return *blob;
 }
 
 /**
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index f6758dad981f..b7469fdbff01 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -678,6 +678,7 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
  */
 int tomoyo_find_next_domain(struct linux_binprm *bprm)
 {
+	struct tomoyo_domain_info **blob;
 	struct tomoyo_domain_info *old_domain = tomoyo_domain();
 	struct tomoyo_domain_info *domain = NULL;
 	const char *original_name = bprm->filename;
@@ -843,7 +844,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		domain = old_domain;
 	/* Update reference count on "struct tomoyo_domain_info". */
 	atomic_inc(&domain->users);
-	bprm->cred->security = domain;
+	blob = tomoyo_cred(bprm->cred);
+	*blob = domain;
 	kfree(exename.name);
 	if (!retval) {
 		ee->r.domain = domain;
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 1d3d7e7a1f05..768dff9608b1 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -71,9 +71,12 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 				if (!cred) {
 					error = -ENOMEM;
 				} else {
-					struct tomoyo_domain_info *old_domain =
-						cred->security;
-					cred->security = new_domain;
+					struct tomoyo_domain_info **blob;
+					struct tomoyo_domain_info *old_domain;
+
+					blob = tomoyo_cred(cred);
+					old_domain = *blob;
+					*blob = new_domain;
 					atomic_inc(&new_domain->users);
 					atomic_dec(&old_domain->users);
 					commit_creds(cred);
@@ -234,10 +237,14 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  */
 static int __init tomoyo_initerface_init(void)
 {
+	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
 
+	if (!tomoyo_enabled)
+		return 0;
+	domain = tomoyo_domain();
 	/* Don't create securityfs entries unless registered. */
-	if (current_cred()->security != &tomoyo_kernel_domain)
+	if (domain != &tomoyo_kernel_domain)
 		return 0;
 
 	tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9f932e2d6852..25739888921f 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -18,7 +18,9 @@
  */
 static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 {
-	new->security = NULL;
+	struct tomoyo_domain_info **blob = tomoyo_cred(new);
+
+	*blob = NULL;
 	return 0;
 }
 
@@ -34,8 +36,13 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
 			       gfp_t gfp)
 {
-	struct tomoyo_domain_info *domain = old->security;
-	new->security = domain;
+	struct tomoyo_domain_info **old_blob = tomoyo_cred(old);
+	struct tomoyo_domain_info **new_blob = tomoyo_cred(new);
+	struct tomoyo_domain_info *domain;
+
+	domain = *old_blob;
+	*new_blob = domain;
+
 	if (domain)
 		atomic_inc(&domain->users);
 	return 0;
@@ -59,7 +66,9 @@ static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
  */
 static void tomoyo_cred_free(struct cred *cred)
 {
-	struct tomoyo_domain_info *domain = cred->security;
+	struct tomoyo_domain_info **blob = tomoyo_cred(cred);
+	struct tomoyo_domain_info *domain = *blob;
+
 	if (domain)
 		atomic_dec(&domain->users);
 }
@@ -73,6 +82,9 @@ static void tomoyo_cred_free(struct cred *cred)
  */
 static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 {
+	struct tomoyo_domain_info **blob;
+	struct tomoyo_domain_info *domain;
+
 	/*
 	 * Do only if this function is called for the first time of an execve
 	 * operation.
@@ -93,13 +105,14 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	 * stored inside "bprm->cred->security" will be acquired later inside
 	 * tomoyo_find_next_domain().
 	 */
-	atomic_dec(&((struct tomoyo_domain_info *)
-		     bprm->cred->security)->users);
+	blob = tomoyo_cred(bprm->cred);
+	domain = *blob;
+	atomic_dec(&domain->users);
 	/*
 	 * Tell tomoyo_bprm_check_security() is called for the first time of an
 	 * execve operation.
 	 */
-	bprm->cred->security = NULL;
+	*blob = NULL;
 	return 0;
 }
 
@@ -112,8 +125,11 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
  */
 static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 {
-	struct tomoyo_domain_info *domain = bprm->cred->security;
+	struct tomoyo_domain_info **blob;
+	struct tomoyo_domain_info *domain;
 
+	blob = tomoyo_cred(bprm->cred);
+	domain = *blob;
 	/*
 	 * Execute permission is checked against pathname passed to do_execve()
 	 * using current domain.
@@ -531,6 +547,8 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);
 
+bool tomoyo_enabled;
+
 /**
  * tomoyo_init - Register TOMOYO Linux as a LSM module.
  *
@@ -539,13 +557,17 @@ DEFINE_SRCU(tomoyo_ss);
 static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
+	struct tomoyo_domain_info **blob;
 
 	if (!security_module_enable("tomoyo"))
 		return 0;
+	tomoyo_enabled = true;
+
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	cred->security = &tomoyo_kernel_domain;
+	blob = tomoyo_cred(cred);
+	*blob = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
 	return 0;
 }
-- 
2.17.1


