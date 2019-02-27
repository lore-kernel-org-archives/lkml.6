Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788EF218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpJZ5gD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfB0BPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:15:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36906 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfB0BPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:15:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so7074714pgq.4;
        Tue, 26 Feb 2019 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pNCeok3QJKBxaBhOG2/zMR9WIyLWa8tgM+zLNG8caak=;
        b=YpJZ5gD+KTfYt/kQLWMXvGTiJ58tQ7vSB6vHmak/mIB3wYenVGS1/7GdhSjN1JJ4A+
         k2wSMVBHpGSwKcN4coIUFoMwM5QWCYaHor6ZfuqYR81vEmilRSairkdrrdhidxTcxGjN
         8OhGN+uxHpW83rOrUR+oV6bLhBcaAhKnCk5uJCeU9h8/kcIl3ZHVV8uBfwqp4zwNdUsU
         bRrDxqz5Rv7h8oMm2CmfYVDF0TOld5wTV5m8Xhrr50uC4C7fDrN9LhZ+aTU9hJHVwUCN
         gP4DzK+NU5RyEK4k4bOR2ttrx7TMJotwIPFSSPvDpF/Zqqw7d7DT8P8KU3mVvLiDuKq7
         LK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pNCeok3QJKBxaBhOG2/zMR9WIyLWa8tgM+zLNG8caak=;
        b=qMWyZYNdXb/T+Uu5o3eTbjztGUN4XAJq+b8U8qaBmDTAR/36WimbRNdFDEzUjspA1b
         n05XZKVyafLxwIeXQt3DFao9yx1piYWHHLFetjRrOW0cMXWI8nzge3qSqf6xxUYOKhye
         mrlQdASXxbSgpZzsaSF8Byv27tja14f4oWu3XM9ctRycfv1BOZjGxTZjjpRCorYA02i+
         rI46tDcMhB6NihXh5VlArtKdpLG8ScdGhWWMmCxqQetjJT7HR1gj/kkV35xQciAfogR1
         HGxRRIpQyTdeDiwgqAhFQC3gVkBh8VqnrcZjaCyM0TumuJnbZYuuSOuTq2/Uptm53HrY
         gsCw==
X-Gm-Message-State: AHQUAuYYMxgNNn1HKpJApW5bxAkLvG0MOyAfWQaITjQ7do1tFIBtlQJE
        ADpGey1k3A6RZs5z89D9iq/jg6vy
X-Google-Smtp-Source: AHgI3IYtiVD4qCQcm7EPf/HedPB2KLnRZLH8SoImeV51BhNF9ibaI1u8/ZIm8a1NeGcWI+Cimay3yQ==
X-Received: by 2002:a63:20a:: with SMTP id 10mr360779pgc.346.1551230111458;
        Tue, 26 Feb 2019 17:15:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:15:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 8/8] net: Remove switchdev_ops
Date:   Tue, 26 Feb 2019 17:14:27 -0800
Message-Id: <20190227011427.16487-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted all possible callers to using a switchdev
notifier for attributes we do not have a need for implementing
switchdev_ops anymore, and this can be removed from all drivers the
net_device structure.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c  | 12 ------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h  |  2 --
 .../mellanox/mlxsw/spectrum_switchdev.c         | 12 ------------
 drivers/net/ethernet/mscc/ocelot.c              |  5 -----
 drivers/net/ethernet/rocker/rocker_main.c       |  5 -----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |  5 -----
 include/linux/netdevice.h                       |  3 ---
 include/net/switchdev.h                         | 17 -----------------
 net/dsa/slave.c                                 |  5 -----
 9 files changed, 66 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index b00f6f74f91a..995426ea9a43 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3660,7 +3660,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 	}
 	mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
 
-	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
 	mlxsw_sp->ports[local_port] = mlxsw_sp_port;
 	err = register_netdev(dev);
 	if (err) {
@@ -3677,7 +3676,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 
 err_register_netdev:
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
 err_port_vlan_create:
 err_port_pvid_set:
@@ -3720,7 +3718,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u8 local_port)
 	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
 	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
@@ -4441,12 +4438,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_span_init;
 	}
 
-	err = mlxsw_sp_switchdev_init(mlxsw_sp);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
-		goto err_switchdev_init;
-	}
-
 	err = mlxsw_sp_counter_pool_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to init counter pool\n");
