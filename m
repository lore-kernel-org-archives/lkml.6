Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5F1208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p/JeJBcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeK0KWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:22:40 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:42538
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbeK0KWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543274812; bh=mdy2YdUdtSJS+oWKPUtutk2c4C3wLLPLrYrGLBo+7N8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=p/JeJBcAiLq17bJWVyy9tmqSP1VEwJZOxnPc5f/lLRd/r24uHLo5Jj5vB4DxOiPp+PqNP4btZVhrO/f7N7UFBHPho1QWjA+3r9DQ+To9eHCBmnqiZgESLcsdnxIfpc0cFNBqQcMKp9padW3OVs99MkPkOWMt61KpYfWTcS3cOeOBi6LA5q1XoIjIWtHTjthBgC9l3ZKJTVnEkelrQMmwMsMNsoey3EXOW3Da3Mzypb7IG1GUUhm/fRQM/vCUPPamOKO08Kvxj3JR7ujLn3TxlO8nmgaSRcqNcqgpO+pCWjGjbuN/uULTdAD/dLLAD3zz6ZS7QyzTM8DgpM6dUonAug==
X-YMail-OSG: _cZQ2iYVM1k_4JyYuTwv5LfT8_Pl6w2BJwh10yHM6HKOlwiM9HZM8KBI9.G_MuT
 bwg2kme0j3iFs.tRkrbx8OamVLTGVyPKX2w3EmL.NERv0K8rVVe9P1u5yB9Z_U92F1ZjEgtfiPdZ
 .VfZN2GAP5FEgnNjWDMsIAokUDD1awKLHKT5K92bZ9A3q3F3pCOrJtC4BR.UTj7tTiZ3DRYVbdhA
 FabhdXlJh4Wje7lFxbRafA84MpkjIDHZ_kHhlreqGBeSjTyf5OpJJl4p98T5GsA8WlrGYlRmC7p4
 mtP6b1Z0gVfwXDFlOnFs5V.MJyvkgsa_ajHTEZqIcpuBM22LlGLlwCXsnR6uLzJTd2n8Nk8A4Mm3
 zjHsHcPtMBQXvq.r5DKWhQffgUQyPnG6Ofy9d6jjJBKV2i5ZvHFHAfIsRxkKbUYFBET.gY2FZKty
 As_0qWpU7jcx1t0FfyCziDJhWrvvdDv6E0Q4ROcX2Ls7N1J_betq_xGWRrkzcu6pW6nnotMN8znK
 Fgp1fInBGIDm2BIMFJMjES8TmMSkU6pth1WGdMpUR1lesOSDgPdu8XntHF.wZr56CtQQ3CevdjYx
 lpKUbKg.7iJjKB.cOC1QVs8XhGTcTEl3gtWLKmhTwdF3rxxNnZ8PGioNIt7QTBytqK2nZADcuMTo
 i6N.FRJ3yxB9lp53KcGZPc.exxIH3RlAjvM7ZF0cYP.CwR.d4LeUGL.smD3wj3jq5i91Tqx6fGmu
 fD5UFyWGSE2WppJ.7lJGezJWvWTcor.w5nU.s7vsIvuJlLLGjJPCbduoKYXfrZDGWvLSrUn__IHk
 9HT3LXk4ZnBafsviOxfP_HpcJHT5Y7__6kQhxhKbkszrkI6b9H2XIDTqDe06bxrs5ZydK_4R.tFr
 VbnpH03B8K.K0t8.JY7gQopntEmC0ZmbQW02EuRmKMqtlSOrmvHPbMV2IYcFG_gsfSZMSihdDmOx
 2rm694vb6SUmCIuB8WquVB48inQE7jj5eN87cN2ne15E0GVoRytammRF9Gzv7zIZQ6r.2tLtQrx0
 ZWL8DJDooA2CAA8eyR3.wcGt1RqTWrYbCKbkgcBxhlJ8WZ3PwvN6v8_8iEIt.bf7Xuz9APQbwuH7
 Iz9jP79eExK8Ie0hKLNee4o9EqUEwgJW41NY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:26:52 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 29dff8d62ab536d21f7d336a2d7a212f;
          Mon, 26 Nov 2018 23:26:49 +0000 (UTC)
Subject: [PATCH v5 01/38] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
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
Message-ID: <ecb10f5c-7bbd-fb2e-4148-63290bc9a7ff@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:26:46 -0800
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

This adds a flag for the current "major" LSMs to distinguish them when
we have a universal method for ordering all LSMs. It's called "legacy"
since the distinction of "major" will go away in the blob-sharing world.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  | 3 +++
 security/apparmor/lsm.c    | 1 +
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 security/tomoyo/tomoyo.c   | 1 +
 5 files changed, 7 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aaeb7fa24dc4..63c0e102de20 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,8 +2039,11 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+#define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	unsigned long flags;	/* Optional: flags describing LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 42446a216f3b..2edd35ca5044 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1728,5 +1728,6 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce683259357..56c6f1849c80 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7209,6 +7209,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = selinux_init,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 81fb4c1631e9..3639e55b1f4b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4891,5 +4891,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1b5b5097efd7..09f7af130d3a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -552,5 +552,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = tomoyo_init,
 };
-- 
2.14.5


