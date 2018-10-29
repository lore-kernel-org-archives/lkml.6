Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6512084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrpn5ZdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6512084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJ3ENh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:13:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46785 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeJ3ENg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:13:36 -0400
Received: by mail-yb1-f193.google.com with SMTP id f15-v6so3453634ybq.13;
        Mon, 29 Oct 2018 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHTYtlDQysopH/0k213hDNMRKYTEPiF5GpZvkqXkLyQ=;
        b=Hrpn5ZdKlJRLhFupDCCpMwHTAFQEz0zJ6xVM1l4ESQStAsj9QwF2Q+5pFiznntWV2P
         8bPD88SwLYQbcRUsTxLqvXnX9Fuui4iDSbcMTGmCbdfMFfVVOBPoqP3dgHIN5II43CpN
         vohAWgB3X1jB4Vbme463Mec2t6cQvwZlEVEMZouVVRfcEgyO1tTDcLfDfeUIN0FF5KdF
         BgQuuW4xjjB2Q0Kpb3HtRt0RBmfpcY7q3TofXjBXgGpHcs2IfG7OuD0cUqla1jvZlbaa
         yrhiHuJdfeG5SW5I3dCJAKGRB07S1owLP7yue7SwFpJTVXla+FHTfdcAAD2ytMopOZmn
         lDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHTYtlDQysopH/0k213hDNMRKYTEPiF5GpZvkqXkLyQ=;
        b=fubZem/khVdjaKsowloGImP3v+prwwJaPV03aYDwIwNvhJPhJ4AaW+8oSfoDYaUQfi
         eZ26wcd82jl5ZKodnLIIbvflotIIkr0lKNsiIktUEXwNO5rmPsG+PVF0KQaGim4EweJS
         IUUM7/3c/1FAPs5SADWlhHKI/8thTlrX75mG7NkYHXcPmlzGqFGZnPV262e+PRaNk3QW
         IzlS0CVys5toz+9GWRHjWUVlc+OdkT8LMjfn3ftn5Vp2rJf7GTxVnYqLN9vzjyu3ttwC
         xBKWb1A4pU3/1hPsrp3q0pv+E3YeXq2igayxrP1z8hTB/HnJHN8YpZdeMgYFPSk+nBH2
         bWRg==
X-Gm-Message-State: AGRZ1gIDfH5+zhjT075lbZNJly3hmv4s0sxlEdo6OSaXjxN2xd9Cib3J
        wOPpSHuOXBQ2HsgwebQOtSv34rCi
X-Google-Smtp-Source: AJdET5c0VsDtIxa10FRnWYrRAA+5kbaGIwFIXC9+c9puXVAKyWcvY/OAKYhQEKCTwrf2c+gIVYLV2g==
X-Received: by 2002:a25:b43:: with SMTP id 64-v6mr15101073ybl.133.1540841012023;
        Mon, 29 Oct 2018 12:23:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k85-v6sm5410014ywa.76.2018.10.29.12.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:23:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
        DEVICE TREE), linux@armlinux.org.uk
Subject: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Mon, 29 Oct 2018 12:00:13 -0700
Message-Id: <20181029190014.6455-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029190014.6455-1-f.fainelli@gmail.com>
References: <20181029190014.6455-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and perform the virtual to physical conversion of these
addresses in arm64_memblock_init() where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h |  8 -------
 arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 23 deletions(-)

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
index 3cf87341859f..292570b08f85 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,6 +62,8 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
+static phys_addr_t phys_initrd_start, phys_initrd_end;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
@@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_end = start + size;
 	}
 	return 0;
 }
@@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	u64 __maybe_unused base, size;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	    (initrd_start || phys_initrd_start)) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		if (phys_initrd_start) {
+			/* Command line specified the initrd location */
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = __phys_to_virt(phys_initrd_end);
+		} else if (initrd_start) {
+			/* FDT specified the initrd location */
+			phys_initrd_start = __pa(initrd_start);
+			phys_initrd_end = __pa(initrd_end);
+		}
+
+		base = phys_initrd_start & PAGE_MASK;
+		size = PAGE_ALIGN(phys_initrd_end - phys_initrd_start);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -434,6 +448,13 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+
+			/*
+			 * initrd_below_start_ok can be changed by
+			 * __early_init_dt_declare_initrd(), set it back to what
+			 * we want here.
+			 */
+			initrd_below_start_ok = 0;
 		}
 	}
 
@@ -455,19 +476,10 @@ void __init arm64_memblock_init(void)
 	}
 
 	/*
-	 * Register the kernel text, kernel data, initrd, and initial
+	 * Register the kernel text, kernel data and initial
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
-	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1

