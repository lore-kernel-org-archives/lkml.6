Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D28C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A5223E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhYJ+SAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83A5223E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeHJGjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:39:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46269 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJGjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:39:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so3749568pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=C/3QyVBVJ5N4uMXjBE8lAvGTjXlEKlthoRgVEyRbJD0=;
        b=FhYJ+SAaV+7M9F/Ar+R4If/36a3B9zECN9j/cXbqLZMnRdBbnYWmbC0z1AWbnMtv8O
         VCUHNYwcxnVisaX6fe0A2HEQIbKW74tfTIDFz/SBStcof1vEpzhfXJ1yRCsrbcyqJcV6
         6Ch/zk0oDXrJMeCr81lFjTyVH1I4hwNxHj39rgqqEvXyLblzuXO3TD2E0WaFSQInizzr
         a5HTdkhsUmldFbWISbPDc8wBhI7ANgDmTFJ+pp8pGg3kAlQtIcZD7xI0hrPKhwINl3SR
         CUCeaJ2/FbGQZaS/UZwh2TT2XTdNfGB1jarug9k7WF1Cs+GgapiXcWdv8tLcm+/YTUxw
         /c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=C/3QyVBVJ5N4uMXjBE8lAvGTjXlEKlthoRgVEyRbJD0=;
        b=fx9bsZDrPuwfvvfTT0GJ3YMSdvHkXEE3Ar+LVNAQ1XE/uWlCR6Uuheg4Jjk3Hl/JOj
         laWA/1/6jerN37wcVXuFG+N6anZcIJvstjimbSNbFIVhV3nAQd7USNaNrmLw5XQpXLre
         XtiAc5JCy8F2O7He5Wmd0L/MoGLDOUsjNpiRlxMpqQh8O4uPswvM6124fy4NdGJhYeYW
         wNxoC+Mq7HNz8lyblnFUB0FJ4GsqlxVL9FgX9dO52h73Bi1tC3zm1EAz472dUmzf2R4V
         7roWh8IjhpqGmiYngy8b7mzxzlvoZEWfafMQdCngzcL5+dVHaMku9MA4nWBfX7rDsrS4
         xgdw==
X-Gm-Message-State: AOUpUlFs7chzCdWZZOY+69Y4Xe/jZg+0kTaNYg9A5HUrQLOrWaPq3/xZ
        hngyKYINw2r9pMvwtLsYaaM=
X-Google-Smtp-Source: AA+uWPyKBo0oyetIqaqBXdLGWQyRGn6eijVVqGSDqCVTcGwGsGCqbdyaGmzz347Q+zE0X7sFx6ZWjg==
X-Received: by 2002:a62:9f1d:: with SMTP id g29-v6mr5090414pfe.207.1533874302617;
        Thu, 09 Aug 2018 21:11:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t1-v6sm8000008pgp.32.2018.08.09.21.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 21:11:42 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] riscv: Drop setup_initrd
Date:   Thu,  9 Aug 2018 21:11:40 -0700
Message-Id: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_initrd() does not appear to serve a practical purpose other than
preventing qemu boots with "-initrd" parameter, so let's drop it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/riscv/kernel/setup.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2e56af3281f8..579f58a42974 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void __init setup_initrd(void)
-{
-	extern char __initramfs_start[];
-	extern unsigned long __initramfs_size;
-	unsigned long size;
-
-	if (__initramfs_size > 0) {
-		initrd_start = (unsigned long)(&__initramfs_start);
-		initrd_end = initrd_start + __initramfs_size;
-	}
-
-	if (initrd_start >= initrd_end) {
-		printk(KERN_INFO "initrd not found or empty");
-		goto disable;
-	}
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		printk(KERN_ERR "initrd extends beyond end of memory");
-		goto disable;
-	}
-
-	size =  initrd_end - initrd_start;
-	memblock_reserve(__pa(initrd_start), size);
-	initrd_below_start_ok = 1;
-
-	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
-		(void *)(initrd_start), size);
-	return;
-disable:
-	pr_cont(" - disabling initrd\n");
-	initrd_start = 0;
-	initrd_end = 0;
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
@@ -195,10 +160,6 @@ static void __init setup_bootmem(void)
 	set_max_mapnr(PFN_DOWN(mem_size));
 	max_low_pfn = pfn_base + PFN_DOWN(mem_size);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 	memblock_allow_resize();
-- 
2.7.4

