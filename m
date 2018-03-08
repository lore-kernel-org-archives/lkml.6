Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935087AbeCHCiq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:38:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934801AbeCHCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:00 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 13/23] {topost} net: hns3: fix for pause configuration lost during reset
Date: Thu, 8 Mar 2018 11:06:38 +0800
Message-ID: <1520478408-116992-14-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Pause configuration will be set to default value by hclge_tm_schd_init
during reset, which causes the RSS configuration loss problem.

This patch fixes it by calling hclge_tm_init_hw during reset process
, which will set the pause configuration to default value.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1d69470..c0f6939 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5495,9 +5495,9 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
-	ret = hclge_tm_schd_init(hdev);
+	ret = hclge_tm_init_hw(hdev);
 	if (ret) {
-		dev_err(&pdev->dev, "tm schd init fail, ret =%d\n", ret);
+		dev_err(&pdev->dev, "tm init hw fail, ret =%d\n", ret);
 		return ret;
 	}
 
-- 
2.9.3
