Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DFFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CCD2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550401175;
	bh=nJ3x3ZMB0vVBfnJozZaP3YeOeHftY2uGqyuZkKAdMTI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WeR/vWEqNIdQf3SGWa9PfHziaW5QSVjDaRSRrRjwpp/OmcUKTgTVWMyYPJA6J3OqC
	 Fc0Aw/pc3C1aR2P9kV4xh3+6jxrasZvlz4lUjb12UIjprKK8w/IqThh/BHNJ4p3ot/
	 SX4mMkBDpaQEx1pMs8boyPr5/mAauXEZkrhXQ/kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfBQK7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 05:59:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40381 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBQK7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 05:59:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so5972394wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KOnvY4rBE3OfVO8r8hiq/6HbmlF91yCnVrRDyDXoNfw=;
        b=bHiy+zfuGUIAlCxexo1g1moW+3P0oNHhUirTt1w3pg4ElzoH3SAix5ff5ISQ4akOsf
         hzBqIPpa0Fxkq1jS7HPfxGeqLbBUHE+Sn3Blb2PgMVRZnqKejKs/Qf3K8QtxlibCQWkF
         tiIPUz0nK1I+AwNN60n+vnNoEn2VQNnLg2M28+IJy4nhoYe3pz5A+CXV4pRrQ3f0A/7C
         wPdy+Fq8V2ygbGbH6Z3PjG85lP5Rs24/U4ssJ5m8byqyvEF4nREcyOB+iv8PWGxiJOsQ
         gjY0r98BFXiYvaItRTu66w4esOt7Q1jJtyaEDCh2ACojepjzbBF4J5lpK/vmBL1Guu/y
         HAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=KOnvY4rBE3OfVO8r8hiq/6HbmlF91yCnVrRDyDXoNfw=;
        b=akQqs5znX1GuZUM46F37n4bV7wLmzl5+HJCINa/gfgDOiQl/Qo6QYLY1jFhWlmCuuy
         9b49Rc6Q2eIOxbQ8rHGo1G33JkU6fwCJ1uffvTEvaPPHavj/cF3V9+DeUBJ8IItL65yD
         r1CUyzL3P9hz0kpR903/qd07WUscpaMxRjhPgge2pWeL6hMnYd/H9bzFl4oawBpOcJSx
         fTqnLvy0FQuyu4hCpGXLin+JG4ZUXwKU1Ib+kbA5Tll2GH5SPrnlRr77RovrwfkQcn7I
         3K2NdkAgW0ZEwvsobJyvN5rHHOJJbuYdsUAI0epQna9y5p3ewih3XmlvFgf4fkd2gA0s
         c/Wg==
X-Gm-Message-State: AHQUAuahPx/n5rc/d99uFlfYXQb+LPScEcLDdkKhQor5NZJigI3TtMAI
        GIPQJ8KbKJrru4dOc2nod3A=
X-Google-Smtp-Source: AHgI3IYyDy5e+qd4If+sVqQ52LBKB/gbad9D0wBNcQmh9hsFqXwvNEbwjs8Si8imnLV8OHB17pEwJQ==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr12208696wmb.92.1550401169834;
        Sun, 17 Feb 2019 02:59:29 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 2sm24064694wrg.89.2019.02.17.02.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 02:59:29 -0800 (PST)
Date:   Sun, 17 Feb 2019 11:59:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [RFC GIT PULL] EFI fixes, memblock quirk
Message-ID: <20190217105926.GA69415@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 582a32e708823e5957fd73ccd78dc4a9e49d21ea efi/arm: Revert "Defer persistent reservations until after paging_init()"

This tree reverts a GICv3 commit (which was broken) and fixes it in 
another way, by adding a memblock build-time entries quirk for ARM64.

I marked it RFC: please have a second look at the mm/memblock.c change, 
which adds a INIT_MEMBLOCK_RESERVED_REGIONS detour that ARM64 takes for 
these systems.

Perhaps we should upgrade the build time sizing of all platforms to 
INIT_MEMBLOCK_REGIONS+NR_CPUS+1 and thus centrally give an extra 
allocation entry per CPU configured?

Or is there some cleaner solution?

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (2):
      arm64, mm, efi: Account for GICv3 LPI tables in static memblock reserve table
      efi/arm: Revert "Defer persistent reservations until after paging_init()"


 arch/arm64/include/asm/memory.h         | 11 +++++++++++
 arch/arm64/kernel/setup.c               |  1 -
 drivers/firmware/efi/efi.c              |  4 ----
 drivers/firmware/efi/libstub/arm-stub.c |  3 ---
 include/linux/efi.h                     |  7 -------
 include/linux/memblock.h                |  3 ---
 mm/memblock.c                           | 11 +++++++++--
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e1ec947e7c0c..0c656850eeea 100644
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
+# define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
+#endif
+
 #include <asm-generic/memory_model.h>
 
 #endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..d09ec76f08cf 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,7 +313,6 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
-	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..55b77c576c42 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -592,11 +592,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
-	return 0;
-}
 
-int __init efi_apply_persistent_mem_reservations(void)
-{
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..c037c6c5d0b7 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,9 +75,6 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
-	if (IS_ENABLED(CONFIG_ARM))
-		return;
-
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..28604a8d0aa9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1198,8 +1198,6 @@ static inline bool efi_enabled(int feature)
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
-
-extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1218,11 +1216,6 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
-
-static inline int efi_apply_persistent_mem_reservations(void)
-{
-	return 0;
-}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
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
index 022d4cbb3618..ea31045ba704 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -26,6 +26,13 @@
 
 #include "internal.h"
 
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_PHYSMEM_REGIONS			4
+
+#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
+# define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#endif
+
 /**
  * DOC: memblock overview
  *
@@ -92,7 +99,7 @@ unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
-static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
+static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
 #endif
@@ -105,7 +112,7 @@ struct memblock memblock __initdata_memblock = {
 
 	.reserved.regions	= memblock_reserved_init_regions,
 	.reserved.cnt		= 1,	/* empty dummy entry */
-	.reserved.max		= INIT_MEMBLOCK_REGIONS,
+	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
 	.reserved.name		= "reserved",
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
