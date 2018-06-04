Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeFDHNy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:13:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34204 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753306AbeFDHKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:10:25 -0400
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 01/10] fsl/fman: share the event interrupt
Date: Mon,  4 Jun 2018 15:08:28 +0800
Message-Id: <20180604070837.19265-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to share fman event interrupt because
the 1588 timer driver will also use this interrupt.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 9530405..c415ac6 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2801,7 +2801,8 @@ static irqreturn_t fman_irq(int irq, void *handle)
 	of_node_put(muram_node);
 	of_node_put(fm_node);
 
-	err = devm_request_irq(&of_dev->dev, irq, fman_irq, 0, "fman", fman);
+	err = devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
+			       "fman", fman);
 	if (err < 0) {
 		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, irq, err);
-- 
1.7.1
