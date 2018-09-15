Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B8ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AEE208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AEE208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeIONnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 09:43:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIONnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 09:43:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE2ABCDD14801;
        Sat, 15 Sep 2018 16:25:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Sat, 15 Sep 2018
 16:24:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dev@openvswitch.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: fix return type of ndo_start_xmit function
Date:   Sat, 15 Sep 2018 16:19:06 +0800
Message-ID: <20180915081906.23816-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in many
drivers returns an 'int'.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/caif/caif_hsi.c                           | 2 +-
 drivers/net/caif/caif_serial.c                        | 2 +-
 drivers/net/caif/caif_spi.c                           | 2 +-
 drivers/net/caif/caif_virtio.c                        | 2 +-
 drivers/net/can/xilinx_can.c                          | 2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c           | 2 +-
 drivers/net/ethernet/altera/altera_tse_main.c         | 2 +-
 drivers/net/ethernet/amd/am79c961a.c                  | 2 +-
 drivers/net/ethernet/amd/atarilance.c                 | 6 ++++--
 drivers/net/ethernet/amd/declance.c                   | 2 +-
 drivers/net/ethernet/amd/sun3lance.c                  | 6 ++++--
 drivers/net/ethernet/amd/sunlance.c                   | 2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c              | 2 +-
 drivers/net/ethernet/apple/bmac.c                     | 4 ++--
 drivers/net/ethernet/apple/mace.c                     | 4 ++--
 drivers/net/ethernet/apple/macmace.c                  | 4 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_main.c      | 3 ++-
 drivers/net/ethernet/arc/emac_main.c                  | 2 +-
 drivers/net/ethernet/aurora/nb8800.c                  | 2 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c          | 3 ++-
 drivers/net/ethernet/broadcom/sb1250-mac.c            | 4 ++--
 drivers/net/ethernet/cavium/liquidio/lio_main.c       | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c    | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c     | 5 +++--
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c      | 3 ++-
 drivers/net/ethernet/cirrus/ep93xx_eth.c              | 2 +-
 drivers/net/ethernet/cirrus/mac89x0.c                 | 4 ++--
 drivers/net/ethernet/cortina/gemini.c                 | 3 ++-
 drivers/net/ethernet/davicom/dm9000.c                 | 2 +-
 drivers/net/ethernet/faraday/ftgmac100.c              | 4 ++--
 drivers/net/ethernet/faraday/ftmac100.c               | 3 ++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        | 3 ++-
 drivers/net/ethernet/freescale/fec_mpc52xx.c          | 3 ++-
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 3 ++-
 drivers/net/ethernet/freescale/gianfar.c              | 4 ++--
 drivers/net/ethernet/freescale/ucc_geth.c             | 3 ++-
 drivers/net/ethernet/hisilicon/hip04_eth.c            | 3 ++-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c         | 2 +-
 drivers/net/ethernet/i825xx/ether1.c                  | 5 +++--
 drivers/net/ethernet/i825xx/lib82596.c                | 4 ++--
 drivers/net/ethernet/i825xx/sun3_82586.c              | 6 ++++--
 drivers/net/ethernet/ibm/ehea/ehea_main.c             | 2 +-
 drivers/net/ethernet/ibm/emac/core.c                  | 5 +++--
 drivers/net/ethernet/ibm/ibmvnic.c                    | 2 +-
 drivers/net/ethernet/korina.c                         | 3 ++-
 drivers/net/ethernet/lantiq_etop.c                    | 2 +-
 drivers/net/ethernet/lantiq_xrx200.c                  | 3 ++-
 drivers/net/ethernet/marvell/mvneta.c                 | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c       | 2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c             | 3 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c           | 2 +-
 drivers/net/ethernet/micrel/ks8695net.c               | 2 +-
 drivers/net/ethernet/micrel/ks8851_mll.c              | 2 +-
 drivers/net/ethernet/moxa/moxart_ether.c              | 3 ++-
 drivers/net/ethernet/mscc/ocelot.c                    | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c   | 2 +-
 drivers/net/ethernet/netx-eth.c                       | 2 +-
 drivers/net/ethernet/ni/nixge.c                       | 3 ++-
 drivers/net/ethernet/nuvoton/w90p910_ether.c          | 3 ++-
 drivers/net/ethernet/nxp/lpc_eth.c                    | 3 ++-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 3 ++-
 drivers/net/ethernet/pasemi/pasemi_mac.c              | 3 ++-
 drivers/net/ethernet/qualcomm/emac/emac.c             | 3 ++-
 drivers/net/ethernet/renesas/sh_eth.c                 | 3 ++-
 drivers/net/ethernet/seeq/ether3.c                    | 5 +++--
 drivers/net/ethernet/seeq/sgiseeq.c                   | 3 ++-
 drivers/net/ethernet/sgi/ioc3-eth.c                   | 4 ++--
 drivers/net/ethernet/sgi/meth.c                       | 2 +-
 drivers/net/ethernet/smsc/smc911x.c                   | 3 ++-
 drivers/net/ethernet/smsc/smc91x.c                    | 3 ++-
 drivers/net/ethernet/smsc/smsc911x.c                  | 3 ++-
 drivers/net/ethernet/socionext/sni_ave.c              | 2 +-
 drivers/net/ethernet/sun/ldmvsw.c                     | 2 +-
 drivers/net/ethernet/sun/sunbmac.c                    | 3 ++-
 drivers/net/ethernet/sun/sunqe.c                      | 2 +-
 drivers/net/ethernet/sun/sunvnet.c                    | 2 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c        | 2 +-
 drivers/net/ethernet/ti/cpmac.c                       | 2 +-
 drivers/net/ethernet/ti/davinci_emac.c                | 2 +-
 drivers/net/ethernet/ti/netcp_core.c                  | 3 ++-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c          | 2 +-
 drivers/net/ethernet/toshiba/spider_net.c             | 2 +-
 drivers/net/ethernet/toshiba/tc35815.c                | 6 ++++--
 drivers/net/ethernet/tundra/tsi108_eth.c              | 3 ++-
 drivers/net/ethernet/wiznet/w5100.c                   | 2 +-
 drivers/net/ethernet/wiznet/w5300.c                   | 2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c           | 3 ++-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c     | 3 ++-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c         | 3 ++-
 drivers/net/ethernet/xscale/ixp4xx_eth.c              | 2 +-
 drivers/net/hamradio/baycom_epp.c                     | 3 ++-
 drivers/net/hamradio/dmascc.c                         | 4 ++--
 drivers/net/hyperv/netvsc_drv.c                       | 3 ++-
 drivers/net/plip/plip.c                               | 4 ++--
 drivers/net/rionet.c                                  | 3 ++-
 drivers/net/usb/ipheth.c                              | 2 +-
 drivers/net/xen-netback/interface.c                   | 3 ++-
 net/caif/chnl_net.c                                   | 3 ++-
 net/hsr/hsr_device.c                                  | 2 +-
 net/l2tp/l2tp_eth.c                                   | 3 ++-
 net/openvswitch/vport-internal_dev.c                  | 3 ++-
 101 files changed, 170 insertions(+), 120 deletions(-)

