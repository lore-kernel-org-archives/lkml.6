Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC93FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5491621522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kftmXddT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5491621522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbeITGBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:01:14 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:40235 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732713AbeITGBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402846; bh=FJJkoSJ8Xo+ddLuyjQ53dOgH+/r7caIk8iD36W+r2k8=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=kftmXddTYGvZvIog7yOL1ttlyMsYBPx8214z88CSCQkUcQjFwbmuxYMmGt2v/SBKG/vdYJ1GulgWXx3ujVd6AGcr6319ADSh3Ox1a7RAu/slhv0JsyGHReNKEhGLZ/S5BnlNcLSIBjyMf/xB56JYMO2P+/JflFcfSvXoNTkAuB7CT9qs+jX+cTFe1+Y7cLk2omMZAPk5PC3Co/YxGbynb4+7wJBdm3PxbKO2J0WODRtjZDWU/Hx4OnhPEIfeXsp8w+9LAlfTgdRuQqKVjKDuj4TpmAb/4SWxcFefaQR8YJCbTPXOhl+GzaQ4hz1ebpkE+z6hf+tyaB6eueNQ9RREww==
X-YMail-OSG: OwZ4NKMVM1ndti97IoBSrVRCqcRVDnyy0nLs7hyffl_hefRZPhoPRcuqI1qVfIK
 Ea38tHVt4Fpz8O3RysIfnJFsxrBMFcXVTtpfKLJGWb3ryTswmu6ZD5zWzbxyD9bgd1fVI7HP0LWs
 5U3UCMgA7QDymTRvtZ1NxSBI5q4rJ_HkrEvRkGUeAwZbsuQWgrwl8TTqhj0FSB2x41dwX5QpGwyt
 Axj0S_8l11v_7ljtl7G7Lglogc6Nrpz870w0lXQWH5Nqz3iHhI8zDJXLdtiIotvwPZxKnRa3cxxI
 jRnj_N3Emcj6Nv8l.OdHwzai2e7xscroN4LPiNGOTsANItOpOqgaz1UPP4Athts2qRRTaTFTriFv
 wci5lp8mb25i4KWThwnwY4TbjIthXiWMTONCw8yuRRT1aB0RxPfXoed0cyivGZSbhI1CJpHGoOWd
 5_9jW2S89mN0zdF1vBjDgGesoH6ZGcgOKawSHCJkxLiMjeHbON4cCb6NKfAdfyl5Hwog0BLoC7bE
 qv4GE29LrylLDP7k4MrNUqX129S9VIIabYSqEnuMKwO1iqA7vFOZGsB15_0Au9yVdMayCemf2S0.
 V5SqPtEf5nQIq_hdFdPYmih6qje1e3VBvGLYMZG8lJxd5ZtlERVdh8ekJIX6NVZEWlZ8itPEVITn
 BU62rluBLBfAnD41nUrJfsUorVav35eQiLA8qfsTW.4i6YhsmhdERbzouQepeFFOKCJz2rkLvZA9
 HzjgvUj1uESvFztqZO2BrRMemFUm.LMqopaKalX532Au.p_S_723UE6v.HB8_IwM_J0qQjI2LCCJ
 O6Q2pwXzVRn7ja2TdvOHPCUn1tdDK6FHmt.Z1B.k.zmghIcAGtul_q_8qAHLlURJE1_VeWtH8JoQ
 RDiU7Sv1C5Sbw3OiHCh6oB_FZQy6cuRm38O0w56tJabdvxa8Yj7kc3g0GGwJHDhsuLFEini7gZq5
 d1AC1RsdTYy1CFmhk_yhAGGJjLAJzzTfesn3rqjYGPvU0TEkkFc1VI_803fPwL.Qcsy0ewFeuTX_
 OqKOQvdX8R_S94EHlnEmhVuZD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:20:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d7b940e3a0aa168118a93b792a05ab1f;
          Thu, 20 Sep 2018 00:20:41 +0000 (UTC)
Subject: [PATCH v3 07/16] TOMOYO: Abstract use of cred security blob
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
Message-ID: <ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:20:38 -0700
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

TOMOYO: Abstract use of cred security blob

Don't use the cred->security pointer directly.
Provide helper functions that provide the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/tomoyo/common.h        | 21 ++++++++++++++++--
 security/tomoyo/domain.c        |  4 +++-
 security/tomoyo/securityfs_if.c | 15 +++++++++----
 security/tomoyo/tomoyo.c        | 39 +++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 16 deletions(-)

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
index 9f932e2d6852..622ffa74a124 100644
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
@@ -539,13 +557,16 @@ DEFINE_SRCU(tomoyo_ss);
 static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
+	struct tomoyo_domain_info **blob;
 
 	if (!security_module_enable("tomoyo"))
 		return 0;
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


