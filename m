Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933742AbeBLNNL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:13:11 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41634 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933166AbeBLNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:13:09 -0500
X-Google-Smtp-Source: AH8x225KRhMwNNmrZPi6edWaGzvab/4O5I4JkO5wo5r85dlsxHp83zQp4CvFcL3eEPeO1MFDxoItxQ==
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: marc.zyngier@arm.com, andrew.smirnov@gmail.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] irqchip/irq-imx-gpcv2: Remove unused function
Date: Mon, 12 Feb 2018 11:12:56 -0200
Message-Id: <1518441176-6107-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx_gpcv2_get_wakeup_source() is not used anywhere, so remove it.

This fixes the following sparse warning:

drivers/irqchip/irq-imx-gpcv2.c:34:5: warning: symbol 'imx_gpcv2_get_wakeup_source' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 675eda5..4760307 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -28,20 +28,6 @@ struct gpcv2_irqchip_data {
 
 static struct gpcv2_irqchip_data *imx_gpcv2_instance;
 
-/*
- * Interface for the low level wakeup code.
- */
-u32 imx_gpcv2_get_wakeup_source(u32 **sources)
-{
-	if (!imx_gpcv2_instance)
-		return 0;
-
-	if (sources)
-		*sources = imx_gpcv2_instance->wakeup_sources;
-
-	return IMR_NUM;
-}
-
 static int gpcv2_wakeup_source_save(void)
 {
 	struct gpcv2_irqchip_data *cd;
-- 
2.7.4
