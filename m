Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40702C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21812073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4XvnYxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfBFRqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:46:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbfBFRqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so3399516pfi.8;
        Wed, 06 Feb 2019 09:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WvhLDrmdZVDiIsG2N5l3hvtM8l0zlUNLE53dWbT9Tio=;
        b=M4XvnYxCENkWxZP4bwYvz50RehYtXtHz0PlK+q047MPtBuQGJJV+iRZGoPU9qoeTN4
         xal1WtYEzbXPFbnNIWqvhiLszhvKkHEi6R+3yFG81Gi1XwC6KHav+2yp5Nvd0KJERZbQ
         jc7bFUPJDj7nnCEFyd3q3Imogvy+6QbsIqOYehN8200Z+hJLU0eTq/RTzTbowfHDcOTo
         azISKb+qurIb/N4PWYjb0uaIHyxZuGHQJwGcS9DR3FjeGM3mEAhEkydG1y8G+w63CuiR
         iTWF0VWj6DsIo9W4BQBlV97kyP6Z9pgv77jMYjjPOEk19msM0k/fuiFmGQ+OQi6o2aXQ
         E9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WvhLDrmdZVDiIsG2N5l3hvtM8l0zlUNLE53dWbT9Tio=;
        b=KLs5/nOaIVesjcKSPQ4Q4ERz2VTO9QpVd3kV8uv8/hVlMrGwEhB/h1nnWZgNHcQR3l
         xqS+mZjO4xBd/zRaQtmePtO/E2tViE/9Y+e5ZQzpCzBTdmVTYzX0UcF0aTGR485Q950j
         bCVcMVaasZsrDcOqoVG3RdxatHmjyycKwxsE3RWPTyCFBkZTdfeBWGOMrwV5t3dywUfq
         fOwpP4/hXspJmfXwz7c7H17z09bQ//chUNnaRq3GG8Qm011x6a6l6cRY1TLsj17+bqWW
         b1kgtTOvL8w/1x+Y6uMSilY/3bDOJTNzpIrGxPLFpPX+1Q5CXjmKUJHEfeVvmpzy9L2+
         3seg==
X-Gm-Message-State: AHQUAuaE+71+y9izcEQH8kM6F4J/DOJM/TZkGnvCB9cKgb2Jiba+Grk0
        9lApC8js3DEii5aumuBcYX+yX7VT
X-Google-Smtp-Source: AHgI3IZ+gEItW8hORxqCVFCFK+xPE1CQvBGj2TG/4TqGBzVP8mbfm+G1j5ieZfOQNFntOIoBP9lHHA==
X-Received: by 2002:aa7:8759:: with SMTP id g25mr2608919pfo.248.1549475176009;
        Wed, 06 Feb 2019 09:46:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v4 07/12] nfp: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:41 -0800
Message-Id: <20190206174546.23597-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NFP only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Since NFP uses switchdev_port_same_parent_id() convert it to use
netdev_port_same_parent_id().

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/netronome/nfp/flower/action.c    |  3 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +---
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  4 +---
 drivers/net/ethernet/netronome/nfp/nfp_port.c | 22 +++++--------------
 drivers/net/ethernet/netronome/nfp/nfp_port.h |  4 +++-
 5 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index 8d54b36afee8..7b217d7285c7 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -3,7 +3,6 @@
 
 #include <linux/bitfield.h>
 #include <net/pkt_cls.h>
-#include <net/switchdev.h>
 #include <net/tc_act/tc_csum.h>
 #include <net/tc_act/tc_gact.h>
 #include <net/tc_act/tc_mirred.h>
