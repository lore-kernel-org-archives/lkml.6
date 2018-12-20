Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC0B21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeLTDQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729879AbeLTDQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:32 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B2FB7EF21CAF;
        Thu, 20 Dec 2018 11:16:28 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:16 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 9/9] net: hns3: remove redundant variable initialization
Date:   Thu, 20 Dec 2018 11:52:06 +0800
Message-ID: <1545277926-66432-10-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
References: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the redundant variable initialization,
as driver will devm_kzalloc to set value to hdev soon.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 156242f..82103d5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1721,7 +1721,7 @@ static int hclgevf_configure(struct hclgevf_dev *hdev)
 static int hclgevf_alloc_hdev(struct hnae3_ae_dev *ae_dev)
 {
 	struct pci_dev *pdev = ae_dev->pdev;
-	struct hclgevf_dev *hdev = ae_dev->priv;
+	struct hclgevf_dev *hdev;
 
 	hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
-- 
1.9.1

