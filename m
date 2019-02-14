Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC20C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753642229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XkhUWKhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395444AbfBNS2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:28:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60438 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394212AbfBNS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:28:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EISCcZ066050;
        Thu, 14 Feb 2019 12:28:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550168892;
        bh=7AphfzT6sJ9IjLDsLO5s6pDHeYN50/XKzARORGto9HM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XkhUWKhbFsKqoPF+fTD0mEX1jeNi4ALneiwx2Slc3Hm/QYlinkDG+vNUHok5wh0sl
         yq7EgGwE+1WBLfyGIevjcHl7NrWPfidaGRUqywokgdSIrNsWBsauxFwiCmCBUHeLzc
         fS7ffPE8rUoLtDPfEwS9DNu8fVaDQk3zI87GuXWU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EISCCI117626
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 12:28:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 12:28:11 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 12:28:11 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EISBlV011742;
        Thu, 14 Feb 2019 12:28:11 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.120.181])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x1EISBU11354;
        Thu, 14 Feb 2019 12:28:11 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 3/5] can: m_can: Rename m_can_priv to m_can_classdev
Date:   Thu, 14 Feb 2019 12:27:52 -0600
Message-ID: <20190214182754.30721-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190214182754.30721-1-dmurphy@ti.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the common m_can_priv class structure to
m_can_classdev as this is more descriptive.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v5 - New patch per comment in v4 - https://lore.kernel.org/patchwork/patch/1033095/

 drivers/net/can/m_can/m_can.c          | 95 +++++++++++++-------------
 drivers/net/can/m_can/m_can.h          | 28 ++++----
 drivers/net/can/m_can/m_can_platform.c | 16 ++---
 3 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2ceccb870557..cc51e385fd83 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -269,7 +269,7 @@
 #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
 #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
 
-static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
+static u32 m_can_read(struct m_can_classdev *priv, enum m_can_reg reg)
 {
 	u32 ret = -EINVAL;
 
@@ -279,7 +279,7 @@ static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
 	return ret;
 }
 
-static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
+static int m_can_write(struct m_can_classdev *priv, enum m_can_reg reg, u32 val)
 {
 	int ret = -EINVAL;
 
@@ -289,7 +289,7 @@ static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
 	return ret;
 }
 
