Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE56ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65312086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5U10neE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65312086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeIQKJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35606 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQKJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so7050301pgf.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0XuvytDIZIPEY9+sAmEOOZCu/wM93HXYDHUd2QKgHW8=;
        b=r5U10neE2504arw92/UhGTbjWEN7/sxjMn1HXtujEC+FYbZhokIs6waQuKlv4kgBwv
         AA642IjB/3Hb4+nMM2r8cxWzPnYIr8Y3Lspm6N8KhcaivLLV6PsAkmOHYoK8RhV2Pw6+
         cfNrSOK4IVsP7nHFm3MXU+ZtbZ8qxvlenwO2yjNI7/fxjrYm7Qg9kBWYAUsZBkI51AKY
         69tsIRM3jVUpV0FFf3GgGLIQ7pyS7kvw/iApq/jYP8pxQZNyja2fk3haxpaJpPv6KPJb
         QsOqyhxWB//9otaUUpVLOxUJwoJife1XUTzIIv3mDLbZ8dtzb+KP+CEa5xanaDThmz/k
         iolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0XuvytDIZIPEY9+sAmEOOZCu/wM93HXYDHUd2QKgHW8=;
        b=evwUYOFlSCSLvglzuov9etQqY9WD9mc9gr0Hltn+wJXf2ANaYOnhtypH+LBgcWaRvH
         PP+jXCmv+dwrATo+oRe8tLzi3CPwYVl4gRMjAabIQd1+8ElylXq5Osy/NsOr9aLR+zDx
         jxizD0jEyR9Cv6C5yQx0PwdgdfEd7kMSKCeN/TuzgCCvvbNLH1DdQXtkexb7Rfzra+mA
         /0qT+WjDL5sZa+kkIxcflJ9hNfxYDhHS6X+sxZG5y7fNdjkbgFTEhwCrKt505E+Fx79a
         RbktYctnO4+ooNK6crAtGMKhV44Jf3uII4QlsuGIdbiUfJn3Z3m5TyzpI49786y66A8t
         MMmQ==
X-Gm-Message-State: APzg51COiSlYvSeYQv0iN0Hrn2PFDie+rIwa0PiT7tzHt6FSjCrY+hbQ
        ZMuej9xfmtz0hz9OA+22jOfqZu8Rd1o=
X-Google-Smtp-Source: ANB0VdaWAyvYUoe2450H1QlEHSN0NsRXhKdXKOLbyqF5RjQeHaJbtb9mdBuBVMu/jAicr0UA4EiGmA==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr24205682pfg.42.1537159438954;
        Sun, 16 Sep 2018 21:43:58 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:43:58 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
Date:   Mon, 17 Sep 2018 12:43:29 +0800
Message-Id: <20180917044333.30051-3-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel will set up the initial page table in the init_pg_dir.
However, it will create the final page table in the swapper_pg_dir
during the initialization process. We need to let __enable_mmu()
know which page table to use.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/head.S  | 19 +++++++++++--------
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c83a8c47e3f..de2aaea00bd2 100644
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

