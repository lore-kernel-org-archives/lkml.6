Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeCICFD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:05:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38056 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750904AbeCICFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:02 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 4/9] net: hns3: fix for pause configuration lost during reset
Date: Fri, 9 Mar 2018 10:36:59 +0800
Message-ID: <1520563024-94811-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
References: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
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
index 34a0905..109155d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5493,9 +5493,9 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
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
