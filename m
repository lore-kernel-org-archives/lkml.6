Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39ACC282DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21072173C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOYTbVD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBJRxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34816 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfBJRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so9874627otm.2;
        Sun, 10 Feb 2019 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIVYf9JotKnwepovE3GpoXexvmzAMYjU81aU5RcnSF4=;
        b=uOYTbVD61U8bTWzhedfdn5nY7VPQzlXMEjzGA2tsY09AXRFT3Kxyk1QQRD0odKgmY9
         SgDccPuAboUhEgdVoKxuqa8DKpAmzdxiaN6nShMqztrXTkasmyyUcTSDllj0G1S1Vz2Z
         vp3633ekK4cLnPQiNJufEeAcPPGH9GtTj6UYB/LZdh9oooElIAHLKmbI+uBlYIgQRnJQ
         JVcbPEeZAyDTUdzLOwDAsZVLY7P2z2veG2mIvyzITIQq45Z6cmbwjzYkr3FMhiIr39ZC
         ZEzrZqZ7oaPUQn7NyU5HO+CO7GhMZdO19DdxDZr3WvsjaUPZdd9sQ4Kq/orAMPtpepBy
         XI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIVYf9JotKnwepovE3GpoXexvmzAMYjU81aU5RcnSF4=;
        b=apJY5sS8tqjwl0Ugw9nXAECbsubPx7DGoS+awhIC5KjPgILt19COK9fGB60BSg9C8Z
         unJwYtcl9gTvSqWFqSaNuEGDYIAZFy2z89mZJDbDqbx7LHlfPYhnBz1u7x2SgSJmvb41
         JIEpnoIIVUJyICyy6jPWofQoJ5xgHY0DAyJOxLjdZpdAz4kI2tAnsLrDa2jLB23v2vGd
         vkkdp5NNBmd5Ndqa1cH9/lfTf7KnOrzBAFvj9Gd+ggna+CQCiiWFBVzQyCzv3oQPz2Vr
         k0MEpYjLNck62mHsVLZyOOjhezyeO9GqDdqJhiYuAd7LiF3T/Z+YXtHqZJQRRpz3MsxC
         WFvQ==
X-Gm-Message-State: AHQUAubKRHO/bRVJ4F3X5+0LI6CMT/7/leIQgma2AGUhMzSIbEnU4RQN
        ZiqCAfmZ0/iM1UDC21FyoQiDgV2S
X-Google-Smtp-Source: AHgI3IZ1VjiG8OFOB3bveXKH4Wjf8zGJwfM/0tiHTwNl2m/lu3w93YYRTqY9Un/WLQZ83/lIypOtIA==
X-Received: by 2002:a9d:3b65:: with SMTP id z92mr24110459otb.275.1549821225075;
        Sun, 10 Feb 2019 09:53:45 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 16/16] net: Remove switchdev_ops
Date:   Sun, 10 Feb 2019 09:51:05 -0800
Message-Id: <20190210175105.31629-17-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 ------------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  2 --
 .../mellanox/mlxsw/spectrum_switchdev.c        | 12 ------------
 drivers/net/ethernet/mscc/ocelot.c             |  5 -----
 drivers/net/ethernet/rocker/rocker_main.c      |  5 -----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c        |  5 -----
 include/linux/netdevice.h                      |  3 ---
 include/net/switchdev.h                        | 18 ------------------
 net/dsa/slave.c                                |  5 -----
 9 files changed, 67 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 7c9745cecbbd..619965abab43 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3220,7 +3220,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 	}
 	mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
 
-	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
 	mlxsw_sp->ports[local_port] = mlxsw_sp_port;
 	err = register_netdev(dev);
 	if (err) {
@@ -3237,7 +3236,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 
 err_register_netdev:
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
 err_port_vlan_create:
 err_port_pvid_set:
@@ -3280,7 +3278,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u8 local_port)
 	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
 	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
@@ -4001,12 +3998,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
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
@@ -4077,8 +4068,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 err_counter_pool_init:
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
-err_switchdev_init:
 	mlxsw_sp_span_fini(mlxsw_sp);
 err_span_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
@@ -4141,7 +4130,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
 	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index ceebc91f4f1d..82e3e6dc81a1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -375,8 +375,6 @@ u32 mlxsw_sp_bytes_cells(const struct mlxsw_sp *mlxsw_sp, u32 bytes);
 /* spectrum_switchdev.c */
 int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 			bool adding);
 void
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 39a99db040bd..a3a3c14c7886 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1925,10 +1925,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
-static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
-};
-
 static int
 mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 				struct mlxsw_sp_bridge_port *bridge_port,
@@ -3536,11 +3532,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp)
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
index 1dda4dd4c073..c98d2df08968 100644
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
@@ -1649,7 +1645,6 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 
 	dev->netdev_ops = &ocelot_port_netdev_ops;
 	dev->ethtool_ops = &ocelot_ethtool_ops;
-	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index b94f940dc7b5..262f6dd173f6 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2124,10 +2124,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_set	= rocker_port_attr_set,
-};
-
 struct rocker_fib_event_work {
 	struct work_struct work;
 	union {
@@ -2581,7 +2577,6 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	rocker_port_dev_addr_init(rocker_port);
 	dev->netdev_ops = &rocker_port_netdev_ops;
 	dev->ethtool_ops = &rocker_port_ethtool_ops;
-	dev->switchdev_ops = &rocker_port_switchdev_ops;
 	netif_tx_napi_add(dev, &rocker_port->napi_tx, rocker_port_poll_tx,
 			  NAPI_POLL_WEIGHT);
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 8baa503d9a6a..fe7d7617e800 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -914,10 +914,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 	return err;
 }
 
-static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_set	= swdev_port_attr_set,
-};
-
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1439,7 +1435,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
 	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
-	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1fb733f38a47..a747456b9d23 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1836,9 +1836,6 @@ struct net_device {
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
index 7bc6a004d32a..e66a6c30eee6 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -111,21 +111,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
-/**
- * struct switchdev_ops - switchdev operations
- *
- * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
- *
- * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
- */
-struct switchdev_ops {
-	int	(*switchdev_port_attr_get)(struct net_device *dev,
-					   struct switchdev_attr *attr);
-	int	(*switchdev_port_attr_set)(struct net_device *dev,
-					   const struct switchdev_attr *attr,
-					   struct switchdev_trans *trans);
-};
-
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -223,7 +208,6 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 			int (*del_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj));
 
-#define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -310,8 +294,6 @@ switchdev_handle_port_obj_del(struct net_device *dev,
 	return 0;
 }
 
-#define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
-
 #endif
 
 #endif /* _LINUX_SWITCHDEV_H_ */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ee4b94c5e68e..871ab04d5f05 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1047,10 +1047,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_port_parent_id	= dsa_slave_get_port_parent_id,
 };
 
-static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
-};
-
 static struct device_type dsa_type = {
 	.name	= "dsa",
 };
@@ -1310,7 +1306,6 @@ int dsa_slave_create(struct dsa_port *port)
 	eth_hw_addr_inherit(slave_dev, master);
 	slave_dev->priv_flags |= IFF_NO_QUEUE;
 	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
-	slave_dev->switchdev_ops = &dsa_slave_switchdev_ops;
 	slave_dev->min_mtu = 0;
 	slave_dev->max_mtu = ETH_MAX_MTU;
 	SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
-- 
2.19.1

