Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeEGNTo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:19:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751923AbeEGNTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:19:43 -0400
From: Zhao Chen <zhaochen6@huawei.com>
To: <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <zhaochen6@huawei.com>,
        <tony.qu@huawei.com>, <yin.yinshi@huawei.com>, <luoshaokai@huawei.com>
Subject: [PATCH net-next] net-next/hinic: add pci device ids for 25ge and 100ge card
Date: Mon, 7 May 2018 09:21:57 -0400
Message-ID: <20180507132157.25047-1-zhaochen6@huawei.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PCI device IDs to support 25GE and 100GE card:

1. Add device id 0x0201 for HINIC 100GE dual port card.
2. Add device id 0x0200 for HINIC 25GE dual port card.
3. Macro of device id 0x1822 is modified for HINIC 25GE quad port card.

Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index eb53bd93065e..5b122728dcb4 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -51,7 +51,9 @@ static unsigned int rx_weight = 64;
 module_param(rx_weight, uint, 0644);
 MODULE_PARM_DESC(rx_weight, "Number Rx packets for NAPI budget (default=64)");
 
-#define PCI_DEVICE_ID_HI1822_PF         0x1822
+#define HINIC_DEV_ID_QUAD_PORT_25GE     0x1822
+#define HINIC_DEV_ID_DUAL_PORT_25GE     0x0200
+#define HINIC_DEV_ID_DUAL_PORT_100GE    0x0201
 
 #define HINIC_WQ_NAME                   "hinic_dev"
 
@@ -1097,7 +1099,9 @@ static void hinic_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic_pci_table[] = {
-	{ PCI_VDEVICE(HUAWEI, PCI_DEVICE_ID_HI1822_PF), 0},
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE), 0},
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_25GE), 0},
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE), 0},
 	{ 0, 0}
 };
 MODULE_DEVICE_TABLE(pci, hinic_pci_table);
-- 
2.17.0
