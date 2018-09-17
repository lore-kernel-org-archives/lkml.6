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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C86ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86A214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWPa7lnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C86A214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeIQKJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35149 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so6805376plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C2IPggZWJw23xtNz6miFjfiCvmiToIusZWIrnQ3xks4=;
        b=fWPa7lnIHArkOlvyUHOBhX162dTRAAoUF1oYwLOfhNp4+eXPtrop6geXUOQq5a+5lF
         ILAeGyhhikrRlbk6CAF4iDSeCGgIyrHttdQu4U+wXxR0BU3Fukrau3Ds9AEDrgsmoVW/
         CSUZpR/bkN7JXIVawSLa0pUhIB55mGM7/KaCUO5ZFs/WEkfyxtopugHUnQqSlVZuS48C
         YhvPgrPOhhmMb4trAYIU0GQJbDqa7Um5cNEIvO3vMcSb+Pecx5vyDCO1WYYMnqBakfkw
         cTc9un74lUjoWBLTOVvpv5rSZM6sKFjIErU9+pr53y75FCclZNxSJrQUvBJGQtxL9uX3
         Nykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C2IPggZWJw23xtNz6miFjfiCvmiToIusZWIrnQ3xks4=;
        b=COHzLUCy9jGOwO6PqEqJ5IbXf0j5yrhuoOQwREcHjeW2WKtp7qg7OZ4lRStXwAf6sN
         N7Je0pLDQ79j6F+z47mqR5tB4a+tv+X5OXdN9IEqXWkIEqjZeYdXbs82L35hjyf8x0SA
         +ZK9W7rkoYN2+jUqZ3sDnVOr3WQiUjwptS9cDHGdTY1/jAoENPmvO/CcHNDJyjzR5UxS
         qU5J3ty+1cvlCXen/0P2BA0ZcEOZue7gp+qYwPQel3/AErTRZzcgcq/Ao2X4iCmN5Tia
         4vUYahULpHGyj9IOdepLuvHfpZYguukcd9tb2f+Y565LEtUnYm3NCiH2gWbTc0tdc39j
         Dhew==
X-Gm-Message-State: APzg51CfCoU0SzRtGI8dOb/3dv5OJKvQaMAHkhy+//dvEXLazNCxVIoj
        tNXH+XqLoX4X8ciL9G6d04I=
X-Google-Smtp-Source: ANB0Vdb/WrmyS2PfMv5YT+CKO8vyh2DpkhRvLPFqb8KZHXF/5n7JJuR3RMJi3Hek5n5dLEomLFWVkg==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3-v6mr22798945plk.246.1537159434789;
        Sun, 16 Sep 2018 21:43:54 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:43:54 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] arm64/mm: Introduce the init_pg_dir.
Date:   Mon, 17 Sep 2018 12:43:28 +0800
Message-Id: <20180917044333.30051-2-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the swapper_pg_dir read only, we will move it to the rodata
section. And force the kernel to set up the initial page table in
the init_pg_dir. After generating all levels page table, we copy
only the top level into the swapper_pg_dir during paging_init().

In this patch, just add the init_pg_dir to vmlinux.lds.S and
boiler-plate clearing/cleaning/invalidating it in head.S.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 22 +++++++++++++++-------
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..e7bdc324d538 100644
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
+ *	start, end:	page aligned virtual addresses
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
index 605d1b60469c..612ffc0bbe11 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,12 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define INIT_PG_TABLES					\
+	. = ALIGN(PAGE_SIZE);				\
+	init_pg_dir = .;				\
+	. += SWAPPER_DIR_SIZE;				\
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

