Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED839C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18302159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18302159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbeIUVc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42971 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389547AbeIUVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:25 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC7E8C761168D;
        Fri, 21 Sep 2018 23:42:52 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:42:47 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: Adjust prefix of tx/rx statistic names
Date:   Fri, 21 Sep 2018 16:41:39 +0100
Message-ID: <20180921154148.26756-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Some prefix of tx/rx statistic names are redundant, this patch modifies
these names.

The new prefix looks like below:
rxq#1_ -> rxq1_
txq#1_ -> txq1_
tx_dropped -> dropped
tx_wake -> wake
tx_busy -> busy
rx_dropped -> dropped

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        | 10 +++++-----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 3cfb6b8..ce2e6ea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -22,13 +22,13 @@ struct hns3_stats {
 static const struct hns3_stats hns3_txq_stats[] = {
 	/* Tx per-queue statistics */
 	HNS3_TQP_STAT("io_err_cnt", io_err_cnt),
-	HNS3_TQP_STAT("tx_dropped", sw_err_cnt),
+	HNS3_TQP_STAT("dropped", sw_err_cnt),
 	HNS3_TQP_STAT("seg_pkt_cnt", seg_pkt_cnt),
 	HNS3_TQP_STAT("packets", tx_pkts),
 	HNS3_TQP_STAT("bytes", tx_bytes),
 	HNS3_TQP_STAT("errors", tx_err_cnt),
-	HNS3_TQP_STAT("tx_wake", restart_queue),
-	HNS3_TQP_STAT("tx_busy", tx_busy),
+	HNS3_TQP_STAT("wake", restart_queue),
+	HNS3_TQP_STAT("busy", tx_busy),
 };
 
 #define HNS3_TXQ_STATS_COUNT ARRAY_SIZE(hns3_txq_stats)
@@ -36,7 +36,7 @@ static const struct hns3_stats hns3_txq_stats[] = {
 static const struct hns3_stats hns3_rxq_stats[] = {
 	/* Rx per-queue statistics */
 	HNS3_TQP_STAT("io_err_cnt", io_err_cnt),
-	HNS3_TQP_STAT("rx_dropped", sw_err_cnt),
+	HNS3_TQP_STAT("dropped", sw_err_cnt),
 	HNS3_TQP_STAT("seg_pkt_cnt", seg_pkt_cnt),
 	HNS3_TQP_STAT("packets", rx_pkts),
 	HNS3_TQP_STAT("bytes", rx_bytes),
@@ -369,7 +369,7 @@ static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
 			data[ETH_GSTRING_LEN - 1] = '\0';
 
 			/* first, prepend the prefix string */
-			n1 = snprintf(data, MAX_PREFIX_SIZE, "%s#%d_",
+			n1 = snprintf(data, MAX_PREFIX_SIZE, "%s%d_",
 				      prefix, i);
 			n1 = min_t(uint, n1, MAX_PREFIX_SIZE - 1);
 			size_left = (ETH_GSTRING_LEN - 1) - n1;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e9625ce..86d3d8b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -354,7 +354,7 @@ static u8 *hclge_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		struct hclge_tqp *tqp = container_of(handle->kinfo.tqp[i],
 			struct hclge_tqp, q);
-		snprintf(buff, ETH_GSTRING_LEN, "txq#%d_pktnum_rcd",
+		snprintf(buff, ETH_GSTRING_LEN, "txq%d_pktnum_rcd",
 			 tqp->index);
 		buff = buff + ETH_GSTRING_LEN;
 	}
@@ -362,7 +362,7 @@ static u8 *hclge_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		struct hclge_tqp *tqp = container_of(kinfo->tqp[i],
 			struct hclge_tqp, q);
-		snprintf(buff, ETH_GSTRING_LEN, "rxq#%d_pktnum_rcd",
+		snprintf(buff, ETH_GSTRING_LEN, "rxq%d_pktnum_rcd",
 			 tqp->index);
 		buff = buff + ETH_GSTRING_LEN;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 166a2cf..c220d9b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -110,7 +110,7 @@ static u8 *hclgevf_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 	for (i = 0; i < hdev->num_tqps; i++) {
 		struct hclgevf_tqp *tqp = container_of(handle->kinfo.tqp[i],
 			struct hclgevf_tqp, q);
-		snprintf(buff, ETH_GSTRING_LEN, "txq#%d_pktnum_rcd",
+		snprintf(buff, ETH_GSTRING_LEN, "txq%d_pktnum_rcd",
 			 tqp->index);
 		buff += ETH_GSTRING_LEN;
 	}
@@ -118,7 +118,7 @@ static u8 *hclgevf_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 	for (i = 0; i < hdev->num_tqps; i++) {
 		struct hclgevf_tqp *tqp = container_of(handle->kinfo.tqp[i],
 			struct hclgevf_tqp, q);
-		snprintf(buff, ETH_GSTRING_LEN, "rxq#%d_pktnum_rcd",
+		snprintf(buff, ETH_GSTRING_LEN, "rxq%d_pktnum_rcd",
 			 tqp->index);
 		buff += ETH_GSTRING_LEN;
 	}
-- 
2.7.4


