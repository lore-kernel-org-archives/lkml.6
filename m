Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1F32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a165ELMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1F32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeK0Kfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:35:43 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:45664
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbeK0Kfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275593; bh=9sjMSXF/Q8aciNYYUwWXS/TtIz39HJVSzkpXcl3Y2K4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=a165ELMkQDT6aRadPiTh839vqQ3XE0l4syX8GsHaF0Ayzl73mUoJYlc6ZUCt9LNS3gF5ACavPbiCH2JgnHWBg/ysenm1eqQFfn8b/ZJ7RFBhpMs6cJQsrTO6/BVyQMPwlsWng/5daWbunVhy6uZCDAIKWaXiG+HZC3O0kOf+Ib3MNjcd9HqhKMiibtkxKjULO0R4B5sHZd4oIsOsI8fhZ6GMEeG1GK6vhfZKm8d5LVK8nYWuI4obbmr3jsX5rtc7OQdWXkcSpi8R5GRQ1ds/buBgn7JXcmF2ZT2Nx6IBP3lEc4Rax+TAc9EHJQUznPXqr7uPL4BOJR/oQGeHCYYYVA==
X-YMail-OSG: inKkXdQVM1mA9w5UvB1feFSFI19Te9Jhbt1JWAbwlWLWrSUt3q36IP84CJ2Zh6s
 xU8wEHCg3Z_OG3guoW8d9it2r9Ydu54ROtYNMzW9GEVv5JfAT9GkFqxiM2cP6uw_Tmal.jzh_clW
 YqczbyKAlkf94PYxF9TbhpbXzbafD1TMMUspqZ7_PwY..EGwPXFPh_MuNheYGwiv_GREwZaVPH_Y
 YJLljgxHaXSQHvi0pyS3y5fQlZHLXsB7o.Dmx0BcDN0TN2VHIi0Q7rRQBlPLZV390533Ho4Axs_x
 VCdMyy5VRlgCJ6AcoZy8ZoFzRvEAsnlL6Mx.mqEfdTxbNG3uMWzNjEhPQsajRmxuaoMijYQ78Qiz
 b_mtHcivFNY4v91Qh6kdBKbwI290SPjWalPNhiJoDF6vPCc5KdwRbrov9LAg59yZvtrUz0KAu3bT
 Yn4YnQXy6f59HDQCqobycOwPQf0UFQHvyyKRulVgfQmns9b0SYoX1gs8fW38KvaVBo7QGNO093YL
 8kUIGLclFvsgonZ78sM9EDOBmjNlCJOZX4r8XHRgnHXsFbCUbSor3h2XFaJomAxm_gaAxzfDDvcq
 zLOAVXBJ48Y7_.4iVqVItIfy5ZMAiDceNYDIlOmyDHrtLbe1DWWIjlTgmZSoUD96QAf3rjhfLki5
 kc1W28IS7okIssodfI8yXgAznMZAVsFfyGcdpYqg_p5XNsL0CBhX2yQlZl12ZwSu9QsKDNE2DPhy
 hNCzaBacG1uP7QZZawrCI5NRIqJeG4I4vLVWPs40J61bf4gkRLOyjab_qRigYZ3DBl8RYqMwuYbH
 O1ysQR.RohtxpVF.Rw4Oa.vz.hR7_C8dsKPfbANM41nVOL.hSLk8JuYSo6l5b0A9UFVqXnMfWjDc
 u1o.RvHa4Z6TmqEWSwfipRyzZiqXEMkyqRdkWvYtAYsQk9dFF2UU_X2j5EK.UUUcDkQL.gA5vlPy
 efATQm68LsG.R5lvxXT.2JusKKUSVSFqFHCtaUb2uFwiJWg1ucmaODXiwLYm8i5H4rSlEdaIFzc9
 p.bDGbjJizdq2zJeCrpnncRzLS5kAk4WW3wbX3qe2hYxIdSBKp0_YWhH8eX3HrXOYmAJ5eSOybyb
 mewaTRsDkhXLzUY574xNbtwMEmk3G9ZwhwuqUKKJW3OI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:39:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4ba474287b3debb52399a04543db9a59;
          Mon, 26 Nov 2018 23:39:48 +0000 (UTC)
Subject: [PATCH v5 17/38] Yama: Initialize as ordered LSM
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
Message-ID: <a635a0d9-6966-c13e-c0cc-3d68c389538c@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:39:45 -0800
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

This converts Yama from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 5 -----
 security/Kconfig          | 2 +-
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 8 +++++++-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b565c0c10269..6cfbd7d78a89 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2087,10 +2087,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 566d54215cbe..94a71e022b79 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -241,7 +241,7 @@ source security/integrity/Kconfig
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "loadpin,integrity,selinux,smack,tomoyo,apparmor"
+	default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/security.c b/security/security.c
index 0c092d62cc47..0c3c66dbf51c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -274,7 +274,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..eb1da1303d2e 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -477,9 +477,15 @@ static void __init yama_init_sysctl(void)
 static inline void yama_init_sysctl(void) { }
 #endif /* CONFIG_SYSCTL */
 
-void __init yama_add_hooks(void)
+static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
 	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
 	yama_init_sysctl();
+	return 0;
 }
+
+DEFINE_LSM(yama) = {
+	.name = "yama",
+	.init = yama_init,
+};
-- 
2.14.5


