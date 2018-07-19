Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD79C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B7320856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B7320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeGSPbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731908AbeGSPbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F6ABDD007A41;
        Thu, 19 Jul 2018 22:48:15 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:48:09 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: Remove unused struct member and definition
Date:   Thu, 19 Jul 2018 15:47:05 +0100
Message-ID: <20180719144706.644-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719144706.644-1-salil.mehta@huawei.com>
References: <20180719144706.644-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The struct hclge_desc_cb and hclge_desc_cb are never used in
anywhere. This patch removes them.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 7 -------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 54e199d..66a534a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -27,16 +27,9 @@ struct hclge_desc {
 	__le32 data[6];
 };
 
-struct hclge_desc_cb {
-	dma_addr_t dma;
-	void *va;
-	u32 length;
-};
-
 struct hclge_cmq_ring {
 	dma_addr_t desc_dma_addr;
 	struct hclge_desc *desc;
-	struct hclge_desc_cb *desc_cb;
 	struct hclge_dev *dev;
 	u32 head;
 	u32 tail;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index a1ed6df..7d4845e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -140,12 +140,6 @@ enum hclge_evt_cause {
 };
 
 #define HCLGE_MPF_ENBALE 1
-struct hclge_caps {
-	u16 num_tqp;
-	u16 num_buffer_cell;
-	u32 flag;
-	u16 vmdq;
-};
 
 enum HCLGE_MAC_SPEED {
 	HCLGE_MAC_SPEED_10M	= 10,		/* 10 Mbps */
@@ -191,7 +185,6 @@ struct hclge_hw {
 	struct hclge_mac mac;
 	int num_vec;
 	struct hclge_cmq cmq;
-	struct hclge_caps caps;
 };
 
 /* TQP stats */
-- 
2.7.4


