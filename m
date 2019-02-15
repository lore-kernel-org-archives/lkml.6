Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2152192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or0Bgq02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394688AbfBOMfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:35:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40214 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfBOMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:35:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so10165413wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9XvbP3q/Notg42vlwN25xZrwhT5Enb4lH/EsK0IncY=;
        b=Or0Bgq02ZY0qWqKiUkzPKNov6a/Q4YjPvl3EGGQc5U3Kb08erVsAndV9zUC1DM2985
         YRD5HtKTFwHzSw5q3yHyGONIFaq6Dvgp8tF4JVybWWSWxYDPXP3krYM62JroTbagB47j
         f6X8KxSUCvVJgoWHNa6+u2FdHEI1A+TezX3Tz1CTpQ2iFNKJMnJcK8lbVCz10jEexjEc
         I6+OJnQ69wwk8bzqdDW8WAIVldCPyCj/NgDSHIcQah4hagCExU7djTMgKFEDEl9Q/7rW
         eIBuIjBfkroSw0TNJTc/G+vKNoDyzYhIE+ORcH5wOp4k3BB5BuuBiQ+l1Yr3LDEjgN3c
         sAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9XvbP3q/Notg42vlwN25xZrwhT5Enb4lH/EsK0IncY=;
        b=hpX2ZJVc7RuisE4KGpibNqCoXdhkM5LcN8HGpR3UBkIQqRCsyMreYFo05APaExBLGR
         XjycNdyaYKT864x17rmkMIDWMJRmK/89WuiyP5bpaji2K+OpSKtN9LsezAjOvsn4xH0M
         9LgcZcyM6lx8AbcxYcDI4wcDzoNh0wbhnfMg1GommewQJc5smTcY7DB+CwQlHUyvp9IB
         4VDjar0Utkbz25AstVDNGQwFXr+kDwuyJk9AMP4niyXvtcVfv4NSHkA2dh3PvzVHObqJ
         heLpGxEbBCfMgvW5uvoGCVKkHFWwgqGPeSE6fEzRxEhooPOq0SNIoq6AoDeUPuj3fRDY
         nFgg==
X-Gm-Message-State: AHQUAuZG50DgqB3J3vZz5uXRwlIq3bvGzdrligNkySW3fKMkQSTBIbqH
        S5KkThcCxF9UT4NVcC/KHCCdCA==
X-Google-Smtp-Source: AHgI3Ia0V0oIs9whIxqvFzynyPSYDBBbEeYAogPOVKTT+A0weNNJxri66roozxRtk3RqOD44fgI1Ug==
X-Received: by 2002:a5d:6810:: with SMTP id w16mr6703382wru.62.1550234110537;
        Fri, 15 Feb 2019 04:35:10 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y13sm636673wrw.31.2019.02.15.04.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 04:35:09 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] arm64: account for GICv3 LPI tables in static memblock reserve table
Date:   Fri, 15 Feb 2019 13:33:32 +0100
Message-Id: <20190215123333.21209-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
References: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the irqchip and EFI code, we have what basically amounts to a quirk
to work around a peculiarity in the GICv3 architecture, which permits
the system memory address of LPI tables to be programmable only once
after a CPU reset. This means kexec kernels must use the same memory
as the first kernel, and thus ensure that this memory has not been
given out for other purposes by the time the ITS init code runs, which
is not very early for secondary CPUs.

On systems with many CPUs, these reservations could overflow the
memblock reservation table, and this was addressed in commit
eff896288872 ("efi/arm: Defer persistent reservations until after
paging_init()"). However, this turns out to have made things worse,
since the allocation of page tables and heap space for the resized
memblock reservation table itself may overwrite the regions we are
attempting to reserve, which may cause all kinds of corruption,
also considering that the ITS will still be poking bits into that
memory in response to incoming MSIs.

So instead, let's grow the static memblock reservation table on such
systems so it can accommodate these reservations at an earlier time.
This will permit us to revert the above commit in a subsequent patch.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 include/linux/memblock.h        |  3 ---
 mm/memblock.c                   | 10 ++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e1ec947e7c0c..ada877f56551 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -332,6 +332,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_addr_valid(kaddr)		\
 	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
+/*
+ * Given that the GIC architecture permits ITS implementations that can only be
+ * configured with a LPI table address once, GICv3 systems with many CPUs may
+ * end up reserving a lot of different regions after a kexec for their LPI
+ * tables (one per CPU), as we are forced to reuse the same memory after kexec
+ * (and thus reserve it persistently with EFI beforehand)
+ */
+#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
+#define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
+#endif
+
 #include <asm-generic/memory_model.h>
 
 #endif
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 64c41cf45590..859b55b66db2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -29,9 +29,6 @@ extern unsigned long max_pfn;
  */
 extern unsigned long long max_possible_pfn;
 
-#define INIT_MEMBLOCK_REGIONS	128
-#define INIT_PHYSMEM_REGIONS	4
-
 /**
  * enum memblock_flags - definition of memory region attributes
  * @MEMBLOCK_NONE: no special request
diff --git a/mm/memblock.c b/mm/memblock.c
index 022d4cbb3618..a526c3ab8390 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -26,6 +26,12 @@
 
 #include "internal.h"
 
+#define INIT_MEMBLOCK_REGIONS		128
+#define INIT_PHYSMEM_REGIONS		4
+#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
+#define INIT_MEMBLOCK_RESERVED_REGIONS	INIT_MEMBLOCK_REGIONS
+#endif
+
 /**
  * DOC: memblock overview
  *
@@ -92,7 +98,7 @@ unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
-static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
+static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
 #endif
@@ -105,7 +111,7 @@ struct memblock memblock __initdata_memblock = {
 
 	.reserved.regions	= memblock_reserved_init_regions,
 	.reserved.cnt		= 1,	/* empty dummy entry */
-	.reserved.max		= INIT_MEMBLOCK_REGIONS,
+	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
 	.reserved.name		= "reserved",
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
-- 
2.20.1

