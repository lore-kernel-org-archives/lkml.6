Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACEC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F1520673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F1520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeGSPco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:32:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731849AbeGSPbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5F15DD43652F;
        Thu, 19 Jul 2018 22:48:09 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:48:03 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 6/9] net: hns3: Modify inconsistent bit mask macros
Date:   Thu, 19 Jul 2018 15:47:03 +0100
Message-ID: <20180719144706.644-7-salil.mehta@huawei.com>
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

Use BIT() and GENMASK() to convert the bit mask, modify
the inconsistent ones, and remove useless ones.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 25 ++++++++--------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  2 +-
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 219ffc7..ec7b8d7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -75,19 +75,12 @@ struct hclge_cmq {
 	enum hclge_cmd_status last_status;
 };
 
-#define HCLGE_CMD_FLAG_IN_VALID_SHIFT	0
-#define HCLGE_CMD_FLAG_OUT_VALID_SHIFT	1
-#define HCLGE_CMD_FLAG_NEXT_SHIFT	2
-#define HCLGE_CMD_FLAG_WR_OR_RD_SHIFT	3
-#define HCLGE_CMD_FLAG_NO_INTR_SHIFT	4
-#define HCLGE_CMD_FLAG_ERR_INTR_SHIFT	5
-
-#define HCLGE_CMD_FLAG_IN	BIT(HCLGE_CMD_FLAG_IN_VALID_SHIFT)
-#define HCLGE_CMD_FLAG_OUT	BIT(HCLGE_CMD_FLAG_OUT_VALID_SHIFT)
-#define HCLGE_CMD_FLAG_NEXT	BIT(HCLGE_CMD_FLAG_NEXT_SHIFT)
-#define HCLGE_CMD_FLAG_WR	BIT(HCLGE_CMD_FLAG_WR_OR_RD_SHIFT)
-#define HCLGE_CMD_FLAG_NO_INTR	BIT(HCLGE_CMD_FLAG_NO_INTR_SHIFT)
-#define HCLGE_CMD_FLAG_ERR_INTR	BIT(HCLGE_CMD_FLAG_ERR_INTR_SHIFT)
+#define HCLGE_CMD_FLAG_IN	BIT(0)
+#define HCLGE_CMD_FLAG_OUT	BIT(1)
+#define HCLGE_CMD_FLAG_NEXT	BIT(2)
+#define HCLGE_CMD_FLAG_WR	BIT(3)
+#define HCLGE_CMD_FLAG_NO_INTR	BIT(4)
+#define HCLGE_CMD_FLAG_ERR_INTR	BIT(5)
 
 enum hclge_opcode_type {
 	/* Generic commands */
@@ -379,7 +372,7 @@ struct hclge_pf_res_cmd {
 	__le16 msixcap_localid_ba_nic;
 	__le16 msixcap_localid_ba_rocee;
 #define HCLGE_PF_VEC_NUM_S		0
-#define HCLGE_PF_VEC_NUM_M		(0xff << HCLGE_PF_VEC_NUM_S)
+#define HCLGE_PF_VEC_NUM_M		GENMASK(7, 0)
 	__le16 pf_intr_vector_number;
 	__le16 pf_own_fun_number;
 	__le32 rsv[3];
@@ -468,8 +461,8 @@ struct hclge_rss_tc_mode_cmd {
 	u8 rsv[8];
 };
 
-#define HCLGE_LINK_STS_B	0
-#define HCLGE_LINK_STATUS	BIT(HCLGE_LINK_STS_B)
+#define HCLGE_LINK_STATUS_UP_B	0
+#define HCLGE_LINK_STATUS_UP_M	BIT(HCLGE_LINK_STATUS_UP_B)
 struct hclge_link_status_cmd {
 	u8 status;
 	u8 rsv[23];
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index de36dfb..e0b617c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2349,7 +2349,7 @@ static int hclge_get_mac_link_status(struct hclge_dev *hdev)
 	}
 
 	req = (struct hclge_link_status_cmd *)desc.data;
-	link_status = req->status & HCLGE_LINK_STATUS;
+	link_status = req->status & HCLGE_LINK_STATUS_UP_M;
 
 	return !!link_status;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index aeae1ba..a1ed6df 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -40,7 +40,7 @@
 #define HCLGE_RSS_HASH_ALGO_TOEPLITZ	0
 #define HCLGE_RSS_HASH_ALGO_SIMPLE	1
 #define HCLGE_RSS_HASH_ALGO_SYMMETRIC	2
-#define HCLGE_RSS_HASH_ALGO_MASK	0xf
+#define HCLGE_RSS_HASH_ALGO_MASK	GENMASK(3, 0)
 #define HCLGE_RSS_CFG_TBL_NUM \
 	(HCLGE_RSS_IND_TBL_SIZE / HCLGE_RSS_CFG_TBL_SIZE)
 
-- 
2.7.4


