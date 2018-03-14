Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCNPJh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:09:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33064 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeCNPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:09:36 -0400
X-Google-Smtp-Source: AG47ELuClu60ZudU9Q2sXu80KvGD0KQrLEkWNYZeMWGct0DN0Q+7FnjoMQHoC5JEM2rF5RFvSRdU2Q==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] microblaze: remove unused alloc_maybe_bootmem
Date: Wed, 14 Mar 2018 16:09:31 +0100
Message-Id: <77785f26fa882362b5e72e71845bb607f2cec757.1521040166.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

alloc_maybe_bootmem is unused, so remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/microblaze/include/asm/setup.h | 1 -
 arch/microblaze/mm/init.c           | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index be84a4d3917f..7c968c1d1729 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -44,7 +44,6 @@ void machine_early_init(const char *cmdline, unsigned int ram,
 void machine_halt(void);
 void machine_power_off(void);
 
-extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 # endif /* __ASSEMBLY__ */
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 434639f9a3a6..5bc9c7fbb541 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -414,14 +414,6 @@ void __init *early_get_page(void)
 
 #endif /* CONFIG_MMU */
 
-void * __ref alloc_maybe_bootmem(size_t size, gfp_t mask)
-{
-	if (mem_init_done)
-		return kmalloc(size, mask);
-	else
-		return alloc_bootmem(size);
-}
-
 void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
 {
 	void *p;
-- 
1.9.1
