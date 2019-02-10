Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D0C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF46B20874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inq7s76h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBJRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36451 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfBJRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so13934198otk.3;
        Sun, 10 Feb 2019 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDLwzZYTke7J4+Ms6YdobffRPZitEEVhuCSfGIatE34=;
        b=inq7s76hipaZ2SVZuEpfHYQbdYYGKaQLgwlW0/hM8jbPVAFPC1YYJJeBOzYF894nJh
         bZ6FECDD7AGFF5IXIN4nNe/zkR+wLs30zF7/ldrU9DUe3v4cbN/zh0pdfPwRwqUqjiC7
         UOGsmiTTgjvbswrZbuNKno6/NjfAfs0i+vygsuh++JyGMBpwsDdk0TgKOtNgX8J203FQ
         8qWPeRDRuoDlzPL2NQjbvndVv8Yras2MOCIlcJ2IUL+KajV7CZT8kZJf0/zDtBbHm8Xf
         aURM+mp7Uzj33HfShKSSCYDtwCTxBfgTYMLF7hjFYRuqyRm5k9304vE3jFsQAF00+s6M
         Tqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDLwzZYTke7J4+Ms6YdobffRPZitEEVhuCSfGIatE34=;
        b=trKrQp6WANNeHpxvVsY+ZCRMcGTYdtyOvlReHp34wEcXUt14TLLyKhcgxJ15ZwnrLH
         ZvOm/+FBDVoDVw9sfMiT0wOreua6P9LeSPFVzgpJTdet0+NOg5hRuuS+x0KPv2Muh8mr
         Kb23e+Z3O8TnINgtOhXSIO9l2Ho8C5a1usTQ0BHuMcpyC2eopO5GknT58YHvf/EpOS7p
         iwVEB1tkURbb/ZTzc2j6daUTX5PxJWanizLgj1EFL4t0CWWzfPTXap0xKPlWJhx9uGm4
         IXsNlkFpTRmiUEo1E0cKGQWC1vN74i2CwYY0pTZ5jZbNWDSSoELlgKJ9iwuDwq8KH1VN
         P2wA==
X-Gm-Message-State: AHQUAuZYHeYR74+LEh62qj8S6201/d6QSulqn7RTmo519zmOhIWlsaW3
        F5ztDHd0XTANY0PPQW8OU9IdKzBU
X-Google-Smtp-Source: AHgI3Iak9dRJ702t9kOw9Hrq4u7t8VXuY7tT3knPKXMHOxeThC2H7fElrI6Z09W6gaOBN7nYZE0IhQ==
X-Received: by 2002:a9d:630f:: with SMTP id q15mr22820213otk.187.1549821209744;
        Sun, 10 Feb 2019 09:53:29 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 08/16] net: Get rid of switchdev_port_attr_get()
Date:   Sun, 10 Feb 2019 09:50:57 -0800
Message-Id: <20190210175105.31629-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt        |  5 ++-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 32 -------------------
 drivers/net/ethernet/rocker/rocker_main.c     | 30 -----------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 19 -----------
 include/net/switchdev.h                       |  8 -----
 net/dsa/slave.c                               |  7 ----
 6 files changed, 2 insertions(+), 99 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index ea90243340a9..327afe754230 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -233,9 +233,8 @@ the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
 To support learning and learning_sync port attributes, the driver implements
-switchdev op switchdev_port_attr_get/set for
-SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the attributes
-to the hardware defaults.
+switchdev op switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
+The driver should initialize the attributes to the hardware defaults.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 8242a373f6e7..6b09d68671cf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,37 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static void mlxsw_sp_port_bridge_flags_get(struct mlxsw_sp_bridge *bridge,
-					   struct net_device *dev,
-					   unsigned long *brport_flags)
-{
-	struct mlxsw_sp_bridge_port *bridge_port;
-
-	bridge_port = mlxsw_sp_bridge_port_find(bridge, dev);
-	if (WARN_ON(!bridge_port))
-		return;
-
-	memcpy(brport_flags, &bridge_port->flags, sizeof(*brport_flags));
-}
-
-static int mlxsw_sp_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
-					       &attr->u.brport_flags);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int
 mlxsw_sp_port_bridge_vlan_stp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct mlxsw_sp_bridge_vlan *bridge_vlan,
@@ -1957,7 +1926,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
 	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 375c4c908bea..ff3f14504f4f 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1606,17 +1606,6 @@ rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 						trans);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
-					unsigned long *p_brport_flags)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
-}
-
 static int
 rocker_world_port_attr_bridge_ageing_time_set(struct rocker_port *rocker_port,
 					      u32 ageing_time,
@@ -2064,24 +2053,6 @@ static const struct net_device_ops rocker_port_netdev_ops = {
  * swdev interface
  ********************/
 
-static int rocker_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	const struct rocker_port *rocker_port = netdev_priv(dev);
-	int err = 0;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
-							      &attr->u.brport_flags);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return err;
-}
-
 static int rocker_port_attr_set(struct net_device *dev,
 				const struct switchdev_attr *attr,
 				struct switchdev_trans *trans)
@@ -2154,7 +2125,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
 	.switchdev_port_attr_set	= rocker_port_attr_set,
 };
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 79635d1091df..b195b09e0d1d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -640,24 +640,6 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 	fsl_mc_free_irqs(sw_dev);
 }
 
-static int swdev_port_attr_get(struct net_device *netdev,
-			       struct switchdev_attr *attr)
-{
-	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		attr->u.brport_flags =
-			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
-			(port_priv->flood ? BR_FLOOD : 0);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int port_attr_stp_state_set(struct net_device *netdev,
 				   struct switchdev_trans *trans,
 				   u8 state)
@@ -933,7 +915,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 }
 
 static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_get	= swdev_port_attr_get,
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index e2083824e577..96cd3e795f7f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -178,8 +178,6 @@ switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *info)
 #ifdef CONFIG_NET_SWITCHDEV
 
 void switchdev_deferred_process(void);
-int switchdev_port_attr_get(struct net_device *dev,
-			    struct switchdev_attr *attr);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr);
 int switchdev_port_obj_add(struct net_device *dev,
@@ -224,12 +222,6 @@ static inline void switchdev_deferred_process(void)
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
index 7b33be6f1954..d8eb33979368 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -382,12 +382,6 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
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
@@ -1054,7 +1048,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_get	= dsa_slave_port_attr_get,
 	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
 };
 
-- 
2.19.1

