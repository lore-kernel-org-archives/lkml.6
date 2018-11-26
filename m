Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66897C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155752082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o5vbZEQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155752082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeK0Kmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:42:37 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:39748
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbeK0Kmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543276005; bh=qNf9MfBwO3Sxe+oX3dUWwfB5aAArEZsPKtpkBR2iPAk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=o5vbZEQ3ZJzMjEooNHrp5yDU1fRpjk1MqXOq70td8Ekka84lmtsV6yUqePZGRu5R8lj7FfHYEhb1BXvhzQbep+BVDYqq1akol2pBFRd+kiW1WyZ7ZKdfX4/etOHhFFp4uerp8vxrHAx1iGm8qmdxLkNOOJGozcakAOp7VB4WNR4MvJajGUsqzFGCC7AVm+RjIX+CnsijUc06z3GkPoPVsdNdi0R4495D1QlDLDcXY738hXoF/k93rpFzkSBQnTV8zC+Hz4JRSTQ7PXO+m1pHy5aro0b4j8B12Car4z5ajMzfr3jroOGcK2cStS2T70TXBlqqGsSNj14eepIDiIIIzQ==
X-YMail-OSG: KTgZLS4VM1nq_q_htNx7gmAs6LcpwaDuGIXWpTJqOPK0T5LVJPK_LHAyTk6qhUB
 kaUTdie07LylTmnBtHmxsLkEnxATJnbQQjHAInx0cV9J5KwWNh4R8F9scQqsuGqGFGvcpaq0J3BZ
 sf5Y07.uzZumShf2QaanVaqKb_fCC.diRdpdfE52KWsYOlpaRTzybQqfrN1rirKBLcvABClrNpkc
 Ux08xVJnOiaaFJn9GOlzXOBCwKIULFWslzOHE3T5KirCdBwuF8tlS6cEKi49T2_AaA9qJjogDp3K
 GNIROrmGGDTjCwcmK9BbySX8ANZylSEJIsgJSnl2wUKkSjpED2eAPURzBtelnRy_V9zuWnaEyIDS
 E6IrFiTDGJGf2f5MIgdVJXM_2VebkwSxn8JMz.KBBLrnEbzWfIlLYHD35vv7HnRDR8cWRZmX57uk
 1tRfdu5nfabkU7fYDsfmGRSkgwEPPwYvCImf8KlOMpwKB6TTc1BiV6ku2unBW2rOw.Qvmk9K5jUq
 kzTr7IQ6t8HsPwl0UaamBXzkLUBy5.rq9OlZkkKXlXiGz6dHHm9cqkG0nKgvOmn.w_88UhQdr_gy
 7UMrXJ2QXIV.FKs_jVn8AJY9c0e15E1tKCwg51PLHKUKwkrpsoxPRoCIe8hEkftwiXjgRpaEcn6h
 4jEkqzkbs3G9CK7ceiPrd3D4h9WByeDbdrkUCOB78KmHerqGjqeOQfkRlC0JHtL504tdRbRuKcT1
 IWGTWLos0XLg1qD6nzoM_twkseJZ_eeUxSlZ.WNj9oSnOzlUuVztX9b0M0e_8opHD4UbQinmkhY2
 EiS3V4L2VKMbpJS8kyCip_k47oxIOVKp2XjY88309q1Ok2ODfo8wjEGCnuLSPM02v_cV1icWOAy1
 _sPD9TyIrTNcEA_20UEDrnqv_MEX9X6kdfDWkKsHBZBR3ak6g4a_8ULtOzio22bsgWAwAmczWLHH
 foZYRsNHKtG.bhmvt3DoCZysCoteVEKi4nNTrSq2LQ2Ci4olLGZHlkvOltsMZFKzbMM8EEnyrNHs
 0l_YfnE.nbUgYPx6QWV.EmAkbks7PMqtIq2LeHHCpmoO2tlSoPpgCMMWA1wtj3hr_M0OQjjQW6YH
 E2JFXjv8CW54_ULV.Mq9P2QazmCjU9S3JV2TxCg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:46:45 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp404.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5bad0e564cced4e88587d425b3fcea34;
          Mon, 26 Nov 2018 23:46:43 +0000 (UTC)
Subject: [PATCH v5 26/38] TOMOYO: Abstract use of cred security blob
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
Message-ID: <2ba69559-bb0a-a87a-d829-1e43012074b6@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:46:41 -0800
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

Don't use the cred->security pointer directly.
Provide helper functions that provide the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/tomoyo/common.h        | 21 +++++++++++++++++++--
 security/tomoyo/domain.c        |  4 +++-
 security/tomoyo/securityfs_if.c | 15 +++++++++++----
 security/tomoyo/tomoyo.c        | 40 +++++++++++++++++++++++++++++++---------
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 539bcdd30bb8..41898613d93b 100644
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
+extern int tomoyo_enabled;
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
index daff7d7897ad..15864307925d 100644
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
 
+int tomoyo_enabled __lsm_ro_after_init = 1;
+
 /**
  * tomoyo_init - Register TOMOYO Linux as a LSM module.
  *
@@ -539,17 +557,21 @@ DEFINE_SRCU(tomoyo_ss);
 static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
+	struct tomoyo_domain_info **blob;
 
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	cred->security = &tomoyo_kernel_domain;
+	blob = tomoyo_cred(cred);
+	*blob = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
+
 	return 0;
 }
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
+	.enabled = &tomoyo_enabled,
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = tomoyo_init,
 };
-- 
2.14.5


