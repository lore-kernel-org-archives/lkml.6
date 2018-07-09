Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDC9208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhQiCjIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDC9208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933433AbeGIXmb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:42:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41289 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeGIXm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:42:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so10120346pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8W7o3oy86/J1tw2fkmeq5q6MVz6b0M86D1KTHsBktO0=;
        b=AhQiCjIECu9/zR+qGwxkxxMbPAeEhXfW6JcXM7c8tO8hv3hjxw5j6hqk3NI/0fh1pR
         Ipau4mN/X8TVlnlkGexox5l0yIzeGGuL76zi7YwYBASTo3D5ld3h1RvJziSHyT2bj96q
         9FSjYqqw5B1RAYf39J0dwFJp/4LFBUUq7SJGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8W7o3oy86/J1tw2fkmeq5q6MVz6b0M86D1KTHsBktO0=;
        b=rwChBRLwBUWUjedhhJaUOpE+848WLsnYyXxtaJnpcF9PtzOSWsmgRCD7UdCCY7ScdK
         wimH0pRlxZNcT57D/wXuaU1wMi3UjTSKqwAfGxAKfXOtpsNQw+/wOJ3X6BjsRoDo/eik
         u+ble9AyCJYgMh6Irq4b9iwCwzTK+Zj4O9dW0PiaDb2vJRyvzoekGhRYWFE8WBlKkN2f
         R7gZRFIHuA9gyb7JEXwcJSErOm/c/ENsdBbBUyR2MRWQ4ihtx4N+3KZjFEWtzCYtZj82
         tCnBGBTMkVtm+lyg0vH4coMHt1B/6sS9wZkegOSoAdpayJOmj/flOIzIVPZsa8mcQ+WV
         NmnA==
X-Gm-Message-State: APt69E1a+9LsSho5P4ZWNlv3o7eo+tPlniLB2TygYT5BwZQAyobncVRe
        7EW1P83Cu24efHbpd5FV3SvtBQ==
X-Google-Smtp-Source: AAOMgpf5PksEoYErQkxaaGC0mSk94WnYjZWqgZvffO1iHon9mFUzUCXMa0JM/VKni+/Jp/2kRW51ww==
X-Received: by 2002:a63:4450:: with SMTP id t16-v6mr20567863pgk.102.1531179748487;
        Mon, 09 Jul 2018 16:42:28 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id u71-v6sm6896003pfk.174.2018.07.09.16.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:42:27 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3.1 4/4] arm64: acpi: fix alignment fault in accessing ACPI
Date:   Tue, 10 Jul 2018 08:42:29 +0900
Message-Id: <20180709234229.20181-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709234229.20181-1-takahiro.akashi@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix against the issue that crash dump kernel may hang up
during booting, which can happen on any ACPI-based system with "ACPI
Reclaim Memory."

(kernel messages after panic kicked off kdump)
	   (snip...)
	Bye!
	   (snip...)
	ACPI: Core revision 20170728
	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
	Internal error: Oops: 96000021 [#1] SMP
	Modules linked in:
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
	task: ffff000008d05180 task.stack: ffff000008cc0000
	PC is at acpi_ns_lookup+0x25c/0x3c0
	LR is at acpi_ds_load1_begin_op+0xa4/0x294
	   (snip...)
	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
	Call trace:
	   (snip...)
	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
	---[ end trace c46ed37f9651c58e ]---
	Kernel panic - not syncing: Fatal exception
	Rebooting in 10 seconds..

(diagnosis)
* This fault is a data abort, alignment fault (ESR=0x96000021)
  during reading out ACPI table.
* Initial ACPI tables are normally stored in system ram and marked as
  "ACPI Reclaim memory" by the firmware.
* After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
  memory as MEMBLOCK_NOMAP"), those regions are differently handled
  as they are "memblock-reserved", without NOMAP bit.
* So they are now excluded from device tree's "usable-memory-range"
  which kexec-tools determines based on a current view of /proc/iomem.
* When crash dump kernel boots up, it tries to accesses ACPI tables by
  mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
  since they are no longer part of mapped system ram.
* Given that ACPI accessor/helper functions are compiled in without
  unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
  any unaligned access to ACPI tables can cause a fatal panic.

With this patch, acpi_os_ioremap() always honors memory attribute
information provided by the firmware (EFI) and retaining cacheability
allows the kernel safe access to ACPI tables.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/acpi.h | 23 ++++++++++++++++-------
 arch/arm64/kernel/acpi.c      | 11 +++--------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 0db62a4cbce2..68bc18cb2b85 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,10 +12,12 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
 
 #include <asm/cputype.h>
+#include <asm/io.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
 
@@ -29,18 +31,22 @@
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
+
 /* ACPI table mapping after acpi_permanent_mmap is set */
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
+	/* For normal memory we already have a cacheable mapping. */
+	if (memblock_is_map_memory(phys))
+		return (void __iomem *)__phys_to_virt(phys);
+
 	/*
-	 * EFI's reserve_regions() call adds memory with the WB attribute
-	 * to memblock via early_init_dt_add_memory_arch().
+	 * We should still honor the memory's attribute here because
+	 * crash dump kernel possibly excludes some ACPI (reclaim)
+	 * regions from memblock list.
 	 */
-	if (!memblock_is_memory(phys))
-		return ioremap(phys, size);
-
-	return ioremap_cache(phys, size);
+	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
 }
 #define acpi_os_ioremap acpi_os_ioremap
 
@@ -129,7 +135,10 @@ static inline const char *acpi_get_enable_method(int cpu)
  * for compatibility.
  */
 #define acpi_disable_cmcff 1
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return __acpi_get_mem_attribute(addr);
+}
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7b09487ff8fb..ed46dc188b22 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -18,6 +18,7 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
 #include <linux/efi-bgrt.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -29,13 +30,9 @@
 
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
+#include <asm/pgtable.h>
 #include <asm/smp_plat.h>
 
-#ifdef CONFIG_ACPI_APEI
-# include <linux/efi.h>
-# include <asm/pgtable.h>
-#endif
-
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
 EXPORT_SYMBOL(acpi_disabled);
@@ -239,8 +236,7 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
-#ifdef CONFIG_ACPI_APEI
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 {
 	/*
 	 * According to "Table 8 Map: EFI memory types to AArch64 memory
@@ -261,4 +257,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
-#endif
-- 
2.17.0