-static u32 m_can_fifo_read(struct m_can_priv *priv,
+static u32 m_can_fifo_read(struct m_can_classdev *priv,
 			   u32 fgi, unsigned int offset)
 {
 	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE + offset;
@@ -301,7 +301,7 @@ static u32 m_can_fifo_read(struct m_can_priv *priv,
 	return ret;
 }
 
-static u32 m_can_fifo_write(struct m_can_priv *priv,
+static u32 m_can_fifo_write(struct m_can_classdev *priv,
 			    u32 fpi, unsigned int offset, u32 val)
 {
 	u32 addr_offset =  priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE + offset;
@@ -313,7 +313,7 @@ static u32 m_can_fifo_write(struct m_can_priv *priv,
 	return ret;
 }
 
-static u32 m_can_fifo_write_no_off(struct m_can_priv *priv,
+static u32 m_can_fifo_write_no_off(struct m_can_classdev *priv,
 				   u32 fpi, u32 val)
 {
 	u32 ret = 0;
@@ -324,7 +324,7 @@ static u32 m_can_fifo_write_no_off(struct m_can_priv *priv,
 	return ret;
 }
 
-static u32 m_can_txe_fifo_read(struct m_can_priv *priv, u32 fgi, u32 offset)
+static u32 m_can_txe_fifo_read(struct m_can_classdev *priv, u32 fgi, u32 offset)
 {
 	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE + offset;
 	u32 ret = -EINVAL;
@@ -335,12 +335,12 @@ static u32 m_can_txe_fifo_read(struct m_can_priv *priv, u32 fgi, u32 offset)
 	return ret;
 }
 
-static inline bool m_can_tx_fifo_full(struct m_can_priv *priv)
+static inline bool m_can_tx_fifo_full(struct m_can_classdev *priv)
 {
 		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
 }
 
-void m_can_config_endisable(struct m_can_priv *priv, bool enable)
+void m_can_config_endisable(struct m_can_classdev *priv, bool enable)
 {
 	u32 cccr = m_can_read(priv, M_CAN_CCCR);
 	u32 timeout = 10;
@@ -373,13 +373,13 @@ void m_can_config_endisable(struct m_can_priv *priv, bool enable)
 	}
 }
 
-static inline void m_can_enable_all_interrupts(struct m_can_priv *priv)
+static inline void m_can_enable_all_interrupts(struct m_can_classdev *priv)
 {
 	/* Only interrupt line 0 is used in this driver */
 	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
 }
 
-static inline void m_can_disable_all_interrupts(struct m_can_priv *priv)
+static inline void m_can_disable_all_interrupts(struct m_can_classdev *priv)
 {
 	m_can_write(priv, M_CAN_ILE, 0x0);
 }
@@ -387,7 +387,7 @@ static inline void m_can_disable_all_interrupts(struct m_can_priv *priv)
 static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 {
 	struct net_device_stats *stats = &dev->stats;
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
 	u32 id, fgi, dlc;
@@ -444,7 +444,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 
 static int m_can_do_rx_poll(struct net_device *dev, int quota)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	u32 pkts = 0;
 	u32 rxfs;
 
@@ -497,7 +497,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 static int m_can_handle_lec_err(struct net_device *dev,
 				enum m_can_lec_type lec_type)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
@@ -554,7 +554,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 static int __m_can_get_berr_counter(const struct net_device *dev,
 				    struct can_berr_counter *bec)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	unsigned int ecr;
 
 	ecr = m_can_read(priv, M_CAN_ECR);
@@ -564,7 +564,7 @@ static int __m_can_get_berr_counter(const struct net_device *dev,
 	return 0;
 }
 
-static int m_can_clk_start(struct m_can_priv *priv)
+static int m_can_clk_start(struct m_can_classdev *priv)
 {
 	int err;
 
@@ -580,7 +580,7 @@ static int m_can_clk_start(struct m_can_priv *priv)
 	return 0;
 }
 
-static void m_can_clk_stop(struct m_can_priv *priv)
+static void m_can_clk_stop(struct m_can_classdev *priv)
 {
 	if (priv->pm_clock_support)
 		pm_runtime_put_sync(priv->dev);
@@ -589,7 +589,7 @@ static void m_can_clk_stop(struct m_can_priv *priv)
 static int m_can_get_berr_counter(const struct net_device *dev,
 				  struct can_berr_counter *bec)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int err;
 
 	err = m_can_clk_start(priv);
@@ -606,7 +606,7 @@ static int m_can_get_berr_counter(const struct net_device *dev,
 static int m_can_handle_state_change(struct net_device *dev,
 				     enum can_state new_state)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
@@ -680,7 +680,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 
 static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 
 	if ((psr & PSR_EW) &&
@@ -733,7 +733,7 @@ static inline bool is_lec_err(u32 psr)
 static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 				   u32 psr)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 
 	if (irqstatus & IR_RF0L)
@@ -752,7 +752,7 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 
 static int m_can_rx_handler(struct net_device *dev, int quota)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 	u32 irqstatus, psr;
 
@@ -775,7 +775,7 @@ static int m_can_rx_handler(struct net_device *dev, int quota)
 
 static int m_can_rx_peripherial(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	m_can_rx_handler(dev, 1);
 
@@ -787,7 +787,7 @@ static int m_can_rx_peripherial(struct net_device *dev)
 static int m_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 
 	work_done = m_can_rx_handler(dev, quota);
@@ -807,7 +807,7 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	int i = 0;
 	unsigned int msg_mark;
 
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 
 	/* read tx event fifo status */
@@ -840,7 +840,7 @@ static void m_can_echo_tx_event(struct net_device *dev)
 static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	u32 ir;
 
@@ -941,7 +941,7 @@ static const struct can_bittiming_const m_can_data_bittiming_const_31X = {
 
 static int m_can_set_bittiming(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
@@ -1014,7 +1014,7 @@ static int m_can_set_bittiming(struct net_device *dev)
  */
 static void m_can_chip_config(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	u32 cccr, test;
 
 	m_can_config_endisable(priv, true);
@@ -1126,7 +1126,7 @@ static void m_can_chip_config(struct net_device *dev)
 
 static void m_can_start(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	/* basic m_can configuration */
 	m_can_chip_config(dev);
@@ -1155,7 +1155,7 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
  * else it returns the release and step coded as:
  * return value = 10 * <release> + 1 * <step>
  */
-static int m_can_check_core_release(struct m_can_priv *priv)
+static int m_can_check_core_release(struct m_can_classdev *priv)
 {
 	u32 crel_reg;
 	u8 rel;
@@ -1183,7 +1183,7 @@ static int m_can_check_core_release(struct m_can_priv *priv)
 /* Selectable Non ISO support only in version 3.2.x
  * This function checks if the bit is writable.
  */
-static bool m_can_niso_supported(struct m_can_priv *priv)
+static bool m_can_niso_supported(struct m_can_classdev *priv)
 {
 	u32 cccr_reg, cccr_poll = 0;
 	int niso_timeout = -ETIMEDOUT;
@@ -1210,7 +1210,7 @@ static bool m_can_niso_supported(struct m_can_priv *priv)
 	return !niso_timeout;
 }
 
-static int m_can_dev_setup(struct m_can_priv *m_can_dev)
+static int m_can_dev_setup(struct m_can_classdev *m_can_dev)
 {
 	struct net_device *dev = m_can_dev->net;
 	int m_can_version;
@@ -1303,7 +1303,7 @@ static int m_can_dev_setup(struct m_can_priv *m_can_dev)
 
 static void m_can_stop(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(priv);
@@ -1314,7 +1314,7 @@ static void m_can_stop(struct net_device *dev)
 
 static int m_can_close(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
 	if (!priv->is_peripherial)
@@ -1336,7 +1336,7 @@ static int m_can_close(struct net_device *dev)
 
 static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	/*get wrap around for loopback skb index */
 	unsigned int wrap = priv->can.echo_skb_max;
 	int next_idx;
@@ -1348,7 +1348,7 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 	return !!priv->can.echo_skb[next_idx];
 }
 
-static void m_can_tx_handler(struct m_can_priv *priv)
+static void m_can_tx_handler(struct m_can_classdev *priv)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)priv->skb->data;
 	struct net_device *dev = priv->net;
@@ -1460,7 +1460,7 @@ static void m_can_tx_handler(struct m_can_priv *priv)
 
 static void m_can_tx_work_queue(struct work_struct *ws)
 {
-	struct m_can_priv *priv = container_of(ws, struct m_can_priv,
+	struct m_can_classdev *priv = container_of(ws, struct m_can_classdev,
 						tx_work);
 	m_can_tx_handler(priv);
 }
@@ -1468,8 +1468,7 @@ static void m_can_tx_work_queue(struct work_struct *ws)
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
-
+	struct m_can_classdev *priv = netdev_priv(dev);
 
  	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -1487,7 +1486,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 
 static int m_can_open(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int err;
 
 	err = m_can_clk_start(priv);
@@ -1562,7 +1561,7 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
-static void m_can_of_parse_mram(struct m_can_priv *priv,
+static void m_can_of_parse_mram(struct m_can_classdev *priv,
 				const u32 *mram_config_vals)
 {
 	priv->mcfg[MRAM_SIDF].off = mram_config_vals[0];
@@ -1600,7 +1599,7 @@ static void m_can_of_parse_mram(struct m_can_priv *priv,
 		priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
 }
 
-void m_can_init_ram(struct m_can_priv *priv)
+void m_can_init_ram(struct m_can_classdev *priv)
 {
 	int end, i, start;
 
@@ -1616,7 +1615,7 @@ void m_can_init_ram(struct m_can_priv *priv)
 }
 EXPORT_SYMBOL_GPL(m_can_init_ram);
 
-int m_can_class_get_clocks(struct m_can_priv *m_can_dev)
+int m_can_class_get_clocks(struct m_can_classdev *m_can_dev)
 {
 	int ret = 0;
 
@@ -1632,9 +1631,9 @@ int m_can_class_get_clocks(struct m_can_priv *m_can_dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
-struct m_can_priv *m_can_class_allocate_dev(struct device *dev)
+struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
 {
-	struct m_can_priv *class_dev = NULL;
+	struct m_can_classdev *class_dev = NULL;
 	u32 mram_config_vals[MRAM_CFG_LEN];
 	struct net_device *net_dev;
 	u32 tx_fifo_size;
@@ -1677,7 +1676,7 @@ struct m_can_priv *m_can_class_allocate_dev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
-int m_can_class_register(struct m_can_priv *m_can_dev)
+int m_can_class_register(struct m_can_classdev *m_can_dev)
 {
 	int ret;
 
@@ -1725,7 +1724,7 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 int m_can_class_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *priv = netdev_priv(ndev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
@@ -1745,7 +1744,7 @@ EXPORT_SYMBOL_GPL(m_can_class_suspend);
 int m_can_class_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *priv = netdev_priv(ndev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -1768,7 +1767,7 @@ int m_can_class_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 
-void m_can_class_unregister(struct m_can_priv *m_can_dev)
+void m_can_class_unregister(struct m_can_classdev *m_can_dev)
 {
 	unregister_candev(m_can_dev->net);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 36b1b833d41b..8d1f0f7f5b43 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -107,18 +107,18 @@ struct mram_cfg {
 	u8  num;
 };
 
-struct m_can_priv;
+struct m_can_classdev;
 struct m_can_ops {
 	/* Device specific call backs */
-	int (*clr_dev_interrupts) (struct m_can_priv *m_can_class);
-	u32 (*read_reg) (struct m_can_priv *m_can_class, int reg);
-	int (*write_reg) (struct m_can_priv *m_can_class, int reg, int val);
-	u32 (*read_fifo) (struct m_can_priv *m_can_class, int addr_offset);
-	int (*write_fifo) (struct m_can_priv *m_can_class, int addr_offset, int val);
-	int (*device_init) (struct m_can_priv *m_can_class);
+	int (*clr_dev_interrupts) (struct m_can_classdev *m_can_class);
+	u32 (*read_reg) (struct m_can_classdev *m_can_class, int reg);
+	int (*write_reg) (struct m_can_classdev *m_can_class, int reg, int val);
+	u32 (*read_fifo) (struct m_can_classdev *m_can_class, int addr_offset);
+	int (*write_fifo) (struct m_can_classdev *m_can_class, int addr_offset, int val);
+	int (*device_init) (struct m_can_classdev *m_can_class);
 };
 
-struct m_can_priv {
+struct m_can_classdev {
 	struct can_priv can;
 	struct napi_struct napi;
 	struct net_device *net;
@@ -147,12 +147,12 @@ struct m_can_priv {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
 
-struct m_can_priv *m_can_class_allocate_dev(struct device *dev);
-int m_can_class_register(struct m_can_priv *m_can_dev);
-void m_can_class_unregister(struct m_can_priv *m_can_dev);
-int m_can_class_get_clocks(struct m_can_priv *m_can_dev);
-void m_can_init_ram(struct m_can_priv *priv);
-void m_can_config_endisable(struct m_can_priv *priv, bool enable);
+struct m_can_classdev *m_can_class_allocate_dev(struct device *dev);
+int m_can_class_register(struct m_can_classdev *m_can_dev);
+void m_can_class_unregister(struct m_can_classdev *m_can_dev);
+int m_can_class_get_clocks(struct m_can_classdev *m_can_dev);
+void m_can_init_ram(struct m_can_classdev *priv);
+void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index d8d51bd64205..bc9143764ac8 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -14,21 +14,21 @@ struct m_can_plat_priv {
 	void __iomem *mram_base;
 };
 
-static u32 iomap_read_reg(struct m_can_priv *m_can_class, int reg)
+static u32 iomap_read_reg(struct m_can_classdev *m_can_class, int reg)
 {
 	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
 
 	return readl(priv->base + reg);
 }
 
-static u32 iomap_read_fifo(struct m_can_priv *m_can_class, int offset)
+static u32 iomap_read_fifo(struct m_can_classdev *m_can_class, int offset)
 {
 	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
 
 	return readl(priv->mram_base + offset);
 }
 
-static int iomap_write_reg(struct m_can_priv *m_can_class, int reg, int val)
+static int iomap_write_reg(struct m_can_classdev *m_can_class, int reg, int val)
 {
 	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
 
@@ -37,7 +37,7 @@ static int iomap_write_reg(struct m_can_priv *m_can_class, int reg, int val)
 	return 0;
 }
 
-static int iomap_write_fifo(struct m_can_priv *m_can_class, int offset, int val)
+static int iomap_write_fifo(struct m_can_classdev *m_can_class, int offset, int val)
 {
 	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
 
@@ -55,7 +55,7 @@ static struct m_can_ops m_can_plat_ops = {
 
 static int m_can_plat_probe(struct platform_device *pdev)
 {
-	struct m_can_priv *mcan_class;
+	struct m_can_classdev *mcan_class;
 	struct m_can_plat_priv *priv;
 	struct resource *res;
 	void __iomem *addr;
@@ -127,7 +127,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
 static int m_can_plat_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
-	struct m_can_priv *mcan_class = netdev_priv(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(dev);
 
 	m_can_class_unregister(mcan_class);
 
@@ -139,7 +139,7 @@ static int m_can_plat_remove(struct platform_device *pdev)
 static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *mcan_class = netdev_priv(ndev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
 
 	m_can_class_suspend(dev);
 
@@ -152,7 +152,7 @@ static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 static int __maybe_unused m_can_runtime_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *mcan_class = netdev_priv(ndev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
 	int err;
 
 	err = clk_prepare_enable(mcan_class->hclk);
-- 
2.20.1.390.gb5101f9297