diff --git a/drivers/net/caif/caif_hsi.c b/drivers/net/caif/caif_hsi.c
index 433a14b..a38ee73 100644
--- a/drivers/net/caif/caif_hsi.c
+++ b/drivers/net/caif/caif_hsi.c
@@ -1006,7 +1006,7 @@ static void cfhsi_aggregation_tout(struct timer_list *t)
 	cfhsi_start_tx(cfhsi);
 }
 
-static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cfhsi *cfhsi = NULL;
 	int start_xfer = 0;
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index a0f954f..d9190c0 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -275,7 +275,7 @@ static int handle_tx(struct ser_device *ser)
 	return tty_wr;
 }
 
-static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t caif_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ser_device *ser;
 
diff --git a/drivers/net/caif/caif_spi.c b/drivers/net/caif/caif_spi.c
index d28a139..ab19b66 100644
--- a/drivers/net/caif/caif_spi.c
+++ b/drivers/net/caif/caif_spi.c
@@ -486,7 +486,7 @@ static void cfspi_xfer_done_cb(struct cfspi_ifc *ifc)
 	complete(&cfspi->comp);
 }
 
-static int cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cfspi *cfspi = NULL;
 	unsigned long flags;
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 2814e0d..f5507db 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -519,7 +519,7 @@ static struct buf_info *cfv_alloc_and_copy_to_shm(struct cfv_info *cfv,
 }
 
 /* Put the CAIF packet on the virtio ring and kick the receiver */
-static int cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct cfv_info *cfv = netdev_priv(netdev);
 	struct buf_info *buf_info;
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 045f084..6de5004 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -612,7 +612,7 @@ static int xcan_start_xmit_mailbox(struct sk_buff *skb, struct net_device *ndev)
  *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queue is full
  */
-static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index e1acafa..eda955d 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -432,7 +432,7 @@ static void emac_timeout(struct net_device *dev)
 /* Hardware start transmission.
  * Send a packet to media from the upper layer.
  */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct emac_board_info *db = netdev_priv(dev);
 	unsigned long channel;
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 02921d8..ef93345 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -565,7 +565,7 @@ static irqreturn_t altera_isr(int irq, void *dev_id)
  * physically contiguous fragment starting at
  * skb->data, for length of skb_headlen(skb).
  */
-static int tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct altera_tse_private *priv = netdev_priv(dev);
 	unsigned int txsize = priv->tx_ring_size;
diff --git a/drivers/net/ethernet/amd/am79c961a.c b/drivers/net/ethernet/amd/am79c961a.c
index 01d132c..265039c 100644
--- a/drivers/net/ethernet/amd/am79c961a.c
+++ b/drivers/net/ethernet/amd/am79c961a.c
@@ -440,7 +440,7 @@ static void am79c961_timeout(struct net_device *dev)
 /*
  * Transmit a packet
  */
-static int
+static netdev_tx_t
 am79c961_sendpacket(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dev_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/ethernet/amd/atarilance.c b/drivers/net/ethernet/amd/atarilance.c
index c5b8126..d3d44e0 100644
--- a/drivers/net/ethernet/amd/atarilance.c
+++ b/drivers/net/ethernet/amd/atarilance.c
@@ -339,7 +339,8 @@ static unsigned long lance_probe1( struct net_device *dev, struct lance_addr
                                    *init_rec );
 static int lance_open( struct net_device *dev );
 static void lance_init_ring( struct net_device *dev );
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev );
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev);
 static irqreturn_t lance_interrupt( int irq, void *dev_id );
 static int lance_rx( struct net_device *dev );
 static int lance_close( struct net_device *dev );
