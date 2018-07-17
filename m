Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F39720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6LG9rWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F39720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbeGQK21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40872 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbeGQK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so264098pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHMfmXYRt+NUeLDMJ3xqtsloMlEG5qTDwOuESNzHR1s=;
        b=h6LG9rWz359FaN46YcAWwn4DeIuLG9kN1XJ2UyhbeEHvOzmN7KxVUE/fT8kt1i4uXV
         9jbAEfbOHgBH6pJIkQun3xdG5YObzdLIRnxIGPmqSadX4WkeGMo1YYqnFTlrydmQr3k8
         uyqfJBM/gkOnU538G+8pAyIOV0pFE2PK1TAfFxuhiFp5OnJv+2pjzMWmsyH3bOa2RZZw
         z4aaUKtj2rv/EoTmowfh7n1iMtjd+8IISnpQk5GWXOEPC90/1Qd1DDVlFMi9fK7+2qG4
         NibgzZCkethO2IPgg16n5B+QZbj3KrEbXw3sNHsvUZdiLMKxQCzI4d+Tsz/IKIK45UBX
         FTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHMfmXYRt+NUeLDMJ3xqtsloMlEG5qTDwOuESNzHR1s=;
        b=QT+xeu+jNaQpdk4Ww5jEXbE81sbHwNdSutzERkcrE3hohnvNngMn7KzisIn7xCrYdh
         XzTBwc2A60zpk1SeTvPeNwjq2EV4/00VjLoH3C0ShGnXS4IzQJZQUQKwqPJq2L7YplWE
         wa4qU0StFyFCzDawsKQ5LpBStZu0J9UUy9WM3p2ErVCb8eagwsDbkwe/93lmVEpiEhKf
         W+RDSLpEPpP6i/Y5PaQVjI82A1Ii3KnbxfB2FcV8M4Aqntvv8a0lI7bn89e/L3ewbO4S
         R53mhAgIME6Y2rRr5jEZKJIfE6HtWHlLSuvBe+eLC1C6Te1bk2ht8leAciOIMNs52uHX
         Hs9g==
X-Gm-Message-State: AOUpUlFKyDBVKYzHENf0QAhlFOqflOmCsRnhqWLGdg718NJlpd8CvdkM
        wTA28Ovx4KtSfnOpUXQk84g=
X-Google-Smtp-Source: AAOMgpcWzYAD/tqCit7AWDlmZlhlq6HVBHHKDl3N/S6oWPQcbnQRQTyArl6IwuUJO4yT/AkQvI19Xg==
X-Received: by 2002:a63:5143:: with SMTP id r3-v6mr943559pgl.11.1531821398273;
        Tue, 17 Jul 2018 02:56:38 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id u2-v6sm1232542pfn.59.2018.07.17.02.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:56:37 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section
Date:   Tue, 17 Jul 2018 17:56:08 +0800
Message-Id: <20180717095608.11008-7-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move {idmap_pg_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir}
to .rodata section.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2446911f4262..142528a23b44 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -64,8 +64,13 @@ jiffies = jiffies_64;
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
 	__entry_tramp_text_end = .;
+
+#define TRAMP_PG_TABLE					\
+	tramp_pg_dir = .;				\
+	. += PAGE_SIZE;
 #else
 #define TRAMP_TEXT
+#define TRAMP_PG_TABLE
 #endif
 
 #define INIT_PG_TABLES					\
@@ -74,6 +79,24 @@ jiffies = jiffies_64;
 	. += SWAPPER_DIR_SIZE;                          \
 	init_pg_end = .;
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+#define RESERVED_PG_TABLE				\
+	reserved_ttbr0 = .;				\
+	. += RESERVED_TTBR0_SIZE;
+#else
+#define RESERVED_PG_TABLE
+#endif
+
+#define KERNEL_PG_TABLES				\
+	. = ALIGN(PAGE_SIZE);                           \
+	idmap_pg_dir = .;				\
+	. += IDMAP_DIR_SIZE;				\
+	TRAMP_PG_TABLE					\
+	RESERVED_PG_TABLE				\
+	swapper_pg_dir = .;				\
+	. += PAGE_SIZE;					\
+	swapper_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -143,6 +166,7 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
 	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
 	NOTES
+	KERNEL_PG_TABLES
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
@@ -224,21 +248,6 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
-#endif
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.17.1

