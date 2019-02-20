Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BCAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABFF2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfBTCdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727576AbfBTCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F261E8BDC600E4FC7F7A;
        Wed, 20 Feb 2019 10:33:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:29 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 05/12] net: hns3: modify print message of ssu common ecc errors
Date:   Wed, 20 Feb 2019 10:32:44 +0800
Message-ID: <1550629971-23999-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

This patch add information of specific bit in log to be consistent
with other type of errors, so that we can know which memory of ssu
has occurred a ecc ras errors.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 45 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index d0f6541..c9c2c85 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -277,6 +277,45 @@ static const struct hclge_hw_error hclge_ssu_com_err_int[] = {
 	{ /* sentinel */ }
 };
 
+#define HCLGE_SSU_MEM_ECC_ERR(x) \
+	{ .int_msk = BIT(x), .msg = "ssu_mem" #x "_ecc_mbit_err" }
+
+static const struct hclge_hw_error hclge_ssu_mem_ecc_err_int[] = {
+	HCLGE_SSU_MEM_ECC_ERR(0),
+	HCLGE_SSU_MEM_ECC_ERR(1),
+	HCLGE_SSU_MEM_ECC_ERR(2),
+	HCLGE_SSU_MEM_ECC_ERR(3),
+	HCLGE_SSU_MEM_ECC_ERR(4),
+	HCLGE_SSU_MEM_ECC_ERR(5),
+	HCLGE_SSU_MEM_ECC_ERR(6),
+	HCLGE_SSU_MEM_ECC_ERR(7),
+	HCLGE_SSU_MEM_ECC_ERR(8),
+	HCLGE_SSU_MEM_ECC_ERR(9),
+	HCLGE_SSU_MEM_ECC_ERR(10),
+	HCLGE_SSU_MEM_ECC_ERR(11),
+	HCLGE_SSU_MEM_ECC_ERR(12),
+	HCLGE_SSU_MEM_ECC_ERR(13),
+	HCLGE_SSU_MEM_ECC_ERR(14),
+	HCLGE_SSU_MEM_ECC_ERR(15),
+	HCLGE_SSU_MEM_ECC_ERR(16),
+	HCLGE_SSU_MEM_ECC_ERR(17),
+	HCLGE_SSU_MEM_ECC_ERR(18),
+	HCLGE_SSU_MEM_ECC_ERR(19),
+	HCLGE_SSU_MEM_ECC_ERR(20),
+	HCLGE_SSU_MEM_ECC_ERR(21),
+	HCLGE_SSU_MEM_ECC_ERR(22),
+	HCLGE_SSU_MEM_ECC_ERR(23),
+	HCLGE_SSU_MEM_ECC_ERR(24),
+	HCLGE_SSU_MEM_ECC_ERR(25),
+	HCLGE_SSU_MEM_ECC_ERR(26),
+	HCLGE_SSU_MEM_ECC_ERR(27),
+	HCLGE_SSU_MEM_ECC_ERR(28),
+	HCLGE_SSU_MEM_ECC_ERR(29),
+	HCLGE_SSU_MEM_ECC_ERR(30),
+	HCLGE_SSU_MEM_ECC_ERR(31),
+	{ /* sentinel */ }
+};
+
 static const struct hclge_hw_error hclge_ssu_port_based_err_int[] = {
 	{ .int_msk = BIT(0), .msg = "roc_pkt_without_key_port" },
 	{ .int_msk = BIT(1), .msg = "tpu_pkt_without_key_port" },
@@ -835,13 +874,15 @@ static int hclge_handle_mpf_ras_error(struct hclge_dev *hdev,
 	desc_data = (__le32 *)&desc[2];
 	status = le32_to_cpu(*(desc_data + 2));
 	if (status) {
-		dev_warn(dev, "SSU_ECC_MULTI_BIT_INT_0 ssu_ecc_mbit_int[31:0]\n");
+		hclge_log_error(dev, "SSU_ECC_MULTI_BIT_INT_0",
+				&hclge_ssu_mem_ecc_err_int[0], status);
 		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
 	}
 
 	status = le32_to_cpu(*(desc_data + 3)) & BIT(0);
 	if (status) {
-		dev_warn(dev, "SSU_ECC_MULTI_BIT_INT_1 ssu_ecc_mbit_int[32]\n");
+		dev_warn(dev, "SSU_ECC_MULTI_BIT_INT_1 ssu_mem32_ecc_mbit_err found [error status=0x%x]\n",
+			 status);
 		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
 	}
 
-- 
2.7.4