@@ -769,7 +770,8 @@ static void lance_tx_timeout (struct net_device *dev)
 
 /* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
 
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev )
+static netdev_tx_t
+lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	struct lance_ioreg	 *IO = lp->iobase;
diff --git a/drivers/net/ethernet/amd/declance.c b/drivers/net/ethernet/amd/declance.c
index 116997a..29ebbf5 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -894,7 +894,7 @@ static void lance_tx_timeout(struct net_device *dev)
 	netif_wake_queue(dev);
 }
 
-static int lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	volatile struct lance_regs *ll = lp->ll;
diff --git a/drivers/net/ethernet/amd/sun3lance.c b/drivers/net/ethernet/amd/sun3lance.c
index 77b1db2..da7e3d4 100644
--- a/drivers/net/ethernet/amd/sun3lance.c
+++ b/drivers/net/ethernet/amd/sun3lance.c
@@ -236,7 +236,8 @@ struct lance_private {
 static int lance_probe( struct net_device *dev);
 static int lance_open( struct net_device *dev );
 static void lance_init_ring( struct net_device *dev );
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev );
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev);
 static irqreturn_t lance_interrupt( int irq, void *dev_id);
 static int lance_rx( struct net_device *dev );
 static int lance_close( struct net_device *dev );
@@ -511,7 +512,8 @@ static void lance_init_ring( struct net_device *dev )
 }
 
 
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev )
+static netdev_tx_t
+lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	int entry, len;
diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index cdd7a61..b4fc0ed 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1106,7 +1106,7 @@ static void lance_tx_timeout(struct net_device *dev)
 	netif_wake_queue(dev);
 }
 
-static int lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	int entry, skblen, len;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 24f1053..1d37da0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2009,7 +2009,7 @@ static int xgbe_close(struct net_device *netdev)
 	return 0;
 }
 
-static int xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 024998d..6a8e256 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -154,7 +154,7 @@ struct bmac_data {
 static irqreturn_t bmac_rxdma_intr(int irq, void *dev_id);
 static void bmac_set_timeout(struct net_device *dev);
 static void bmac_tx_timeout(struct timer_list *t);
-static int bmac_output(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t bmac_output(struct sk_buff *skb, struct net_device *dev);
 static void bmac_start(struct net_device *dev);
 
 #define	DBDMA_SET(x)	( ((x) | (x) << 16) )
@@ -1456,7 +1456,7 @@ static int bmac_close(struct net_device *dev)
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
-static int
+static netdev_tx_t
 bmac_output(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bmac_data *bp = netdev_priv(dev);
diff --git a/drivers/net/ethernet/apple/mace.c b/drivers/net/ethernet/apple/mace.c
index 0b5429d..68b9ee4 100644
--- a/drivers/net/ethernet/apple/mace.c
+++ b/drivers/net/ethernet/apple/mace.c
@@ -78,7 +78,7 @@ struct mace_data {
 
 static int mace_open(struct net_device *dev);
 static int mace_close(struct net_device *dev);
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
 static void mace_set_multicast(struct net_device *dev);
 static void mace_reset(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
@@ -525,7 +525,7 @@ static inline void mace_set_timeout(struct net_device *dev)
     mp->timeout_active = 1;
 }
 
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
 {
     struct mace_data *mp = netdev_priv(dev);
     volatile struct dbdma_regs __iomem *td = mp->tx_dma;
diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
index 137cbb4..376f2c2 100644
--- a/drivers/net/ethernet/apple/macmace.c
+++ b/drivers/net/ethernet/apple/macmace.c
@@ -89,7 +89,7 @@ struct mace_frame {
 
 static int mace_open(struct net_device *dev);
 static int mace_close(struct net_device *dev);
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
 static void mace_set_multicast(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
 static void mace_reset(struct net_device *dev);
@@ -444,7 +444,7 @@ static int mace_close(struct net_device *dev)
  * Transmit a frame
  */
 
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mace_data *mp = netdev_priv(dev);
 	unsigned long flags;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index e3ae29e..1081225 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -73,7 +73,8 @@ static int aq_ndev_close(struct net_device *ndev)
 	return err;
 }
 
-static int aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/arc/emac_main.c b/drivers/net/ethernet/arc/emac_main.c
index bd277b0..87f395e 100644
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -676,7 +676,7 @@ static struct net_device_stats *arc_emac_stats(struct net_device *ndev)
  *
  * This function is invoked from upper layers to initiate transmission.
  */
-static int arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
 	unsigned int len, *txbd_curr = &priv->txbd_curr;
diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 6f56276..c7d88ea 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -394,7 +394,7 @@ static void nb8800_tx_dma_start_irq(struct net_device *dev)
 	spin_unlock(&priv->tx_lock);
 }
 
-static int nb8800_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t nb8800_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct nb8800_priv *priv = netdev_priv(dev);
 	struct nb8800_tx_desc *txd;
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 02e7dfc..edf5cf8 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -568,7 +568,8 @@ static irqreturn_t bcm_enet_isr_dma(int irq, void *dev_id)
 /*
  * tx request callback
  */
-static int bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcm_enet_priv *priv;
 	struct bcm_enet_desc *desc;
diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index c44cff5..5db9f41 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -299,7 +299,7 @@ static enum sbmac_state sbmac_set_channel_state(struct sbmac_softc *,
 static void sbmac_promiscuous_mode(struct sbmac_softc *sc, int onoff);
 static uint64_t sbmac_addr2reg(unsigned char *ptr);
 static irqreturn_t sbmac_intr(int irq, void *dev_instance);
-static int sbmac_start_tx(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t sbmac_start_tx(struct sk_buff *skb, struct net_device *dev);
 static void sbmac_setmulti(struct sbmac_softc *sc);
 static int sbmac_init(struct platform_device *pldev, long long base);
 static int sbmac_set_speed(struct sbmac_softc *s, enum sbmac_speed speed);
@@ -2028,7 +2028,7 @@ static irqreturn_t sbmac_intr(int irq,void *dev_instance)
  *  Return value:
  *  	   nothing
  ********************************************************************* */
-static int sbmac_start_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t sbmac_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sbmac_softc *sc = netdev_priv(dev);
 	unsigned long flags;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0aba1f7..deffb3a 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2313,7 +2313,7 @@ static inline int send_nic_timestamp_pkt(struct octeon_device *oct,
  * @returns whether the packet was transmitted to the device okay or not
  *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
  */
-static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct lio *lio;
 	struct octnet_buf_free_info *finfo;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 0ec4bfe..54b2457 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -1401,7 +1401,7 @@ static int send_nic_timestamp_pkt(struct octeon_device *oct,
  * @returns whether the packet was transmitted to the device okay or not
  *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
  */
-static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct octnet_buf_free_info *finfo;
 	union octnic_cmd_setup cmdsetup;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index a9306164..07ead6b 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -31,7 +31,8 @@
 
 static int lio_vf_rep_open(struct net_device *ndev);
 static int lio_vf_rep_stop(struct net_device *ndev);
-static int lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev);
+static netdev_tx_t lio_vf_rep_pkt_xmit(struct sk_buff *skb,
+				       struct net_device *ndev);
 static void lio_vf_rep_tx_timeout(struct net_device *netdev);
 static int lio_vf_rep_phys_port_name(struct net_device *dev,
 				     char *buf, size_t len);
@@ -362,7 +363,7 @@ static void lio_vf_rep_get_stats64(struct net_device *dev,
 		netif_wake_queue(ndev);
 }
 
-static int
+static netdev_tx_t
 lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct lio_vf_rep_desc *vf_rep = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index bb43ddb..0baa8e8 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1268,7 +1268,8 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 	return 0;
 }
 
-static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
 	union mgmt_port_ring_entry re;
diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index e2a7029..13dfdfc 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -332,7 +332,7 @@ static int ep93xx_poll(struct napi_struct *napi, int budget)
 	return rx;
 }
 
-static int ep93xx_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ep93xx_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ep93xx_priv *ep = netdev_priv(dev);
 	struct ep93xx_tdesc *txd;
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 3f8fe8f..6324e80 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -113,7 +113,7 @@ struct net_local {
 
 /* Index to functions, as function prototypes. */
 static int net_open(struct net_device *dev);
-static int net_send_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t net_send_packet(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t net_interrupt(int irq, void *dev_id);
 static void set_multicast_list(struct net_device *dev);
 static void net_rx(struct net_device *dev);
@@ -324,7 +324,7 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int
+static netdev_tx_t
 net_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index ceec467..847e58d 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1224,7 +1224,8 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	return -ENOMEM;
 }
 
-static int gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->txq_order) - 1;
diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 50222b7..6efde28 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1023,7 +1023,7 @@ static void dm9000_send_packet(struct net_device *dev,
  *  Hardware start transmission.
  *  Send a packet to media from the upper layer.
  */
-static int
+static netdev_tx_t
 dm9000_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long flags;
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index d8ead7e..4d67322 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -712,8 +712,8 @@ static bool ftgmac100_prep_tx_csum(struct sk_buff *skb, u32 *csum_vlan)
 	return skb_checksum_help(skb) == 0;
 }
 
-static int ftgmac100_hard_start_xmit(struct sk_buff *skb,
-				     struct net_device *netdev)
+static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
+					     struct net_device *netdev)
 {
 	struct ftgmac100 *priv = netdev_priv(netdev);
 	struct ftgmac100_txdes *txdes, *first;
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index a1197d3..9c63e81 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -1016,7 +1016,8 @@ static int ftmac100_stop(struct net_device *netdev)
 	return 0;
 }
 
-static int ftmac100_hard_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+ftmac100_hard_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ftmac100 *priv = netdev_priv(netdev);
 	dma_addr_t map;
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index a5131a5..84843de 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2044,7 +2044,8 @@ static inline int dpaa_xmit(struct dpaa_priv *priv,
 	return 0;
 }
 
-static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
+static netdev_tx_t
+dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	const int queue_mapping = skb_get_queue_mapping(skb);
 	bool nonlinear = skb_is_nonlinear(skb);
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 6d7269d..b90bab7 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -305,7 +305,8 @@ static int mpc52xx_fec_close(struct net_device *dev)
  * invariant will hold if you make sure that the netif_*_queue()
  * calls are done at the proper times.
  */
-static int mpc52xx_fec_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+mpc52xx_fec_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 	struct bcom_fec_bd *bd;
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 2c2976a..7c548ed 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -481,7 +481,8 @@ static struct sk_buff *tx_skb_align_workaround(struct net_device *dev,
 }
 #endif
 
-static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	cbd_t __iomem *bdp;
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 40a1a87..52fe94b 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -112,7 +112,7 @@
 const char gfar_driver_version[] = "2.0";
 
 static int gfar_enet_open(struct net_device *dev);
-static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t gfar_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void gfar_reset_task(struct work_struct *work);
 static void gfar_timeout(struct net_device *dev);
 static int gfar_close(struct net_device *dev);
@@ -2334,7 +2334,7 @@ static inline bool gfar_csum_errata_76(struct gfar_private *priv,
 /* This is called by the kernel when a frame is ready for transmission.
  * It is pointed to by the dev->hard_start_xmit function pointer
  */
-static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	struct gfar_priv_tx_q *tx_queue = NULL;
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 9600837..32e0270 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3078,7 +3078,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 
 /* This is called by the kernel when a frame is ready for transmission. */
 /* It is pointed to by the dev->hard_start_xmit function pointer */
-static int ucc_geth_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+ucc_geth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
 #ifdef CONFIG_UGETH_TX_ON_DEMAND
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 14374a8..be268dc 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -422,7 +422,8 @@ static void hip04_start_tx_timer(struct hip04_priv *priv)
 			       ns, HRTIMER_MODE_REL);
 }
 
-static int hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct hip04_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index c572700..471805e 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -736,7 +736,7 @@ static int hix5hd2_fill_sg_desc(struct hix5hd2_priv *priv,
 	return 0;
 }
 
-static int hix5hd2_net_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t hix5hd2_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hix5hd2_priv *priv = netdev_priv(dev);
 	struct hix5hd2_desc *desc;
diff --git a/drivers/net/ethernet/i825xx/ether1.c b/drivers/net/ethernet/i825xx/ether1.c
index dc98345..35f6291 100644
--- a/drivers/net/ethernet/i825xx/ether1.c
+++ b/drivers/net/ethernet/i825xx/ether1.c
@@ -64,7 +64,8 @@
 #define RX_AREA_END	0x0fc00
 
 static int ether1_open(struct net_device *dev);
