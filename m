Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBDC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B4B2156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NCRyCMWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B4B2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391780AbeIVGJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:09:24 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:33427 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391751AbeIVGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537575486; bh=moeYvcwDz4aHiI88+2oNPpuMjK4sdeV0qJVQV11wnek=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=NCRyCMWsfPCupQl75/PsQ9NYMrF2sRyV0BJIs40t4oxmrmoU9uFeTKXsqSwjE5kSdzXcRgKz9Ts8+x7WZ0+NTVgZMsAUWotfTNC0KHPwPJrdQKGVblBvyq/1k7ojgvoZ+TiU40BWGjj+0Tgg3la2CU0xFJIfseHKnOH5N/xs7tIWJ9ItUStTOhlfioK9ldfLjqj0XZBKXUqgdGb9KU7IZ55/t+d+dcaGrjUymH1Wz8f+y5rD5CmhYB9AxPPTsQ4j3WuVa8qZ2Sb5lwIqxwksCWsiLArSCFzAxd5O8k6wMrT9eIfGmmRomR9Hhd81ggzQhuQ3LevNhvhTjU5xtPPUqA==
X-YMail-OSG: sbj6abEVM1kSW373iwhkHdt3qPKP6FhEE6R28BxytgCwL0wrVh_aVBULcABhGNY
 rZk0qTyOfQF.Z6Mw1AsCqFCcskHNWs4vcO9NzUrSOyGXLEwgpIkJc0jRNF.MesgzDxJQpqq848ze
 Z_Qheq1YNcGhN3RRKhyVEWeIXqvR0IS1Ln79REQYx7HtU3skJZljmkcDPhskeeg2vwG1LnyGXT7T
 RHkmlpjzc0LfLf5w5BEkOz.XgI4J0nCFG8.do6Clb4PJiGfUs4Sr7RBh_SVrRjpWR4RczPw.NHo8
 sJY8DwlT.rFnRq60FuVCJMHZkVAAdY7EFJ2T8N9t8U1ELAzQnbItmEp4rEZAMfrHtfH5kJjxGAeE
 BySuOhGdeGoMmVwCniTHMyQxp_IvMyOo5VF4hDVxcmf6P0jUUSKoCRCoY.d7LvHZZHX4JbIO6sYD
 Rwjgr6QCqk4OfYCPcgJkH2DTLWtF2cGF5XjuRXmhaSRaBQJiHvpSyL2QBbjDvtHV5p5GaB8osp74
 vk1SUv30_PxhvjrKBt7EgK0wC_cPM8ZfH2EEQtqawblcOkSTKaa6PcuDvVkF7o4.m7mkpuV8iPq1
 SkUyH56cum_0LrpwyO7wRlTDth__SJ4_8Hlri8jKVxc3uOC4iErjYq2.7e0VLjiCkSt6JX62gDJS
 jLOZGFtYRATV8grxwrsKybPDcuCn4RiOn6OlJg6qFD2AMtOLaIABGIXsgOy3TM4zhAMmXXKoBMS4
 nbwJ8PJIT9Lht6jOKMMTeHGZ78C9DIEZAk_Lx8B3h.3T7KU81dqyorKqnMf6CgKayZIi1MOt9Mkh
 Ls86dHQkROfgd9K6PLsFyNSL13FLIWvoKpY0ew3v2lLhBCJJ2oG_qKU_I2bQ18nXiZLCLZfk9as6
 qlPDh.FFd14Vi_ef7zkGOJ78qqd41Szn8ppKXEBqEX4yzWGyaz3dv5HHpDi2yutIin1a8Xf7IcuP
 m5Arr6g1xodbfWE2I3FRx3TJi9shakEeLJRFTkYHNoJSCnWzxQ.5oJJnajFfcXJxqqP6R95iEukr
 EX0InN3zrfbqZU2ZVyzYh3ZcRQBAMlWKx
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 00:18:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2cf301e387c71a2550cd07cc03f04e49;
          Sat, 22 Sep 2018 00:18:04 +0000 (UTC)
Subject: [PATCH v4 06/19] AppArmor: Abstract use of cred security blob
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
Message-ID: <e9eb2c69-5175-d033-cb38-1cc84cf55bfe@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 17:17:59 -0700
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
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/domain.c       |  2 +-
 security/apparmor/include/cred.h | 16 +++++++++++++++-
 security/apparmor/lsm.c          | 10 +++++-----
 security/apparmor/task.c         |  6 +++---
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de0ffda..726910bba84b 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -975,7 +975,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 	}
 	aa_put_label(cred_label(bprm->cred));
 	/* transfer reference, released when cred is freed */
-	cred_label(bprm->cred) = new;
+	set_cred_label(bprm->cred, new);
 
 done:
 	aa_put_label(label);
diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index e287b7d0d4be..a90eae76d7c1 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -23,8 +23,22 @@
 #include "policy_ns.h"
 #include "task.h"
 
-#define cred_label(X) ((X)->security)
+static inline struct aa_label *cred_label(const struct cred *cred)
+{
+	struct aa_label **blob = cred->security;
+
+	AA_BUG(!blob);
+	return *blob;
+}
 
+static inline void set_cred_label(const struct cred *cred,
+				  struct aa_label *label)
+{
+	struct aa_label **blob = cred->security;
+
+	AA_BUG(!blob);
+	*blob = label;
+}
 
 /**
  * aa_cred_raw_label - obtain cred's label
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8b8b70620bbe..4f51705c3c71 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -57,7 +57,7 @@ DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 static void apparmor_cred_free(struct cred *cred)
 {
 	aa_put_label(cred_label(cred));
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 }
 
 /*
@@ -65,7 +65,7 @@ static void apparmor_cred_free(struct cred *cred)
  */
 static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 				 gfp_t gfp)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 	return 0;
 }
 
@@ -84,7 +84,7 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 }
 
 static void apparmor_task_free(struct task_struct *task)
@@ -1455,7 +1455,7 @@ static int __init set_init_ctx(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	cred_label(cred) = aa_get_label(ns_unconfined(root_ns));
+	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 	task_ctx(current) = ctx;
 
 	return 0;
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index c6b78a14da91..4551110f0496 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -81,7 +81,7 @@ int aa_replace_current_label(struct aa_label *label)
 	 */
 	aa_get_label(label);
 	aa_put_label(cred_label(new));
-	cred_label(new) = label;
+	set_cred_label(new, label);
 
 	commit_creds(new);
 	return 0;
@@ -138,7 +138,7 @@ int aa_set_current_hat(struct aa_label *label, u64 token)
 		return -EACCES;
 	}
 
-	cred_label(new) = aa_get_newest_label(label);
+	set_cred_label(new, aa_get_newest_label(label));
 	/* clear exec on switching context */
 	aa_put_label(ctx->onexec);
 	ctx->onexec = NULL;
@@ -172,7 +172,7 @@ int aa_restore_previous_label(u64 token)
 		return -ENOMEM;
 
 	aa_put_label(cred_label(new));
-	cred_label(new) = aa_get_newest_label(ctx->previous);
+	set_cred_label(new, aa_get_newest_label(ctx->previous));
 	AA_BUG(!cred_label(new));
 	/* clear exec && prev information when restoring to previous context */
 	aa_clear_task_ctx_trans(ctx);
-- 
2.17.1


