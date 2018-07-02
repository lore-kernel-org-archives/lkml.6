Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2328C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648C925524
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmM2Tn2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648C925524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGBLRe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:17:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42321 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbeGBLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:17:25 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so7009597pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TD8Q4iC+usD3cHPACbg0jcP6zmu4NFsRN6oV6XSzc/c=;
        b=dmM2Tn2QTZPsHUL9tCXAe2QpqolgjZF9zTyib4kg/49AKyOkgvRAt2S4gIWnyt+8of
         pYEQ2N/S0zeUFqLmyGb2/rlnYjc+b7f2Yhq+Mo26YoY2D0P/DXhn5e/DLBYrTJnP/PbN
         Lr2rZfWZOE6OweV0lHGhEJlqjw8m4cPgHqfjNjE/k6mUfSz0suMU2bCqqFxh8yOdVyUc
         fkGRxCqDhbp/o29lqCxvhVe2CxCzChE+/QLE+CRxaa0c3tvMTi71OwAzSb40tfZyGhHR
         cVvtn+S7vADaD86+nc21PUS47eKfuoA382WNjbMHCifYYX/RgrKSR4jb4Skmmc/HxgHo
         Hrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TD8Q4iC+usD3cHPACbg0jcP6zmu4NFsRN6oV6XSzc/c=;
        b=FV2kskuYcDpIJkrnzahwDBR1W7sNhf7txKdRbOWrIWn46ClKyC2Rr1STXQZjOgDE07
         EZzMReq6vE3HrI0RHbVvClUPx1lhL+lsXjVcxb+SdySRgKFahljO8aw6H91ntGJcLmpY
         DmR0PlNMkeFVq/QBkJ5jClXLNuHCzwmm0YHbVOHcIODEcPlxIvvTsDPHs7qWlLOvpuDo
         Zr6FTnxpNLBKm4guVU48zXo9LtRnIxjPG1ztr60JvYDjZrchtffiutCjGWXibfNGOhc3
         7ZWdF6+3K4ubG2+68rE1AcsjwRCJstlwFhVtqWP4WSJLLi0Z7QREu4qhXZ/hp4V6KXDj
         7ZrQ==
X-Gm-Message-State: APt69E1LoBIgRRdGGQLG0TuSN1GUCdVXgDYFXC4wnsozUN0uFa0TrK6/
        hv5SWeayZ3ftv9HsSyA/6RaqHw==
X-Google-Smtp-Source: AAOMgpfaoRpeSP1jwCvHa6ypi4HlnQxqNDcGc++Y6MhKIJf+vgci2KxR7ny1AT0evZM98fd45VxFrg==
X-Received: by 2002:a62:9c9c:: with SMTP id u28-v6mr25119634pfk.90.1530530245334;
        Mon, 02 Jul 2018 04:17:25 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s2-v6sm11262150pfh.186.2018.07.02.04.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:17:24 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] arm64/mm: Introduce init_pg_dir
Date:   Mon,  2 Jul 2018 19:16:55 +0800
Message-Id: <20180702111659.25570-2-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add init_pg_dir to vmlinux.lds.S and boiler-plate
clearing/cleaning/invalidating it in head.S.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/assembler.h | 23 +++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 24 ++++++++++++++++++------
 arch/arm64/kernel/vmlinux.lds.S    |  7 +++++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..414fb167e3e7 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -456,6 +456,29 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	b.ne	9998b
 	.endm
 
+/*
+ * clear_page - clear one page
+ */
+	.macro clear_page, start:req
+9996:	stp     xzr, xzr, [\start], #16
+	stp     xzr, xzr, [\start], #16
+	stp     xzr, xzr, [\start], #16
+	stp     xzr, xzr, [\start], #16
+	tst	\start, #(PAGE_SIZE - 1)
+	b.ne    9996b
+	.endm
+
+/*
+ * clear_pages - clear contiguous pages
+ */
+	.macro clear_pages, start:req, count:req
+9997:	cbz	\count, 9998f
+	clear_page \start
+	sub	\count, \count, #1
+	b	9997b
+9998:
+	.endm
+
 /*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..3f99c59ba193 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -295,18 +295,25 @@ __create_page_tables:
 	sub	x1, x1, x0
 	bl	__inval_dcache_area
 
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
 	/*
 	 * Clear the idmap and swapper page tables.
 	 */
 	adrp	x0, idmap_pg_dir
 	adrp	x1, swapper_pg_end
 	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
+	lsr	x1, x1, #(PAGE_SHIFT)
+	clear_pages x0, x1
+
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	lsr	x1, x1, #(PAGE_SHIFT)
+	clear_pages x0, x1
 
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
@@ -395,6 +402,11 @@ __create_page_tables:
 	dmb	sy
 	bl	__inval_dcache_area
 
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
 	ret	x28
 ENDPROC(__create_page_tables)
 	.ltorg
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..d4fc68286a49 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,12 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define INIT_DIR					\
+	. = ALIGN(PAGE_SIZE);                           \
+	init_pg_dir = .;                                \
+	. += SWAPPER_DIR_SIZE;                          \
+	init_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -168,6 +174,7 @@ SECTIONS
 		CON_INITCALL
 		SECURITY_INITCALL
 		INIT_RAM_FS
+		INIT_DIR
 		*(.init.rodata.* .init.bss)	/* from the EFI stub */
 	}
 	.exit.data : {
-- 
2.17.1