-static int ether1_sendpacket(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ether1_sendpacket(struct sk_buff *skb,
+				     struct net_device *dev);
 static irqreturn_t ether1_interrupt(int irq, void *dev_id);
 static int ether1_close(struct net_device *dev);
 static void ether1_setmulticastlist(struct net_device *dev);
@@ -667,7 +668,7 @@
 	netif_wake_queue(dev);
 }
 
-static int
+static netdev_tx_t
 ether1_sendpacket (struct sk_buff *skb, struct net_device *dev)
 {
 	int tmp, tst, nopaddr, txaddr, tbdaddr, dataddr;
diff --git a/drivers/net/ethernet/i825xx/lib82596.c b/drivers/net/ethernet/i825xx/lib82596.c
index f00a1dc..2f7ae11 100644
--- a/drivers/net/ethernet/i825xx/lib82596.c
+++ b/drivers/net/ethernet/i825xx/lib82596.c
@@ -347,7 +347,7 @@ struct i596_private {
 	0x7f /*  *multi IA */ };
 
 static int i596_open(struct net_device *dev);
-static int i596_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t i596_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t i596_interrupt(int irq, void *dev_id);
 static int i596_close(struct net_device *dev);
 static void i596_add_cmd(struct net_device *dev, struct i596_cmd *cmd);
@@ -966,7 +966,7 @@ static void i596_tx_timeout (struct net_device *dev)
 }
 
 
-static int i596_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t i596_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct i596_private *lp = netdev_priv(dev);
 	struct tx_cmd *tx_cmd;
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 8bb15a8..1a86184 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -121,7 +121,8 @@
 static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id);
 static int     sun3_82586_open(struct net_device *dev);
 static int     sun3_82586_close(struct net_device *dev);
-static int     sun3_82586_send_packet(struct sk_buff *,struct net_device *);
+static netdev_tx_t     sun3_82586_send_packet(struct sk_buff *,
+					      struct net_device *);
 static struct  net_device_stats *sun3_82586_get_stats(struct net_device *dev);
 static void    set_multicast_list(struct net_device *dev);
 static void    sun3_82586_timeout(struct net_device *dev);
@@ -1002,7 +1003,8 @@ static void sun3_82586_timeout(struct net_device *dev)
  * send frame
  */
 
-static int sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	int len,i;
 #ifndef NO_NOPCOMMANDS
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index ba580bf..88128d3 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -2038,7 +2038,7 @@ static void ehea_xmit3(struct sk_buff *skb, struct net_device *dev,
 	dev_consume_skb_any(skb);
 }
 
-static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ehea_port *port = netdev_priv(dev);
 	struct ehea_swqe *swqe;
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 7410a1d..fc4de2b 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1436,7 +1436,7 @@ static inline int emac_xmit_finish(struct emac_instance *dev, int len)
 }
 
 /* Tx lock BH */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
 	unsigned int len = skb->len;
@@ -1494,7 +1494,8 @@ static inline int emac_xmit_split(struct emac_instance *dev, int slot,
 }
 
 /* Tx lock BH disabled (SG version for TAH equipped EMACs) */
-static int emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
 	int nr_frags = skb_shinfo(skb)->nr_frags;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 4f0daf6..fad1bc9 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1428,7 +1428,7 @@ static int ibmvnic_xmit_workarounds(struct sk_buff *skb,
 	return 0;
 }
 
-static int ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 	int queue_num = skb_get_queue_mapping(skb);
diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index ae195f8..104b71d 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -196,7 +196,8 @@ static void korina_chain_rx(struct korina_private *lp,
 }
 
 /* transmit packet */
-static int korina_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+korina_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct korina_private *lp = netdev_priv(dev);
 	unsigned long flags;
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 32ac904..efaa7e5 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -459,7 +459,7 @@ struct ltq_etop_priv {
 	return 0;
 }
 
-static int
+static netdev_tx_t
 ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	int queue = skb_get_queue_mapping(skb);
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index c8b6d90..da6ac66 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -284,7 +284,8 @@ static int xrx200_tx_housekeeping(struct napi_struct *napi, int budget)
 	return pkts;
 }
 
-static int xrx200_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
+static netdev_tx_t
+xrx200_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	struct xrx200_priv *priv = netdev_priv(net_dev);
 	struct xrx200_chan *ch = &priv->chan_tx;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fe3edb3..4019479 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2393,7 +2393,7 @@ static int mvneta_tx_frag_process(struct mvneta_port *pp, struct sk_buff *skb,
 }
 
 /* Main tx processing */
-static int mvneta_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mvneta_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
 	u16 txq_id = skb_get_queue_mapping(skb);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2850041..84485e7 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2904,7 +2904,7 @@ static int mvpp2_tx_tso(struct sk_buff *skb, struct net_device *dev,
 }
 
 /* Main tx processing */
-static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2_tx_queue *txq, *aggr_txq;
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 3a97306..ff2fea0 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1260,7 +1260,8 @@ static int pxa168_rx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static int pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pxa168_eth_private *pep = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index cc1e9a9..3b391ae 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -859,7 +859,7 @@ static void mtk_stop_queue(struct mtk_eth *eth)
 	}
 }
 
-static int mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
diff --git a/drivers/net/ethernet/micrel/ks8695net.c b/drivers/net/ethernet/micrel/ks8695net.c
index bd51e05..b881f5d 100644
--- a/drivers/net/ethernet/micrel/ks8695net.c
+++ b/drivers/net/ethernet/micrel/ks8695net.c
@@ -1164,7 +1164,7 @@ static int ks8695_poll(struct napi_struct *napi, int budget)
  *	sk_buff and adds it to the TX ring. It then kicks the TX DMA
  *	engine to ensure transmission begins.
  */
