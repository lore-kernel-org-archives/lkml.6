Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeC1CHe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:07:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44620 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeC1CHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:07:03 -0400
X-Google-Smtp-Source: AIpwx48GGNANmPe5lEZ8ROsdYnmVsUFv+Uaw0XUE4vzQ6ol/03kX3rp0Og1k76m7WHiYWBh6Z0CgsA==
From: Rob Herring <robh@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] microblaze: remove unnecessary prom.h includes
Date: Tue, 27 Mar 2018 21:06:58 -0500
Message-Id: <20180328020700.17050-2-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328020700.17050-1-robh@kernel.org>
References: <20180328020700.17050-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove prom.h, remove unnecessary prom.h includes.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
---
v2: no change

 arch/microblaze/include/asm/cpuinfo.h | 2 +-
 arch/microblaze/include/asm/pci.h     | 1 -
 arch/microblaze/kernel/platform.c     | 1 -
 arch/microblaze/pci/indirect_pci.c    | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/microblaze/include/asm/cpuinfo.h b/arch/microblaze/include/asm/cpuinfo.h
index 3337417fcdca..8f4996730552 100644
--- a/arch/microblaze/include/asm/cpuinfo.h
+++ b/arch/microblaze/include/asm/cpuinfo.h
@@ -13,7 +13,7 @@
 #ifndef _ASM_MICROBLAZE_CPUINFO_H
 #define _ASM_MICROBLAZE_CPUINFO_H
 
-#include <asm/prom.h>
+#include <linux/of.h>
 
 /* CPU Version and FPGA Family code conversion table type */
 struct cpu_ver_key {
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 114b93488193..c1ee76d30aed 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -19,7 +19,6 @@
 #include <linux/scatterlist.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
 #define PCIBIOS_MIN_IO		0x1000
diff --git a/arch/microblaze/kernel/platform.c b/arch/microblaze/kernel/platform.c
index b9529caa507a..2540d60610d9 100644
--- a/arch/microblaze/kernel/platform.c
+++ b/arch/microblaze/kernel/platform.c
@@ -12,7 +12,6 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
-#include <asm/prom.h>
 #include <asm/setup.h>
 
 static struct of_device_id xilinx_of_bus_ids[] __initdata = {
diff --git a/arch/microblaze/pci/indirect_pci.c b/arch/microblaze/pci/indirect_pci.c
index ae4fca46c9f6..24030837a425 100644
--- a/arch/microblaze/pci/indirect_pci.c
+++ b/arch/microblaze/pci/indirect_pci.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 
 #include <linux/io.h>
-#include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
 static int
-- 
2.14.1
