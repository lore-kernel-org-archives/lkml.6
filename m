Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeFAQyO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:54:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753307AbeFAQyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:54:11 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 08/11] net: hns3: Add missing break in misc_irq_handle
Date: Fri, 1 Jun 2018 17:52:08 +0100
Message-ID: <20180601165211.46372-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180601165211.46372-1-salil.mehta@huawei.com>
References: <20180601165211.46372-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

There is a break missing in the switch/case handling in
hclge_misc_irq_handle, which causes the log to output
uncorrectly.

This patch adds the missing break, and change the dev_dbg
to dev_warn in order to better catch the error.

Fixes: c1a81619d73a ("net: hns3: Add mailbox interrupt handling to PF driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 58fef5e..19e5689 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2580,10 +2580,10 @@ static irqreturn_t hclge_misc_irq_handle(int irq, void *data)
 		 * mbx messages reported by this interrupt.
 		 */
 		hclge_mbx_task_schedule(hdev);
-
+		break;
 	default:
-		dev_dbg(&hdev->pdev->dev,
-			"received unknown or unhandled event of vector0\n");
+		dev_warn(&hdev->pdev->dev,
+			 "received unknown or unhandled event of vector0\n");
 		break;
 	}
 
-- 
2.7.4