@@ -4517,8 +4508,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 err_counter_pool_init:
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
-err_switchdev_init:
 	mlxsw_sp_span_fini(mlxsw_sp);
 err_span_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
@@ -4585,7 +4574,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
 	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index a61c1130d9e3..da6278b0caa4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -407,8 +407,6 @@ extern const struct mlxsw_sp_sb_vals mlxsw_sp2_sb_vals;
 /* spectrum_switchdev.c */
 int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 			bool adding);
 void
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c1aedfea3a31..f6ce386c3036 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1938,10 +1938,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
-static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
-};
-
 static int
 mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 				struct mlxsw_sp_bridge_port *bridge_port,
@@ -3545,11 +3541,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp)
 	kfree(mlxsw_sp->bridge);
 }
 
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-	mlxsw_sp_port->dev->switchdev_ops = &mlxsw_sp_port_switchdev_ops;
-}
-
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-}
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 83a678b11757..a1d0d6e42533 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1324,10 +1324,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
-static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_set	= ocelot_port_attr_set,
-};
-
 static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
 				   struct net_device *bridge)
 {
@@ -1660,7 +1656,6 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 
 	dev->netdev_ops = &ocelot_port_netdev_ops;
 	dev->ethtool_ops = &ocelot_ethtool_ops;
-	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index fc772cf079cc..c883aa89b7ca 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2142,10 +2142,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_set	= rocker_port_attr_set,
-};
-
 struct rocker_fib_event_work {
 	struct work_struct work;
 	union {
@@ -2599,7 +2595,6 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	rocker_port_dev_addr_init(rocker_port);
 	dev->netdev_ops = &rocker_port_netdev_ops;
 	dev->ethtool_ops = &rocker_port_ethtool_ops;
-	dev->switchdev_ops = &rocker_port_switchdev_ops;
 	netif_tx_napi_add(dev, &rocker_port->napi_tx, rocker_port_poll_tx,
 			  NAPI_POLL_WEIGHT);
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b0d2d9bf2532..ad577beeb052 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -925,10 +925,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 	return err;
 }
 
-static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_set	= swdev_port_attr_set,
-};
-
 static int
 ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
 		struct switchdev_notifier_port_attr_info *port_attr_info)
@@ -1455,7 +1451,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
 	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
-	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 58e83bd7a861..c10b60297d28 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1843,9 +1843,6 @@ struct net_device {
 #endif
 	const struct net_device_ops *netdev_ops;
 	const struct ethtool_ops *ethtool_ops;
-#ifdef CONFIG_NET_SWITCHDEV
-	const struct switchdev_ops *switchdev_ops;
-#endif
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	const struct l3mdev_ops	*l3mdev_ops;
 #endif
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5087c06ceb4b..e4f751e19ecf 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -112,17 +112,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
-/**
- * struct switchdev_ops - switchdev operations
- *
- * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
- */
-struct switchdev_ops {
-	int	(*switchdev_port_attr_set)(struct net_device *dev,
-					   const struct switchdev_attr *attr,
-					   struct switchdev_trans *trans);
-};
-
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -226,9 +215,6 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 			int (*set_cb)(struct net_device *dev,
 				      const struct switchdev_attr *attr,
 				      struct switchdev_trans *trans));
-
-#define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
-
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -325,9 +311,6 @@ switchdev_handle_port_attr_set(struct net_device *dev,
 {
 	return 0;
 }
-
-#define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
-
 #endif
 
 #endif /* _LINUX_SWITCHDEV_H_ */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index b089b43120e1..1808a2cd6872 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1118,10 +1118,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= dsa_slave_vlan_rx_kill_vid,
 };
 
-static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
-};
-
 static struct device_type dsa_type = {
 	.name	= "dsa",
 };
@@ -1382,7 +1378,6 @@ int dsa_slave_create(struct dsa_port *port)
 	eth_hw_addr_inherit(slave_dev, master);
 	slave_dev->priv_flags |= IFF_NO_QUEUE;
 	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
-	slave_dev->switchdev_ops = &dsa_slave_switchdev_ops;
 	slave_dev->min_mtu = 0;
 	slave_dev->max_mtu = ETH_MAX_MTU;
 	SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
-- 
2.17.1

