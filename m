Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909475-2-8026011412050063983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909474; b=TJKYJ+ZGwBOgGCAWLe/BKScdh87CXyVb9wgybTzcVc7oNe9
    Bz/iWgWs9/xQGUZ7yix09JSgqSAVSB71H3KL0TBvmGx2SXUOyrJATjqO459e5/N3
    0cPm+mFSiiV13ME3F/N3xPJ5Fub4im6Lq59ZCavyIPZwv/49XR46hqXRWoOdMNH7
    eLajmZTgfSVmDXFvh+lIDBouYACXQOrhce7GyefcLWg43bpQobWA5Upoe1asGBDC
    sDpKEpNJnBT9w6T06U8bj2TbWYcM27qXE+IBFe5gStyH7xegU3Mm3DH/Z5787EhT
    QZstmkyhBTkGyJGzUWveRmnMZHfZYbJRC7Z//LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909474;
    bh=o9wt4qxRgviZ/SM2aAeUByaDVo70FE/AaFiMiokIiaM=; b=Pl7qBNTtBBUT
    VPVCNdm8OeP0DfSdpfEK7k7tjTmKieunT8FgOl8T1DCO9DY8Aaf8YpIfxz76UZJn
    DjB++c4m9Hx36bhiB1XzyyBC9i6zjA2d9NqiPjJJkvi477ISs3/Ti+R9J3hnHHLM
    AZuhMQ5Utw9yTK8fjUgB8IJJFmu81VinOAzomJ8sgd8eGVQ4ZRCJ5x7o+o57eigB
    9Wm6jEwoBNb6fCogY6nefVA1YZ+QSmfzaR9u8vqCrYryGkQMvkkJCgxAWoxddvPx
    0YQTHeQOOryxdcvaXSXF/26q4PHiPstui2kUNn8b3Vt+X/xAk1Gclbt5IE3GRIvS
    IfymJkz2jQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=g3bSVM/I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NbcHd8uj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=g3bSVM/I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NbcHd8uj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030780AbeCAM7K (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:59:10 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35599 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030781AbeCAM7H (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:07 -0500
X-Google-Smtp-Source: AG47ELtD9SfX5B/ebbCGDbEQMCO76Tb5+BucethGiDDu5z38caUlitVDXoQqjxHR4ioGmmn3vAaCbQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 27/45] arm64: entry: Apply BP hardening for suspicious interrupts from EL0
Date: Thu,  1 Mar 2018 20:54:04 +0800
Message-Id: <1519908862-11425-28-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
