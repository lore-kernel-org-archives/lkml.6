Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C7BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAABA208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mnZHyH6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAABA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeK0Kax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:30:53 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:42381
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbeK0Kax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275304; bh=gmxgmI0e0SUx/xHFAFEiz1hpEu9sU384sPzkIMx2nJQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mnZHyH6lvuY51Vjta5kD7nmPA/UhZmoDFBXu6/kurgzz2B8WTZ77tW9MI8mSqlSJLliMy5yVAAjf/TO3G/TIk0dCjrfm7VIdMQPniNXruX6E2/4ye9oMQ3JWyaQGNhmfXRawNBGRhnfuXqeJAlHiTKrSGzOijYSRHzZgzTTnDieTbVqpJiWMrkl4dZFO1NL3DuXjn6uASzaMSpKG8GcpwQjp3hiSOcE/iWNzLMpGyCovtGdpCQ/iLzmJSFdoloB7R9FZ33BeDZiEl9FofZ9+LylGYzXgLuwLUvOwfm3UhBhAAnZ/s/yvd478CW06kH39bx38po2Dq/aKS9qTkLr9kg==
X-YMail-OSG: V2zdBukVM1mSXZpKVCw6XVdbAphU8gve3ir8r2TSzEOSHmqPyHdk9YpDxoybzjd
 GwU1sHKGP8AYPjxBCpzZoZq_vduaPSNpM.GAv0BJXR5MQ9FN35kRK.OkCrScaGu1Ga4xfZF_FEXm
 H4ku5QhFDwJN74OuYkRAGZHe_jD97NA..fFE3O_ixIwOs1I5xRjqSmTcSufPojwPoY1xsSdwAUjB
 kZi8AkZ8iaNfJVyLdstWv0ik5YkpYTQwdGNKeoC8cfU2BO1N4SP8o82IFBKHaMkgKqGGUV2_l8hN
 huaMJHLFqQACzfCceqj7woVpFlheVItdc5hQW517AiP9FtQ8oFMij04_Meu.MAZCYG7_oFfRkQRt
 HhUry7GOr5.iVydkUfS2Smexc8S3YgAk7xZeAiBu37l0q9G0wi8ATcpAxPP.cybVUFR6zCudBN9y
 IYalmjQZAUtNFMmGPX5CyyxE3joF55kZHijj_TSgsdCS5xudZG7laiLentSC0R4hyhIAsSCO.0l4
 Zgn_MDvoDjvkbO6yjdAOnNqL5jKQrId.ML9kCAIetqAHyHYUZzRJy2PjifBz3R_PtL6K10_xbxfQ
 8By0Mt_OYf95DVsXleatQR8hBhCC3yEbDa9VtNttgIfNblSEA5dyfj60LdN.nHMdK0yLNMLGX9I0
 c5wV3MGoBWEHREE0zkdIM2zF1_c485Wgr28YdaAobRuxAw2buAfb1r.NUO0y8.fApdHAERHQE5lK
 7GK73zG7uhwU82wkrGD6dCcLS6fqPkqGqtemucmDGmvdzlFLgl3geFyMGm94F8yKPToaLrEtYw9U
 rNOGbxdf91MjnMAU3Se_OSWH.TqXqs5I_HCCem2HEgTAqaJZ3GlGu_9KvMGv7F.tB0wL7RkR5zFG
 DAQHrY9EiNFpxUBdRMaOe4J8DK3Dnu9mJHx3e4F69FIjl9C7sGLGFnRrB7Cf0INfMCcl.EvWGbuP
 9pQkQKrtAuE9LYof3pZbkT2.ObuBq78Zms0QhQmFjoviOxGLy0IxLUB13a47UVybNZ3WPp5mrM01
 s3ESwE57ddChuXYuPnpyiAhoinRZEkcrrhF2.SYItcS3S2AL05BeaoN91aETGMk.SeMUlsk4iAIF
 SpGzTSQO.Ff_RAh49CmRcYkkwbwuBM9HXcR6L9HeNdRc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:35:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e1c59684d0d44c1862b255bd32e36fc3;
          Mon, 26 Nov 2018 23:35:01 +0000 (UTC)
Subject: [PATCH v5 11/38] LSM: Separate idea of "major" LSM from "exclusive"
 LSM
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
Message-ID: <66ac31c3-ebfd-2b04-57a7-2361fd2005d8@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:34:56 -0800
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

In order to both support old "security=" Legacy Major LSM selection, and
handling real exclusivity, this creates LSM_FLAG_EXCLUSIVE and updates
the selection logic to handle them.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/apparmor/lsm.c    |  2 +-
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 272791fdd26e..7d04a0c32011 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+#define LSM_FLAG_EXCLUSIVE	BIT(1)
 
 struct lsm_info {
 	const char *name;	/* Required. */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d840c1ef3e4d..37dafab649b1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1722,7 +1722,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/security.c b/security/security.c
index a7889885585e..0009ef6c83fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -49,6 +49,7 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)						\
@@ -129,6 +130,12 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
 	return true;
 }
 
@@ -144,6 +151,11 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		int ret;
 
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive chosen: %s\n", lsm->name);
+		}
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b81239a09dbb..3687599d9d16 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7199,7 +7199,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 56a114c1d750..849426ac6a6c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4888,6 +4888,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a46f6bc1e97c..daff7d7897ad 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -550,6 +550,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
-	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.init = tomoyo_init,
 };
-- 
2.14.5


