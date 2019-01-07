Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F773C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6392147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfAGXW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:22:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52223 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAGXWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:22:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ggeEN-0007sY-Eb; Mon, 07 Jan 2019 23:22:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: fix various indentation issues
Date:   Mon,  7 Jan 2019 23:22:49 +0000
Message-Id: <20190107232249.13590-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several statements that have indentation issues, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c     | 2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c      | 6 +++---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c   | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c           | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 1c6ed5b2a6f9..19bb04b3f097 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -660,9 +660,9 @@ static void _rtl92e_hwconfig(struct net_device *dev)
 	case WIRELESS_MODE_AUTO:
 	case WIRELESS_MODE_N_24G:
 		regBwOpMode = BW_OPMODE_20MHZ;
-			regRATR = RATE_ALL_CCK | RATE_ALL_OFDM_AG |
-				  RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
-			regRRSR = RATE_ALL_CCK | RATE_ALL_OFDM_AG;
+		regRATR = RATE_ALL_CCK | RATE_ALL_OFDM_AG |
+			  RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
+		regRRSR = RATE_ALL_CCK | RATE_ALL_OFDM_AG;
 		break;
 	case WIRELESS_MODE_N_5G:
 		regBwOpMode = BW_OPMODE_5G;
@@ -961,7 +961,7 @@ static void _rtl92e_net_update(struct net_device *dev)
 	net = &priv->rtllib->current_network;
 	rtl92e_config_rate(dev, &rate_config);
 	priv->dot11CurrentPreambleMode = PREAMBLE_AUTO;
-	 priv->basic_rate = rate_config &= 0x15f;
+	priv->basic_rate = rate_config &= 0x15f;
 	rtl92e_writew(dev, BSSIDR, *(u16 *)net->bssid);
 	rtl92e_writel(dev, BSSIDR + 2, *(u32 *)(net->bssid + 2));
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 96f265eee007..7031f6833b8b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -436,7 +436,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 				network->qos_data.param_count)) {
 			network->qos_data.old_param_count =
 				network->qos_data.param_count;
-	priv->rtllib->wmm_acm = network->qos_data.wmm_acm;
+			priv->rtllib->wmm_acm = network->qos_data.wmm_acm;
 			schedule_work(&priv->qos_activate);
 			RT_TRACE(COMP_QOS,
 				 "QoS parameters change call qos_activate\n");
@@ -1573,7 +1573,7 @@ static void _rtl92e_free_rx_ring(struct net_device *dev)
 			pci_unmap_single(priv->pdev,
 				*((dma_addr_t *)skb->cb),
 				priv->rxbuffersize, PCI_DMA_FROMDEVICE);
-				kfree_skb(skb);
+			kfree_skb(skb);
 		}
 
 		pci_free_consistent(priv->pdev,
@@ -2515,7 +2515,7 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	if (dev_alloc_name(dev, ifname) < 0) {
 		RT_TRACE(COMP_INIT,
 			 "Oops: devname already taken! Trying wlan%%d...\n");
-			dev_alloc_name(dev, ifname);
+		dev_alloc_name(dev, ifname);
 	}
 
 	RT_TRACE(COMP_INIT, "Driver probe completed1\n");
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 9bf95bd0ad13..157bcee34067 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -996,7 +996,7 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
 	tx_power_track_counter++;
 
 
-	 if (tx_power_track_counter >= 180) {
+	if (tx_power_track_counter >= 180) {
 		schedule_delayed_work(&priv->txpower_tracking_wq, 0);
 		tx_power_track_counter = 0;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 843e874b8a06..1899dbb2c957 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -738,7 +738,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 
 		else if (wrqu->encoding.length == 0xd) {
 			ieee->pairwise_key_type = KEY_TYPE_WEP104;
-				rtl92e_enable_hw_security_config(dev);
+			rtl92e_enable_hw_security_config(dev);
 			rtl92e_set_key(dev, key_idx, key_idx, KEY_TYPE_WEP104,
 				       zero_addr[key_idx], 0, hwkey);
 			rtl92e_set_swcam(dev, key_idx, key_idx, KEY_TYPE_WEP104,
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 687dbb04ed2e..2d330d2bbf6d 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -139,7 +139,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 {
 	union delba_param_set DelbaParamSet;
 	struct sk_buff *skb = NULL;
-	 struct rtllib_hdr_3addr *Delba = NULL;
+	struct rtllib_hdr_3addr *Delba = NULL;
 	u8 *tag = NULL;
 	u16 len = 6 + ieee->tx_headroom;
 
@@ -316,7 +316,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	 struct rtllib_hdr_3addr *rsp = NULL;
+	struct rtllib_hdr_3addr *rsp = NULL;
 	struct ba_record *pPendingBA, *pAdmittedBA;
 	struct tx_ts_record *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
@@ -420,7 +420,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	 struct rtllib_hdr_3addr *delba = NULL;
+	struct rtllib_hdr_3addr *delba = NULL;
 	union delba_param_set *pDelBaParamSet = NULL;
 	u8 *dst = NULL;
 
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index f38f1f74fcd6..55da8c9dfe50 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -285,7 +285,7 @@ static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *TK, const u16 *TTAK,
 static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct rtllib_tkip_data *tkey = priv;
-		int len;
+	int len;
 	u8 *pos;
 	struct rtllib_hdr_4addr *hdr;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb +
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index fa580ce1cf43..501ded929329 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -913,7 +913,7 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 		rx_stats->bContainHTC = true;
 	}
 
-	 if (RTLLIB_QOS_HAS_SEQ(fc))
+	if (RTLLIB_QOS_HAS_SEQ(fc))
 		rx_stats->bIsQosData = true;
 
 	return hdrlen;
-- 
2.19.1

