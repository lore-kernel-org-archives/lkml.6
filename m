Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473591-2-206406914256264717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473590; b=IY5JJBnttX7W5vdVyepE+EPx+WkP42XpyfgOnS3UEROTbud0nR
    xDizyUtQNdIKcoP3RhxPJVr7n52CrIrdlDUhPVTeKVc9pU+mpKti6XGSyjQd9eeY
    Y7sa3p15cyy9IrGgOp52LQUMihxsqCt7aDrgFMKJcX+R2qxUIPBJkP3seztj9k5s
    MjevElUIYSKNxwOmNSoJHr5HRzMS0SCN/gRJrUGvsIBJLOePeiLpSscMscoQy9jN
    B6LpxzPfxCn17p8VIrsjtFpcTodBUZyNVh+yTNxK1N3XQTXCkcPvx0/jTX1t8HZo
    KhaAPeTbi198yu8f7LigAQhvtKbwjf/4yVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473590; bh=EEMWD8r8ACoLrEVHdUkWuklY55Zsqt
    IXW7g0jzY/LIM=; b=UXxeHJKEqWWCgtZiVeJ6/wmjef04TTZM0a2PkhvMBMtOrM
    I59d4eppc/OXoUBU2fVZCwg85I+DzOPmWLfqkBe7CQx/KvozSuRW8MVEu7aqJ9Nr
    qnQbBxXReRsmfPEIo/u7CnxCqLynYe7P2cIGBlpJ7NmM4M0vjvsb8qC8VPX4RYzi
    IqXkqHiYVxtjBXgYQJTwEyz7Ur466F7JTz150MtziNkzDUN3ZwE3TDcegZiKO90t
    pPJ1S9mMaBeo/v00gxld8+r8vOnCbbLFbPB8/ahe2xhNBan8+VtKWRwCvMKcmuug
    215TPAlc2fPe9bDRgSg494hhTlmd0nKo7ClkFcxg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG9jcqVUx80I2BtG1oSvdhxlSGfyX16dIF1k/xFS9Uo7JH4yxXh1zr7zf/Xz90xyP/LpeGoo4hApbRYoyVYgWurfTolAGKPRawdgeQ30aktalTjEVeee
    A7DN51Ivvcv7cDgbkt6ZTV3Q3VAld5AHWvBKvmP7SaMEWJIGCJ2mbUAfdOcDx4oCaYuaGDcXILjd4oW3/UOCYEjK1J+PuSbRb5N8FUfBXGGjfYEzSkfvS/Kp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=21-8QumFperNIO-zfXQA:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934336AbeDKTG2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935211AbeDKTGZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 302/310] net/mlx4_en: Fix mixed PFC and Global pause user control requests
Date: Wed, 11 Apr 2018 20:37:21 +0200
Message-Id: <20180411183635.548716175@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>


[ Upstream commit 6e8814ceb7e8f468659ef9253bd212c07ae19584 ]

Global pause and PFC configuration should be mutually exclusive (i.e. only
one of them at most can be set). However, once PFC was turned off,
driver automatically turned Global pause on. This is a bug.

Fix the driver behaviour to turn off PFC/Global once the user turned the
other on.

This also fixed a weird behaviour that at a current time, the profile
had both PFC and global pause configuration turned on, which is
Hardware-wise impossible and caused returning false positive indication
to query tools.

In addition, fix error code when setting global pause or PFC to change
metadata only upon successful change.

Also, removed useless debug print.

