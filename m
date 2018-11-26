Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42681C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC662082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qTE8CfJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC662082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeK0Ke5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:34:57 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:37771
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727735AbeK0Ke5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275547; bh=t2Ye1hoXiTqxsi4YrwjYTdnEc0e7oHqLwJe19sMMBHw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=qTE8CfJuH+kP14v8p7Nlj6QrARjJ6w0UwbhzAa7a9FYtw/16XK8yZ3Sc1jeT6TbudFVDDwp5oTGca3FebvqHkdSUSWNAjtFHV0hw1Yn4+nwpSF/MYeHsHN1CXuvk0oOSiAO3bsQBhONSZWuqHH7YHJF4v7it7BNc7OMPyHjSi7dqxdMFvj8AzeZPMSyYGvNP32xjUw01rdR/+xEHe3ElqWOue0klFgbHZfLQ8jtACD+hAvxMNHA7SBugNAStoAfhpiPU5xva1YzF6+Aaq0ool1QIPh+fAuKckAj16XDGb/s8HvqxLQDLDLSP+9fCvMoBq8Hl0F11N6BW1YYufbxTnQ==
X-YMail-OSG: WXzSSrUVM1mx_n3Z8D4O_UgaLH3As1mbgq_hTyb3e.FcSfua2dYCfpTdZZGI69e
 JXGkAZScLRzEbvZSiDlZPII9JlzNrdcgqljjc_VV6raT9PsTvOdooE984RwwFMwpjLVyteOanoEb
 6JxeHBXjq5dQmvL.yiYsOeh5M5__.dVwLadbnXI6YQUziW4cueIoqyZQw_S2htQhoxu3VXzx_ksL
 WT55wGyCAnIydV5l0YsCRUGyXan_.hI2gYzwlKHO2DiWjDzkRRn4pf.mVYURitxdwpouoA7wD9Tp
 MVEFclt5cXVlkAIye2Jtu63hz1IASMub1SH_419I48doq1CRuiHYf6574qt8Mpg2Y.foLH3bimXe
 8qQQcMypTqlghDrztLuOS05Mwkia76dOVohOpo0h.hm0DhRVuVV9UN13tVhDMzvCgmjbZkhwlPyx
 Tpvizz.uKitbXleJnU_HlQR8u6pT4rkSHNI5fOrZSZVfs1DKeh8LAF3N3pSOzIbLKI4h7Srp6I1I
 bsqjWhMv0Q9bv6edzFDZ71fKJiUKqmx0LiqudO5rMUZaScDbCIzOrvTj328TB08diG1UTqZjELei
 P83naEAukBA1x6.Qpg10g.WYCUMlUqw85jxNqTYFLUG52021FTBEcYiAQiKvMkzKo3Gof.HCP0OM
 BjRcXRxjAO5IF.r4Gp6vt3d29ztUsPMBDIr.neXQWIOXelw2nVrIQFBjllveJwUGQF8Rp2IrWSxK
 SQXQHZBOFXQcwlUmCZ.QIFST4vWl2RBKBGYIyq.vsIcgSdTtjL3Ef5OVTLhB.ZO9h8jhC9tFhEcs
 BpU9nIk2ItDfBeiuqUBWeiJYjsCD03CGOlBv67LMIz8Rk40CJNKrNiADcGPsBoN.Qf0YumqS6wXm
 9eW_RSwH_LXBypr02hrsyPHTGrRAOB5yczGSYH_ej3aSSvan5CyL2s_jZPtd.T1sSkGDP2i.jTBG
 s5xLZcK_FsyZD31TXK33jkSnZ89IyViHXvR9T34ioBZNRn6aK_X.fJUb0MsVyA8XEztoln5n7kF7
 gFJE9L7otelgVejqlkTNwE7fReyZta2NQURq0.g.RkfsS_F1GyY.jTWftKqt_AlVjSp6cUwRvKc8
 FaavNAEGqnGJ3gHc8Ggm1M0vIzcdDKB.GNo4zmQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:39:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 263d3cb4d592cdb7baf8d5e402c0ea4b;
          Mon, 26 Nov 2018 23:39:07 +0000 (UTC)
Subject: [PATCH v5 16/38] LoadPin: Initialize as ordered LSM
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
Message-ID: <4145222c-9ae7-4d97-32c3-f0f860a1f401@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:39:04 -0800
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

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  5 -----
 security/Kconfig           | 39 +--------------------------------------
 security/loadpin/loadpin.c |  8 +++++++-
 security/security.c        |  1 -
 4 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7d04a0c32011..b565c0c10269 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,10 +2092,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 41aa0be6142f..566d54215cbe 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,46 +239,9 @@ source security/yama/Kconfig
 
 source security/integrity/Kconfig
 
-choice
-	prompt "Default security module"
-	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
-	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
-	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
-	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
-	default DEFAULT_SECURITY_DAC
-
-	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
-
-	config DEFAULT_SECURITY_SELINUX
-		bool "SELinux" if SECURITY_SELINUX=y
-
-	config DEFAULT_SECURITY_SMACK
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
-
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
-		bool "AppArmor" if SECURITY_APPARMOR=y
-
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
-
-endchoice
-
-config DEFAULT_SECURITY
-	string
-	default "selinux" if DEFAULT_SECURITY_SELINUX
-	default "smack" if DEFAULT_SECURITY_SMACK
-	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "apparmor" if DEFAULT_SECURITY_APPARMOR
-	default "" if DEFAULT_SECURITY_DAC
-
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "integrity"
+	default "loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 48f39631b370..055fb0a64169 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -187,13 +187,19 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin) = {
+	.name = "loadpin",
+	.init = loadpin_init,
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
diff --git a/security/security.c b/security/security.c
index 3fac0ff39944..0c092d62cc47 100644
--- a/security/security.c
+++ b/security/security.c
@@ -275,7 +275,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
-- 
2.14.5


