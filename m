Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFEMdD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:33:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48391 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752023AbeFEMcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:32:25 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 5/6] net: tlan: use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:50 +0800
Message-ID: <20180605122851.23912-6-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20180605122851.23912-1-yuehaibing@huawei.com>
References: <20180605122851.23912-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/tlan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index c769cd9..66f2e5d 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -843,9 +843,9 @@ static int tlan_init(struct net_device *dev)
 
 	dma_size = (TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS)
 		* (sizeof(struct tlan_list));
-	priv->dma_storage = pci_alloc_consistent(priv->pci_dev,
-						 dma_size,
-						 &priv->dma_storage_dma);
+	priv->dma_storage = pci_zalloc_consistent(priv->pci_dev,
+						  dma_size,
+						  &priv->dma_storage_dma);
 	priv->dma_size = dma_size;
 
 	if (priv->dma_storage == NULL) {
@@ -853,7 +853,6 @@ static int tlan_init(struct net_device *dev)
 		       dev->name);
 		return -ENOMEM;
 	}
-	memset(priv->dma_storage, 0, dma_size);
 	priv->rx_list = (struct tlan_list *)
 		ALIGN((unsigned long)priv->dma_storage, 8);
 	priv->rx_list_dma = ALIGN(priv->dma_storage_dma, 8);
-- 
2.7.0
