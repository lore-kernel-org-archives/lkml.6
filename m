Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71773C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEF820823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV6Vn7PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfBEWOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:14:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40467 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbfBEWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so4273410edr.7;
        Tue, 05 Feb 2019 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I7rRGkpXq7CkNzOX7vahMr99VKUy5W50XI5Z7ov8fk4=;
        b=iV6Vn7PMYtVEC26NO7unmrLu5rwVTdpgRy+vG3+k/sy/IiYOOrWDnK6E+v6lovkJFX
         Y6mY9bbN+Vh6AaDcGCSnWrBp5HQruFRW7Yls8jrL1PvspS5r98+Qh2CxQj7KO/HMiuZj
         dJkMM/k1AXeHJqzpVJ2Pm/RxBuAb04J3hKpPsYpCGMOajq8CXsdEjy0M2okPPz465Vqk
         SwZ94d9jazm7uz8Rciagss5JhiqkEMrjdHAO5zXt+kpuEuGzX/zapfY2i9khbPf95FOJ
         wG3oEX6/cbLsM/yaByNUgVcSpUFYistHhAEg7OFrWCwMh9BekmXba5K8szuKoAhfxoEV
         uPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I7rRGkpXq7CkNzOX7vahMr99VKUy5W50XI5Z7ov8fk4=;
        b=KpLtBlMx5bX8Y57j0KRY2TzD5LUl5O8dwhWsIlIHGfVF5h9LU7uhjDzYNeWMn7kagO
         svaGw4a+2fL64/y7Mp+ep2NEhdfhI5a7rbOhRSBx9l6bkXPjAbMMuDB3LSeL7FlVtqK4
         h4nXo1h62hEZkcH6WH//FiQlXjDw7tegckaNsiqfvcJSk3ebNTuA4mBzL3I7VCuNRo4R
         vW3fk6YWphabxzcvZoZdZpI4/M9Eih0ZIxF6KvKWBYFUoLtIVdUqTtiKRK5/tEIFOzGy
         bue3mHoB0OfagaF6A36xyjHCR2TnUf5OCZd6JO/vSMp0ndFl1sHpDsrVrNxiu3pbeFZl
         FMYg==
X-Gm-Message-State: AHQUAuYxdsu+06KLX8SGndNrKcB9iCySt0tcjNyVF6wVvaOmwjL+MqGb
        20BN2nccoEtcCuMy4qmGhfaN982+
X-Google-Smtp-Source: AHgI3IY8bpGZZuy1g98yb6BB/HKwXQXFljOPe/0qP6Q8fQ+0PCr2Gsgm1Z0rKmAZgD3Uym98iE0CoA==
X-Received: by 2002:a17:906:3049:: with SMTP id d9mr5175238ejd.19.1549404827084;
        Tue, 05 Feb 2019 14:13:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:46 -0800 (PST)
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
Subject: [PATCH net-next v2 08/12] rocker: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:13:07 -0800
Message-Id: <20190205221311.18476-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 62a205eba9f7..596f44dbfae1 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2026,6 +2026,18 @@ static void rocker_port_neigh_destroy(struct net_device *dev,
 			    err);
 }
 
+static int rocker_port_get_port_parent_id(struct net_device *dev,
+					  struct netdev_phys_item_id *ppid)
+{
+	const struct rocker_port *rocker_port = netdev_priv(dev);
+	const struct rocker *rocker = rocker_port->rocker;
+
+	ppid->id_len = sizeof(rocker->hw.id);
+	memcpy(&ppid->id, &rocker->hw.id, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops rocker_port_netdev_ops = {
 	.ndo_open			= rocker_port_open,
 	.ndo_stop			= rocker_port_stop,
@@ -2035,6 +2047,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 	.ndo_get_phys_port_name		= rocker_port_get_phys_port_name,
 	.ndo_change_proto_down		= rocker_port_change_proto_down,
 	.ndo_neigh_destroy		= rocker_port_neigh_destroy,
+	.ndo_get_port_parent_id		= rocker_port_get_port_parent_id,
 };
 
 /********************
@@ -2049,10 +2062,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 	int err = 0;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(rocker->hw.id);
-		memcpy(&attr->u.ppid.id, &rocker->hw.id, attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
 							      &attr->u.brport_flags);
-- 
2.17.1

