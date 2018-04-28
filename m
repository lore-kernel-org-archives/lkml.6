Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759525AbeD1GQI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 02:16:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751844AbeD1GQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 02:16:06 -0400
From: Pengcheng Li <lipengcheng8@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <lipengcheng8@huawei.com>, <yaobaofeng@huawei.com>,
        <lijiangxiong@hisilicon.com>, <kongfei@hisilicon.com>
Subject: [PATCH] misc: st_core: Fix skb double free corruption
Date: Sat, 28 Apr 2018 14:07:49 +0800
Message-ID: <1524895669-47953-1-git-send-email-lipengcheng8@huawei.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.181.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When some failures happened in hci_recv_frame() function,
skb is freed by both hci_recv_frame and st_send_frame

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Yao Baofeng <yaobaofeng@huawei.com>
Signed-off-by: Li Jiangxiong <lijiangxiong@hisilicon.com>
---
 drivers/misc/ti-st/st_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 0005159..f4ce211 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -124,7 +124,6 @@ static void st_send_frame(unsigned char chnl_id, struct st_data_s *st_gdata)
 			(st_gdata->list[chnl_id]->priv_data, st_gdata->rx_skb)
 			     != 0)) {
 			pr_err(" proto stack %d's ->recv failed", chnl_id);
-			kfree_skb(st_gdata->rx_skb);
 			return;
 		}
 	} else {
-- 
2.8.0