-static int
+static netdev_tx_t
 ks8695_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ks8695_priv *ksp = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
index 0e9719f..ce1ff28 100644
--- a/drivers/net/ethernet/micrel/ks8851_mll.c
+++ b/drivers/net/ethernet/micrel/ks8851_mll.c
@@ -1021,7 +1021,7 @@ static void ks_write_qmu(struct ks_net *ks, u8 *pdata, u16 len)
  * spin_lock_irqsave is required because tx and rx should be mutual exclusive.
  * So while tx is in-progress, prevent IRQ interrupt from happenning.
  */
-static int ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int retv = NETDEV_TX_OK;
 	struct ks_net *ks = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index b34055a..1a20221 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -329,7 +329,8 @@ static irqreturn_t moxart_mac_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int moxart_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+moxart_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct moxart_mac_priv_t *priv = netdev_priv(ndev);
 	void *desc;
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1a4f2bb..6bac11e 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -530,7 +530,7 @@ static int ocelot_gen_ifh(u32 *ifh, struct frame_info *info)
 	return 0;
 }
 
-static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 1aac55d..26bfc04 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -812,7 +812,7 @@ static int nfp_net_prep_port_id(struct sk_buff *skb)
  *
  * Return: NETDEV_TX_OK on success.
  */
-static int nfp_net_tx(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t nfp_net_tx(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	const struct skb_frag_struct *frag;
diff --git a/drivers/net/ethernet/netx-eth.c b/drivers/net/ethernet/netx-eth.c
index df4188cb..3ec648b 100644
--- a/drivers/net/ethernet/netx-eth.c
+++ b/drivers/net/ethernet/netx-eth.c
@@ -107,7 +107,7 @@ static void netx_eth_set_multicast_list(struct net_device *ndev)
 	/* implement me */
 }
 
-static int
+static netdev_tx_t
 netx_eth_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct netx_eth_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 74cf52e..1f2a91a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -496,7 +496,8 @@ static int nixge_check_tx_bd_space(struct nixge_priv *priv,
 	return 0;
 }
 
-static int nixge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+nixge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct nixge_priv *priv = netdev_priv(ndev);
 	struct nixge_hw_dma_bd *cur_p;
diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index 052b3d2..abae9160 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -624,7 +624,8 @@ static int w90p910_send_frame(struct net_device *dev,
 	return 0;
 }
 
-static int w90p910_ether_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+w90p910_ether_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct w90p910_ether *ether = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 8b23d28..2e2513d 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1050,7 +1050,8 @@ static int lpc_eth_close(struct net_device *ndev)
 	return 0;
 }
 
-static int lpc_eth_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+lpc_eth_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct netdata_local *pldat = netdev_priv(ndev);
 	u32 len, txidx;
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 43c0c10..858287d 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2078,7 +2078,8 @@ static int pch_gbe_stop(struct net_device *netdev)
  *	- NETDEV_TX_OK:   Normal end
  *	- NETDEV_TX_BUSY: Error end
  */
-static int pch_gbe_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+pch_gbe_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	struct pch_gbe_tx_ring *tx_ring = adapter->tx_ring;
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 8a31a02..8a3c6fc 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1431,7 +1431,8 @@ static void pasemi_mac_queue_csdesc(const struct sk_buff *skb,
 	write_dma_reg(PAS_DMA_TXCHAN_INCR(txring->chan.chno), 2);
 }
 
-static int pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+pasemi_mac_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pasemi_mac * const mac = netdev_priv(dev);
 	struct pasemi_mac_txring * const txring = tx_ring(mac);
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 2a0cbc5..9f24ce5 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -123,7 +123,8 @@ static int emac_napi_rtx(struct napi_struct *napi, int budget)
 }
 
 /* Transmit the packet */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+emac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct emac_adapter *adpt = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index f27a0dc..1aed9d5 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2489,7 +2489,8 @@ static void sh_eth_tx_timeout(struct net_device *ndev)
 }
 
 /* Packet transmit function */
-static int sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct sh_eth_txdesc *txdesc;
diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index c5bc124..d1bb73b 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -77,7 +77,8 @@
 static int	ether3_rx(struct net_device *dev, unsigned int maxcnt);
 static void	ether3_tx(struct net_device *dev);
 static int	ether3_open (struct net_device *dev);
-static int	ether3_sendpacket (struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t	ether3_sendpacket(struct sk_buff *skb,
+					  struct net_device *dev);
 static irqreturn_t ether3_interrupt (int irq, void *dev_id);
 static int	ether3_close (struct net_device *dev);
 static void	ether3_setmulticastlist (struct net_device *dev);
@@ -481,7 +482,7 @@ static void ether3_timeout(struct net_device *dev)
 /*
  * Transmit a packet
  */
-static int
+static netdev_tx_t
 ether3_sendpacket(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long flags;
diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
index 573691b..70cce63 100644
--- a/drivers/net/ethernet/seeq/sgiseeq.c
+++ b/drivers/net/ethernet/seeq/sgiseeq.c
@@ -578,7 +578,8 @@ static inline int sgiseeq_reset(struct net_device *dev)
 	return 0;
 }
 
-static int sgiseeq_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+sgiseeq_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sgiseeq_private *sp = netdev_priv(dev);
 	struct hpc3_ethregs *hregs = sp->hregs;
diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 18d533f..3140999 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -99,7 +99,7 @@ struct ioc3_private {
 
 static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void ioc3_set_multicast_list(struct net_device *dev);
-static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void ioc3_timeout(struct net_device *dev);
 static inline unsigned int ioc3_hash(const unsigned char *addr);
 static inline void ioc3_stop(struct ioc3_private *ip);
@@ -1390,7 +1390,7 @@ static void ioc3_remove_one(struct pci_dev *pdev)
 	.remove		= ioc3_remove_one,
 };
 
-static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long data;
 	struct ioc3_private *ip = netdev_priv(dev);
diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index ea55abd..703fbbe 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -697,7 +697,7 @@ static void meth_add_to_tx_ring(struct meth_private *priv, struct sk_buff *skb)
 /*
  * Transmit a packet (called by the kernel)
  */
-static int meth_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t meth_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct meth_private *priv = netdev_priv(dev);
 	unsigned long flags;
diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index b1b53f6..8355dfb 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -513,7 +513,8 @@ static void smc911x_hardware_send_pkt(struct net_device *dev)
  * now, or set the card to generates an interrupt when ready
  * for the packet.
  */
-static int smc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+smc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smc911x_local *lp = netdev_priv(dev);
 	unsigned int free;
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index b944828..8d6cff8 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -638,7 +638,8 @@ static void smc_hardware_send_pkt(unsigned long data)
  * now, or set the card to generates an interrupt when ready
  * for the packet.
  */
-static int smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index c009407..99a5a8a 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -1786,7 +1786,8 @@ static int smsc911x_stop(struct net_device *dev)
 }
 
 /* Entry point for transmitting a packet */
