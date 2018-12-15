Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F966206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbeLOPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:32:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729687AbeLOPcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:32:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C31627A69A34;
        Sat, 15 Dec 2018 23:32:43 +0800 (CST)
Received: from S00293818-DELL1.home (10.47.95.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 23:32:37 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH V2 net-next 1/6] net: hns3: Add "bd info" query function
Date:   Sat, 15 Dec 2018 15:31:53 +0000
Message-ID: <20181215153158.1239-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215153158.1239-1-salil.mehta@huawei.com>
References: <20181215153158.1239-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.95.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints Sending and receiving
package descriptor information.

debugfs command:
echo dump bd info 1 > cmd

Sample Command:
root@(none)# echo bd info 1 > cmd
hns3 0000:7d:00.0: TX Queue Num: 0, BD Index: 0
hns3 0000:7d:00.0: (TX) addr: 0x0
hns3 0000:7d:00.0: (TX)vlan_tag: 0
hns3 0000:7d:00.0: (TX)send_size: 0
hns3 0000:7d:00.0: (TX)vlan_tso: 0
hns3 0000:7d:00.0: (TX)l2_len: 0
hns3 0000:7d:00.0: (TX)l3_len: 0
hns3 0000:7d:00.0: (TX)l4_len: 0
hns3 0000:7d:00.0: (TX)vlan_tag: 0
hns3 0000:7d:00.0: (TX)tv: 0
hns3 0000:7d:00.0: (TX)vlan_msec: 0
hns3 0000:7d:00.0: (TX)ol2_len: 0
hns3 0000:7d:00.0: (TX)ol3_len: 0
hns3 0000:7d:00.0: (TX)ol4_len: 0
hns3 0000:7d:00.0: (TX)paylen: 0
hns3 0000:7d:00.0: (TX)vld_ra_ri: 0
hns3 0000:7d:00.0: (TX)mss: 0
hns3 0000:7d:00.0: RX Queue Num: 0, BD Index: 120
hns3 0000:7d:00.0: (RX)addr: 0xffee7000
hns3 0000:7d:00.0: (RX)pkt_len: 0
hns3 0000:7d:00.0: (RX)size: 0
hns3 0000:7d:00.0: (RX)rss_hash: 0
hns3 0000:7d:00.0: (RX)fd_id: 0
hns3 0000:7d:00.0: (RX)vlan_tag: 0
hns3 0000:7d:00.0: (RX)o_dm_vlan_id_fb: 0
hns3 0000:7d:00.0: (RX)ot_vlan_tag: 0
hns3 0000:7d:00.0: (RX)bd_base_info: 0

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 79 +++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 86d667a3730a..9a026556df0e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -52,7 +52,7 @@ static int hns3_dbg_queue_info(struct hnae3_handle *h, char *cmd_buf)
 		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
 			return -EPERM;
 
-		ring = ring_data[i + h->kinfo.num_tqps].ring;
+		ring = ring_data[(u32)(i + h->kinfo.num_tqps)].ring;
 		base_add_h = readl_relaxed(ring->tqp->io_base +
 					   HNS3_RING_RX_RING_BASEADDR_H_REG);
 		base_add_l = readl_relaxed(ring->tqp->io_base +
@@ -125,10 +125,85 @@ static int hns3_dbg_queue_info(struct hnae3_handle *h, char *cmd_buf)
 	return 0;
 }
 
