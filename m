Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8684222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oH1g8P9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404788AbfBOWxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36458 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404675AbfBOWxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so5476722pgr.3;
        Fri, 15 Feb 2019 14:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OWzvzFMgG7QaNM4TQQVNPz9Dz/XntulO6mi3+88Pl8=;
        b=oH1g8P9ngUqR4QKeaQ7n4s8yK/kZ6IU5fTdKbYyTyPu/o+AU/UL/p9ZqHzBJYO2T+u
         92Vryg1mqmrWJLOysldqQ+to37Y1NVK/tED7v5OhEBibF4ghDlbLi/VaFjmNukssRiz/
         6C2VDB4fpa79gUXQCXSX0Lrqk2U2gZtL/1FGPgvkwJi/WWS1T1e9y4UC+ecYU3xTn2Ry
         UgqYCtpv+m5gWcXmMTSFHTKfVcSjsWtiAlaYXpLnDpZNRlwYRa6DYE2r1UGdOvYk/ZYm
         f7wmN7adZ7RLn1VRohc/kW/y7p3loQsSszUOxNvOtFlasl0pI5jt/EfaCqOplyj7V29x
         vh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OWzvzFMgG7QaNM4TQQVNPz9Dz/XntulO6mi3+88Pl8=;
        b=HuuUOPWf0MNCsSwpBWXL5p7xnOLrIf3GK+pS2kC1UWyER3CvkMJdxQLTY6vXjnikG1
         Kgccie2RVkk/y9Qx2IlmXbGinUMzhZNWT99YsDO9eJprHzWbVf11wiqPqyGqGFIpuU+G
         zwLDLjeZJHlRiOp6TqePu7Jb6qKftHU7MCE7jhomjVEiNIaQvkMeix4g5lbQUh5W4Zba
         TSVCEVV62FtQFpP872Qa+LELflu4bvhnnAiZse6OL0L/QAd5wR/CG4wYhAlfJGNkYsPJ
         xJllCs7UIVhqMZhGERxCfv4YLBgVLAJ9aTq/BJhBvGdBo06yFY9otKlsCguEnqSZk0/z
         C46Q==
X-Gm-Message-State: AHQUAuZFUqcHt7WNByOm6oPb7SuUJVuQyj7+w4iuogN6YjORhOI2YL54
        W+ang9CiFTtfwYUUufw9w5GkEs14
X-Google-Smtp-Source: AHgI3Ibofh7cqqh2+pr98Q1pGZfPS3IPrgIwd9nNpF0CogjEoboRkoOMdzEtLqI9CfU5d/l0MErB5g==
X-Received: by 2002:aa7:82ca:: with SMTP id f10mr11933008pfn.131.1550271212118;
        Fri, 15 Feb 2019 14:53:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 9/9] net: Get rid of switchdev_port_attr_get()
Date:   Fri, 15 Feb 2019 14:53:13 -0800
Message-Id: <20190215225313.32303-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the bridge no longer calling switchdev_port_attr_get() to obtain
the supported bridge port flags from a driver but instead trying to set
the bridge port flags directly and relying on driver to reject
unsupported configurations, we can effectively get rid of
switchdev_port_attr_get() entirely since this was the only place where
it was called.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt                   | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 7 -------
 drivers/net/ethernet/rocker/rocker_main.c                | 7 -------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c                  | 7 -------
 include/net/switchdev.h                                  | 8 --------
 net/dsa/slave.c                                          | 7 -------
 6 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index b764568deabf..633dd1fd81b7 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -233,7 +233,7 @@ the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
 To support learning, the driver implements switchdev op
-switchdev_port_attr_get/set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
+switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_{PRE}_BRIDGE_FLAGS.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 2311ef8554d9..d0fcc36f2188 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,12 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static int mlxsw_sp_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int
 mlxsw_sp_port_bridge_vlan_stp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct mlxsw_sp_bridge_vlan *bridge_vlan,
@@ -1949,7 +1943,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
 	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 107fcbec3234..68d8f33113a5 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2071,12 +2071,6 @@ static const struct net_device_ops rocker_port_netdev_ops = {
  * swdev interface
  ********************/
 
-static int rocker_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int rocker_port_attr_set(struct net_device *dev,
 				const struct switchdev_attr *attr,
 				struct switchdev_trans *trans)
@@ -2153,7 +2147,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
 	.switchdev_port_attr_set	= rocker_port_attr_set,
 };
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e71bc7ed363e..7557f994ef06 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -640,12 +640,6 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 	fsl_mc_free_irqs(sw_dev);
 }
 
-static int swdev_port_attr_get(struct net_device *netdev,
-			       struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int port_attr_stp_state_set(struct net_device *netdev,
 				   struct switchdev_trans *trans,
 				   u8 state)
@@ -935,7 +929,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 }
 
 static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_get	= swdev_port_attr_get,
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 0f352019ef99..45310ddf2d7e 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -179,8 +179,6 @@ switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *info)
 #ifdef CONFIG_NET_SWITCHDEV
 
 void switchdev_deferred_process(void);
-int switchdev_port_attr_get(struct net_device *dev,
-			    struct switchdev_attr *attr);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr);
 int switchdev_port_obj_add(struct net_device *dev,
@@ -225,12 +223,6 @@ static inline void switchdev_deferred_process(void)
 {
 }
 
-static inline int switchdev_port_attr_get(struct net_device *dev,
-					  struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int switchdev_port_attr_set(struct net_device *dev,
 					  const struct switchdev_attr *attr)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 06aa7376d968..07a98b17f2ac 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -387,12 +387,6 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_port_attr_get(struct net_device *dev,
-				   struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
 						     struct sk_buff *skb)
 {
@@ -1059,7 +1053,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_get	= dsa_slave_port_attr_get,
 	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
 };
 
-- 
2.17.1

