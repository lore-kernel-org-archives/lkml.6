Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E29C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8AB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MGJ3DdiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8AB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeK0Kc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:32:28 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:41775
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727487AbeK0Kc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275399; bh=B7bxOfpQI1kzSPjOBDZSM+OSrBcvf30xxjpv6gdsFtY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=MGJ3DdiSo+yGlruHPTkyhsfkFbFww1GQMhfTKL5zCeDCh149v/9VbvTX2Qltl1HZjpCu//ugcO5aCaAnR8jVxhIFXU3Y3uor3Oq7NSptOnZE1QCkrSIrflucJE47bLXoxMbJEXwYNmT2Wx1hchLpCDfqpAFkrflrLlMTPDx6ZEMBKGYw5bw4thoiXEWRxA3czXMpzX09NtXTIP9WZRQXHntk/0QiNpgNSM3GjmWw7rSMwblXnZ5CeOOIWZcNVY/Uk2XNoEU5/MnVhaLiUL1pN0p+b/2MMdBEnbMi0qhWqTfAOKo6XeBIMP28Tvd64UduDNo/GDVE4tGyR10j2ugTrg==
X-YMail-OSG: bm6jbHkVM1l6zujn9CEOJnFeUTm5pLMqUN5TdUz6sFEfAh.yBhogAp.UAgxGg01
 fas7Js9CWdRoCkXeVG0GL1RSKpRc0hbWnuxaVVLDQNERdWKjfvhbiOiVHVF3BH6mL5V0Bzz6WYRP
 Cd79kXzqBxkrR2cu3bME8HDcqA2xCHr.CcJ4G8d2tH6caRe60kfCm2A2hTxCn9ccwt2jw77gLt5h
 c.IOXRXw_tqWUYCcarF5INrg4dHPcabDPdruHpA9AjvW46glEMBZ0oe4sVQzLy5A2DrXSCUYEu9c
 u8VBtgRqeckZ3QlWbFkswEuHdAjiCHXrnXeFnAToP8ErePlsxiyNvAxU31Fbd93E9l8yIfVdAyXg
 oVCbGTkgq2eaflMA1Zpmg5PrYR404u.aQco6ZdVywJoL7uoFupp20s_IZ5cCD0QY03uXHiXVVyk7
 V5arvoYbrYDBFtUHiV8Lazls3a1N2Rpan1cO3NV9bkcCmmnKBNluYdfx5WyBWfThL9oILs8Vjn9f
 epB2bbFbXc0u1L_nugPP3mzGP4B1N_3uy_BZokUsKNVSTAqRVY5UFqo5UeMR1RNE57uOla1GKB_O
 OXNrYLoFUTPIAiQH03dNWiWPCQbkVUGyvQ4a1W7mkEyx9krG6IIbJVVo2DC7taAQvEpk6L8dDH.J
 yF0C2iW_v7wC17GZ9McPI.c9CZ2ojzPjOAI9FwUBXZ6gRHzNMWTP.tVc.qeZJKSvJy4WdfBC99Yr
 wDgqw7jZLA9wGKj86hgUfV7ryaiYGgGjL_qlO60Qi8cQDgCpQcuxO0oDPAFOMKmo0.SJzlj6djPD
 R1S5dIu1zSuID1cR50berltLQeLt4.qIU5MBq6i6RuPJxb9VwqNzFUhXp.oMvTR94RYrjFWl98zl
 QXLbDi3NQ_qx6MSkS6f_d0TSW2kch93LjsBSMqKYQtyNXVTgJqeG.S0gASatBdm.LpAyb3I1KYWA
 I.u5.nDwZOsqzP9FQqeh91iGRH1m04x4TGmDDxkjnLlNzL0WoJAAM.xMguW.2k37RCCHWg98pyTT
 fQBLtA92TP.y1JeP3n3HcQUp0JKYnfSQMHk.PTiCzc1.wMZzAyfCbVBzurcEogismwttYqGd8e0p
 LGrC_hZQ.OX_xiiJDKX5gtaXesjuPtZQveYZlSdaIRSg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:36:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5a854c24c8b472307d347f0b8eba087a;
          Mon, 26 Nov 2018 23:36:39 +0000 (UTC)
Subject: [PATCH v5 13/38] selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
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
Message-ID: <5ea7cc62-94f0-0496-b39c-e6aff4cd9e9e@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:36:36 -0800
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
soon-to-be redundant SECURITY_SELINUX_BOOTPARAM_VALUE. Since explicit
ordering via CONFIG_LSM or "lsm=" will define whether an LSM is enabled or
not, this CONFIG will become effectively ignored, so remove it. However,
in order to stay backward-compatible with "security=selinux", the enable
variable defaults to true.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/Kconfig | 15 ---------------
 security/selinux/hooks.c |  5 +----
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a690eb40..55f032f1fc2d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -22,21 +22,6 @@ config SECURITY_SELINUX_BOOTPARAM
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_SELINUX_BOOTPARAM_VALUE
-	int "NSA SELinux boot parameter default value"
-	depends on SECURITY_SELINUX_BOOTPARAM
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'selinux', which allows SELinux to be disabled at boot.  If this
-	  option is set to 0 (zero), the SELinux kernel parameter will
-	  default to 0, disabling SELinux at bootup.  If this option is
-	  set to 1 (one), the SELinux kernel parameter will default to 1,
-	  enabling SELinux at bootup.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3687599d9d16..edd5b8dd3e56 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -120,9 +120,8 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
+int selinux_enabled __lsm_ro_after_init = 1;
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
-
 static int __init selinux_enabled_setup(char *str)
 {
 	unsigned long enabled;
@@ -131,8 +130,6 @@ static int __init selinux_enabled_setup(char *str)
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
-#else
-int selinux_enabled = 1;
 #endif
 
 static unsigned int selinux_checkreqprot_boot =
-- 
2.14.5


