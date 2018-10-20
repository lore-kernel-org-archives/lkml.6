Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9086C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 09:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4582150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 09:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlNi1uYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4582150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJTRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 13:41:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39981 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeJTRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 13:41:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so39810691wro.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHc11vhMARtDZs1nuQq2CZe5+fQS2/S7WpD2lg9m7dE=;
        b=GlNi1uYmhDH01oha5VpoEDlXkS+9sXfS1QZ7YVBYl0/ChpbVAY6/KIfPmejQBHajdg
         4aRm+4+lsXylljQMxui3sco61IFhyz9zLaBuEkM4T1e0j9OxyRGjfZaUdzG2IFP3R127
         zM//2HZ7X0oKvfUb6bLxANh29aLwWfQ2Wen0oJ3hmbfrmb5cg3loxYO7N68DRlvYA/Fv
         Bej7oZkl97oI4DEb6tdmxqJ8PBFpOdV77gE6MQxTlbxOd9QKJV9nYcW8QFxNEFVUwl3R
         CDiAqHhHhXO5O/sWEg5mk7rNZmHjiTzDEONxVn8Lw8F5EgNa7uKg09yXH1stI+EAQ4J8
         FofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHc11vhMARtDZs1nuQq2CZe5+fQS2/S7WpD2lg9m7dE=;
        b=rpxFRmc3imqBKjyss0zQZhXLs0vaIpgNdrbnNVDRAlsOJBmL+src4nPzVGRzf55CDk
         slLY6rHKdh/wt6awS27MpJKn+wOs6PXmWKlluEQityalE14Bcgq87IdluObuZOi5iaaa
         sK2KcxtFnKd/WoilZqzt7cGJyTRg6VtzUMpbmin1Pbtm+51RFM2OiufPSB1iEsoHug/i
         xpfsXovaEGg2x1T7dsLtIUdP3rdyV3c2WaHNZosaiw8vEY98g1iQ52Mb8WSH4yPbkm1r
         /Ed4rWKI2bZG39O4mbVA0u0zguVbFIr6qrSWkl/dNd3ryqUWZuYe0XajE5WPHvpIkoKW
         hLOw==
X-Gm-Message-State: AGRZ1gKmgxzXdvETVmTYmOrODQ3GFIixsSQlku8P58rjtAJRf2492lQb
        7lfGOoa7XLt14AZPpZWS/U0=
X-Google-Smtp-Source: AJdET5dDu1I6n5YU0IueK92NfF6c2yp5cCIStkItK9Gy+rcWhLh9+m1/m4vm/9zXzOU8FP8YtyAkJw==
X-Received: by 2002:a5d:524f:: with SMTP id p15-v6mr6494426wrv.192.1540027884657;
        Sat, 20 Oct 2018 02:31:24 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v76-v6sm7226030wmd.32.2018.10.20.02.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 02:31:24 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Ensure ELF appended dtb is relocated
Date:   Sat, 20 Oct 2018 12:31:00 +0300
Message-Id: <20181020093100.3810-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes booting with the combination of CONFIG_RELOCATABLE=y
and CONFIG_MIPS_ELF_APPENDED_DTB=y.

Sections that appear after the relocation table are not relocated
on system boot (except .bss, which has special handling).

With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
vmlinux ELF, so it must be relocated together with everything else.

Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/vmlinux.lds.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 971a504001c2..36f2e860ba3e 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -140,6 +140,13 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 #endif
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
+		*(.appended_dtb)
+		KEEP(*(.appended_dtb))
+	}
+#endif
+
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(4);
 
@@ -164,11 +171,6 @@ SECTIONS
 	__appended_dtb = .;
 	/* leave space for appended DTB */
 	. += 0x100000;
-#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
-	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
-		*(.appended_dtb)
-		KEEP(*(.appended_dtb))
-	}
 #endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
-- 
2.19.1

