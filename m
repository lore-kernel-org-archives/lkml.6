Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4450C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79D20643
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfBTCdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730335AbfBTCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26BBF1DBCAD91B0C75DF;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
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
Subject: [Patch net-next 07/12] net: hns3: enable 8~11th bit of mac common msi-x error
Date:   Wed, 20 Feb 2019 10:32:46 +0800
Message-ID: <1550629971-23999-8-git-send-email-tanhuazhong@huawei.com>
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

These bits are enabled now and have been test.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 4951684..f0f1221 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -219,6 +219,12 @@ static const struct hclge_hw_error hclge_mac_afifo_tnl_int[] = {
 	{ .int_msk = BIT(5), .msg = "cge_igu_afifo_ecc_mbit_err" },
 	{ .int_msk = BIT(6), .msg = "lge_igu_afifo_ecc_1bit_err" },
 	{ .int_msk = BIT(7), .msg = "lge_igu_afifo_ecc_mbit_err" },
+	{ .int_msk = BIT(8), .msg = "cge_igu_afifo_overflow_err" },
+	{ .int_msk = BIT(9), .msg = "lge_igu_afifo_overflow_err" },
+	{ .int_msk = BIT(10), .msg = "egu_cge_afifo_underrun_err" },
+	{ .int_msk = BIT(11), .msg = "egu_lge_afifo_underrun_err" },
+	{ .int_msk = BIT(12), .msg = "egu_ge_afifo_underrun_err" },
+	{ .int_msk = BIT(13), .msg = "ge_igu_afifo_overflow_err" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 86d6143..fc06828 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -45,8 +45,8 @@
 #define HCLGE_TM_QCN_MEM_ERR_INT_EN	0xFFFFFF
 #define HCLGE_NCSI_ERR_INT_EN	0x3
 #define HCLGE_NCSI_ERR_INT_TYPE	0x9
-#define HCLGE_MAC_COMMON_ERR_INT_EN		GENMASK(7, 0)
-#define HCLGE_MAC_COMMON_ERR_INT_EN_MASK	GENMASK(7, 0)
+#define HCLGE_MAC_COMMON_ERR_INT_EN		0x107FF
+#define HCLGE_MAC_COMMON_ERR_INT_EN_MASK	0x107FF
 #define HCLGE_PPU_MPF_ABNORMAL_INT0_EN		GENMASK(31, 0)
 #define HCLGE_PPU_MPF_ABNORMAL_INT0_EN_MASK	GENMASK(31, 0)
 #define HCLGE_PPU_MPF_ABNORMAL_INT1_EN		GENMASK(31, 0)
-- 
2.7.4

