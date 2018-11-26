Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1205E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gf3FDKgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1205E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeK0K04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:26:56 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:40920
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbeK0K04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275068; bh=TGi2qrqGS1NpUSr2tXr7yuOrqhaa8jqVNl/N6nC/ayc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gf3FDKgH9QW9LNUOfAmG1iWPvkTKKpO9jae9LDW6LSpRDazVcYpn+qQuW4Z9LrI/ftyXO0VLGyswvfByB7UBCQcpnWE/7rAhOdZUBwO6hGoSpGDP6Kc2l2Wi9uueoFcOuriOyk2dtoJPLLstAFp3scK36/s+ftcXZS+2P6txu091Cw5J8+h+aGNBf6gjWYXP6cOwwA06NF5aqPse8XFqmCbGKzQrcgeWsA/voxhAGSHx4giH+G69Mau51IJKObxOAXpc85fsQsdIVpQXja5owQVRhQuod0cvMwyOImsYDakoR6VUc3qBoCbjin/ZpaT9qLkKV/GDTa2L1C9mmkr04A==
X-YMail-OSG: EuiNDlEVM1kF4StpJG8wkuMG1zNCmooD5wp.b_PqDyjEvf.xxW7utBBfkbkHbLM
 2cOUMFjqnj_oaE9T1fWNyOuSEZO6KIDNFF.ccUFAIc_00ArfbRjL8x5nY1NfKNJy1BAGkHLW3phc
 xc4Iv78B0kirFQq2iLLMyF9oPGtpXe75Q9tQ_FO03XtW_p.3vWMu9Qss62qktxZ11ZQ44h1us3jn
 K4vPL1409th7NzLRG8LRDpRlv__ryPwbolYpQQVRB6aMl0L5pDavVB0JDGeIQXmIJLCdaUZipukR
 QCOGV11FfHUkT7GQQphY45QUUkgZIw8.E3MxZRnnOG0IuXwnZ3UWjxlyZ2J93TwNlQ7tlyUybQdj
 gaflZTW2ZppHIbicZm2D7X4KRgPgU6Rovp4_fK0ACAd1HjyRWtu.g6rHb3qQzIz2Xe5wBGlMwq3f
 IPKsgNFhaKxzUdpy7uXwfTIAu22hUFddI6_Dku_L8c7ucWHTgY5KKgpdZMilATPnSJVF9hY.c9DC
 ELKw2CeKxm31OsCf5doEUSKLCHtcZI0cLxflwLfbVN6XG00qOoAd1vr6p26VlKZdMeUWGQ8sk0F4
 ..mNxOyWAPgU1hBMbbMqvx4QfbKA5_nHjq_SrlUGaBY7icqlAzKSFq5tTWf..fbT244UUgj1v6BN
 oHBLj8N076DwzbuLVgCMlai5ssXM2fj.9l2n2sllZS7.e.mWvDn6oQH27eSm3delajps.iYjxrWD
 RCdLpCLClJiYytfQwU45wn6z.AJturjOpWVE0v.UEYMwEotyihY9tkR.68qayDddi_1rmfaTr9wV
 93mZkWo270zD8oGf5IY3hXa4NAaw0g8teYcIDXRm36f5tmrZcNjOX2JHzDgyYBM7HgMIpFe8OpMG
 Y2eRIcG9RgCiOEq4LUZ9mUUjOru_QE774Bo32UKLZzYi5uJ57rlVjQjOJg56sxEAHzL5mkdzfqPT
 yHBPEJYxH3nQhmPbKc5Y8vyUPlTWb.VCsN86mCsU5mGn4johEVpmaUMstjk3p29arkJ.aFVaUQEB
 CiHM5HfiLe5Tq2YYi8NZVVgAZYFDvf3RkmZaW2p.kx7z421Li7oRDH0b6UK8A.gct2kxOl.Ug0Uk
 PLT2kmFrAqv0EoISHr4UAKaydar89Qd.95P4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:31:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51780166ccef8dfc214316ac59562bc0;
          Mon, 26 Nov 2018 23:31:06 +0000 (UTC)
Subject: [PATCH v5 06/38] LSM: Introduce CONFIG_LSM
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
Message-ID: <ec153379-6907-0405-85c4-e564cefe8e26@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:31:04 -0800
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

This provides a way to declare LSM initialization order via the new
CONFIG_LSM. Currently only non-major LSMs are recognized. This will
be expanded in future patches.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    |  9 +++++++++
 security/security.c | 27 ++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index d9aa521b5206..7de42bbacc28 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,14 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM
+	string "Ordered list of enabled LSMs"
+	default "integrity"
+	help
+	  A comma-separated list of LSMs, in initialization order.
+	  Any LSMs left off this list will be ignored.
+
+	  If unsure, leave this as the default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 4c193aba4531..96e0b7d057b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -48,6 +48,8 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
+
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
 
@@ -155,15 +157,30 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/* Populate ordered LSMs list from single LSM name. */
+/* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
 	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	sep = kstrdup(order, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
+			    strcmp(lsm->name, name) == 0) {
+				append_ordered_lsm(lsm, origin);
+				found = true;
+			}
+		}
 
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (strcmp(lsm->name, order) == 0)
-			append_ordered_lsm(lsm, origin);
+		if (!found)
+			init_debug("%s ignored: %s\n", origin, name);
 	}
+	kfree(sep);
 }
 
 static void __init ordered_lsm_init(void)
@@ -173,7 +190,7 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	ordered_lsm_parse("integrity", "builtin");
+	ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		maybe_initialize_lsm(*lsm);
-- 
2.14.5


