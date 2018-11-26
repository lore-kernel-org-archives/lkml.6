Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA246C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D06208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NSvzzqnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D06208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeK0K3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:29:30 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:43057
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbeK0K33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275221; bh=ujgfotxrQ01hsR5Dk4QiWiX3I+MyR/d1upQJsg3YCs8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NSvzzqnH4M8ixMRthcT6nGUkN/uZMR4JJmYFNfmiYXPCFzI3QOF6IU8f3zKpvWxa8x4rxQhp7E88dSOfI2+EO8E3DJ05xLMq24IdYDNp+TGSUy3adEO/pSmH4lMI8GO2yoKOtlD8UEZIQSpJEqMb8XYWB3iTHz2fJO6u3n/RQQkiX5VwYsa630DiUC8HE7nTj1gbJQDBnETkjLXXJNQhJp7pDCe2qBNjBVDgYvrCIxnlNEomy+iRyJd9VPtMoMyil3tnjY8xHNoKu5decoLDrDtMFPAwGtqrkZQtHBxpePKb3zph5KfOurEGhfEHlE4CaV4/9hpOLJd8Pg/uzxSLmg==
X-YMail-OSG: ahdH9VMVM1kyaHnREsD6uRZbM_.xtRqT75871fF7Ffs7ymXgIWMw3Wm2QoT4rjq
 etJZqdjUUpy_G9rIllFBQ10sSz3vRIJzg2HjT7RmLORPJySPPRWNlSsT0WS256EYBGAWYpDOcgqK
 gb43Jqf2WumYcafMTMYAF59LqDVltwPlk1hsBuj9L6HnNTE9gPsB5jRKv5LOZBuCb3tPVpKwul1F
 gKkN2Fuj7fGeePt109ODxvpD2DiDqm20VLTG5j_RQ9xfcInkqIqLXsNRnhWEwl5d3R4uGPyUhbKe
 hZd9A92pLCy1KsCRdXQN3k83u918_IUS8AmMWyVKousUREU3.HahrStOTbA2L.uB.sHgs_JTQfrg
 9bSJXuvA71qW0f3cSx_C9K2T4x6HnNy91fiG2K7uuILt_XlddXLTMInwaSRyqTPoOZwG0rJ9clxV
 fSLsE3G5Yuy0VaxdCoQ4v2.5rXCQEZ_EdXm9T8h2vNHmnCiG8UsiAL4wknfqe7w7AgdvHEyN2Er1
 zxQEW5qn9upZUxI4AJbzIgS7HCkcSILr30HJPa.S_f223PLMGSOqbQPmZjYHF7jUfXcJV6hylL_k
 .XSST60wgZkIntUUM76SwORFBlXn8mhk4zhO445Jss0.iDUre_pC0pEhP7kfX8D_NYawe6X10eDb
 B0BW5Wu6XfdAh6dbid9q_tKiJHReD_VHnKCtyYLQ5if7i1vNmhbKDWzK8OxBXNqqJkkXZLjUaC_v
 S37xrR3cDIzzcEN3ngLwCgBucad8nFHiJaZ0ZxYoAATLdB8Y48KXcT7ZrEPcZCvrZR.L.wYtEp8e
 s7vanrJjDQ93cBuO410PL0eLlJ1YD5b4fXTCwNs5ZlYGF9hxubwgNLCuDuyM7F5s_b0iIOb_D9PA
 jjA_8lKlKG2uM37JlMB5iVS0YjXoCdgzmftTYfmG2JS7j6KbkQslsjaE3FYrEO3t041T7q_S4CUv
 2ENsUABsYf7LQfE7oBXEehTAy0G.fqEHfawz4BZY1A.XT4YW0Zt9uMuP2W6NEHL7kp.FRWpHCuML
 IYfiA5etyCCNjQxfzK4H.rP5L6QZmg72_NLliwoLcX9YMd2iuJLCFzVu.aIC2k_X2yFT3KpW4wu7
 rGHb0nSTDjsk9NJBB4Au20tQ0FugpK2XCY.d3gx.beJ4p
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:33:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f7adb105e9d2d5472fff1733906b2c81;
          Mon, 26 Nov 2018 23:33:40 +0000 (UTC)
Subject: [PATCH v5 09/38] LSM: Prepare for reorganizing "security=" logic
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
Message-ID: <26e368e6-fe18-c408-e4a9-915e87a4adc9@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:33:37 -0800
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

This moves the string handling for "security=" boot parameter into
a stored pointer instead of a string duplicate. This will allow
easier handling of the string when switching logic to use the coming
enable/disable infrastructure.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index ea760d625af6..f4a7b7d52d71 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,9 +34,6 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
-
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
@@ -45,9 +42,8 @@ static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
 static __initdata const char *chosen_lsm_order;
+static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -138,7 +134,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 		return true;
 
 	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
+	if (strcmp(lsm->name, chosen_major_lsm) != 0)
 		return false;
 
 	return true;
@@ -168,6 +164,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	if (!chosen_major_lsm)
+		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+
 	sep = kstrdup(order, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
@@ -257,12 +256,12 @@ int __init security_init(void)
 }
 
 /* Save user chosen LSM */
-static int __init choose_lsm(char *str)
+static int __init choose_major_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	chosen_major_lsm = str;
 	return 1;
 }
-__setup("security=", choose_lsm);
+__setup("security=", choose_major_lsm);
 
 /* Explicitly choose LSM initialization order. */
 static int __init choose_lsm_order(char *str)
-- 
2.14.5