@@ -137,7 +136,7 @@ nfp_fl_output(struct nfp_app *app, struct nfp_fl_output *output,
 
 		if (nfp_netdev_is_nfp_repr(in_dev)) {
 			/* Confirm ingress and egress are on same device. */
-			if (!switchdev_port_same_parent_id(in_dev, out_dev))
+			if (!netdev_port_same_parent_id(in_dev, out_dev))
 				return -EOPNOTSUPP;
 		}
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 7d2d4241498f..776f6c07701b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -36,7 +36,6 @@
 #include <linux/vmalloc.h>
 #include <linux/ktime.h>
 
-#include <net/switchdev.h>
 #include <net/vxlan.h>
 
 #include "nfpcore/nfp_nsp.h"
@@ -3531,6 +3530,7 @@ const struct net_device_ops nfp_net_netdev_ops = {
 	.ndo_udp_tunnel_add	= nfp_net_add_vxlan_port,
 	.ndo_udp_tunnel_del	= nfp_net_del_vxlan_port,
 	.ndo_bpf		= nfp_net_xdp,
+	.ndo_get_port_parent_id	= nfp_port_get_port_parent_id,
 };
 
 /**
@@ -3815,8 +3815,6 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 	netdev->netdev_ops = &nfp_net_netdev_ops;
 	netdev->watchdog_timeo = msecs_to_jiffies(5 * 1000);
 
-	SWITCHDEV_SET_OPS(netdev, &nfp_port_switchdev_ops);
-
 	/* MTU range: 68 - hw-specific max */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = nn->max_mtu;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 69d7aebda09b..62839807e21e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -5,7 +5,6 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/lockdep.h>
 #include <net/dst_metadata.h>
-#include <net/switchdev.h>
 
 #include "nfpcore/nfp_cpp.h"
 #include "nfpcore/nfp_nsp.h"
@@ -273,6 +272,7 @@ const struct net_device_ops nfp_repr_netdev_ops = {
 	.ndo_fix_features	= nfp_repr_fix_features,
 	.ndo_set_features	= nfp_port_set_features,
 	.ndo_set_mac_address    = eth_mac_addr,
+	.ndo_get_port_parent_id	= nfp_port_get_port_parent_id,
 };
 
 void
@@ -336,8 +336,6 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 
 	netdev->max_mtu = pf_netdev->max_mtu;
 
-	SWITCHDEV_SET_OPS(netdev, &nfp_port_switchdev_ops);
-
 	/* Set features the lower device can support with representors */
 	if (repr_cap & NFP_NET_CFG_CTRL_LIVE_ADDR)
 		netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_port.c b/drivers/net/ethernet/netronome/nfp/nfp_port.c
index 86bc149ca231..7e90880fa46b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_port.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_port.c
@@ -31,34 +31,22 @@ struct nfp_port *nfp_port_from_netdev(struct net_device *netdev)
 	return NULL;
 }
 
-static int
-nfp_port_attr_get(struct net_device *netdev, struct switchdev_attr *attr)
+int nfp_port_get_port_parent_id(struct net_device *netdev,
+				struct netdev_phys_item_id *ppid)
 {
 	struct nfp_port *port;
+	const u8 *serial;
 
 	port = nfp_port_from_netdev(netdev);
 	if (!port)
 		return -EOPNOTSUPP;
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID: {
-		const u8 *serial;
-		/* N.B: attr->u.ppid.id is binary data */
-		attr->u.ppid.id_len = nfp_cpp_serial(port->app->cpp, &serial);
-		memcpy(&attr->u.ppid.id, serial, attr->u.ppid.id_len);
-		break;
-	}
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = nfp_cpp_serial(port->app->cpp, &serial);
+	memcpy(&ppid->id, serial, ppid->id_len);
 
 	return 0;
 }
 
-const struct switchdev_ops nfp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= nfp_port_attr_get,
-};
-
 int nfp_port_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		      void *type_data)
 {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_port.h b/drivers/net/ethernet/netronome/nfp/nfp_port.h
index b2479a2a49e5..90ae053f5c07 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_port.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_port.h
@@ -7,6 +7,7 @@
 #include <net/devlink.h>
 
 struct net_device;
+struct netdev_phys_item_id;
 struct nfp_app;
 struct nfp_pf;
 struct nfp_port;
@@ -90,7 +91,6 @@ struct nfp_port {
 };
 
 extern const struct ethtool_ops nfp_port_ethtool_ops;
-extern const struct switchdev_ops nfp_port_switchdev_ops;
 
 __printf(2, 3) u8 *nfp_pr_et(u8 *data, const char *fmt, ...);
 
@@ -106,6 +106,8 @@ int
 nfp_port_set_features(struct net_device *netdev, netdev_features_t features);
 
 struct nfp_port *nfp_port_from_netdev(struct net_device *netdev);
+int nfp_port_get_port_parent_id(struct net_device *netdev,
+				struct netdev_phys_item_id *ppid);
 struct nfp_port *
 nfp_port_from_id(struct nfp_pf *pf, enum nfp_port_type type, unsigned int id);
 struct nfp_eth_table_port *__nfp_port_get_eth_port(struct nfp_port *port);
-- 
2.17.1

