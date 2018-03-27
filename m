Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeC0QUB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:20:01 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44355 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeC0QTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:35 -0400
X-Google-Smtp-Source: AG47ELuZcx1ll2NZ1t7mUQaYDaTRH5jKQSOghnNzpLoqdQndObgzK8PRVt4mMckW2l1LkgnaEK8yBw==
Subject: [PATCH v4 8/8] irq: Remove MULTI_IRQ_HANDLER as it's now obselete
Date: Tue, 27 Mar 2018 09:19:11 -0700
Message-Id: <20180327161911.14086-9-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327161911.14086-1-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that every user of MULTI_IRQ_HANDLER has been convereted over to use
GENERIC_IRQ_MULTI_HANDLER we can remove the references to
MULTI_IRQ_HANDLER.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/irqchip/Kconfig | 24 ++++++++----------------
 kernel/irq/Kconfig      |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5af28ac6ce35..70157a257ce0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,8 +8,7 @@ config ARM_GIC
 	bool
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,8 +34,7 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -62,8 +60,7 @@ config ARM_NVIC
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -90,16 +87,14 @@ config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -136,8 +131,7 @@ config DW_APB_ICTL
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -162,8 +156,7 @@ config CLPS711X_IRQCHIP
 	bool
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -182,8 +175,7 @@ config OMAP_IRQCHIP
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config PIC32_EVIC
 	bool
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 8596baa8e53d..116a6972f124 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -134,7 +134,6 @@ config GENERIC_IRQ_DEBUGFS
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
-	depends on !MULTI_IRQ_HANDLER
 	bool
 	help
 	  Allow each machine to specify it's own IRQ handler at run time.
-- 
2.16.1
