Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBBC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A9B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SVWDfHQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeK0K2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:28:35 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:37373
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbeK0K2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275166; bh=f/TY9l73GMshFbCbwrpBRqM3LiA17i42/3X1M8hx5cI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SVWDfHQlnCDX1GeaY9n/EcjgYFZMikp7Lnlz19S3wyDzFl007uknMXbWv6dleYJqh3PkJXYcFceybLQH3ksAOOJS/4x5tvudx04hYzALFQFfy4xJRu2zXTKtMINPlO+RhjVlbrP/7HrlqWtpwUQ3It1cpeyBmOicLnEal+6K1HYa0lfOjHPJfeZOKLrrY8kQZklap8ivj5vJgFdEGB4vrNh+g3jgX49FUOPkSsb5kOGTb6hI6DmOzp4AgU+Y1tZokL2rlkCmW5QVhqk100USukWTCwBnxSONJPuOJQLVAz5oHrD242YMl9X/WfS11WY5bU172IxgoJRt5HBLCSx2Aw==
X-YMail-OSG: wesRcy8VM1kpWAP8HLRBHe1xbr39ZevlcgKFQqQvwqoii5CH2HOSzXJeyBC.yOo
 fP1xr6DYp2yqJDEBTxxqzvoUSAbXgETvysQ1BT2z9RcUpqF.1O3xz2Ty39xvCcXCuheaM5ccweJX
 K8kBmDExRTEeM_T2pFcBAPC9.rL03utEcPCDm69m6L_KrtLDj0SYphLpjhu692TiRdqm4D3vivPQ
 juWTRrxALxfLAW8.gw7TaiBXHiVBz.18xa5irf0v9taNEsihf.NU9eg_38jTbuE_BgBx4sWGMxOy
 5yxFSpv6MVoRHgocDhiV5P0doyocHAR91aZ2Sd.2izcpmtVZSESVgrwA3QB8lJYE1hSHeja3HbSG
 gehC6PyfXYsObyw_epvPZJf7EsErgOpPw7oCJl.pxSVOcOSilMQ6j8T9rsmhVocB6X2Ru2TyeMKq
 cUwzcCsZBqsQ9yK0GJZnOjg31vSFxNd17EklFSELydP6AiHC7JijHKOkWScXM1OWg50SFZxa.TkK
 UfZl.ytjlfNLBeB2uEX_tPq00pZBNp6YDXHI_w0RJy.T5tWzqycpebXtph1h_1YMDGS0GNN3dB8u
 60SZVEzC_wrTW8Sva.zeSaP7cvfaJJ28Vd3ar4X15uKRZxq82qfivOGthvHfZsVKIAEiURi5LtUU
 Ii9Mbda7eAlElQI9baO.dpw.XaF0lng0Lw2IlsVelaqK1HC0htNAMVrZqk3gidvOTtGRPY0BKODm
 WcMy6mOnMrpV9hrHP0wFsPtS2bYdgT5Kc_pjY9Z4rq4vwMcWZPhOPUoig5FeiRtkVROiHHFsLTQp
 PGdwbTA9jNvGPLngAjeMgKsJsgcos2qRiD7hVY4Aeb2OdznWE59resHtLk3b8XUnicdrr1wC42qc
 F8jFmzTkGUT6WqfFpUo1Hfc2zivEKMGsoQMtcmi62HnjvuCesbQ30FSBWMyxxzckQm2ickZStRo4
 wrRXOwouMUCG1xT9z9KbE_O.6GhmNKwDUXQema1Rs4KcUndLLv.vQJzbonh3zcVJ6HmzwnCgxdSj
 oOK0ZcAJboA8imYcRqR88AbUy0TzP8uwi1jsVFkx9W7mmEYlZsjA6SKbPIsbxxF5gQmApw6ZRN4C
 rLnj10d6z_gk391PL.oFCcNzntVOY8bprp3PfiuMe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:32:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 111f5b9d597319e49534bdc80c98b414;
          Mon, 26 Nov 2018 23:32:42 +0000 (UTC)
Subject: [PATCH v5 08/38] LSM: Tie enabling logic to presence in ordered list
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
Message-ID: <602079a2-b7f8-4c8d-8fd7-fc6e90095335@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:32:40 -0800
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

Until now, any LSM without an enable storage variable was considered
enabled. This inverts the logic and sets defaults to true only if the
LSM gets added to the ordered initialization list. (And an exception
continues for the major LSMs until they are integrated into the ordered
initialization in a later patch.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  2 +-
 security/security.c       | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dabd2761acfc..272791fdd26e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL means enabled. */
+	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/security.c b/security/security.c
index 38fc436e8b4b..ea760d625af6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -63,10 +63,10 @@ static __initdata bool debug;
 
 static bool __init is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled || *lsm->enabled)
-		return true;
+	if (!lsm->enabled)
+		return false;
 
-	return false;
+	return *lsm->enabled;
 }
 
 /* Mark an LSM's enabled flag. */
@@ -117,7 +117,11 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
 		return;
 
+	/* Enable this LSM, if it is not already set. */
+	if (!lsm->enabled)
+		lsm->enabled = &lsm_enabled_true;
 	ordered_lsms[last_lsm++] = lsm;
+
 	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
 		   is_enabled(lsm) ? "en" : "dis");
 }
@@ -210,6 +214,10 @@ static void __init major_lsm_init(void)
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
+		/* Enable this LSM, if it is not already set. */
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+
 		maybe_initialize_lsm(lsm);
 	}
 }
-- 
2.14.5


