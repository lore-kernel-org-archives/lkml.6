Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519634025-2-7461165601090219553
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634024; b=jMtX76xB1f+5nZTxwQr5g/Hb2hLsaJI5IXqb+50G3Z3lGHq
    Iq0vVLwJ7Y+SjfOdribAEI2e9ewfUuhkLNofyPsQxipDBYCjJKFnNXpIieDFrJp0
    PICjthXW4gMzCHcsjO6NvBX89ZkZX/Cup5GaoETktuTzMtgNtQ3HXh1clZxvr6Xn
    8XYO0thg45ZXak4g0s6bkNh4MeyBrjX7YysMxQfdv+Ih3CQAEpHkOeSxtwqyze4p
    Gdv7suDhGy6UWj4ErSiOujCpi5/vtng23hrS5ztr9g/IjIT+zQ+AyuMXKrpJ7Knu
    UAITlLPqIqS60UjZODlmV8+fADhBzx3JMMMt0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634024;
    bh=lZSZ7mN/jhpd6MgLblCtRDrj6c7/jUPbXNYPUP0WgH0=; b=kIX1uzmW4713
    c2TuqgFf1tYVoso/LT18ZNVM0iSfDzNtfjJ9r28mhGE2zj36UftDg43/6EwnpjRH
    gvJmOYwVITu3gruTodctYs1iz0B8qWL1cKdFBpU4SiY5Yq9PjwihOOKt6jfCDd9x
    /5+VjtVJpZecJ2uFr32yQsHbCyPOlSGmJ3R/9tIj5xRd4LKHdqGqDZ+6cwT9VMRC
    PssJtmz0yRipTuGFGsXNnEFhPlIMFquup10Vc4PXDMNmgbiL5Cp39zfd2DRqiX/9
    ilkbwAsBeH7sVrCIfllB3XvvqelanxrAZODwF6RfFaUpBIWkkSoib+FBtPiOtwBw
    IrQyF/4WDQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=C0FlJHD/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i/U7gyv/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=C0FlJHD/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i/U7gyv/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeBZIXb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:23:31 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38441 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeBZIX0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:23:26 -0500
X-Google-Smtp-Source: AH8x226GuGWOMfFSbijRgk+cKl7VkCSs5yvGnYANzLy9FpwQu1qE4noRiAt28x9AZXM0t2xlGngwmA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 19/52] arm64: cpu_errata: Allow an erratum to be match for all revisions of a core
Date: Mon, 26 Feb 2018 16:19:53 +0800
Message-Id: <1519633227-29832-20-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 06f1494f837 upstream.

Some minor erratum may not be fixed in further revisions of a core,
leading to a situation where the workaround needs to be updated each
time an updated core is released.

Introduce a MIDR_ALL_VERSIONS match helper that will work for all
versions of that MIDR, once and for all.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpu_errata.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b75e917..c66a673c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -53,6 +53,13 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 	.midr_range_min = min, \
 	.midr_range_max = max
 
+#define MIDR_ALL_VERSIONS(model) \
+	.def_scope = SCOPE_LOCAL_CPU, \
+	.matches = is_affected_midr_range, \
+	.midr_model = model, \
+	.midr_range_min = 0, \
+	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
-- 
2.7.4
