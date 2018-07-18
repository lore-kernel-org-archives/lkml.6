Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0254ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569A62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utMDSbIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569A62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeGRKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:55:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42549 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbeGRKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:55:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so1796060pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHMfmXYRt+NUeLDMJ3xqtsloMlEG5qTDwOuESNzHR1s=;
        b=utMDSbIQRRd7BMsq8U+tY8RQXqda5gROWSOFXUJyBrsriVoNSNYzgwr7aS3RvPiWeB
         2JsfmzObB4zMaVrCn7X6KVM6U5kBehgr98yKWiKzCUebYiYUeJ4rjC1tYEfcGGXHPEch
         cd7L2Xt65PCCIIa2wQbo+hxLX2JdgjWnS/U3C8oMk/Mhh3qiwKqQPkjxcDNVQvmIDfzS
         PGBdUevf0aU3Afuh6vU/9O+GmZcZOxVFdjQhMOEjfvhJWQfPO1Te9ofmOj5Jo+m5poqV
         DiEiVHVZlh0haQiuWP4FO9Gnm6VFD+kt/f7AxCHJ/x8YVKWCGuaocQ0+3svXPvABF3qb
         vRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHMfmXYRt+NUeLDMJ3xqtsloMlEG5qTDwOuESNzHR1s=;
        b=ELdmM3c7QGjK01XOQIBIB5NHJGMA1UuylNTD/za8fRTODgYXI5x2J7MIlkva+FoJyc
         Bdt/TXLacGsPMC+RTHUhDfJTMinUPPAKaFt/LsmElbQPPGYF+m76ditFSPzoJXT5vwyE
         hOHTM8HPSt6CN89T/0mAo05iAmyQn52wfs00io2dGZWKbYq2lXMIo2rhwmtOrYE+GN7B
         zCzrwKATouZIjVjOUlvpqVRS/Uzr6FKrux7KPLA/sB91FJMJmpNu76Aq1wo8wPzF6gGf
         UgrYZQNBcP+Ow/L/N9LlSiDZSKo74UK67GprC/9ehjNiLW9Ios4AJim7rdWnaLfuFkmS
         oSOg==
X-Gm-Message-State: AOUpUlEV1UFO2lUmvMaR1pUL7O82il84F8k2f0zO5zxKXxUMxS7r2tT+
        08GgwVYTMf3WwG7U5cGIXQc=
X-Google-Smtp-Source: AAOMgpeECIz/SAQKfIgtI1wS4ZtPvWip8TNcEQ2TftMWsfi9Fdmfv8iNZwijNBIUXyHOukXnRF0hCA==
X-Received: by 2002:a62:9042:: with SMTP id a63-v6mr4627849pfe.52.1531909089875;
        Wed, 18 Jul 2018 03:18:09 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id x2-v6sm6899518pgq.33.2018.07.18.03.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:18:09 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 6/6] arm64/mm: Move
Date:   Wed, 18 Jul 2018 18:17:27 +0800
Message-Id: <20180718101727.10787-7-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
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

