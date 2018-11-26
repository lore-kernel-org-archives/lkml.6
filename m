Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC287C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AD62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tQYy9Nqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AD62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeK0Klq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:41:46 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:38112
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727637AbeK0Klq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275955; bh=OVmMPLMFIEQe7/xmXls0TKHgNoRAVpp7J85y53TwffI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=tQYy9Nqrd3XCXRWAtVzd4xi0Otu8aF0zGYpBrgygWJp2Xs1zPaUtf1QoSxs3cm5nSVjec6GSh42/c4rcSGelbiaMAHOPcTbgrOkqW7X81IiIfVRunL9m6u3EHQhR8UYntcucAoSJuQKDGRH9XP2QF8i+LKZsj/seqfkLKjde/O7mcafdGNAoUZqP4PrT/okigMX4yxCplj9UmGte+D/yJsk1FVCNEIi99ykpiHVqDLS0U+AWvSnlnFJKKGQJX0w67E6IF2hkiKoCXHUQLuDKrSPqnOla356GTteD07kVTNIq5qbxCzF4MTYnMX30lA5sI0LZ4ci5Q40/4RVOK70HzQ==
X-YMail-OSG: kzk2uRIVM1lSX98gpB866IqaqP5P1TNoSI7S_TGl4hM3PW7xPZLgRbMu2yuZClL
 tnIUzk4qj_sGDty2exaDsQR0E4sgT6aSH3iweaaVvkCDdKgYcsIZTYJ.NxVNSTNh0DW40Sj13buM
 n_AJ6LUeIJzVv_8Yp0ce4WDIsahSwEOUg06f_d5hnpJJWj_qZz0sJ6nY3HwH5WVbaL30WHBvJQ2N
 bhMafHri_PhD7bstJISYqnuA5OQJuJvQl9oejZIqhfa6ZbujGT_de_5CRkWGQMsvx5zDx.HnkzVa
 TW4xpxph_DJJuZrUfUBZwaSfpCT7gO.zkwL4Tf7Nm3D45BSz1KN9YfmgIq7F2VJ0H9LdD0oy.iJm
 Bnrt.zAmnc06IsASR8AEqPlrDWKadwosOk7Xdo3iEqmiaDmvEY.OiqSV0KxqkrfrCEpqLLbD5YEW
 ERBxt_EgO8Lc9ajNUXPUcl6f07w9c3GC5NMWvOutBdvm1HPcKIg6LM2WC_XGMfyuNp0NzEnXIRVI
 wGAuneXxerdWC80J8dsABMlYnpRHWzRcj.vMCphMiNDcwdA10UyXf1JOZrhTxZGBYhM73AWlwTlY
 BD2UyCtDdWtCktmZ7UblsO98x0McBWii8lTcvIFrXW9YXAWhGRZqyszQYYeUryXK9C0StDxFig9.
 V1l5UcIHdU8bD3g_YrUmDG9UrxoKI8wwjyObIucrx_zphDp4Iz7hiH7cgE_I3XYu0F_1oE_Hdl0S
 MkDUqyClAgIbOpKmF1wv1sDHssL3.PXGQ7mDTSyqMn4kmW0p9sz3_w0uOK7QylDMnxrWvWXE149y
 z3XHBKtRXjKyKaZKn8nl7jSNb.d5woMBzPWEBkUHL0_BSg8fjbm4S5hoO21s7.ybXxuYJuKgzWSo
 FHIoFS4yu0IJIg.9o4wES7G9iFgWiQ.kPBcY5ll6zBccqT_dSazklXI4Ev.XStX.A02zigqMWykL
 EnBHFe1BwRCT0QQB1Ys5KSJk48SkGrkr7Nft058g1eicd6J1Z9jAhshmAh8Gt4vX7wESJ5Oyemi_
 tYTTKBFBgRg1J78HFhLeDhuGF7fKPXnYxp9IZN1Pu3.4hKfZzj8xF6sPlG_EswSlbj3lsydETgg_
 pNbYasxYMoN408IXY5pJkf8.OkPcqUPTf8brahg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:45:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 80261e733d22cdb6cef6e5fb85907676;
          Mon, 26 Nov 2018 23:45:53 +0000 (UTC)
Subject: [PATCH v5 25/38] AppArmor: Abstract use of cred security blob
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
Message-ID: <4292905c-9e49-adb7-9bda-4aa739163d7b@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:45:51 -0800
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
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
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
index 265ae6641a06..a757370f2a0c 100644
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
index e8b40008d58c..803ec0a63d87 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -59,7 +59,7 @@ DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 static void apparmor_cred_free(struct cred *cred)
 {
 	aa_put_label(cred_label(cred));
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 }
 
 /*
@@ -67,7 +67,7 @@ static void apparmor_cred_free(struct cred *cred)
  */
 static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 	return 0;
 }
 
@@ -77,7 +77,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 				 gfp_t gfp)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 	return 0;
 }
 
@@ -86,7 +86,7 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 }
 
 static void apparmor_task_free(struct task_struct *task)
@@ -1484,7 +1484,7 @@ static int __init set_init_ctx(void)
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
2.14.5


