Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387526-1519634053-2-7646488480170890854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634052; b=uP9FI6zlNhoddJLu1voyRbXuczQAokN8q5qIoKo8HSB91dQ
    4Y4S4LQIUIxIQtwwF05xdvV2L3o2VuAaKBLJj7G8hSGS32S4MpFgyHRJe2EEQDY2
    khOfWhuwlVsOvyRpstx7WgPl4xVDQlWVKL7BSA0hxxkAW40gCf+bOpcpTURQS1qR
    UyWbE8ZRlVgYqSxdkwwcPmyDiSk3dHC+0kvNAnLAi27HGPlIDyoJ2CDGSHcSkJiv
    0Gdmfx79M2d8uCFNbbjPMLdqwuQc+vQMPw9Pu4arTkGKsq1WtDf2rnnioChZI0lc
    rT+CIf7CPFWJOQGXxKcFy7eGycpofMg17rrQh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634052;
    bh=tfc0ew0kAdAAuBXUjDfVzA2fzAypIwJmE3g0LacJX+Y=; b=Jj4DClxaSbl2
    XKWGBDNEiWOprUWsdrhyQQTtQlPfvaF8JHoPgxboXwJrG4nYNquTAVu8f37pVsmZ
    VVdLN3GyWICpkwgTb/By9k5WnHh8GjAQ8R0/YqJgEA2hH4yAytX0mbcN4e8XOvnr
    J655x8bs9Yi4AmPGyWXXblZkKo9owCASyMXIFVuleRsS5v3ImctQMWPIu3+eEcp9
    5xCtbTlIaHGL2atrfknFM87Pbz0dTTDzR8/tGBlemD9IGtDatK7eNTBltLJzmteU
    UTJh/7R/sBlbt6m0esyhZrlPzs8Loi5sw+A3wUN8fAJkpqORRfIlunuv1lJ7YH5o
    /1jRWpJPVw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=L+2IwLVV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EeKxGUjl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=L+2IwLVV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EeKxGUjl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeBZIXR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:23:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37589 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeBZIXN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:23:13 -0500
X-Google-Smtp-Source: AH8x225w45emhMQsQfhEt+GkVCTXs31wTps36odkn0QmvtPN9e+G4fkFsZIsFt73V0xx8Y+mHY+hbQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org (open list:POWER STATE
        COORDINATION INTERFACE (PSCI)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 17/52] drivers/firmware: Expose psci_get_version through psci_ops structure
Date: Mon, 26 Feb 2018 16:19:51 +0800
Message-Id: <1519633227-29832-18-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit d68e3ba5303f upstream.

Entry into recent versions of ARM Trusted Firmware will invalidate the CPU
branch predictor state in order to protect against aliasing attacks.

This patch exposes the PSCI "VERSION" function via psci_ops, so that it
can be invoked outside of the PSCI driver where necessary.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/firmware/psci.c | 2 ++
 include/linux/psci.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 8263429..9a3ce76 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -496,6 +496,8 @@ static void __init psci_init_migrate(void)
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_ops.get_version = psci_get_version;
+
 	psci_function_id[PSCI_FN_CPU_SUSPEND] =
 					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
 	psci_ops.cpu_suspend = psci_cpu_suspend;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index bdea1cb..6306ab1 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -26,6 +26,7 @@ int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
 struct psci_operations {
+	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
 	int (*cpu_off)(u32 state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
-- 
2.7.4
