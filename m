Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3155C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A13C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfAUHz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:55:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728357AbfAUHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:55:26 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AAFDF9DF9DC46FC69F3;
        Mon, 21 Jan 2019 14:09:50 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Jan 2019 14:09:40 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH net-next] hinic: Add pci device ids
Date:   Sun, 20 Jan 2019 22:15:46 +0000
Message-ID: <20190120221546.24445-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PCI device IDs to support following cards:

1. Add device id 0x0205 for HINIC 100GE dual port mezz card.
2. Add device id 0x0210 for HINIC 25GE quad port mezz card.
3. Delete device id 0x0201 for HINIC 100GE dual port card, because
this is used by other product.
4. Macro of device id 0x200 is modified for HINIC 100GE dual port card.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index da323b9e1f62..e64bc664f687 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -51,9 +51,10 @@ static unsigned int rx_weight = 64;
 module_param(rx_weight, uint, 0644);
 MODULE_PARM_DESC(rx_weight, "Number Rx packets for NAPI budget (default=64)");
 
-#define HINIC_DEV_ID_QUAD_PORT_25GE     0x1822
-#define HINIC_DEV_ID_DUAL_PORT_25GE     0x0200
-#define HINIC_DEV_ID_DUAL_PORT_100GE    0x0201
+#define HINIC_DEV_ID_QUAD_PORT_25GE         0x1822
+#define HINIC_DEV_ID_DUAL_PORT_100GE        0x0200
+#define HINIC_DEV_ID_DUAL_PORT_100GE_MEZZ   0x0205
+#define HINIC_DEV_ID_QUAD_PORT_25GE_MEZZ    0x0210
 
 #define HINIC_WQ_NAME                   "hinic_dev"
 
@@ -1113,8 +1114,9 @@ static void hinic_shutdown(struct pci_dev *pdev)
 
 static const struct pci_device_id hinic_pci_table[] = {
 	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE), 0},
-	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_25GE), 0},
 	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE), 0},
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_100GE_MEZZ), 0},
+	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE_MEZZ), 0},
 	{ 0, 0}
 };
 MODULE_DEVICE_TABLE(pci, hinic_pci_table);
-- 
2.17.1

