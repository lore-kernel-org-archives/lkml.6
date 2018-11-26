Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D61C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55417208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g8Z+N/JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55417208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeK0KZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:25:31 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:44432
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbeK0KZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543274982; bh=Ya7Phvm+WiI8d4/gPHrsBV24paT3pkpeWbno0iaac1A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=g8Z+N/JB5ib9tb4u6lqmZO/0N7MfwJV6YUe927WMsZ69rE7z1V+2scF1GbTNxpN1xZtv/t26XAHTJ6VP+gWk+vSzWg/sR1JHxAYIVQky0FO7i+kxox3B7UO4JFheNc4Sbs+9sryfOxmLXIOVCP8uWOz909A9Wf4hdhN/3ukIhb/c815mtIr4r62Ju+5yrlfq1iMjhimVQCQ+3hbXSH6IQ0f8cWGrImHsrXAu7gMtCcgbkzZcePpvr9Zo5eGco1Qr8cs+Ft+noIaqcbvICZHvDhsiudi4PulXlYQRiNj/6NgeI7+NvOxCHFeXxz36rDOLwUxWofPXa/aaCH6zN1SeUA==
X-YMail-OSG: GNYzrEUVM1kuC7ec_zv5qAali_PwYKhswLLGVujRMA1PeO0xm2nPQCMQ4sxkGf4
 IcWejIK4OBf2ASPWehr674MwOxZQCjHJi_EkVKzmcGj4JMdZaJsB3yg8eATxtCzEThuwZSYb0wN.
 PyZbjoHFsrZyTEfsAVBxJ3DWkZiyGbQ0c5XLs1zG_UymryRD.jo1Yldlx1rFwxL0zxYC89Uim11W
 0zyE4jLOVEa_yztXA28YsgOM8ek54_a.sbZ0CCW.mlXvXBekTRhzkGV1tAu3wZ0jmFiQYpC2e6Qc
 AeXINxcQ_fZ0cx_21Xz4q0G9QgEjLMHuS1Tv3tuYP7BjNijpB2Nd8zd0JgmlIxM.ElkxgJ3WvBT4
 bECkPlY0nzRHvfvQxjzw6rNIoO4X64Gs8PYG7zrMbRCdvT7Z5FPfme_Vo7ZFt3iMbadNStIsiJq8
 40obd9R30_hgiDeK_ENoJe7TysYjmv037iCCkWq8mXGKB3lvWv5WCsk9KJ3VzReVrMuDGEQN1OqG
 A2HewvajEMYdlHRrFrcll_HTcV0G9aeEumkSQQ9H7T2NPq9FzE2oEPFFPuMHdvrbV2C0P00MdF9m
 atsvzbHGtNR1TTkcT9ryXZups1nRNwuiUqjsDcHtuPbGy1AOBSdjaRm.3PszKZTaj6Y2PhqROZkm
 HQngC7NFWeQdicUJIj88BnHVhO_WCLTzpL3DK1emZfB4sPh.joSZrN.nNIBU00BWIKGYErjI5qba
 cFeNaHWhmOzDXrhHNjaYLS6JJyjm8kLnDXpiIqx8NxgZHHUTFK9QZBPxoUp6k9rDKffGE7BgpNew
 xG.uCUG6pPPYDpmYPCOtemmun9V0pvjiJnEfeCkwqRgMm4nUc48PEeN5f4bur7AnSeAnZ6TZKmfW
 R2iynRhGs6kM1IKjqwUQsX5Pw9qqC_Bgs188Z0G.iZazTnWPJCPLt95N0mVwaMZx35coKyGEn3Wz
 0YjR_oiAurixZZXN1LOW_uJbqg072Vt9v3uC05uWFHY0XaYCWPTNuzLlYm3PYG50QlG7bdRCKEJB
 4xwWA3NnfqHe1lI.DL4hxrhDhIQK27..Mfz7HDJGvHcEnz.9HsuP7MbuPNpoSRSuv5JU9nZoFemC
 pSFpDaio0vd8MM1DwmnTVdzeyt7jOrndCmly2AWMn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:29:42 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 37e4085ac49bce8b94538b8e3540aa56;
          Mon, 26 Nov 2018 23:29:41 +0000 (UTC)
Subject: [PATCH v5 04/38] LSM: Lift LSM selection out of individual LSMs
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
Message-ID: <60a53863-a05e-cbbd-d73e-5a0d2fc6567c@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:29:39 -0800
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

