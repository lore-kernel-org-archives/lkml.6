Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCWJyu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:54:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60530 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeCWJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:54:49 -0400
From: Colin King <colin.king@canonical.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peng Li <lipeng321@huawei.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: hns3: make function hclge_inform_reset_assert_to_vf static
Date: Fri, 23 Mar 2018 09:54:44 +0000
Message-Id: <20180323095444.26271-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function hclge_inform_reset_assert_to_vf is local to the source and
does not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c:82:5: warning:
symbol 'hclge_inform_reset_assert_to_vf' was not declared. Should it
be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 39013334a613..a6f7ffa9c259 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -79,7 +79,7 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 	return status;
 }
 
-int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
+static int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
 {
 	u8 msg_data[2];
 	u8 dest_vfid;
-- 
2.15.1
