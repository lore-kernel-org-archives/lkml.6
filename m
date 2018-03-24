Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCXDBS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 23:01:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752084AbeCXDBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 23:01:13 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 2/5] net: hns3: fix for returning wrong value problem in hns3_get_rss_indir_size
Date: Sat, 24 Mar 2018 11:32:44 +0800
Message-ID: <1521862367-111399-3-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
References: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

The return type of hns3_get_rss_indir_size is u32. But a negative value is
returned. This patch fixes it by replacing the negative value with zero.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index ac523c9..eb3c34f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -649,7 +649,7 @@ static u32 hns3_get_rss_indir_size(struct net_device *netdev)
 
 	if (!h->ae_algo || !h->ae_algo->ops ||
 	    !h->ae_algo->ops->get_rss_indir_size)
-		return -EOPNOTSUPP;
+		return 0;
 
 	return h->ae_algo->ops->get_rss_indir_size(h);
 }
-- 
2.9.3
