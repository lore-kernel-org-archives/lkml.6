Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeDQVbQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:31:16 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29974 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbeDQV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:24 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 08/13] net: netcp: ethss: re-use stats handling code for 2u hardware
Date: Tue, 17 Apr 2018 17:30:37 -0400
Message-ID: <1524000642-23944-9-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stats block in 2u cpsw hardware is similar to the one on nu
and hence handle it in a similar way by using a macro that includes
2u hardware as well.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 91935e5..d982dcb 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3398,7 +3398,7 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
 	gbe_dev->num_stats_mods = gbe_dev->max_num_ports;
 	gbe_dev->et_stats = gbenu_et_stats;
 
-	if (IS_SS_ID_NU(gbe_dev))
+	if (IS_SS_ID_MU(gbe_dev))
 		gbe_dev->num_et_stats = GBENU_ET_STATS_HOST_SIZE +
 			(gbe_dev->max_num_slaves * GBENU_ET_STATS_PORT_SIZE);
 	else
-- 
1.9.1
