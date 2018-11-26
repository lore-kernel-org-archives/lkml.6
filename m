Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E8B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jxSfTQKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E8B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeK0KYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:24:36 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:37123
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727541AbeK0KYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543274928; bh=312IAhYZpl8ub+eZq6+4gtdGxApt35wUQovj9MI+k8s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jxSfTQKiXJNJOIBP6MKetpVELei/t6KLUZ8Z8L/uezkH318j8B+3NFFpQrNPLgFZ7CsqeLWoDL/vzUuVxA9Oz9FZRiOVK9xuVB2icuCdbs84j9g/s1KoNpxCLAq5U5oTdHQSxWBy5ldN7LBoQn/AVitL1u60L9jGM1CetlBNT8b7sIpS3ljtlQHjm0Tpwz1njUVdXHkyFs4vTpGRIZEhdyhLMQjCP3v8NZd3V1ULfECg8AXnNqk7GY9NaSr6dN9aIoc+Y69J0H2n2tLaUWCT/0OiNQSTQYbcgHUP8CseZ4oKMprivpZCPXs0jGXAMRz4H8C1UrVkPhgyJ+om9DryLA==
X-YMail-OSG: ZRU9.DsVM1lZhUH8LFy0FYsBONEzzJH5xVBuACBIohjVWeCKGsW68MkoQgyCA2_
 H7XvjpEdVzTK6JHIjFDZLubD67fZT01qny2n3vvIUJKQa.5T.33NBzSHYkqbSqG5FhEUTP5xeO0f
 1nwIw54uYxFH0oxAcHlZjTB5HljMpzE5w4jPm0DilTnE0QRss_xzppNWg.AUtK2ki2AWHCy.nhy5
 vikiqbNBqPYWRlShr8mWPhXH_eleC6r_hmq.BTSZdzbQcbvYLQe4Po9G9wj6gsErWbdU.DJwJewQ
 1_v9x_KaMGW1FwBduaen1iN1R_oyBhlF9JQG_XZvmQAnHJR9MZUKmadPkPcS60p0tilJPEwwm2vC
 iieibhzBG0evktE_jRnfjT.QfWXmdnxvY6szkc2D3_5SO1L0s8O_KokmTU6jYUMW_9vHaNo86Tws
 41Huz77RY8EzcAH.MKp3vku5CRqaTBk0x4YSa1XsZyO_dBKQ6PN3VED8p5wDXgSepE3k1YGW4Ytu
 CodmcfbBpP_XLtP5EqwCu.oN7MhHz.0qlNeTvmWf87GM7OAnLi2lzgFdQyTR_UU9GQql_hYF0H9t
 da31R6Su9cx7_e0jqwfq4oa8h.9crg.f4vlH4Yf0eKDjDb_Ppe9FpZLc2_40R7ToYX0DNnjkIDF6
 1At9wVXmGRGwwTqIUsPBNeESHaDWoDNRDDo.zp1KXJ1qxG66nZivxw6TD2IrQ4HGAubhJXE9Zwr3
 ULmitct8p3Nb0WQrccxrbEktBt6nlUB0JQYRxpeOn740eEmrKwMNtougjgFulRhIHencW8ZdbQ.Y
 VPP7hd5oqhfv3cd4kHA_QGR2ywdbDW_z5eC.n0Yg29XUyNxFALP32ewPmZmw7yPi5GcshU33mSgU
 sEWoKdx5QvKxfOxi4LR3B3moHFR_qkmABhejK5qE5XNPA3HVR_uBdp57oNhfzbBma7eIWwYGMNjf
 o7KgM9I8FK3Kg8HAuNnXuTEZ1NfZzxnmUBYkfQLhFIfxRWXcQiFiSFdKJagUK9TNotSUif0GpAps
 SPh1Z5s2SNDUtC8DVZMfoPME.0MToc2bJk_Xlr66LXgl08C8nx4Ek0mzGKZT2yzrm7A_HoJEahy.
 .UKDQWxyKenYwRvreJ3v_0PHddtK5hRQwxPw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:28:48 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3d12d55a43ffd32d6288c356d89534e8;
          Mon, 26 Nov 2018 23:28:47 +0000 (UTC)
Subject: [PATCH v5 03/38] LSM: Plumb visibility into optional "enabled" state
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
Message-ID: <aff8e873-56da-fcc2-9ad5-a9d6a6b48356@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:28:45 -0800
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

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This should be an "int" to include
handling any future cases where "enabled" is exposed via sysctl which
has no "bool" type.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 63c0e102de20..4e2e9cdf78c6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
+	int *enabled;		/* Optional: NULL means enabled. */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2edd35ca5044..127a540ef63a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1332,8 +1332,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1729,5 +1729,6 @@ static int __init apparmor_init(void)
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 56c6f1849c80..efc0ac1b5019 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7210,6 +7210,7 @@ void selinux_complete_init(void)
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
 
-- 
2.14.5


