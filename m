Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5377DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C3B2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMhFeFw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C3B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeGQK2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33756 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbeGQK2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so252921plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3VVPsCbTKnmEUV87ccS35kChskysrdX0+gD/3x+tZs=;
        b=cMhFeFw02rRh3B2UTVX4ucm/mIOero8p+tlPSfRrQfakc3lzmjigzdv4tVDH44QRt2
         zc32OXl1hkb2hgG1nWx7tCytm43BZ7allfimFsDw8VBSKjGatDUGwb5BTJAcQxWGpJux
         8R5WYqTlRCB7Evu1wTg/6qhL8QdYwnZnRxpjLytxZjhNLuLpuiUZb5wGcegY6CihNvPq
         wK+JJEC5fUmIzcJL5v2S/LzCKcucNfjV3U+9GkjyjUTBg44jFDrJZsVp/7D20zsmR6re
         F92zke/ueflBongGuZlHZ+wLUyzI0duMCkkMmJUSuDXdFU17igaduO4I5NsKsnAj1TpZ
         RKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C3VVPsCbTKnmEUV87ccS35kChskysrdX0+gD/3x+tZs=;
        b=droc8nW8pztWGtGmCZiH3n0KzhmGbC38g7QEpzAiyNpOBahwjusZ+g3wkVad6gIJAX
         xtIiFb1e1qMBJuIsbTLlKJnbU6r2BJbHFxDKLmbs2JQTQb8BIMhnAspup42QB9uy7HAE
         wkKLlXsGgikVMtXnbiGnfTkbbEL/1ydYtNvi0KX7DsD0ploqa3GUy2wCw9rLIfjImsDO
         allwslhHkkEbZie7x5jrdQo8UfJr6bA9fdNVY9HqDAvABoNCbTxMACWTbH3Sxv6pTDUW
         wXF0FzLeVeTDtr6PpQvAAzBB/vDgziPsoXkIhCWYL9nRlCiVxijGES37331X8iH/4rfG
         5sRg==
X-Gm-Message-State: AOUpUlGTMEyIhPj93qOdEFw2Wowj/5a4e5KSqaATkHB4evMQKnrI1+FU
        nkfGqB3EIz4Go57PiwoWZvM5zQ==
X-Google-Smtp-Source: AAOMgpfrt9JCN9Jns+KPGf8MFc49y8LzweCB/kFJO9z6dmEO63ZtCxTUtD1vSI3SWrpoigS0sG29ow==
X-Received: by 2002:a17:902:301:: with SMTP id 1-v6mr944978pld.127.1531821389206;
        Tue, 17 Jul 2018 02:56:29 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id u2-v6sm1232542pfn.59.2018.07.17.02.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:56:28 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
Date:   Tue, 17 Jul 2018 17:56:04 +0800
Message-Id: <20180717095608.11008-3-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __enable_mmu() take the physical address of the ttbr1 page as
an argument.

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

