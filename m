Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB573C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978A62148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIWrP95j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978A62148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeHVNS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:18:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40740 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeHVNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:18:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so657238plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrxc0W3QYgtxzlK+dgzzGM8II4AY3PYq2UwJ6UJrT4c=;
        b=nIWrP95jPmg1bzxofkwgxWVq6p69u5/J9fcJ0K7oLmBN8VQd5ra0DTszs9XgMVEfpx
         6DOebTTWB+ZR77yMkhJjBTbzDr+ceUpRQ/agfgIJIzjcsEm52n5OKPbtQpmIag2twnce
         8bLRitSlaheRnChjf+MxrM3BWjqQUsr8D1Lnk9mXAh9FCXcNZIeuMfYIa5yO7+muOrX5
         09s00YCD8tka+pLyqmwKuOP/JXFtX3vLaAhpGk39O7pKEDjQ3D9ZBAf/Sf6yGzNH5YKX
         7yfqWa50L3oPcC/wjnJHT4wcckiWg0K7zhhrhZYED3uyHfRhk7iM9n8xYxPb9Cqj8n5K
         eDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrxc0W3QYgtxzlK+dgzzGM8II4AY3PYq2UwJ6UJrT4c=;
        b=tHyPYBUBDYtvMy37AJfrOVjN75E95okbWALSa1k/oZEaKZopVhS5qg8ADBhuVEqMQ/
         3+0v3rZeP24eJ3euVyAvS8KSKSmne6+S6xJWtJA0fjOoywZuPJAUqyA9EhOt7YRUuET/
         JRIrBa4f1h+3gD/m0WjHPAU8bNwFgGHiqKetegGz5lvVTl6Zxy/hC/2vhQNJXsUjupVp
         qmHDFmFPSiPxtr4FKxCIOF2inScwu2jgaRW0roW4q7GWMROc/Zl+v00KjNLopC7hUnpE
         R66aYkCTofT2adVbGFgSIXN3P4KxjzX+N8kx+LWyMJxPu+WK18q+v4cqGKwgAIU9Yqk2
         GJXQ==
X-Gm-Message-State: AOUpUlEXjqaAyFBd9WRGiF8GkxMCWsUIw2U1K3NJLr71U0NdGKEoWiUI
        Dy42C6qli3AYmaMSek63B+w=
X-Google-Smtp-Source: AA+uWPz68kDmvYnGXPyJSMrsBraMilF+RBEWimkVpcS2a8o18HnZBueB7syVCe4aJlH8dOtlvSzL1g==
X-Received: by 2002:a17:902:74ca:: with SMTP id f10-v6mr22042834plt.260.1534931687270;
        Wed, 22 Aug 2018 02:54:47 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:46 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 2/6] arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
Date:   Wed, 22 Aug 2018 17:54:28 +0800
Message-Id: <20180822095432.12125-3-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel sets up the initial page table in the init_pg_dir.
However, it will create the final page table in the swapper_pg_dir
during the initialization process. We need to let __enable_mmu()
know which page table to use.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/head.S  | 21 ++++++++++++---------
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c83a8c47e3f..c3e4b1886cde 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -714,6 +714,7 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
+	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -756,6 +757,7 @@ ENDPROC(__secondary_switched)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
+ *  x1  = TTBR1_EL1 value for turning on the MMU.
  *
  * Returns to the caller via x30/lr. This requires the caller to be covered
  * by the .idmap.text section.
@@ -764,15 +766,15 @@ ENDPROC(__secondary_switched)
  * If it isn't, park the CPU
  */
 ENTRY(__enable_mmu)
-	mrs	x1, ID_AA64MMFR0_EL1
-	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
+	mrs	x5, ID_AA64MMFR0_EL1
+	ubfx	x6, x5, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp	x6, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
-	update_early_cpu_boot_status 0, x1, x2
-	adrp	x1, idmap_pg_dir
-	adrp	x2, swapper_pg_dir
-	phys_to_ttbr x3, x1
-	phys_to_ttbr x4, x2
+	update_early_cpu_boot_status 0, x5, x6
+	adrp	x5, idmap_pg_dir
+	mov	x6, x1
+	phys_to_ttbr x3, x5
+	phys_to_ttbr x4, x6
 	msr	ttbr0_el1, x3			// load TTBR0
 	msr	ttbr1_el1, x4			// load TTBR1
 	isb
@@ -791,7 +793,7 @@ ENDPROC(__enable_mmu)
 
 __no_granule_support:
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
-	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x1, x2
+	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x5, x6
 1:
 	wfe
 	wfi
@@ -831,6 +833,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
+	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index bebec8ef9372..3e53ffa07994 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -101,6 +101,7 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
+	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-- 
2.17.1

