Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE46208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i4KRo80P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE46208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeK0K0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:26:16 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:42185
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbeK0K0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275029; bh=fMPrSb+dmaLWXhRA4kL8eUvonseX5wD/nHNn/Azz/o8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=i4KRo80PEW+S0nkB0oAcXA96KqkgwJmwcRN2Q36g2taRGDNW969JMkm0qIQ76VT1PqrcZhvZ7j/ExxEovZDP9YzFaK3anc5hUviwaYGNBK+vPVx3oZjZUOQ4HsT71kAiQx5eOLbaBOFMSujocjTvDQwnhJmHFQLt/krHgUi16GAY+xE8PaPfdfz8hg9LDOFraGqgYYs4ka5l1sar8XXxkVZGCOOJ1dkfxrZZooKXpRWkvbdAiblInLn5nPrpWVxMoDWeIRPYQVADYTXMP+dSvj8DnST7l1pev6xXjlgdZ57Q0SVD6F5TsQ884w+gA3ENFPsE8aib/nNtpD1V1g+VZQ==
X-YMail-OSG: pp_tp90VM1lLcxIBuf3SFUuPLwEFHoPilSxtljIDB04Nr5S16VXP7NYDCWeqa5N
 n8IW3DAdxtRXGz5L8kIiLgrX9yZdUpDNDzL8cT3R3YU407eep2jGC6EMJdUa4vMv.2Y9nlHzao.W
 _JIhrjtv61wSRH6OonKPPuTUS6qpAYBfj16G46.t2zdA.VKoCfq6W4QXBfXEY_mhChGSp8n.pGjc
 lhAir68mDEEU2LWKcAogv7KttKpYvHrNjG16Q5CUll75Izl3U6CCtn613DpnyuaO5ktrObwI.88W
 4AKQzRUjS2USFYWZDNVjsK0nlGRZtE.QU0MWyOK.iWPleCFCT_U.czwckNOGnzAy6zh_EFh9hI8E
 dk7STUjOtWbqAXiB8Nj7ruWOOD9gnqPqZx_3lmVlFIMbaQNm_qZiNfXzHrACc.6rH_8KXeQvEIpr
 ivLVojfYNT5azNaeoIDyBwjfRXsSJkxJqJwsXrxxeF_vNlJ5P1j0WQdeis0diVq44J._WZso3JlQ
 OPJ7XZvCCFxjWHtrUvgQFOXNJtq49XPW7SPuJ.yvFA48ogXV1RqeMJN_XKY9eHIsgqGQAxtBIFn4
 QETwphZ5o9xMukpImvROBa8SoNQ7h0HLFLQEUaYqYkCsxB9S9RogDiHaiJIq151hvgFj7Uimsh7f
 vvjudAciLdJAC6YBrR.VPktty9WkTeNYT9Rn2Wure1lNTRspOfgpHb2KLI3ceiB9cUCtSlUEdPMd
 NMWJU0gYPifaYkvX_7ZWr.ncdfpwOEzgFzz97bT_Ai3pXpDX_tplvSkLOqMSsnvltkKeXGlNAJtA
 4X43w_e08SqKgN0QrHLgf1EbC.wdyDdM0bQ7MbLlU8h3kwaekTkNBb2D562Wwgh1Aij_x3D2_hQa
 5H6piJtCfajphb0YgiD7DACoJcyJAoxOTRv3..nmIpnfW0P37BOwDMgekJYNBFhkzOxjeEcGIfs.
 MJrhrSb9l.OPaEhzdbMks3x.59MWaTjzmSSItFkhtzdkcGPyNEigvZ_Y5RWej5xvgOxwtIhOKj6W
 i5XVFkD7ihWoa4HLJjEKRHXHwhrFPmaLOnLA_B6Bw.KmxSSj73ueT8DvsmEEzneOYHgp2Mopd9NH
 d7a9_KKC9oudn_H2EI9y6pbm_E8Wz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:30:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8b6410a7d9dc669a9c778bff1b9412de;
          Mon, 26 Nov 2018 23:30:26 +0000 (UTC)
Subject: [PATCH v5 05/38] LSM: Build ordered list of LSMs to initialize
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
Message-ID: <ea812d01-50c7-2ffa-6c0f-1dd0563a7586@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:30:24 -0800
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

This constructs an ordered list of LSMs to initialize, using a hard-coded
list of only "integrity": minor LSMs continue to have direct hook calls,
and major LSMs continue to initialize separately.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index 7562da854b62..4c193aba4531 100644
--- a/security/security.c
+++ b/security/security.c
@@ -37,6 +37,9 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
@@ -45,6 +48,9 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info **ordered_lsms;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -85,6 +91,34 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 	}
 }
 
+/* Is an LSM already listed in the ordered LSMs list? */
+static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = ordered_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of ordered LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (exists_ordered_lsm(lsm))
+		return;
+
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+		return;
+
+	ordered_lsms[last_lsm++] = lsm;
+	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
+		   is_enabled(lsm) ? "en" : "dis");
+}
+
 /* Is an LSM allowed to be initialized? */
 static bool __init lsm_allowed(struct lsm_info *lsm)
 {
@@ -121,18 +155,32 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-static void __init ordered_lsm_init(void)
+/* Populate ordered LSMs list from single LSM name. */
+static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
-			continue;
-
-		maybe_initialize_lsm(lsm);
+		if (strcmp(lsm->name, order) == 0)
+			append_ordered_lsm(lsm, origin);
 	}
 }
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info **lsm;
+
+	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
+				GFP_KERNEL);
+
+	ordered_lsm_parse("integrity", "builtin");
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		maybe_initialize_lsm(*lsm);
+
+	kfree(ordered_lsms);
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.14.5


