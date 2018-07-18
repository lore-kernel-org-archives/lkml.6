Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92C02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA+JVm3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92C02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGRKzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:55:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44334 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeGRKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:55:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so1793348pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uYu9QLz9hYIGDMOObzr/jqhbQLEAPHa0Z3aW2JR+lyc=;
        b=TA+JVm3WGH1f13xYYMd7TOUQRPOTAe6BmzqtDClADWFVug4/L4E5e5MZojLCVN7NNJ
         fdljckdLemc2yt26AdRy9F6tsRYxjUP107p2meYEDhnSeWUkImsAnlKkvK5MIcUj4Qw/
         9UGZc/4mpVGZjC7TIOQ6Ka3abv0t72oqD+OX2bnjD/pSib1KasF5quBMAzPo4K8TI6K5
         8loSXlKx6qZASkROIpA73/aHNEBvWhGAxtR86dyhaPeSB2enNoZhAjg7C05JZAfJOh7U
         KiY5yBOnQJMOZlU9YkP6pvH6QGeOHiWZ253fygGirodohuFSpo6xydsToMV984+x3pSH
         D4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uYu9QLz9hYIGDMOObzr/jqhbQLEAPHa0Z3aW2JR+lyc=;
        b=QabnzxEDtdj3rYFH+W1Jfb9DOrw7XADagquN6f+UtpNdo+4U0t0G8ltIqrrYI65R4v
         w2+78l5wmeM2TKzJR7H0ohQOjklVW8TyDNHT7mh5gjbkZDWEATzujk8MAFSeTOWPGJw8
         tzCLTIEII/79ixVDnsiQgb2Dnxf+9aFrb417nwMsfqYZQpJC5tN4bH/yNWVkwejo5GK6
         cNv0Oiq2qAb3A0TP+iIDRPOPo1Bnu1eZG+oWTUdmgJpY5IPtD2Rm8uZpjjoFyHkL9C2K
         OCfhwBHB2Cxnm09ksQjIBKQ2Fux26qXKAqOxdCBQBoXGncvSY26pBZK79u70nSG538WF
         V82Q==
X-Gm-Message-State: AOUpUlFQOQIwsJBQbpgGo4oJnrBX2FWJ0E355lU7FB0RBgL05/We2wbI
        DhsNXKlWzxNe2HbsvKr3q/5Rtg==
X-Google-Smtp-Source: AAOMgpew/GwDgqDZkdWBaT0fRJfKdl0gw7dHXEMo6gRdvXuSrE7PuGpVoi62e9mZ6vubUMhbfaq+5g==
X-Received: by 2002:a63:1c5f:: with SMTP id c31-v6mr5248882pgm.321.1531909078760;
        Wed, 18 Jul 2018 03:17:58 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id x2-v6sm6899518pgq.33.2018.07.18.03.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:17:58 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 1/6] arm64/mm: Introduce init_pg_dir
Date:   Wed, 18 Jul 2018 18:17:22 +0800
Message-Id: <20180718101727.10787-2-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add init_pg_dir to vmlinux.lds.S and boiler-plate
clearing/cleaning/invalidating it in head.S.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 22 +++++++++++++++-------
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..eb363a915c0e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	b.ne	9998b
 	.endm
 
+/*
+ * clear_page - clear one page
+ *
+ *	start:	page aligned virtual address
+ */
+	.macro clear_page, start:req
+9996:	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	tst	\start, #(PAGE_SIZE - 1)
+	b.ne	9996b
+	.endm
+
+/*
+ * clear_pages - clear contiguous pages
+ *
+ *	start, end: page aligend virtual addresses
+ */
+	.macro clear_pages, start:req, end:req
+	sub	\end, \end, \start
+	lsr	\end, \end, #(PAGE_SHIFT)
+9997:	cbz	\end, 9998f
+	clear_page \start
+	sub	\end, \end, #1
+	b	9997b
+9998:
+	.endm
+
 /*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..2c83a8c47e3f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -295,18 +295,21 @@ __create_page_tables:
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
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
+	clear_pages x0, x1
+
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	clear_pages x0, x1
 
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
@@ -395,6 +398,11 @@ __create_page_tables:
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
index 605d1b60469c..61d7cee3eaa6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,12 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define INIT_PG_TABLES					\
+	. = ALIGN(PAGE_SIZE);                           \
+	init_pg_dir = .;                                \
+	. += SWAPPER_DIR_SIZE;                          \
+	init_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -161,6 +167,8 @@ SECTIONS
 	__inittext_end = .;
 	__initdata_begin = .;
 
+	INIT_PG_TABLES
+
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
-- 
2.17.1

