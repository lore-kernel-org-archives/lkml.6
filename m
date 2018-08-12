Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98201C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541E621943
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541E621943
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeHLM0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727580AbeHLM0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD5931F89F38C;
        Sun, 12 Aug 2018 17:48:49 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:42 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: Remove tx ring BD len register in hns3_enet
Date:   Sun, 12 Aug 2018 10:47:36 +0100
Message-ID: <20180812094738.14852-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180812094738.14852-1-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
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
index a64d69c87f13..b7b9ee3f4d20 100644
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
index e4b4a8f2ceaa..0f071a0f4ff9 100644
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
2.11.0


