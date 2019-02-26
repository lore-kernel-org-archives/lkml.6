Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBCE206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a56auifa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfBZSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:46:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36333 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfBZSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:46:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id x206so2425926lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jy1VVBUzKtjrg74/rZ/KvvMy2H0d6BKBUN8LnXHZx/8=;
        b=a56auifaLwutXD9YhaJZGx66ZY4jM6tYPj22JS4j6c3jOhzqRkPxDu6bT69LvMpnF6
         Iw5I7EsC/Pu4U0KrW069g5UOpPpP1uK36jMoF8xDi7qhsNgrQLYh0i2dlvZyJ8EPmEcM
         PLzj5cQSYO+3AXtmS8ucLgyAanEwZVyRZq3evb52jk4+tQ5a57BGCvfmZTkPOJF0VuRC
         54Hc18YCDlXrDCE0BcYlCegiFQqlW5R27EMNysu8psnGxFk4F7HLMcfGWdMl8oOL9Uq3
         tBUQu8ZHKKNM62Fx/yjAhVHZkgher1NJ2Fx3QDJWisPihemsKVeqAX7uWye/cKjAmv5D
         1PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jy1VVBUzKtjrg74/rZ/KvvMy2H0d6BKBUN8LnXHZx/8=;
        b=UOk0bHrDaiqtLyBHAisBUR2wrgttq8i15z8306mtccuPXMTe87FD0D+GxElcjOoEqw
         J9PDqOKgEkyL7z4L7DpOiSY49ciKUGezVytdXV8iNUmSZCoNXawBu3hDC/bCu3o8jMn+
         iL8M7FkjafLef+iPR8XcVM9W8srceFua80J1ftcLotuG8f2B2nt1NC1k0dxN57T1Xw5N
         UjBMPe3At1zonwNNugWP2wtCfxgJN3LcWRe4l+r+8kUmYsSCDNsSoF/BVLfrWVnr/csP
         SX8RN3cth4BhJF/1zO2fgzGP1Fef3XHoV1OwsRds75L5RwQJu6ebtmkH0t8zKBoN8Bx5
         suoQ==
X-Gm-Message-State: AHQUAubESiHp6HWKz0RIv6gPEafHBSwFUXaUzW9OqsYgpY5GZBny7ckd
        GAjzTskKhxhyCBxOQfjNJyVjbg==
X-Google-Smtp-Source: AHgI3IY/4+ZOKb17l+HXYFs+GtTK4mGmSu7lJsDGVCRTUPiHs9Ot+2a6YD/d0Bz8aZvkPUgniFHR3g==
X-Received: by 2002:ac2:54b6:: with SMTP id w22mr5515367lfk.132.1551206794139;
        Tue, 26 Feb 2019 10:46:34 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id s129sm3015190lja.49.2019.02.26.10.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:46:33 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 5/6] net: ethernet: ti: cpsw: update mc filtering to use IVDF
Date:   Tue, 26 Feb 2019 20:45:55 +0200
Message-Id: <20190226184556.16082-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpsw can filter multicast addresses only per vlan. Thus if mcast
address is set for one of them or only for real device it must be
added for every created vlan consuming ALE table w/o reason. In order to
simplify dispatching vlan filters, the IVDF recently added is resused.

In case IVDF is disabled - mc is updated only for real device as before.
The previous method is harder to reuse and vlan filtering is limited
only for vlans directly connected to real netdev, so drop it in flavor
of IVDF decision.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/Kconfig |   1 +
 drivers/net/ethernet/ti/cpsw.c  | 113 ++++----------------------------
 2 files changed, 13 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index bb126be1eb72..c99c08ece9a1 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -65,6 +65,7 @@ config TI_CPSW
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_PHY_SEL
+	select VLAN_8021Q_IVDF
 	select TI_CPSW_ALE
 	select MFD_SYSCON
 	select REGMAP
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a591583d120e..fd76d1f12911 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -693,108 +693,21 @@ static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
 	return ret;
 }
 
-static int cpsw_update_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
 {
-	struct addr_sync_ctx *sync_ctx = ctx;
-	struct netdev_hw_addr *ha;
-	int found = 0, ret = 0;
-
-	if (!vdev || !(vdev->flags & IFF_UP))
-		return 0;
-
-	/* vlan address is relevant if its sync_cnt != 0 */
-	netdev_for_each_mc_addr(ha, vdev) {
-		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
-			found = ha->sync_cnt;
-			break;
-		}
-	}
-
-	if (found)
-		sync_ctx->consumed++;
-
-	if (sync_ctx->flush) {
-		if (!found)
-			cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
-		return 0;
-	}
-
-	if (found)
-		ret = cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 1);
-
-	return ret;
-}
-
-static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr, int num)
-{
-	struct addr_sync_ctx sync_ctx;
-	int ret;
-
-	sync_ctx.consumed = 0;
-	sync_ctx.addr = addr;
-	sync_ctx.ndev = ndev;
-	sync_ctx.flush = 0;
-
-	ret = vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
-	if (sync_ctx.consumed < num && !ret)
-		ret = cpsw_set_mc(ndev, addr, -1, 1);
-
-	return ret;
-}
-
-static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr, int num)
-{
-	struct addr_sync_ctx sync_ctx;
-
-	sync_ctx.consumed = 0;
-	sync_ctx.addr = addr;
-	sync_ctx.ndev = ndev;
-	sync_ctx.flush = 1;
-
-	vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
-	if (sync_ctx.consumed == num)
-		cpsw_set_mc(ndev, addr, -1, 0);
+	u16 vid;
 
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 1);
 	return 0;
 }
 
-static int cpsw_purge_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
 {
-	struct addr_sync_ctx *sync_ctx = ctx;
-	struct netdev_hw_addr *ha;
-	int found = 0;
-
-	if (!vdev || !(vdev->flags & IFF_UP))
-		return 0;
-
-	/* vlan address is relevant if its sync_cnt != 0 */
-	netdev_for_each_mc_addr(ha, vdev) {
-		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
-			found = ha->sync_cnt;
-			break;
-		}
-	}
-
-	if (!found)
-		return 0;
-
-	sync_ctx->consumed++;
-	cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
-	return 0;
-}
-
-static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
-{
-	struct addr_sync_ctx sync_ctx;
-
-	sync_ctx.addr = addr;
-	sync_ctx.ndev = ndev;
-	sync_ctx.consumed = 0;
-
-	vlan_for_each(ndev, cpsw_purge_vlan_mc, &sync_ctx);
-	if (sync_ctx.consumed < num)
-		cpsw_set_mc(ndev, addr, -1, 0);
+	u16 vid;
 
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 0);
 	return 0;
 }
 
@@ -816,8 +729,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
 	/* add/remove mcast address either for real netdev or for vlan */
-	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
-			       cpsw_del_mc_addr);
+	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -1970,9 +1882,6 @@ static int cpsw_restore_vlans(struct net_device *vdev, int vid, void *arg)
 {
 	struct cpsw_priv *priv = arg;
 
-	if (!vdev)
-		return 0;
-
 	cpsw_ndo_vlan_rx_add_vid(priv->ndev, 0, vid);
 	return 0;
 }
@@ -2099,7 +2008,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
+	__dev_mc_unsync(ndev, cpsw_del_mc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -3435,6 +3344,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	vlan_dev_ivdf_set(ndev, 1);
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
@@ -3696,6 +3606,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	vlan_dev_ivdf_set(ndev, 1);
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-- 
2.17.1

