Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEBF222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3ZwsPb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404715AbfBOWxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45160 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404653AbfBOWxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so5632547pls.12;
        Fri, 15 Feb 2019 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YRkK8iY5c2UL+9cmABu8/WhNQuT1lvaF8VvP4wC8eM=;
        b=W3ZwsPb0opAWKR/mm9GSm92WrzvmWuYsx/uHnGFuO7Wz7n1d1sAxNiL6O+GA9VciCb
         u1L30qYgYG8dX680e/s2mK4CDT4ZPz0UxGQtvNQNRodp2FDvBi++Uzui5nYUeTO8DRsy
         997vqIQKeqHGENQpzsRWyiqi3lrFZcFkX0RnjzlVHdqs46GVL8PWOx9vviUdW6agt26B
         JOXHuL+oxwOGV4yT3/8nRAUZ1NuRwnrsCKeyhIwJrhUG8di+hLsBbdkkPbD98TxDFWzW
         euUVIgCyT+j51X7DJlLt4vAYLfoaqZt7Uyrc4AtAoEd/4OlmsPmuCq6AUfmIANhiSFVu
         Ioog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/YRkK8iY5c2UL+9cmABu8/WhNQuT1lvaF8VvP4wC8eM=;
        b=jvW3/P8HH05EfVvbpt8plq7UsDkp5dwZdEo2UnZpFzJpo6mJdPkKfHCxAEjEWH0SpD
         JBstmNt8EPCzGWE7ad4N7IHLv+4Jz1OzSb3K6uP6UOcRNBvxwkk7NaU45mFmXFrLBrk2
         vMBazK6S3NgIOlhFhhEgsL+NU7oTQtcVim8h+TfXZV0gfNxbRz4xTRdZ+Amr3KCAy4SN
         0rI9yTQ5aDlozFbAa7L/8A/lcKtYYl4MwWM/NerNic/svcqSVN4Mn1xsVaagoUfjK++f
         qab5nTEdiEC3ZNnMi2zfyn6iYfWwfixnBmna0jkD/ADjhAjIt6VRqeFbM1EZbpNtf/fZ
         ydBQ==
X-Gm-Message-State: AHQUAuYDl5BJldk/FprUS4y5efrqMzBtmxcq1VeKs5sxgu3Vo5DNXlVL
        qWAtrB50BgMGvBlfqmJQ10MNRQB9
X-Google-Smtp-Source: AHgI3Ibw18/Hie3gcC7mgMC8S8INtWplfu07WtQG9kOHQQA9F+3+dQ+1uKey6eq/IOH0lru5+KWyoQ==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr12976295pla.229.1550271210372;
        Fri, 15 Feb 2019 14:53:30 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 8/9] net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Date:   Fri, 15 Feb 2019 14:53:12 -0800
Message-Id: <20190215225313.32303-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted the bridge code and the drivers to check for
bridge port(s) flags at the time we try to set them, there is no need
for a get() -> set() sequence anymore and
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt             |  6 ++----
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 11 +----------
 drivers/net/ethernet/rocker/rocker_main.c          | 14 +-------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 10 +---------
 include/net/switchdev.h                            |  2 --
 net/dsa/slave.c                                    | 10 +---------
 6 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index ea90243340a9..b764568deabf 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -232,10 +232,8 @@ Learning_sync attribute enables syncing of the learned/forgotten FDB entry to
 the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
-To support learning and learning_sync port attributes, the driver implements
-switchdev op switchdev_port_attr_get/set for
-SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the attributes
-to the hardware defaults.
+To support learning, the driver implements switchdev op
+switchdev_port_attr_get/set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 8cdc0fe17a2e..2311ef8554d9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -434,16 +434,7 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 static int mlxsw_sp_port_attr_get(struct net_device *dev,
 				  struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
-					       BR_MCAST_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 2102e449c037..107fcbec3234 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2074,19 +2074,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 static int rocker_port_attr_get(struct net_device *dev,
 				struct switchdev_attr *attr)
 {
-	const struct rocker_port *rocker_port = netdev_priv(dev);
-	int err = 0;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
-								      &attr->u.brport_flags_support);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return err;
+	return -EOPNOTSUPP;
 }
 
 static int rocker_port_attr_set(struct net_device *dev,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 640fd6834be1..e71bc7ed363e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -643,15 +643,7 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 static int swdev_port_attr_get(struct net_device *netdev,
 			       struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int port_attr_stp_state_set(struct net_device *netdev,
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index de72b0a3867f..0f352019ef99 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -45,7 +45,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
 	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
@@ -63,7 +62,6 @@ struct switchdev_attr {
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
-		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index d3370e840956..06aa7376d968 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -390,15 +390,7 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 static int dsa_slave_port_attr_get(struct net_device *dev,
 				   struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = 0;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
-- 
2.17.1

