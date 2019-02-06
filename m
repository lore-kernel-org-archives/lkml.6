Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3CF218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgMPgsW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfBFRrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:47:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39104 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfBFRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so1124853pfa.6;
        Wed, 06 Feb 2019 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7Ci0rv3hQtOueYt0rcl1mxa1iU3dwEVnAYBxfPFBHI=;
        b=mgMPgsW6nken4TlNO/Pv+4E7a+Sr8yIJ1qZyl9cBSzFTR9S5UnQVZ12g91qVCvRrHm
         4x6foaJPEDs/7+XCIIykP7cQUArZ1Q/hn8EyXfQkleWO8dRiZ6pOLqK+n8JUkUfE3PDB
         mP/1CfiT0q4eCL3R5Rl/Bwe3AYEFmcBpBPNqG50HMd7GNNNRZlipeSa0tajlrPzHRR7u
         7hT52Bj6Xs250hrgy5zxc+Tda/zbHJHpzSBH/XKAsU4ox/L3xk19W+G3LPnLv4g1LJuu
         OxnBTS6c8L39otzvyDRkrlq/xB4M9clouvqREV2l1r5lZnrlQgx4yl0HGa+appnbyy7U
         5wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7Ci0rv3hQtOueYt0rcl1mxa1iU3dwEVnAYBxfPFBHI=;
        b=gy4lwrsVMASvKeHEPk7cWz530bQqdr8dE/UyXtAr8dqONqQcK26nSI9j9hS+ohIP+i
         Y8hTlNab9Wj5ZY/6sDQtM5XLK7DkHDTtVQtnKLIcjxzzHTpGfpyO1kR2sh5zlCkLzK9d
         WAPzIk/kizzuo6dam7dqiXqhIb6OpGhi0X8y23enoKb/bHDNi3SXp82BQ2pXr8sHPXAK
         0WVwUzKgyPK7MiHdcJYoltWi6WF/0ZtTeULFCPsppv84vFjMGUgoA08akX/am2i92yto
         D9V0B0Q8YGZ3JHsDg/KKJho00GY4EG+Zii/6Ut4j5b1XLKkJAUYBOn4ev19UlExRdyR7
         Azaw==
X-Gm-Message-State: AHQUAuYhLGYY6uXygK3J2Sro3xmMa8svxXnVJiiGFjfRuRJUMFNdb+bs
        GZk2hDlYsKRX38ZijoD+BSSVm7ON
X-Google-Smtp-Source: AHgI3IbRCyF8F7AV1XyLeKXNd6sYH8tPjuzkxIoHkr/uFlGPUwCYWqjbKH1Vlhqd8Tzdy2MlH6ktRg==
X-Received: by 2002:a62:4618:: with SMTP id t24mr11606031pfa.139.1549475168668;
        Wed, 06 Feb 2019 09:46:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:07 -0800 (PST)
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
Subject: [PATCH net-next v4 03/12] liquidio: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:37 -0800
Message-Id: <20190206174546.23597-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liquidio only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it
a great candidate to be converted to use the ndo_get_port_parent_id()
NDO instead of implementing switchdev_port_attr_get().

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 22 ++++------------
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 25 ++++++-------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 3d24133e5e49..e97e6754ee09 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -21,7 +21,6 @@
 #include <linux/firmware.h>
 #include <net/vxlan.h>
 #include <linux/kthread.h>
-#include <net/switchdev.h>
 #include "liquidio_common.h"
 #include "octeon_droq.h"
 #include "octeon_iq.h"
@@ -3184,7 +3183,8 @@ static const struct devlink_ops liquidio_devlink_ops = {
 };
 
 static int
