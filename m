Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758754AbeBPQ6D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:58:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755597AbeBPQ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:58:02 -0500
From: Robin Murphy <robin.murphy@arm.com>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3-its: Fix misplaced __iomem annotations
Date: Fri, 16 Feb 2018 16:57:56 +0000
Message-Id: <af3a8a44f6693f6293de49a1c2910a57ba12e208.1518800276.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.16.1.dirty
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save 26 lines worth of Sparse complaints by fixing up this minor
mishap. The pointee lies in the __iomem space; the pointer does not.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..3a38b4e8685e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2495,7 +2495,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 
 static void its_vpe_schedule(struct its_vpe *vpe)
 {
-	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 	u64 val;
 
 	/* Schedule the VPE */
@@ -2527,7 +2527,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
 {
-	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
 	u64 val;
-- 
2.16.1.dirty
