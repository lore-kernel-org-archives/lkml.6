Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B658C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE9E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="n7tCOI8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE9E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeK0KdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:33:21 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:39751
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbeK0KdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275451; bh=aA9ToBwx7EdAqaJKoH0MpMTFJSSXKnw022+5umTtX5A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=n7tCOI8prznrulx6BRLKMDa5wH3ZqwvaWC2OUwfHgakiema+/ZThr/C7zyGe5cHD+r065fiGYS238XYVqk4vuyhFSsHvQi9LAqYbWOhrmkqavy6mo8eVzurNgFYZUCg23ZxrKLCJaHsFVlJeZMlQHR+UNWRvgak1QYA2ULOcjBAqysiNf5V2ZHoAcFL7+vpfeUVrfgctzr7nt6nyn27VLIApouTT7l6YCMxSNsmEzsPOx+uKNjl/SlhdSra2t6AA7tGzFkm/Ja8i0FRcWqlQthY4gd5qYyG7UZfS4unsr7ZrRgPDbAfi7SdTRkIVNOWvJMSaSUqD5zR78BGaf2gOcA==
X-YMail-OSG: SblRcHkVM1kRMyghCdep7JgiTN6vuEae.WZ0G1dfbYVOYLrDEyyleFmSzP9FhDl
 .DKKzg7Fjt_7da1xuImkxIBsSOZdfZ.fLC9GUJ0OuZGMD483KxS2ZY3sn5JGKJXj_xNEaNLVcuCG
 3lcG.XT1B8KrvHEPwCClz7OCC7t7uMj5T_YWqEjNg4CVSDx9MBGrmQeKQ3YCh9qwNA4y3e_exyX0
 Jh.QfSlhtvL8qiWN3NHz_xhVkxj7kaYxdj7YWmtVrCHW.yURL3dKu1FhBoJnfQb4nDlzXtOzMSn5
 IOMYhTmjSN3ovdDXT998F0VswHpgakmiPX7RkOoqUJlkKefnui4M5.Dw_BvAPZXgyC7ziXesdvM6
 OvM0AMW5xqUESbqPi5gD4GSFX1NR4mVbyWxoL7eddyL31XXFnJcARvt3_t0k_J3NTYgN_Ayt_A2n
 o2KoQE6cyGGK1Xv2jtwF.rcIE8R0zqIE564zgb.ny9y6OncVEaFKuu7YjfpUxW2Xslrty8FRzh2X
 __3myY6MZ2Lu3Al1_PEIW8a_ea54WH9cuUpI.VQA1dd3meawQZ4kfyGFaaEOkbI.HejfxI.XFFOj
 Tk2isO6bB1qop36Z9lJGTmO_0PfuXLbq0pQWsiAUqN6TGn7pachPSpI_v5aIzz3mWia4IEOQS0xt
 pt3YbvIKN6AOeF0_BUOxg561UZq4dqb6jzpmZSQyNM4ZUN9ZC.EbzkV2n7HsINNgyNgbsVWl8mlT
 7lF6fWhTWboVzTO_vQvD.oLE0IzNsq1OqaPAaWhvU0LqRLI24AwuStSX4opLykWxS03UqyReH1VO
 z_R6qt.GCUdogbGMwLuWQQdVJGnEv9Vd5l1eJguhN9ibEeTuYY9J5LKLhtbE4j2608XyfnilNmOf
 wWRo3B_njm35i..qQp6NPWeitCv46BT_V9lJ2rQHL8NVmZHLWui40bb7qiwkLIHRmeLAC9AoVAcu
 XhTH7SNiAZRytZvAHtNuRABF8HqdcMwTO4gTymrny8Nts.nXqTfn67gUctW0zmlyk526WavHme8Z
 2Z_5xbC0F7.jPWGl97_E6fn72iug2XhaY5lDoNl9iv33wTI__zjE3nq0HdN8vryH0Z0R1JvXFF.W
 ayk0sfSU28_iiB0ASG3Tpu3saxEaqziblc4No9Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:37:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7e91d840eaa9a6d0b28dfe698df4a23e;
          Mon, 26 Nov 2018 23:37:27 +0000 (UTC)
Subject: [PATCH v5 14/38] LSM: Add all exclusive LSMs to ordered
 initialization
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
Message-ID: <e443ed98-b96f-ecbb-1b99-8842562af212@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:37:24 -0800
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

This removes CONFIG_DEFAULT_SECURITY in favor of the explicit ordering
offered by CONFIG_LSM and adds all the exclusive LSMs to the ordered
LSM initialization. The old meaning of CONFIG_DEFAULT_SECURITY is now
captured by which exclusive LSM is listed first in the LSM order. All
LSMs not added to the ordered list are explicitly disabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/security/security.c b/security/security.c
index 0009ef6c83fa..df71b54c1ba4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -169,8 +169,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	char *sep, *name, *next;
 
 	/* Process "security=", if given. */
-	if (!chosen_major_lsm)
-		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 	if (chosen_major_lsm) {
 		struct lsm_info *major;
 
@@ -198,8 +196,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
-			    strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
@@ -208,6 +205,25 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		if (!found)
 			init_debug("%s ignored: %s\n", origin, name);
 	}
+
+	/* Process "security=", if given. */
+	if (chosen_major_lsm) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (exists_ordered_lsm(lsm))
+				continue;
+			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+				append_ordered_lsm(lsm, "security=");
+		}
+	}
+
+	/* Disable all LSMs not in the ordered list. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (exists_ordered_lsm(lsm))
+			continue;
+		set_enabled(lsm, false);
+		init_debug("%s disabled: %s\n", origin, lsm->name);
+	}
+
 	kfree(sep);
 }
 
@@ -229,22 +245,6 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
-static void __init major_lsm_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-			continue;
-
-		/* Enable this LSM, if it is not already set. */
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
-
-		maybe_initialize_lsm(lsm);
-	}
-}
-
 /**
  * security_init - initializes the security framework
  *
@@ -271,11 +271,6 @@ int __init security_init(void)
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-	/*
-	 * Load all the remaining security modules.
-	 */
-	major_lsm_init();
-
 	return 0;
 }
 
-- 
2.14.5


