Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeESPzA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:55:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752586AbeESPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:56 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 6/9] net: hns3: Use enums instead of magic number in hclge_is_special_opcode
Date: Sat, 19 May 2018 16:53:20 +0100
Message-ID: <20180519155323.68960-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180519155323.68960-1-salil.mehta@huawei.com>
References: <20180519155323.68960-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

This patch does bit of a clean-up by using already defined enums for
certain values in function hclge_is_special_opcode(). Below enums from
have been used as replacements for magic values:

enum hclge_opcode_type{
	<snip>
	HCLGE_OPC_STATS_64_BIT		= 0x0030,
	HCLGE_OPC_STATS_32_BIT		= 0x0031,
	HCLGE_OPC_STATS_MAC		= 0x0032,
	<snip>
};

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index fab7068..59fb0eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -190,7 +190,11 @@ static int hclge_cmd_csq_done(struct hclge_hw *hw)
 
 static bool hclge_is_special_opcode(u16 opcode)
 {
-	u16 spec_opcode[3] = {0x0030, 0x0031, 0x0032};
+	/* these commands have several descriptors,
+	 * and use the first one to save opcode and return value
+	 */
+	u16 spec_opcode[3] = {HCLGE_OPC_STATS_64_BIT,
+		HCLGE_OPC_STATS_32_BIT, HCLGE_OPC_STATS_MAC};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(spec_opcode); i++) {
-- 
2.7.4