Fixes: af7d51852631 ("net/mlx4_en: Add DCB PFC support through CEE netlink commands")
Fixes: c27a02cd94d6 ("mlx4_en: Add driver for Mellanox ConnectX 10GbE NIC")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c  |   72 +++++++++++++-----------
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |   33 ++++++-----
 drivers/net/ethernet/mellanox/mlx4/en_main.c    |    4 -
 3 files changed, 62 insertions(+), 47 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -156,57 +156,63 @@ static int mlx4_en_dcbnl_getnumtcs(struc
 static u8 mlx4_en_dcbnl_set_all(struct net_device *netdev)
 {
 	struct mlx4_en_priv *priv = netdev_priv(netdev);
+	struct mlx4_en_port_profile *prof = priv->prof;
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u8 tx_pause, tx_ppp, rx_pause, rx_ppp;
 
 	if (!(priv->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return 1;
 
 	if (priv->cee_config.pfc_state) {
 		int tc;
+		rx_ppp = prof->rx_ppp;
+		tx_ppp = prof->tx_ppp;
 
-		priv->prof->rx_pause = 0;
-		priv->prof->tx_pause = 0;
 		for (tc = 0; tc < CEE_DCBX_MAX_PRIO; tc++) {
 			u8 tc_mask = 1 << tc;
 
 			switch (priv->cee_config.dcb_pfc[tc]) {
 			case pfc_disabled:
-				priv->prof->tx_ppp &= ~tc_mask;
-				priv->prof->rx_ppp &= ~tc_mask;
+				tx_ppp &= ~tc_mask;
+				rx_ppp &= ~tc_mask;
 				break;
 			case pfc_enabled_full:
-				priv->prof->tx_ppp |= tc_mask;
-				priv->prof->rx_ppp |= tc_mask;
+				tx_ppp |= tc_mask;
+				rx_ppp |= tc_mask;
 				break;
 			case pfc_enabled_tx:
-				priv->prof->tx_ppp |= tc_mask;
-				priv->prof->rx_ppp &= ~tc_mask;
+				tx_ppp |= tc_mask;
+				rx_ppp &= ~tc_mask;
 				break;
 			case pfc_enabled_rx:
-				priv->prof->tx_ppp &= ~tc_mask;
-				priv->prof->rx_ppp |= tc_mask;
+				tx_ppp &= ~tc_mask;
+				rx_ppp |= tc_mask;
 				break;
 			default:
 				break;
 			}
 		}
-		en_dbg(DRV, priv, "Set pfc on\n");
+		rx_pause = !!(rx_ppp || tx_ppp) ? 0 : prof->rx_pause;
+		tx_pause = !!(rx_ppp || tx_ppp) ? 0 : prof->tx_pause;
 	} else {
-		priv->prof->rx_pause = 1;
-		priv->prof->tx_pause = 1;
-		en_dbg(DRV, priv, "Set pfc off\n");
+		rx_ppp = 0;
+		tx_ppp = 0;
+		rx_pause = prof->rx_pause;
+		tx_pause = prof->tx_pause;
 	}
 
 	if (mlx4_SET_PORT_general(mdev->dev, priv->port,
 				  priv->rx_skb_size + ETH_FCS_LEN,
-				  priv->prof->tx_pause,
-				  priv->prof->tx_ppp,
-				  priv->prof->rx_pause,
-				  priv->prof->rx_ppp)) {
+				  tx_pause, tx_ppp, rx_pause, rx_ppp)) {
 		en_err(priv, "Failed setting pause params\n");
 		return 1;
 	}
 
+	prof->tx_ppp = tx_ppp;
+	prof->rx_ppp = rx_ppp;
+	prof->tx_pause = tx_pause;
+	prof->rx_pause = rx_pause;
+
 	return 0;
 }
 
@@ -408,6 +414,7 @@ static int mlx4_en_dcbnl_ieee_setpfc(str
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_port_profile *prof = priv->prof;
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u32 tx_pause, tx_ppp, rx_pause, rx_ppp;
 	int err;
 
 	en_dbg(DRV, priv, "cap: 0x%x en: 0x%x mbc: 0x%x delay: %d\n",
@@ -416,23 +423,26 @@ static int mlx4_en_dcbnl_ieee_setpfc(str
 			pfc->mbc,
 			pfc->delay);
 
-	prof->rx_pause = !pfc->pfc_en;
-	prof->tx_pause = !pfc->pfc_en;
-	prof->rx_ppp = pfc->pfc_en;
-	prof->tx_ppp = pfc->pfc_en;
+	rx_pause = prof->rx_pause && !pfc->pfc_en;
+	tx_pause = prof->tx_pause && !pfc->pfc_en;
+	rx_ppp = pfc->pfc_en;
+	tx_ppp = pfc->pfc_en;
 
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-				    prof->tx_pause,
-				    prof->tx_ppp,
-				    prof->rx_pause,
-				    prof->rx_ppp);
-	if (err)
+				    tx_pause, tx_ppp, rx_pause, rx_ppp);
+	if (err) {
 		en_err(priv, "Failed setting pause params\n");
-	else
-		mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
-						prof->rx_ppp, prof->rx_pause,
-						prof->tx_ppp, prof->tx_pause);
+		return err;
+	}
+
+	mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
+					rx_ppp, rx_pause, tx_ppp, tx_pause);
+
+	prof->tx_ppp = tx_ppp;
+	prof->rx_ppp = rx_ppp;
+	prof->rx_pause = rx_pause;
+	prof->tx_pause = tx_pause;
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1003,27 +1003,32 @@ static int mlx4_en_set_pauseparam(struct
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
+	u8 tx_pause, tx_ppp, rx_pause, rx_ppp;
 	int err;
 
 	if (pause->autoneg)
 		return -EINVAL;
 
-	priv->prof->tx_pause = pause->tx_pause != 0;
-	priv->prof->rx_pause = pause->rx_pause != 0;
+	tx_pause = !!(pause->tx_pause);
+	rx_pause = !!(pause->rx_pause);
+	rx_ppp = priv->prof->rx_ppp && !(tx_pause || rx_pause);
+	tx_ppp = priv->prof->tx_ppp && !(tx_pause || rx_pause);
+
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-				    priv->prof->tx_pause,
-				    priv->prof->tx_ppp,
-				    priv->prof->rx_pause,
-				    priv->prof->rx_ppp);
-	if (err)
-		en_err(priv, "Failed setting pause params\n");
-	else
-		mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
-						priv->prof->rx_ppp,
-						priv->prof->rx_pause,
-						priv->prof->tx_ppp,
-						priv->prof->tx_pause);
+				    tx_pause, tx_ppp, rx_pause, rx_ppp);
+	if (err) {
+		en_err(priv, "Failed setting pause params, err = %d\n", err);
+		return err;
+	}
+
+	mlx4_en_update_pfc_stats_bitmap(mdev->dev, &priv->stats_bitmap,
+					rx_ppp, rx_pause, tx_ppp, tx_pause);
+
+	priv->prof->tx_pause = tx_pause;
+	priv->prof->rx_pause = rx_pause;
+	priv->prof->tx_ppp = tx_ppp;
+	priv->prof->rx_ppp = rx_ppp;
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -163,9 +163,9 @@ static int mlx4_en_get_profile(struct ml
 		params->udp_rss = 0;
 	}
 	for (i = 1; i <= MLX4_MAX_PORTS; i++) {
-		params->prof[i].rx_pause = 1;
+		params->prof[i].rx_pause = !(pfcrx || pfctx);
 		params->prof[i].rx_ppp = pfcrx;
-		params->prof[i].tx_pause = 1;
+		params->prof[i].tx_pause = !(pfcrx || pfctx);
 		params->prof[i].tx_ppp = pfctx;
 		params->prof[i].tx_ring_size = MLX4_EN_DEF_TX_RING_SIZE;
 		params->prof[i].rx_ring_size = MLX4_EN_DEF_RX_RING_SIZE;
