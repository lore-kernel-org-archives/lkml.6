Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307C02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTaMoOvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307C02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJ3Int (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36084 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Ins (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id z17-v6so4684238pgv.3;
        Mon, 29 Oct 2018 16:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fU/03j6hWRyu9xAaSEpO9kPy+MSb5qCckFcBZmMx+bY=;
        b=hTaMoOvk6uRPCTs5sir3RKYA+OAF3jlRfZAq1m48fxSAozlUi6oQ3gnEbmRn/ZcYRm
         2OZlfoLmw3YCaywb8j0+J9xpkRWhCe/wabDZzikx5R4JtOgRY7QNN7FlRSn9lZ2PEWDu
         djKWE9N3lU8qVfoEFixfA8mYhSz3sGk1o8XoGmHkfr4eMuwVKgRTYspKKjcWNQT6BWdf
         Mi0EzAfxGcrD3CWHsm49Ai74l3F8Hg3Fqlq9c+ja9NLKM7s6jsozk4FtMAex7KGGc3wC
         6rRKaaqZ11hgwfGanhmwznFzD7dvqD5wTEsIqVw8ETgGdo/8hw7TuskIbgdKZtzu9hd2
         DVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fU/03j6hWRyu9xAaSEpO9kPy+MSb5qCckFcBZmMx+bY=;
        b=ZwE8p4lydkkoVLvwk/zwghCGLfzv1bRX0dczpeMicnCLvRZkRbi5ZAn5C6AnpahF7B
         UUlkm3A86a5ze0Ci2CwYsDeCiTUObnmAg5IhvwCjOCv1G9kHXJwcsGgE+QhEBWyxuJuH
         /Qd8Xnkge7XoXK7N9pQA+WEoWsOZGAo5zutMmWfxQ9KAxdbbmXvFaa8U6gwv/HEW9kaq
         8xhjFeT/Ow1AvNHhZ+x4vDjKlAxrhiwJODy+m3Q51K8GfR83gKtCcwyD0SnxoGPaYa/c
         F2SciNWkj3RcIazVdwf6NVPAFOo8h+Je4iLS/bsypo5fFj1SuVQBKhmb4Ey+9b1SqF1o
         73aw==
X-Gm-Message-State: AGRZ1gJIDnFnc+RUratE3U2dUuAdcSR3qubAVHPyeX+Xz+zWv7bJe+nY
        Qs8s9sSOnT3idPSja38iKiWGTUI9
X-Google-Smtp-Source: AJdET5eHSYsttLAS3SM9hiiHEDvnZ6ilH9qmF6+vipuY0cF622QYjwqgrSyt8Uha2YUYRx0M29GeKw==
X-Received: by 2002:a62:8c93:: with SMTP id m141-v6mr460947pfd.239.1540857163842;
        Mon, 29 Oct 2018 16:52:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:42 -0700 (PDT)
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
        ard.biesheuvel@linaro.org
Subject: [PATCH 5/6] arm64: Utilize ARCH_HAS_PHYS_INITRD
Date:   Mon, 29 Oct 2018 16:52:05 -0700
Message-Id: <20181029235206.30060-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029235206.30060-1-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and select ARCH_HAS_PHYS_INITRD which would do that for
us.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 23 +++++++++++------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 964f682a2b7b..302fb721d412 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -21,6 +21,7 @@ config ARM64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_PHYS_INITRD
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3cf87341859f..fef9eb7fdb50 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,6 +61,8 @@
  */
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
+phys_addr_t phys_initrd_start __initdata;
+unsigned long phys_initrd_size __initdata;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
@@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_size = size;
 	}
 	return 0;
 }
@@ -408,14 +410,14 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		u64 base = phys_initrd_start & PAGE_MASK;
+		u64 size = PAGE_ALIGN(phys_initrd_size);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -460,13 +462,10 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
-	}
+	/* the generic initrd code expects virtual addresses */
+	initrd_start = __phys_to_virt(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size;
+	initrd_below_start_ok = 0;
 #endif
 
 	early_init_fdt_scan_reserved_mem();
-- 
2.17.1

