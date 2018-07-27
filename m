Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCAEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31972088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31972088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeG0DWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:22:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731963AbeG0DWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:22:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 282C7357F7BB3;
        Fri, 27 Jul 2018 10:03:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 10:02:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linyunsheng@huawei.com>, <matthias.bgg@gmail.com>,
        <lipeng321@huawei.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: hns: make hns_dsaf_roce_reset non static
Date:   Fri, 27 Jul 2018 09:53:12 +0800
Message-ID: <20180727015312.19256-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hns_dsaf_roce_reset is exported and used in hns_roce_hw_v1.c
In commit 336a443bd9dd ("net: hns: Make many functions static") I make
it static wrongly.

drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
hns_roce_hw_v1.c:(.text+0x37ac): undefined reference to `hns_dsaf_roce_reset'
hns_roce_hw_v1.c:(.text+0x37cc): undefined reference to `hns_dsaf_roce_reset'

Fixes: 336a443bd9dd ("net: hns: Make many functions static")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 7afc675..619e6ce 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2836,7 +2836,7 @@ module_platform_driver(g_dsaf_driver);
  * @enable: false - request reset , true - drop reset
  * retuen 0 - success , negative -fail
  */
-static int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
+int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 {
 	struct dsaf_device *dsaf_dev;
 	struct platform_device *pdev;
-- 
2.7.0


