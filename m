Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBUXnz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbeBUXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78E62178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 05/13] irqchip: Remove metag irqchip drivers
Date: Wed, 21 Feb 2018 23:38:17 +0000
Message-Id: <20180221233825.10024-6-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, remove the two metag irqchip
drivers. They are of no value without the architecture code.
 - irq-metag: Meta internal (HWSTATMETA) interrupt code.
 - irq-metag-ext: Meta External interrupt code.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-metag@vger.kernel.org
---
 drivers/irqchip/Makefile          |   2 -
 drivers/irqchip/irq-metag-ext.c   | 871 --------------------------------------
 drivers/irqchip/irq-metag.c       | 343 ---------------
 include/linux/irqchip/metag-ext.h |  34 --
 include/linux/irqchip/metag.h     |  25 --
 5 files changed, 1275 deletions(-)
 delete mode 100644 drivers/irqchip/irq-metag-ext.c
 delete mode 100644 drivers/irqchip/irq-metag.c
 delete mode 100644 include/linux/irqchip/metag-ext.h
 delete mode 100644 include/linux/irqchip/metag.h

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3619e0..b5b1f4c93413 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -15,8 +15,6 @@ obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_TEGRA)		+= irq-tegra.o
 obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
-obj-$(CONFIG_METAG)			+= irq-metag-ext.o
-obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
 obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OMPIC)			+= irq-ompic.o
 obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
diff --git a/drivers/irqchip/irq-metag-ext.c b/drivers/irqchip/irq-metag-ext.c
deleted file mode 100644
index e67483161f0f..000000000000
diff --git a/drivers/irqchip/irq-metag.c b/drivers/irqchip/irq-metag.c
deleted file mode 100644
index 857b946747eb..000000000000
diff --git a/include/linux/irqchip/metag-ext.h b/include/linux/irqchip/metag-ext.h
deleted file mode 100644
index d120496370b9..000000000000
diff --git a/include/linux/irqchip/metag.h b/include/linux/irqchip/metag.h
deleted file mode 100644
index 0adcf449e4e4..000000000000
-- 
2.13.6
