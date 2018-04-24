Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeDXNQB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:16:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50720 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933548AbeDXNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:48 -0400
X-Google-Smtp-Source: AIpwx4+Gkp06yDC0gRApC/EeIO10r+psDsgwVmvXzcl1+rkB1GM2uioOe1EhUEUD6iqs5iNju7s0WA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] IB/nes: fix nes_netdev_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:15:45 +0200
Message-Id: <20180424131545.2810-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/infiniband/hw/nes/nes_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes_nic.c b/drivers/infiniband/hw/nes/nes_nic.c
index 0a75164ce..007d5e8a0 100644
--- a/drivers/infiniband/hw/nes/nes_nic.c
+++ b/drivers/infiniband/hw/nes/nes_nic.c
@@ -461,7 +461,7 @@ static bool nes_nic_send(struct sk_buff *skb, struct net_device *netdev)
 /**
  * nes_netdev_start_xmit
  */
-static int nes_netdev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t nes_netdev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct nes_vnic *nesvnic = netdev_priv(netdev);
 	struct nes_device *nesdev = nesvnic->nesdev;
-- 
2.17.0
