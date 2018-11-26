Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2137E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PBzgCU0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2137E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeK0Kbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:31:43 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:39184
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbeK0Kbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275354; bh=ym3f469puDtt39uIiVW6xTc7wt1MEzqcALg9oKeNFac=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PBzgCU0miyUMq9niEBB2HiyrSCI7kj/xxR3NjfgSaGNOJERb9u9izjO8z9pMnLlvZQRwSbtdWpd8Fd4YfcLBVQtuEXdj9bBF2u3+eYwjgtD+h4oivFqwbuO9Mq6naUyNTpce3LGan3JcbqDeu+HhV99N4FkcVGbmbck9RjALbcYMyRfYtxJn/25yiwKnEyFuFpdMstf7kZK7MQ1qQL4M3oIpEN2Vdq8+iqMuoHoo9fhaBttW+r7pkzfr0tYfL98TO9BwdZeXBN+k+xwevMQYZJikadCZSvJk/GzTC4cxYqmFKuqARzBSYzVhOIeRrxUHGuHAspCh7ryEJRgAlMnUKQ==
X-YMail-OSG: Px.HeuoVM1n4DNnLlIpkF2q10jusmo7ASmK.1PQMG4IF3U2y0IFft5c.5WR1d2M
 IxoRty2FPZNvjP4wBgAUY02xDJ4JvEUG_rG9vV_xWnLWEm3Acu8cwbf87c7gxO92KOqqV2ow4feK
 VDTsVYSca5G4ouk_WY.DmLwhKhonMbTBQ.7jLQDlA9QDvwYk2LBXKnLZr6uZkn5bmcYHuy1XTUJ7
 8s6zz9sZ5WZWqvtwCe_a9VMn4XR13k89eAEOb1PC3tzjkITAWp4yJwZ_t21gX7wPnAU2fHLoB7d9
 ykZ8Pj585Hq5BhWtYah.1d9AqiUx6Wkrq1y6UGXVJkZ6AFfQaw52Jz2DGIYgLunzSWTObPab4R5F
 F_kypCTxq4gcd6hyHz.byfMlRrW.GeJsnVHbSh4QlWtF9sR3Qx02aJ8awWKlaaQ1fgwRuh6XKz8B
 RuRJanArzWIZ5etw2I2I3vACpyISpRO8Yxa8_ZxCOeSZ9v7hFW_aCrgpvUVPgwvuZEKVRtqDwaFm
 VNMa_09BEkk97KUKlqVZwco1sH3aglnw.6xHliJqiVnqHnhPpLqWZnHOKIcLLQ9jvrXKOJmblNiO
 Wgzu_AfycdKciQw4P0288uMF33cgPIr8ovgl9NHIWfsbonjjDkl3peTt3qvwSA1HdjPTUBweErt3
 lzz.AVwXSnOd6rN48fckcOG.IV.JCDiJL5IDelcPbQLvFs.pk3P9U4qEe2oqP0VuPZNpa0BYEFiK
 eKcpbmwmKDllNwT_qbRctW7NrQ8NzoQ3Q8hgIPUa61aBjdBBN6Lksqlm4ajedtKsNVauvz4Hi6jr
 vczzfhppI64WxiIrRUBjHVkZ.oCKhl2hk6d2NhZfmOnDs6ZWY4QvvPMe4BYRPu41pB0hKrknncg9
 lXcI5QTQ..hErm.BxIS9Go4C.KfQ3TmVga8Gxvc._Fj_10RM7sIAeqpmH7kzvdtD20UDJZVVzOtY
 jQ4zJg4yIBi9ybEGgkFpsf1gsn9kpNWecBdOS8ogQU5E0lCS.zuWAmFaHyfvUb0d0xLR3051P9VC
 qYcLZml40TRpz4DCuD7XmGDlh3LnGw9pCLI5T01UgXFwrMKoMrwBQpTJ4jVmFSlcB.H0JClLn1aD
 Y.k6Ye4WULwSoeG56x_wNWCETToN1A0SEQ1WeoT._8GI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:35:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 74fbe16db5e95d37f35c3405e5eb1c61;
          Mon, 26 Nov 2018 23:35:52 +0000 (UTC)
Subject: [PATCH v5 12/38] apparmor: Remove SECURITY_APPARMOR_BOOTPARAM_VALUE
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
Message-ID: <5f331e9e-f8c2-4e8a-6a30-af93fbf602db@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:35:49 -0800
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

In preparation for removing CONFIG_DEFAULT_SECURITY, this removes the
soon-to-be redundant SECURITY_APPARMOR_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=apparmor", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/Kconfig | 16 ----------------
 security/apparmor/lsm.c   |  2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index b6b68a7750ce..3de21f46c82a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -14,22 +14,6 @@ config SECURITY_APPARMOR
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_APPARMOR_BOOTPARAM_VALUE
-	int "AppArmor boot parameter default value"
-	depends on SECURITY_APPARMOR
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'apparmor', which allows AppArmor to be enabled or disabled
-          at boot.  If this option is set to 0 (zero), the AppArmor
-	  kernel parameter will default to 0, disabling AppArmor at
-	  boot.  If this option is set to 1 (one), the AppArmor
-	  kernel parameter will default to 1, enabling AppArmor at
-	  boot.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_APPARMOR_HASH
 	bool "Enable introspection of sha1 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 37dafab649b1..e8b40008d58c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1332,7 +1332,7 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+static int apparmor_enabled __lsm_ro_after_init = 1;
 module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
-- 
2.14.5


