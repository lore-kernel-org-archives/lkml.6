Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeDDJOn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:14:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751306AbeDDJOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:14:42 -0400
From: Tan Xiaojun <tanxiaojun@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>
CC: <huawei.libin@huawei.com>, <tanxiaojun@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <linyunsheng@huawei.com>
Subject: [PATCH] net: hns3: fix length overflow when CONFIG_ARM64_64K_PAGES
Date: Wed, 4 Apr 2018 17:40:48 +0800
Message-ID: <1522834848-63974-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable the config item "CONFIG_ARM64_64K_PAGES", the size of PAGE_SIZE
is 65536(64K). But the type of length is u16, it will overflow. So change it
to u32.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 9e4cfbb..98cdbd3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -288,7 +288,7 @@ struct hns3_desc_cb {
 	u16 page_offset;
 	u16 reuse_flag;
 
-	u16 length;     /* length of the buffer */
+	u32 length;     /* length of the buffer */
 
        /* desc type, used by the ring user to mark the type of the priv data */
 	u16 type;
-- 
2.7.4
