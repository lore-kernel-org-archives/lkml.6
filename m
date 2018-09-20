Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8605ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF822150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RSwnStcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF822150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbeITGBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:01:03 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:33355 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387451AbeITGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537402836; bh=4YFT2kRkcBS6EDzTvP9aJ97USIwUQlxH8rUXSudgMqg=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=RSwnStclYuCnlAEmk9IGzHV/dX35X33WIm0Dc7LFAm0Ptciy6jHI0hFKy5sozdxE5W29Wd2Q30wQlem6Uf26SCZ5BWSaHwYLxY+/x6XOWOCbGv3QFKK0l+0s4OcxsLkQN//eoKKN5kloiTSs+CiPkeQOVHarBgmuCdui/PIo/IglmmybybaQNLcS9ZaEsb3GMVxm3ueg9xiD4lEV5L5Y7F9QlupSpDAM8G2mQu0B/RemThsmZbrGlRpr0zaZVt27xrP/cVVwNM7PbHTZgYKrjdc5aXFsi32f7M4+cHKgDGNUi2JkdmAinWcXVi9DwuM3ifVoyUm8v4vPj4ODVihJJg==
X-YMail-OSG: VHdmbdAVM1lFDdy5OQtZFwpJGS3V.PEhyjwSCDTfAEafG3OaIjQbJjU2GjdO.S2
 DaqRwlbM2USxAqo7.jzATHGIZ1h135oRTk2w_O9QrPYA8RPGhlsvNTT1SLpZ7LNR8vjPVEFWRvj4
 v3ZTiEr6p9bCSS4Zp7nAHyQLmvXkXMKMoLljUH0DLmhe6UqgQdrfZFGU5edgwIH8PLByzhAwAPhK
 qS0MnjeqDaWSTMA.FvyApMZ89vkrmQ7akQ.9q7nBIKQpA1mMp_9eSpKYCrNvRiPyVXuY0erXRfEc
 o6bsO3UJ7NANjr3HDhvdob.GF7MAy6prB5dCjpuF30QszEfc9PzDjFOJb7jty1vFP.wVOcLM1YA7
 5La_m1KIH77rszXA57QFP7hSk3.TZfMFZ9DN.e8MPo_LEuVDiqUWCjitbnwV5HsMHhirOjWBn3rE
 BdTP55jV0sINSk7VRg8JmJ6.MKKEUH9zc2Hq6Jw2ZGcyVQtnMTsfKfw6xa3brXDJNMi.ADsrrFVi
 3VcKj1I3SQfht3zVnOIvvvcKT3VwR0aQD1DHWuVk4IgBKsIhtLW0zPLHo0xDvEoUgX9WO.XBONhW
 VpTEl.oGyggkofG_x6GiUZZJiyDFdDFuCTTRwngsJSwxTaGtIV7xea_FXxEQa3PxnGvRxsGlG__u
 DLLtWxpMf_aHGy89r1NjuWZnIr8msxkMenPX7aZP63eBgGNJY4KB4q_xMBqs11yIPIH1Ec0wU0nm
 NdnJM9yLAIWYQTIXPINERgg_o7rxufyyHxG5rB_EihSpkz1ZaZFTf9fCTGHyJEKMs1M8_DKND591
 MsZEDpm46mhRz.HMI2.0h6f91gk7fKJoEnnVBOggVSWpF.VUqqpuC.mAWBJUDZWYAxyncYVgxmv4
 X.w7iwQqip.fNDiMED9kdHjX2ctagnoisB9rpF6IrWHwhhVoNDoowwNGA0TyTqibN_NtxntM77r.
 vqNY.85Xlh_WUvprI.kMm3fFTCcASH.byoZOJCWFROS4f3nkykuccnmQZPunMzjcW502TLYaNRkX
 uR0.8PPHpE1KiDYvOtBmW7gmYklAHDiCdbg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 00:20:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 601572d7d29fa84acf960ef7c37cc7a4;
          Thu, 20 Sep 2018 00:20:32 +0000 (UTC)
Subject: [PATCH v3 06/16] AppArmor: Abstract use of cred security blob
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
Message-ID: <2eb4065c-1bae-203c-dbe0-47980e009a2c@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 17:20:28 -0700
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

AppArmor: Abstract use of cred security blob

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


