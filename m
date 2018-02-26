Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2183564-1519633469-2-11157407888738356822
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
    t=1519633469; b=YXs0mP86pULsOdjV0H2sjD0+rCYTlHh+bSbCh+5n4qOYQnh
    CK+cIIaC00Gx57j+i/JnSKKXUhEMbo77zyBTjeAetvvtwVEb2GQ2KM7k9I+ZdceP
    w2E3qqzvYq8GMPyz5roT6wQb8tHyoRGSLfalNV3V6xezNXjTDa7JPKL6Jw/dd0EN
    /+/cl/ebo0n5blJ+6qHH4vkFe9q2AsIbwncP6TnPr1JgTFqUJpFgEi7Ly8bWxoMC
    COYFZ+QApTBAJyBrDGocOI463r3hD+C6ZUwkchlMYw9K6NzDzQakUtfWfZkLt1Q9
    mkEVxAMvSajGKSsZ22yx0r80lahdfBVYkGpgsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633469;
    bh=o9wt4qxRgviZ/SM2aAeUByaDVo70FE/AaFiMiokIiaM=; b=uAtxyitrTy69
    151rG3lE02Or8dom+0//amfqHN0iFTdNsD4XkUuB9M828cbSEclK6vGDnNaFwMjt
    D4rD+us4vr6btc6rvaMLMp33IniX108PL/gG0s+TTsi43oYJHgz7sdZbeGFOaqiC
    NhYIFbmhGVYY5gpErTbR3hvcEnNljFbZRZlf0tLOMKv4Vn32yi86VEZ8y3ZO57mO
    tG0G++yqGhgBMRsF3O+/KFY3fQOVlPdfsMc4hZUcprFgxaA+xqBEJGpwMOfUGCzf
    yRHup7FkOkV8R5xWwv4e/anoFHe3G35t93wEfof9yrVXS30g2z7fwm78IrtzZRc5
    m+kmAe1UQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VvoK62Rd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3IUJycb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VvoK62Rd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3IUJycb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeBZIY1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:24:27 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46870 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeBZIYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:24:21 -0500
X-Google-Smtp-Source: AH8x226eKM9h91UbQcoAWS+SuHynXLYIbqrGqlwncW5bmPAw2eZiTds6M8FO40BQd19mZXAm8veXiQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 27/52] arm64: entry: Apply BP hardening for suspicious interrupts from EL0
Date: Mon, 26 Feb 2018 16:20:01 +0800
Message-Id: <1519633227-29832-28-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 30d88c0e3ace upstream.

It is possible to take an IRQ from EL0 following a branch to a kernel
address in such a way that the IRQ is prioritised over the instruction
abort. Whilst an attacker would need to get the stars to align here,
it might be sufficient with enough calibration so perform BP hardening
in the rare case that we see a kernel address in the ELR when handling
an IRQ from EL0.

Reported-by: Dan Hettena <dhettena@nvidia.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/entry.S | 5 +++++
 arch/arm64/mm/fault.c     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d50c2fe..e26a114 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -646,6 +646,11 @@ el0_irq_naked:
 #endif
 
 	ct_user_exit
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	tbz	x22, #55, 1f
+	bl	do_el0_irq_bp_hardening
+1:
+#endif
 	irq_handler
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6120a14..ad49ae8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -590,6 +590,12 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	arm64_notify_die("", regs, &info, esr);
 }
 
+asmlinkage void __exception do_el0_irq_bp_hardening(void)
+{
+	/* PC has already been checked in entry.S */
+	arm64_apply_bp_hardening();
+}
+
 asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 						   unsigned int esr,
 						   struct pt_regs *regs)
-- 
2.7.4
