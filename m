Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756760AbeDZQSm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:18:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45255 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeDZQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:18:39 -0400
X-Google-Smtp-Source: AIpwx4/k3UOR1trcVMwdcexuhcgQNVaxsXZw1J2XbVfdkHmgc8SqrJ5R6J27hjOH6dIuaeYzCCkqDQ==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com, lars@metafoo.de,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
Date: Thu, 26 Apr 2018 09:12:39 -0700
Message-Id: <20180426161239.15234-2-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426161239.15234-1-mdf@kernel.org>
References: <20180426161239.15234-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request IRQ with IRQF_SHARED flag. This works since the interrupt
handler already checks if there is an actual IRQ pending and returns
IRQ_NONE otherwise.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 75ccedaa96d2..2bd195532882 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -688,7 +688,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 		goto err_unregister_device;
 
 	ret = devm_request_irq(&pdev->dev, dmac->irq,
-			       axi_dmac_interrupt_handler, 0,
+			       axi_dmac_interrupt_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), dmac);
 	if (ret)
 		goto err_unregister_of;
-- 
2.17.0
