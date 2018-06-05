Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeFEMcm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:32:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751807AbeFEMch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:32:37 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 6/6] enic: use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:51 +0800
Message-ID: <20180605122851.23912-7-yuehaibing@huawei.com>
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
 drivers/net/ethernet/cisco/enic/vnic_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index 76cdd4c..7693af9 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -1217,13 +1217,12 @@ int vnic_dev_classifier(struct vnic_dev *vdev, u8 cmd, u16 *entry,
 		tlv_size = sizeof(struct filter) +
 			   sizeof(struct filter_action) +
 			   2 * sizeof(struct filter_tlv);
-		tlv_va = pci_alloc_consistent(vdev->pdev, tlv_size, &tlv_pa);
+		tlv_va = pci_zalloc_consistent(vdev->pdev, tlv_size, &tlv_pa);
 		if (!tlv_va)
 			return -ENOMEM;
 		tlv = tlv_va;
 		a0 = tlv_pa;
 		a1 = tlv_size;
-		memset(tlv, 0, tlv_size);
 		tlv->type = CLSF_TLV_FILTER;
 		tlv->length = sizeof(struct filter);
 		*(struct filter *)&tlv->val = *data;
-- 
2.7.0
