Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B4C27D6F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B4C27D6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935479AbeF2Kzw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:55:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59983 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932213AbeF2Kyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A90973F3635B;
        Fri, 29 Jun 2018 18:54:37 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:24 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 07/10] net: hns3: remove some unused members of some structures
Date:   Fri, 29 Jun 2018 19:23:02 +0800
Message-ID: <1530271385-49668-8-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

Some members in struct hns3_enet_tqp_vector, struct hnae3_client
and struct hnae3_ae_algo are unused.
This patch removes them.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               | 2 --
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h           | 1 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 1 -
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 8acb1d1..422c56b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -167,7 +167,6 @@ struct hnae3_client_ops {
 #define HNAE3_CLIENT_NAME_LENGTH 16
 struct hnae3_client {
 	char name[HNAE3_CLIENT_NAME_LENGTH];
-	u16 version;
 	unsigned long state;
 	enum hnae3_client_type type;
 	const struct hnae3_client_ops *ops;
@@ -436,7 +435,6 @@ struct hnae3_dcb_ops {
 struct hnae3_ae_algo {
 	const struct hnae3_ae_ops *ops;
 	struct list_head node;
-	char name[HNAE3_CLASS_NAME_SIZE];
 	const struct pci_device_id *pdev_id_table;
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 3b083d5a..8d6096c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -499,7 +499,6 @@ struct hns3_enet_tqp_vector {
 
 	u16 num_tqps;	/* total number of tqps in TQP vector */
 
-	cpumask_t affinity_mask;
 	char name[HNAE3_INT_NAME_LEN];
 
 	/* when 0 should adjust interrupt coalesce parameter */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b7f6960..2a0cd70 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6287,7 +6287,6 @@ static void hclge_get_port_type(struct hnae3_handle *handle,
 
 static struct hnae3_ae_algo ae_algo = {
 	.ops = &hclge_ops,
-	.name = HCLGE_NAME,
 	.pdev_id_table = ae_algo_pci_tbl,
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 1eb61c1..1638193 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1959,7 +1959,6 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 
 static struct hnae3_ae_algo ae_algovf = {
 	.ops = &hclgevf_ops,
-	.name = HCLGEVF_NAME,
 	.pdev_id_table = ae_algovf_pci_tbl,
 };
 
-- 
1.9.1