+static int hns3_dbg_bd_info(struct hnae3_handle *h, char *cmd_buf)
+{
+	struct hns3_nic_priv *priv = h->priv;
+	struct hns3_nic_ring_data *ring_data;
+	struct hns3_desc *rx_desc, *tx_desc;
+	struct device *dev = &h->pdev->dev;
+	struct hns3_enet_ring *ring;
+	u32 tx_index, rx_index;
+	u32 q_num, value;
+	int cnt;
+
+	cnt = sscanf(&cmd_buf[8], "%u %u", &q_num, &tx_index);
+	if (cnt == 2) {
+		rx_index = tx_index;
+	} else if (cnt != 1) {
+		dev_err(dev, "bd info: bad command string, cnt=%d\n", cnt);
+		return -EINVAL;
+	}
+
+	if (q_num >= h->kinfo.num_tqps) {
+		dev_err(dev, "Queue number(%u) is out of range(%u)\n", q_num,
+			h->kinfo.num_tqps - 1);
+		return -EINVAL;
+	}
+
+	ring_data = priv->ring_data;
+	ring  = ring_data[q_num].ring;
+	value = readl_relaxed(ring->tqp->io_base + HNS3_RING_TX_RING_TAIL_REG);
+	tx_index = (cnt == 1) ? value : tx_index;
+
+	if (tx_index >= ring->desc_num) {
+		dev_err(dev, "bd index (%u) is out of range(%u)\n", tx_index,
+			ring->desc_num - 1);
+		return -EINVAL;
+	}
+
+	tx_desc = &ring->desc[tx_index];
+	dev_info(dev, "TX Queue Num: %u, BD Index: %u\n", q_num, tx_index);
+	dev_info(dev, "(TX) addr: 0x%llx\n", tx_desc->addr);
+	dev_info(dev, "(TX)vlan_tag: %u\n", tx_desc->tx.vlan_tag);
+	dev_info(dev, "(TX)send_size: %u\n", tx_desc->tx.send_size);
+	dev_info(dev, "(TX)vlan_tso: %u\n", tx_desc->tx.type_cs_vlan_tso);
+	dev_info(dev, "(TX)l2_len: %u\n", tx_desc->tx.l2_len);
+	dev_info(dev, "(TX)l3_len: %u\n", tx_desc->tx.l3_len);
+	dev_info(dev, "(TX)l4_len: %u\n", tx_desc->tx.l4_len);
+	dev_info(dev, "(TX)vlan_tag: %u\n", tx_desc->tx.outer_vlan_tag);
+	dev_info(dev, "(TX)tv: %u\n", tx_desc->tx.tv);
+	dev_info(dev, "(TX)vlan_msec: %u\n", tx_desc->tx.ol_type_vlan_msec);
+	dev_info(dev, "(TX)ol2_len: %u\n", tx_desc->tx.ol2_len);
+	dev_info(dev, "(TX)ol3_len: %u\n", tx_desc->tx.ol3_len);
+	dev_info(dev, "(TX)ol4_len: %u\n", tx_desc->tx.ol4_len);
+	dev_info(dev, "(TX)paylen: %u\n", tx_desc->tx.paylen);
+	dev_info(dev, "(TX)vld_ra_ri: %u\n", tx_desc->tx.bdtp_fe_sc_vld_ra_ri);
+	dev_info(dev, "(TX)mss: %u\n", tx_desc->tx.mss);
+
+	ring  = ring_data[q_num + h->kinfo.num_tqps].ring;
+	value = readl_relaxed(ring->tqp->io_base + HNS3_RING_RX_RING_TAIL_REG);
+	rx_index = (cnt == 1) ? value : tx_index;
+	rx_desc	 = &ring->desc[rx_index];
+
+	dev_info(dev, "RX Queue Num: %u, BD Index: %u\n", q_num, rx_index);
+	dev_info(dev, "(RX)addr: 0x%llx\n", rx_desc->addr);
+	dev_info(dev, "(RX)pkt_len: %u\n", rx_desc->rx.pkt_len);
+	dev_info(dev, "(RX)size: %u\n", rx_desc->rx.size);
+	dev_info(dev, "(RX)rss_hash: %u\n", rx_desc->rx.rss_hash);
+	dev_info(dev, "(RX)fd_id: %u\n", rx_desc->rx.fd_id);
+	dev_info(dev, "(RX)vlan_tag: %u\n", rx_desc->rx.vlan_tag);
+	dev_info(dev, "(RX)o_dm_vlan_id_fb: %u\n", rx_desc->rx.o_dm_vlan_id_fb);
+	dev_info(dev, "(RX)ot_vlan_tag: %u\n", rx_desc->rx.ot_vlan_tag);
+	dev_info(dev, "(RX)bd_base_info: %u\n", rx_desc->rx.bd_base_info);
+
+	return 0;
+}
+
 static void hns3_dbg_help(struct hnae3_handle *h)
 {
 	dev_info(&h->pdev->dev, "available commands\n");
 	dev_info(&h->pdev->dev, "queue info [number]\n");
+	dev_info(&h->pdev->dev, "bd info [q_num] <bd index>\n");
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
 	dev_info(&h->pdev->dev, "dump tc\n");
 	dev_info(&h->pdev->dev, "dump tm\n");
@@ -205,6 +280,8 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 		hns3_dbg_help(handle);
 	else if (strncmp(cmd_buf, "queue info", 10) == 0)
 		ret = hns3_dbg_queue_info(handle, cmd_buf);
+	else if (strncmp(cmd_buf, "bd info", 7) == 0)
+		ret = hns3_dbg_bd_info(handle, cmd_buf);
 	else if (handle->ae_algo->ops->dbg_run_cmd)
 		ret = handle->ae_algo->ops->dbg_run_cmd(handle, cmd_buf);
 
-- 
2.11.0