-static int smsc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+smsc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smsc911x_data *pdata = netdev_priv(dev);
 	unsigned int freespace;
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 61e6abb..35f19f28 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1384,7 +1384,7 @@ static int ave_stop(struct net_device *ndev)
 	return 0;
 }
 
-static int ave_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t ave_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ave_private *priv = netdev_priv(ndev);
 	u32 proc_idx, done_idx, ndesc, cmdsts;
diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index d42f47f..644e42c 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -113,7 +113,7 @@ static u16 vsw_select_queue(struct net_device *dev, struct sk_buff *skb,
 }
 
 /* Wrappers to common functions */
-static int vsw_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t vsw_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	return sunvnet_start_xmit_common(skb, dev, vsw_tx_port_find);
 }
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index f047b27..720b7ac 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -950,7 +950,8 @@ static void bigmac_tx_timeout(struct net_device *dev)
 }
 
 /* Put a packet on the wire. */
-static int bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bigmac *bp = netdev_priv(dev);
 	int len, entry;
diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
index 7fe0d5e..1468fa0 100644
--- a/drivers/net/ethernet/sun/sunqe.c
+++ b/drivers/net/ethernet/sun/sunqe.c
@@ -570,7 +570,7 @@ static void qe_tx_timeout(struct net_device *dev)
 }
 
 /* Get a packet queued to go onto the wire. */
-static int qe_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t qe_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sunqe *qep = netdev_priv(dev);
 	struct sunqe_buffers *qbufs = qep->buffers;
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 12539b3..5901728 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -247,7 +247,7 @@ static u16 vnet_select_queue(struct net_device *dev, struct sk_buff *skb,
 }
 
 /* Wrappers to common functions */
-static int vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	return sunvnet_start_xmit_common(skb, dev, vnet_tx_port_find);
 }
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
index 1f8e960..7429c20 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
@@ -697,7 +697,7 @@ static void xlgmac_tx_timeout(struct net_device *netdev)
 	schedule_work(&pdata->restart_work);
 }
 
-static int xlgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t xlgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct xlgmac_pdata *pdata = netdev_priv(netdev);
 	struct xlgmac_pkt_info *tx_pkt_info;
diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 9b8a30b..64c45eb 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -544,7 +544,7 @@ static int cpmac_poll(struct napi_struct *napi, int budget)
 
 }
 
-static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	int queue;
 	unsigned int len;
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index f270bee..b83f32d 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -943,7 +943,7 @@ static void emac_tx_handler(void *token, int len, int status)
  *
  * Returns success(NETDEV_TX_OK) or error code (typically out of desc's)
  */
-static int emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct device *emac_dev = &ndev->dev;
 	int ret_code;
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 1f61226..c8139b1 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1270,7 +1270,8 @@ static int netcp_tx_submit_skb(struct netcp_intf *netcp,
 }
 
 /* Submit the packet */
-static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct netcp_intf *netcp = netdev_priv(ndev);
 	struct netcp_stats *tx_stats = &netcp->stats;
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 88d74ae..dbf2590 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -847,7 +847,7 @@ static int gelic_card_kick_txdma(struct gelic_card *card,
  *
  * returns 0 on success, <0 on failure
  */
-int gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
+netdev_tx_t gelic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct gelic_card *card = netdev_card(netdev);
 	struct gelic_descr *descr;
diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index d925b82..44bc5a2 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -882,7 +882,7 @@
  *
  * returns 0 on success, !0 on failure
  */
-static int
+static netdev_tx_t
 spider_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int cnt;
diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index 7163a8d..6a71c2c 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -474,7 +474,8 @@ static void free_rxbuf_skb(struct pci_dev *hwdev, struct sk_buff *skb, dma_addr_
 /* Index to functions, as function prototypes. */
 
 static int	tc35815_open(struct net_device *dev);
-static int	tc35815_send_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t	tc35815_send_packet(struct sk_buff *skb,
+					    struct net_device *dev);
 static irqreturn_t	tc35815_interrupt(int irq, void *dev_id);
 static int	tc35815_rx(struct net_device *dev, int limit);
 static int	tc35815_poll(struct napi_struct *napi, int budget);
@@ -1248,7 +1249,8 @@ static void tc35815_tx_timeout(struct net_device *dev)
  * invariant will hold if you make sure that the netif_*_queue()
  * calls are done at the proper times.
  */
-static int tc35815_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+tc35815_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct tc35815_local *lp = netdev_priv(dev);
 	struct TxFD *txfd;
diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index edcd1e6..de03c6f 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -653,7 +653,8 @@ static void tsi108_complete_tx(struct net_device *dev)
 	}
 }
 
-static int tsi108_send_packet(struct sk_buff * skb, struct net_device *dev)
+static netdev_tx_t
+tsi108_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct tsi108_prv_data *data = netdev_priv(dev);
 	int frags = skb_shinfo(skb)->nr_frags + 1;
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 2bdfb39..d8ba512 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -835,7 +835,7 @@ static void w5100_tx_work(struct work_struct *work)
 	w5100_tx_skb(priv->ndev, skb);
 }
 
