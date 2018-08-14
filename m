Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E08C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE323216EE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE323216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbeHNTCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:02:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733047AbeHNTCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:02:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92730D3608D5B;
        Wed, 15 Aug 2018 00:14:21 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 15 Aug 2018 00:14:14 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH V2 net-next 6/8] net: hns3: Remove tx ring BD len register in hns3_enet
Date:   Tue, 14 Aug 2018 17:13:17 +0100
Message-ID: <20180814161319.16392-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180814161319.16392-1-salil.mehta@huawei.com>
References: <20180814161319.16392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

There is no HNS3_RING_TX_RING_BD_LEN_REG register according
to UM, so this patch removes it.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 --
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a64d69c..b7b9ee3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2969,8 +2969,6 @@ static void hns3_init_ring_hw(struct hns3_enet_ring *ring)
 		hns3_write_dev(q, HNS3_RING_TX_RING_BASEADDR_H_REG,
 			       (u32)((dma >> 31) >> 1));
 
-		hns3_write_dev(q, HNS3_RING_TX_RING_BD_LEN_REG,
-			       hns3_buf_size2type(ring->buf_size));
 		hns3_write_dev(q, HNS3_RING_TX_RING_BD_NUM_REG,
 			       ring->desc_num / 8 - 1);
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index e4b4a8f..0f071a0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -37,7 +37,6 @@ enum hns3_nic_state {
 #define HNS3_RING_TX_RING_BASEADDR_L_REG	0x00040
 #define HNS3_RING_TX_RING_BASEADDR_H_REG	0x00044
 #define HNS3_RING_TX_RING_BD_NUM_REG		0x00048
-#define HNS3_RING_TX_RING_BD_LEN_REG		0x0004C
 #define HNS3_RING_TX_RING_TAIL_REG		0x00058
 #define HNS3_RING_TX_RING_HEAD_REG		0x0005C
 #define HNS3_RING_TX_RING_FBDNUM_REG		0x00060
-- 
2.7.4


