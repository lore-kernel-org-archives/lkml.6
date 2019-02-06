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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E732073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhDu1nOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfBFRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:47:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45865 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfBFRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3196245pgc.12;
        Wed, 06 Feb 2019 09:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+WfFDhr43nxy6UyZTCGjJq3EYiqMxX7GzQG9/ZadJj0=;
        b=ZhDu1nOztMJHbu72r7tpPjltUGqmOKTE4CLwv7fX8TqOg3mO+qQkhxMRAzldVrH9E4
         MEYnH2UjcfcJpKInODpQ+GMI/wnG0Q8c4jZcFHXr2lapaFctvcO6KR3utkx88CLp6Ayc
         h2cURT2BXuLz4dCuDm32KCBmn3mwYG92h0jKkVBwSVTyV1zKMp66RI9SAucw+6uGR4lG
         3yflxbXkY6YNmgj/FbcLbCrEfcguv7XiOHy/MEWwoakRwrCz6b/cIW497WcdPyBsrU2B
         3V99Axpgt4g8RBWascOnG7ccAsRyZ9FxZJta+n4jw7ZR0rlkj17c8sqfycZkGfCIxzvQ
         UyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+WfFDhr43nxy6UyZTCGjJq3EYiqMxX7GzQG9/ZadJj0=;
        b=DPL99bTo7pSfLSLAeXunGXXN9Ck7j8eZiCs9o0/4zli+SdYAlT7PQsbQwosy/+NNlq
         S7MmVQ1crAhIpjwJ96nWFMyduFhsxtb6A5XeTKWvkV9xPq+Jy5WSwYFi97DQ8YjA/0CL
         cL629oDmVweJt8zE+Kt0Ps0kiTe3sO4VFxgLIvgDLnWbVzubMAbK5kLYTZDx/N4EhKFv
         l1N6NEg6axneuImBxbMy18sVj/puWFZ7t9KiJn327gN6MjBOFNJLbpxNiMtPQSX+tDDc
         itJOHbMMLhDd+lE3/lEQ8phOA21mh0cgwpC+qEbBFgArjJLjdnX5E3o0C9KZbg6RiVF7
         as3g==
X-Gm-Message-State: AHQUAuY3OVxOzjJjF4zVudxx+7atIZVMiJWBn7U9QESYCKSDQsBDHKcB
        mIT1D6v1mveKmJ1ei7gKgVr0qyw3
X-Google-Smtp-Source: AHgI3Ibqz9Yc/aChG/MQZTt/Ev/PzCuRaZueY073J+9DOv15GUg9np3pyTE82azc9Vcb7vd5cZkcJA==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr11566053pfe.152.1549475174488;
        Wed, 06 Feb 2019 09:46:14 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:13 -0800 (PST)
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
Subject: [PATCH net-next v4 06/12] mscc: ocelot: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:40 -0800
Message-Id: <20190206174546.23597-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ocelot only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID as a valid
switchdev attribute getter, convert it to use ndo_get_port_parent_id()
and get rid of the switchdev_ops::switchdev_port_attr_get altogether.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 33 ++++++++++++------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c6a575eb0ff5..195306d05bcd 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -916,6 +916,18 @@ static int ocelot_set_features(struct net_device *dev,
 	return 0;
 }
 
+static int ocelot_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	ppid->id_len = sizeof(ocelot->base_mac);
+	memcpy(&ppid->id, &ocelot->base_mac, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_open			= ocelot_port_open,
 	.ndo_stop			= ocelot_port_stop,
@@ -930,6 +942,7 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_vlan_rx_add_vid		= ocelot_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid		= ocelot_vlan_rx_kill_vid,
 	.ndo_set_features		= ocelot_set_features,
+	.ndo_get_port_parent_id		= ocelot_get_port_parent_id,
 };
 
 static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -1013,25 +1026,6 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
-static int ocelot_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	struct ocelot_port *ocelot_port = netdev_priv(dev);
-	struct ocelot *ocelot = ocelot_port->ocelot;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ocelot->base_mac);
-		memcpy(&attr->u.ppid.id, &ocelot->base_mac,
-		       attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int ocelot_port_attr_stp_state_set(struct ocelot_port *ocelot_port,
 					  struct switchdev_trans *trans,
 					  u8 state)
@@ -1331,7 +1325,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_get	= ocelot_port_attr_get,
 	.switchdev_port_attr_set	= ocelot_port_attr_set,
 };
 
-- 
2.17.1

