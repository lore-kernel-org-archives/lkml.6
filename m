Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeDAR0p (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 13:26:45 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42661 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbeDAR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 13:26:41 -0400
X-Google-Smtp-Source: AIpwx4+8TWrW19Lf6awxfWLSgQn6G9HxFxnqamhuQmvZrXjBw/iZixjOtanYGTl0gkmnjKnwijBXMQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        linux-kernel@vger.kernel.org (open list), jon.mason@broadcom.com,
        nbd@nbd.name
Subject: [PATCH net 1/2] net: bgmac: Correctly annotate register space
Date: Sun,  1 Apr 2018 10:26:29 -0700
Message-Id: <20180401172630.12883-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180401172630.12883-1-f.fainelli@gmail.com>
References: <20180401172630.12883-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the members: base, idm_base and nicpm_base should be annotated with
__iomem since they are pointers to register space. This fixes a bunch of
sparse reported warnings.

Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
Fixes: dd5c5d037f5e ("net: ethernet: bgmac: add NS2 support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index 4040d846da8e..40d02fec2747 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -479,9 +479,9 @@ struct bgmac_rx_header {
 struct bgmac {
 	union {
 		struct {
-			void *base;
-			void *idm_base;
-			void *nicpm_base;
+			void __iomem *base;
+			void __iomem *idm_base;
+			void __iomem *nicpm_base;
 		} plat;
 		struct {
 			struct bcma_device *core;
-- 
2.14.1