-static int w5100_start_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t w5100_start_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index 56ae573..80fdbff 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -365,7 +365,7 @@ static void w5300_tx_timeout(struct net_device *ndev)
 	netif_wake_queue(ndev);
 }
 
-static int w5300_start_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t w5300_start_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct w5300_priv *priv = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 60abc92..2241f98 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -674,7 +674,8 @@ static inline int temac_check_tx_bd_space(struct temac_local *lp, int num_frag)
 	return 0;
 }
 
-static int temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct temac_local *lp = netdev_priv(ndev);
 	struct cdmac_bd *cur_p;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f24f48f..12a1460 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -653,7 +653,8 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
  * start the transmission. Additionally if checksum offloading is supported,
  * it populates AXI Stream Control fields with appropriate values.
  */
-static int axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	u32 ii;
 	u32 num_frag;
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 46d3092..7c596d1 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1021,7 +1021,8 @@ static int xemaclite_close(struct net_device *dev)
  *
  * Return:	0, always.
  */
-static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
+static netdev_tx_t
+xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
 	struct sk_buff *new_skb;
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index aee55c0..d2aed66 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -835,7 +835,7 @@ static void eth_txdone_irq(void *unused)
 	}
 }
 
-static int eth_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t eth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct port *port = netdev_priv(dev);
 	unsigned int txreadyq = port->plat->txreadyq;
diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 1e62d00..f4ceccf 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -772,7 +772,8 @@ static void epp_bh(struct work_struct *work)
  * ===================== network driver interface =========================
  */
 
-static int baycom_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+baycom_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct baycom_state *bc = netdev_priv(dev);
 
diff --git a/drivers/net/hamradio/dmascc.c b/drivers/net/hamradio/dmascc.c
index cde4120..2798870 100644
--- a/drivers/net/hamradio/dmascc.c
+++ b/drivers/net/hamradio/dmascc.c
@@ -239,7 +239,7 @@ struct scc_info {
 static int scc_open(struct net_device *dev);
 static int scc_close(struct net_device *dev);
 static int scc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
-static int scc_send_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t scc_send_packet(struct sk_buff *skb, struct net_device *dev);
 static int scc_set_mac_address(struct net_device *dev, void *sa);
 
 static inline void tx_on(struct scc_priv *priv);
@@ -921,7 +921,7 @@ static int scc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 
-static int scc_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t scc_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct scc_priv *priv = dev->ml_priv;
 	unsigned long flags;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 70921bb..1100ac3 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, struct net_device *vf_netdev,
 	return rc;
 }
 
-static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
+static netdev_tx_t
+netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 {
 	struct net_device_context *net_device_ctx = netdev_priv(net);
 	struct hv_netvsc_packet *packet = NULL;
diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index feb92ec..0b354e6 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -146,7 +146,7 @@
 static void plip_interrupt(void *dev_id);
 
 /* Functions for DEV methods */
-static int plip_tx_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t plip_tx_packet(struct sk_buff *skb, struct net_device *dev);
 static int plip_hard_header(struct sk_buff *skb, struct net_device *dev,
                             unsigned short type, const void *daddr,
 			    const void *saddr, unsigned len);
@@ -962,7 +962,7 @@ static __be16 plip_type_trans(struct sk_buff *skb, struct net_device *dev)
 	spin_unlock_irqrestore(&nl->lock, flags);
 }
 
-static int
+static netdev_tx_t
 plip_tx_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct net_local *nl = netdev_priv(dev);
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index e9f101c..de391c7 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -170,7 +170,8 @@ static int rionet_queue_tx_msg(struct sk_buff *skb, struct net_device *ndev,
 	return 0;
 }
 
-static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	int i;
 	struct rionet_private *rnet = netdev_priv(ndev);
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 7275761..53eab6fb 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -413,7 +413,7 @@ static int ipheth_close(struct net_device *net)
 	return 0;
 }
 
-static int ipheth_tx(struct sk_buff *skb, struct net_device *net)
+static netdev_tx_t ipheth_tx(struct sk_buff *skb, struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 	struct usb_device *udev = dev->udev;
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 92274c2..7e3ea39 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -165,7 +165,8 @@ static u16 xenvif_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return vif->hash.mapping[skb_get_hash_raw(skb) % size];
 }
 
-static int xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xenvif *vif = netdev_priv(dev);
 	struct xenvif_queue *queue = NULL;
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 13e2ae6..30be426 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -211,7 +211,8 @@ static void chnl_flowctrl_cb(struct cflayer *layr, enum caif_ctrlcmd flow,
 	}
 }
 
-static int chnl_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+chnl_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct chnl_net *priv;
 	struct cfpkt *pkt = NULL;
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b8cd43c..a067150 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -233,7 +233,7 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
 }
 
 
-static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hsr_priv *hsr = netdev_priv(dev);
 	struct hsr_port *master;
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 8aadc4f..4173cb1 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -77,7 +77,8 @@ static void l2tp_eth_dev_uninit(struct net_device *dev)
 	 */
 }
 
-static int l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct l2tp_eth *priv = netdev_priv(dev);
 	struct l2tp_session *session = priv->session;
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index bb95c43..9f8d0ea 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -43,7 +43,8 @@ static struct internal_dev *internal_dev_priv(struct net_device *netdev)
 }
 
 /* Called with rcu_read_lock_bh. */
-static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int len, err;
 
-- 
1.8.3.1


