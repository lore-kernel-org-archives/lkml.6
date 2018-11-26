Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE438C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A2020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aHaG5NTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A2020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeK0KhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:37:09 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:42007
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbeK0KhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275679; bh=fVRVzoVAGOfByb/OFixOZSHvg+YGRncLAzZbI7X+PB4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=aHaG5NTite4g0yXIUuftVxSoRcpRH/V1A84lIWUk9Abtr3jaVXKzdV6lrzQemwLD5ktJwzEg51eYIFQ8iIkaZ+lKcf0ifhu/cctXUCFUEo+WYXi8/vMwwxCGD4k5Ny/g0s0abENPO+YByYGz1CLQcgfxFEgdU6cjJjAEcfyh583cgVkwJC+HDDbN6/tTxnZVCE63MhewshIySv7P3pIZAeAIY87EoZiH1rBzUcJtDnUTR1V5Qf36PalXd/q6HeWZqIvf5TvlK1M761Z+OeKBBHPCh+1eZO/zHEVfs6bK280A8dZd+IL5Y5FVWSz+7j2UJLKeSvsQ1uUh1lmG9HMOCQ==
X-YMail-OSG: aCn9FCgVM1l9DwgaAq62waoREZGjbj8wRXb0C4bj459iqdlzLnJ0BsFiIPC77m7
 sw73Zu2X8PzyYWtF4cTj7burWPhFicPYnwMLtd2sT1ft2dDTnhVWLd1dGgCAboaOLWFqOsdehAQu
 ZhCiOhX7g5R945ZwHRr1yHjO2SKCOKnovZkrxRx06A9PunqtSFb79MEGFi01woPTjR5Kivg75wHp
 ZZ66Q.WyUAuZCz.08YtgKfrzpEfgPmCVIo_TN4BtWySiJml9Azx.EmrY9lHPshwn97wNzxbinpwn
 5_fwS.WhkTJpeNIPhB56QPdg2ySPDLQRgLOazfpvyDFjfnOHrJj4LJh.2KItSCuY85CHcjdFhwd.
 P6lN7gKy7Tw0eM9koPuEiUHQGaVmYcLRQiAWtczYRdUrisq45HpjtxslRT.xWg8CJxJzSfH8p3lC
 Ae9ZjI3KTEuqbiG466mKGoYkPZjHXeAM_6GbFF24bxTgM.WaESIkQwWB5_cTExg_FoX90oXZIeI.
 YFSC7zPQ45aMsIHu5wSpX5yympGeFn3HlkRj6.SXgCpqnmIGvFm5tvdEtVRlS2iO_YFCCL1ZxVY.
 EemsoH30dX8AGvOcXPfUApKi7BheyfEPUE_qfTYwDqGEgolg0A6IkWepZoA3riaffdAxWKuC8xx5
 dawrYkHcu3arOVjVrgHuHXOj06ADzG_.8XI3qnkTeBJyk4Luz3.DH3Bv.K8MKq.BB6WWdyRoPVyE
 I9.SBZ1B_JDf2ajjz4YGmwqB0fK_b6OPu680CxEcQ3hQWU0HwMlXaFADbsqHC.ypcu24V8dc6Zl1
 ecSlYpfZcFwV9Fo1V2aroNnTzGiuBsdNhL.Cvz7CMxATypjhaaMkNC692QdmCuVnZ2xZ.bRYrWo1
 wfPHxlojYfbwqBTxD_GsAti.SUaWI1z7i2X6b.XD9nAM6fCyRO60bHAhOP2IifK9166vg1CtlCUz
 IBxT5JC35K5jQJI4gJsbruCkOCldXbSShRlmtksHv1hXJpicbRuL9MFEqDEI5muAdVakZ_00ndpf
 dP9rZ2g29IFjAsY7pHxrRIIuZVJGf0RlTozfyuK0uJZx1IwFQ2TstOUx_3C_mWuzbw7lcehwdJxm
 85upxH55gnTSpz7R25.9uldv0pG_CyEHDACza4n.MA3A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:41:19 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3591437ae6288a942f86718ae111444e;
          Mon, 26 Nov 2018 23:41:14 +0000 (UTC)
Subject: [PATCH v5 19/38] capability: Initialize as LSM_ORDER_FIRST
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
Message-ID: <147e1a0c-3d18-c467-8f5a-6559cfcf818c@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:41:11 -0800
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

This converts capabilities to use the new LSM_ORDER_FIRST position.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 2 --
 security/commoncap.c      | 9 ++++++++-
 security/security.c       | 5 -----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 83858e3df9e5..15fc49ee41a1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,6 +2092,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern void __init capability_add_hooks(void);
-
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 18a4fdf6f6eb..ec387535e597 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1363,10 +1363,17 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
-void __init capability_add_hooks(void)
+static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
 				"capability");
+	return 0;
 }
 
+DEFINE_LSM(capability) = {
+	.name = "capability",
+	.order = LSM_ORDER_FIRST,
+	.init = capability_init,
+};
+
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 701507174f40..eab64bdc60fb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -277,11 +277,6 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
-	/*
-	 * Load minor LSMs, with the capability module always first.
-	 */
-	capability_add_hooks();
-
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-- 
2.14.5


