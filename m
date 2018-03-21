Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCUHUr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:20:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751594AbeCUHSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:20 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 05/11] net: hns3: increase the max time for IMP handle command
Date: Wed, 21 Mar 2018 15:49:24 +0800
Message-ID: <1521618570-129694-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may need more time for IMP handle some command, such as reset.
This patch enlarges the max time for cmd timeout.

Driver will check the IMP result every us, it may break through the
loop when get the right result. So not all command need the max time.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 3fd10a6..aae4abe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
-#define HCLGE_CMDQ_TX_TIMEOUT		1000
+#define HCLGE_CMDQ_TX_TIMEOUT		30000
 
 struct hclge_dev;
 struct hclge_desc {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
index 2caca93..621c6cb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include "hnae3.h"
 
-#define HCLGEVF_CMDQ_TX_TIMEOUT		200
+#define HCLGEVF_CMDQ_TX_TIMEOUT		30000
 #define HCLGEVF_CMDQ_RX_INVLD_B		0
 #define HCLGEVF_CMDQ_RX_OUTVLD_B	1
 
-- 
2.9.3