As a prerequisite to adjusting LSM selection logic in the future, this
moves the selection logic up out of the individual major LSMs, making
their init functions only run when actually enabled. This considers all
LSMs enabled by default unless they specified an external "enable"
variable.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  |   1 -
 security/apparmor/lsm.c    |   6 ---
 security/security.c        | 102 +++++++++++++++++++++++++++++++--------------
 security/selinux/hooks.c   |  10 -----
 security/smack/smack_lsm.c |   3 --
 security/tomoyo/tomoyo.c   |   2 -
 6 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4e2e9cdf78c6..dabd2761acfc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2085,7 +2085,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 127a540ef63a..d840c1ef3e4d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1662,12 +1662,6 @@ static int __init apparmor_init(void)
 {
 	int error;
 
-	if (!apparmor_enabled || !security_module_enable("apparmor")) {
-		aa_info_message("AppArmor disabled by boot time parameter");
-		apparmor_enabled = false;
-		return 0;
-	}
-
 	aa_secids_init();
 
 	error = aa_setup_dfa_engine();
diff --git a/security/security.c b/security/security.c
index 0688dfd57e95..7562da854b62 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,33 +52,96 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static bool __init is_enabled(struct lsm_info *lsm)
+{
+	if (!lsm->enabled || *lsm->enabled)
+		return true;
+
+	return false;
+}
+
+/* Mark an LSM's enabled flag. */
+static int lsm_enabled_true __initdata = 1;
+static int lsm_enabled_false __initdata = 0;
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	/*
+	 * When an LSM hasn't configured an enable variable, we can use
+	 * a hard-coded location for storing the default enabled state.
+	 */
+	if (!lsm->enabled) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_true) {
+		if (!enabled)
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_false) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+	} else {
+		*lsm->enabled = enabled;
+	}
+}
+
+/* Is an LSM allowed to be initialized? */
+static bool __init lsm_allowed(struct lsm_info *lsm)
+{
+	/* Skip if the LSM is disabled. */
+	if (!is_enabled(lsm))
+		return false;
+
+	/* Skip major-specific checks if not a major LSM. */
+	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+		return true;
+
+	/* Disabled if this LSM isn't the chosen one. */
+	if (strcmp(lsm->name, chosen_lsm) != 0)
+		return false;
+
+	return true;
+}
+
+/* Check if LSM should be initialized. */
+static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_allowed(lsm);
+
+	/* Record enablement (to handle any following exclusive LSMs). */
+	set_enabled(lsm, enabled);
+
+	/* If selected, initialize the LSM. */
+	if (enabled) {
+		int ret;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info *lsm;
-	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
 			continue;
 
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		maybe_initialize_lsm(lsm);
 	}
 }
 
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
-	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		maybe_initialize_lsm(lsm);
 	}
 }
 
@@ -168,29 +231,6 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
-/**
- * security_module_enable - Load given security module on boot ?
- * @module: the name of the module
- *
- * Each LSM must pass this method before registering its own operations
- * to avoid security registration races. This method may also be used
- * to check if your LSM is currently loaded during kernel initialization.
- *
- * Returns:
- *
- * true if:
- *
- * - The passed LSM is the one chosen by user at boot time,
- * - or the passed LSM is configured as the default and the user did not
- *   choose an alternate LSM at boot time.
- *
- * Otherwise, return false.
- */
-int __init security_module_enable(const char *module)
-{
-	return !strcmp(module, chosen_lsm);
-}
-
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index efc0ac1b5019..b81239a09dbb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7138,16 +7138,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static __init int selinux_init(void)
 {
-	if (!security_module_enable("selinux")) {
-		selinux_enabled = 0;
-		return 0;
-	}
-
-	if (!selinux_enabled) {
-		pr_info("SELinux:  Disabled at boot.\n");
-		return 0;
-	}
-
 	pr_info("SELinux:  Initializing.\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3639e55b1f4b..56a114c1d750 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4841,9 +4841,6 @@ static __init int smack_init(void)
 	struct cred *cred;
 	struct task_smack *tsp;
 
-	if (!security_module_enable("smack"))
-		return 0;
-
 	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
 	if (!smack_inode_cache)
 		return -ENOMEM;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 09f7af130d3a..a46f6bc1e97c 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -540,8 +540,6 @@ static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
 
-	if (!security_module_enable("tomoyo"))
-		return 0;
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-- 
2.14.5