-lio_pf_switchdev_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+liquidio_get_port_parent_id(struct net_device *dev,
+			    struct netdev_phys_item_id *ppid)
 {
 	struct lio *lio = GET_LIO(dev);
 	struct octeon_device *oct = lio->oct_dev;
@@ -3192,24 +3192,12 @@ lio_pf_switchdev_attr_get(struct net_device *dev, struct switchdev_attr *attr)
 	if (oct->eswitch_mode != DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		return -EOPNOTSUPP;
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = ETH_ALEN;
-		ether_addr_copy(attr->u.ppid.id,
-				(void *)&lio->linfo.hw_addr + 2);
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = ETH_ALEN;
+	ether_addr_copy(ppid->id, (void *)&lio->linfo.hw_addr + 2);
 
 	return 0;
 }
 
-static const struct switchdev_ops lio_pf_switchdev_ops = {
-	.switchdev_port_attr_get = lio_pf_switchdev_attr_get,
-};
-
 static int liquidio_get_vf_stats(struct net_device *netdev, int vfidx,
 				 struct ifla_vf_stats *vf_stats)
 {
@@ -3259,6 +3247,7 @@ static const struct net_device_ops lionetdevops = {
 	.ndo_set_vf_trust	= liquidio_set_vf_trust,
 	.ndo_set_vf_link_state  = liquidio_set_vf_link_state,
 	.ndo_get_vf_stats	= liquidio_get_vf_stats,
+	.ndo_get_port_parent_id	= liquidio_get_port_parent_id,
 };
 
 /** \brief Entry point for the liquidio module
@@ -3534,7 +3523,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		 * netdev tasks.
 		 */
 		netdev->netdev_ops = &lionetdevops;
-		SWITCHDEV_SET_OPS(netdev, &lio_pf_switchdev_ops);
 
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index de61060721c4..f3f2e71431ac 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -25,7 +25,6 @@
 #include "octeon_nic.h"
 #include "octeon_main.h"
 #include "octeon_network.h"
-#include <net/switchdev.h>
 #include "lio_vf_rep.h"
 
 static int lio_vf_rep_open(struct net_device *ndev);
@@ -38,6 +37,8 @@ static int lio_vf_rep_phys_port_name(struct net_device *dev,
 static void lio_vf_rep_get_stats64(struct net_device *dev,
 				   struct rtnl_link_stats64 *stats64);
 static int lio_vf_rep_change_mtu(struct net_device *ndev, int new_mtu);
+static int lio_vf_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid);
 
 static const struct net_device_ops lio_vf_rep_ndev_ops = {
 	.ndo_open = lio_vf_rep_open,
@@ -47,6 +48,7 @@ static const struct net_device_ops lio_vf_rep_ndev_ops = {
 	.ndo_get_phys_port_name = lio_vf_rep_phys_port_name,
 	.ndo_get_stats64 = lio_vf_rep_get_stats64,
 	.ndo_change_mtu = lio_vf_rep_change_mtu,
+	.ndo_get_port_parent_id = lio_vf_get_port_parent_id,
 };
 
 static int
@@ -443,31 +445,19 @@ lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
-static int
-lio_vf_rep_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int lio_vf_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid)
 {
 	struct lio_vf_rep_desc *vf_rep = netdev_priv(dev);
 	struct net_device *parent_ndev = vf_rep->parent_ndev;
 	struct lio *lio = GET_LIO(parent_ndev);
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = ETH_ALEN;
-		ether_addr_copy(attr->u.ppid.id,
-				(void *)&lio->linfo.hw_addr + 2);
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = ETH_ALEN;
+	ether_addr_copy(ppid->id, (void *)&lio->linfo.hw_addr + 2);
 
 	return 0;
 }
 
-static const struct switchdev_ops lio_vf_rep_switchdev_ops = {
-	.switchdev_port_attr_get        = lio_vf_rep_attr_get,
-};
-
 static void
 lio_vf_rep_fetch_stats(struct work_struct *work)
 {
@@ -524,7 +514,6 @@ lio_vf_rep_create(struct octeon_device *oct)
 		ndev->min_mtu = LIO_MIN_MTU_SIZE;
 		ndev->max_mtu = LIO_MAX_MTU_SIZE;
 		ndev->netdev_ops = &lio_vf_rep_ndev_ops;
-		SWITCHDEV_SET_OPS(ndev, &lio_vf_rep_switchdev_ops);
 
 		vf_rep = netdev_priv(ndev);
 		memset(vf_rep, 0, sizeof(*vf_rep));
-- 
2.17.1

