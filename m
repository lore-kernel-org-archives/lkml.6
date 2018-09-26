Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98311C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF292152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF292152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeI0An4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:43:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36373 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbeI0An4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34D70149A7C34;
        Thu, 27 Sep 2018 02:29:39 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 02:29:32 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 04/10] net: hns3: Rename mac loopback to app loopback
Date:   Wed, 26 Sep 2018 19:28:34 +0100
Message-ID: <20180926182840.28392-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180926182840.28392-1-salil.mehta@huawei.com>
References: <20180926182840.28392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

In fact, our implementation of mac loopback is the implementation of app
loopback now. Current name is wrong. This patch renames mac loopback to
app loopback.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |  4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c      |  8 ++++----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 03d7878..27155ea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -84,7 +84,7 @@ struct hnae3_queue {
 
 /*hnae3 loop mode*/
 enum hnae3_loop {
-	HNAE3_LOOP_MAC,
+	HNAE3_LOOP_APP,
 	HNAE3_LOOP_SERDES,
 	HNAE3_LOOP_PHY,
 	HNAE3_LOOP_NONE,
@@ -478,7 +478,7 @@ struct hnae3_unic_private_info {
 	struct hnae3_queue **tqp;  /* array base of all TQPs of this instance */
 };
 
-#define HNAE3_SUPPORT_MAC_LOOPBACK    BIT(0)
+#define HNAE3_SUPPORT_APP_LOOPBACK    BIT(0)
 #define HNAE3_SUPPORT_PHY_LOOPBACK    BIT(1)
 #define HNAE3_SUPPORT_SERDES_LOOPBACK BIT(2)
 #define HNAE3_SUPPORT_VF	      BIT(3)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 86587cf..75ebd2e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -79,7 +79,7 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 
 	switch (loop) {
 	case HNAE3_LOOP_SERDES:
-	case HNAE3_LOOP_MAC:
+	case HNAE3_LOOP_APP:
 		ret = h->ae_algo->ops->set_loopback(h, loop, en);
 		break;
 	default:
@@ -286,9 +286,9 @@ static void hns3_self_test(struct net_device *ndev,
 	if (eth_test->flags != ETH_TEST_FL_OFFLINE)
 		return;
 
-	st_param[HNAE3_LOOP_MAC][0] = HNAE3_LOOP_MAC;
-	st_param[HNAE3_LOOP_MAC][1] =
-			h->flags & HNAE3_SUPPORT_MAC_LOOPBACK;
+	st_param[HNAE3_LOOP_APP][0] = HNAE3_LOOP_APP;
+	st_param[HNAE3_LOOP_APP][1] =
+			h->flags & HNAE3_SUPPORT_APP_LOOPBACK;
 
 	st_param[HNAE3_LOOP_SERDES][0] = HNAE3_LOOP_SERDES;
 	st_param[HNAE3_LOOP_SERDES][1] =
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 33e97fc..a0f6329 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -49,7 +49,7 @@ static const struct pci_device_id ae_algo_pci_tbl[] = {
 MODULE_DEVICE_TABLE(pci, ae_algo_pci_tbl);
 
 static const char hns3_nic_test_strs[][ETH_GSTRING_LEN] = {
-	"Mac    Loopback test",
+	"App    Loopback test",
 	"Serdes Loopback test",
 	"Phy    Loopback test"
 };
@@ -493,7 +493,7 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 		    hdev->hw.mac.speed == HCLGE_MAC_SPEED_100M ||
 		    hdev->hw.mac.speed == HCLGE_MAC_SPEED_1G) {
 			count += 1;
-			handle->flags |= HNAE3_SUPPORT_MAC_LOOPBACK;
+			handle->flags |= HNAE3_SUPPORT_APP_LOOPBACK;
 		}
 
 		count++;
@@ -521,9 +521,9 @@ static void hclge_get_strings(struct hnae3_handle *handle,
 					   p);
 		p = hclge_tqps_get_strings(handle, p);
 	} else if (stringset == ETH_SS_TEST) {
-		if (handle->flags & HNAE3_SUPPORT_MAC_LOOPBACK) {
+		if (handle->flags & HNAE3_SUPPORT_APP_LOOPBACK) {
 			memcpy(p,
-			       hns3_nic_test_strs[HNAE3_LOOP_MAC],
+			       hns3_nic_test_strs[HNAE3_LOOP_APP],
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
@@ -3345,7 +3345,7 @@ static void hclge_cfg_mac_mode(struct hclge_dev *hdev, bool enable)
 			"mac enable fail, ret =%d.\n", ret);
 }
 
-static int hclge_set_mac_loopback(struct hclge_dev *hdev, bool en)
+static int hclge_set_app_loopback(struct hclge_dev *hdev, bool en)
 {
 	struct hclge_config_mac_mode_cmd *req;
 	struct hclge_desc desc;
@@ -3459,8 +3459,8 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 	int i, ret;
 
 	switch (loop_mode) {
-	case HNAE3_LOOP_MAC:
-		ret = hclge_set_mac_loopback(hdev, en);
+	case HNAE3_LOOP_APP:
+		ret = hclge_set_app_loopback(hdev, en);
 		break;
 	case HNAE3_LOOP_SERDES:
 		ret = hclge_set_serdes_loopback(hdev, en);
-- 
2.7.4


