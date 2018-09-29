Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A091C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF1B2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF1B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeI2V1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:27:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57455 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbeI2V13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:27:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4C05930FECE4;
        Sat, 29 Sep 2018 22:58:42 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.85.66) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 22:58:36 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH V2 net-next 03/10] net: hns3: Rename loop mode
Date:   Sat, 29 Sep 2018 15:56:15 +0100
Message-ID: <20180929145622.5448-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180929145622.5448-1-salil.mehta@huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

Our loop mode includes mac loop, serdes loop and phy loop. Not all of them
are related with mac. This patch corrects their names.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |  8 ++++----
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c      | 12 ++++++------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 564afd4c1323..03d7878c6168 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -84,10 +84,10 @@ struct hnae3_queue {
 
 /*hnae3 loop mode*/
 enum hnae3_loop {
-	HNAE3_MAC_INTER_LOOP_MAC,
-	HNAE3_MAC_INTER_LOOP_SERDES,
-	HNAE3_MAC_INTER_LOOP_PHY,
-	HNAE3_MAC_LOOP_NONE,
+	HNAE3_LOOP_MAC,
+	HNAE3_LOOP_SERDES,
+	HNAE3_LOOP_PHY,
+	HNAE3_LOOP_NONE,
 };
 
 enum hnae3_client_type {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 8803a8721c8e..86587cf2a676 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -78,8 +78,8 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 		return -EOPNOTSUPP;
 
 	switch (loop) {
-	case HNAE3_MAC_INTER_LOOP_SERDES:
-	case HNAE3_MAC_INTER_LOOP_MAC:
+	case HNAE3_LOOP_SERDES:
+	case HNAE3_LOOP_MAC:
 		ret = h->ae_algo->ops->set_loopback(h, loop, en);
 		break;
 	default:
@@ -286,12 +286,12 @@ static void hns3_self_test(struct net_device *ndev,
 	if (eth_test->flags != ETH_TEST_FL_OFFLINE)
 		return;
 
-	st_param[HNAE3_MAC_INTER_LOOP_MAC][0] = HNAE3_MAC_INTER_LOOP_MAC;
-	st_param[HNAE3_MAC_INTER_LOOP_MAC][1] =
+	st_param[HNAE3_LOOP_MAC][0] = HNAE3_LOOP_MAC;
+	st_param[HNAE3_LOOP_MAC][1] =
 			h->flags & HNAE3_SUPPORT_MAC_LOOPBACK;
 
-	st_param[HNAE3_MAC_INTER_LOOP_SERDES][0] = HNAE3_MAC_INTER_LOOP_SERDES;
-	st_param[HNAE3_MAC_INTER_LOOP_SERDES][1] =
+	st_param[HNAE3_LOOP_SERDES][0] = HNAE3_LOOP_SERDES;
+	st_param[HNAE3_LOOP_SERDES][1] =
 			h->flags & HNAE3_SUPPORT_SERDES_LOOPBACK;
 
 	if (if_running)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2de5a0061dc9..33e97fcfe74e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -523,19 +523,19 @@ static void hclge_get_strings(struct hnae3_handle *handle,
 	} else if (stringset == ETH_SS_TEST) {
 		if (handle->flags & HNAE3_SUPPORT_MAC_LOOPBACK) {
 			memcpy(p,
-			       hns3_nic_test_strs[HNAE3_MAC_INTER_LOOP_MAC],
+			       hns3_nic_test_strs[HNAE3_LOOP_MAC],
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
 		if (handle->flags & HNAE3_SUPPORT_SERDES_LOOPBACK) {
 			memcpy(p,
-			       hns3_nic_test_strs[HNAE3_MAC_INTER_LOOP_SERDES],
+			       hns3_nic_test_strs[HNAE3_LOOP_SERDES],
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
 		if (handle->flags & HNAE3_SUPPORT_PHY_LOOPBACK) {
 			memcpy(p,
-			       hns3_nic_test_strs[HNAE3_MAC_INTER_LOOP_PHY],
+			       hns3_nic_test_strs[HNAE3_LOOP_PHY],
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
@@ -3459,10 +3459,10 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 	int i, ret;
 
 	switch (loop_mode) {
-	case HNAE3_MAC_INTER_LOOP_MAC:
+	case HNAE3_LOOP_MAC:
 		ret = hclge_set_mac_loopback(hdev, en);
 		break;
-	case HNAE3_MAC_INTER_LOOP_SERDES:
+	case HNAE3_LOOP_SERDES:
 		ret = hclge_set_serdes_loopback(hdev, en);
 		break;
 	default:
-- 
2.11.0


