Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C22081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO8QIlU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8C22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeKFIUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:20:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38639 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbeKFIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:20:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so5142944pfi.5;
        Mon, 05 Nov 2018 14:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N5C/Dk/32TAReMlAu4r3WfZ0cG0xx4/p3LhGJUIezOA=;
        b=iO8QIlU2AdfzSk8vfmSS1vkrdmjdB0U0lTL6ss1pW6/TAQyzC+9m+8rfZaB+a/plyX
         n7hn1W8V4B/kapQSwG9f81qmfpPXCnl6MAAOkpFfroDwTWyeEMokDxf6DP81hlQ6SxCS
         1ki3NCO4zjBYn3cXyq0MeAocZMY0QiLhgP/qcgF9sHKyIP4GZVk37p/Y2id5XihGKFWg
         /h6tYeMoaydILMv+F+Ep2Yec6wak642cNb1yvNPLE2WtpBLcZZaSPT7SKQcatkBr7zxC
         U+9BMBkUj3F4JWFGwHRGyZgQ4sP0kkUDEJe/qO08vhp/JvnQjS2FvfDNu8GeUmLsQG+R
         O+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N5C/Dk/32TAReMlAu4r3WfZ0cG0xx4/p3LhGJUIezOA=;
        b=Ts0E6Nfy45xR6UhLLZ+Yy2Fq5n37Mv9EC5wk4P1k65nLum5jE9+CpJQNWVUgreiVve
         MkrXXtW6Zev2kt8R3a3+fNOcS3MkTINr75pc0sPOm1AqZ5NDBYkKo5iwaA168LdLu09G
         z2qVm1zBH1hRadgOr9NKTIAbi0Sg1urcEDfkGkcf6/AsFvLxhmn8xAfnZygveSlj22MC
         8tdiK86kWZsMTGzJ2KyDvZRnnXgwAlTPyGg91W6KTlgOk7yfL4EAJE5R2g3HvYylyiH6
         WfMTU9BIFh7A+81NjYkQIlie6JK3K4gh2khrol8cLew81m4BgN+e8GWkiamOIcjnmBBm
         riHw==
X-Gm-Message-State: AGRZ1gL/4CGNoEeB0zYQV8R79+BCpW7X67kshWHfbIiEaai0uTIYrQhD
        rnh2HwnkU2SqehQ+f+6kc1ypH/BS
X-Google-Smtp-Source: AJdET5eYY+m1nQl01vIFU8Xe0gXFoLHQjVrEKByv775fh1TR9lRHUuzS0+/uWutUxzE+WkkempUBUg==
X-Received: by 2002:a63:e749:: with SMTP id j9-v6mr21340677pgk.246.1541458687607;
        Mon, 05 Nov 2018 14:58:07 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:58:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v4 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
Date:   Mon,  5 Nov 2018 14:54:31 -0800
Message-Id: <20181105225431.24485-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC, ARM, ARM64 and Unicore32 are all capable of parsing the "initrd="
command line parameter to allow specifying the physical address and size
of an initrd. Move that parsing into init/do_mounts_initrd.c such that
we no longer duplicate that logic.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arc/mm/init.c       | 25 +++++--------------------
 arch/arm/mm/init.c       | 17 -----------------
 arch/arm64/mm/init.c     | 18 ------------------
 arch/unicore32/mm/init.c | 18 ------------------
 init/do_mounts_initrd.c  | 17 +++++++++++++++++
 5 files changed, 22 insertions(+), 73 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index f8fe5668b30f..43bf4c3a1290 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -78,24 +78,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 		base, TO_MB(size), !in_use ? "Not used":"");
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(start + size);
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 /*
  * First memory setup routine called from setup_arch()
  * 1. setup swapper's mm @init_mm
@@ -140,8 +122,11 @@ void __init setup_arch_memory(void)
 	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
+	if (phys_initrd_size) {
+		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		initrd_start = (unsigned long)__va(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
+	}
 #endif
 
 	early_init_fdt_reserve_self();
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a3b6f1f1cbaf..478ea8b7db87 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -51,23 +51,6 @@ unsigned long __init __clear_cr(unsigned long mask)
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	phys_addr_t start;
-	unsigned long size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-
 static int __init parse_tag_initrd(const struct tag *tag)
 {
 	pr_warn("ATAG_INITRD is deprecated; "
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a66ffcde5f13..7474093363bc 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,24 +61,6 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 02aa2c0b295e..85ef2c624090 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -30,24 +30,6 @@
 
 #include "mm.h"
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 /*
  * This keeps memory configuration data used by a couple memory
  * initialization functions, as well as show_mem() for the skipping
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 45865b72f4ea..732d21f4a637 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -27,6 +27,23 @@ static int __init no_initrd(char *str)
 
 __setup("noinitrd", no_initrd);
 
+static int __init early_initrd(char *p)
+{
+	phys_addr_t start;
+	unsigned long size;
+	char *endp;
+
+	start = memparse(p, &endp);
+	if (*endp == ',') {
+		size = memparse(endp + 1, NULL);
+
+		phys_initrd_start = start;
+		phys_initrd_size = size;
+	}
+	return 0;
+}
+early_param("initrd", early_initrd);
+
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
-- 
2.17.1

