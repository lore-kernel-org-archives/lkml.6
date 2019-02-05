Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87D2184E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRZgnA2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBEXz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:55:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfBEXz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so2120650pgb.4;
        Tue, 05 Feb 2019 15:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5/2lkSN34z8RTeIIaRZasc8AXz7Kch8Ha5gpyZNhmKs=;
        b=CRZgnA2c7WGtqDHrKYNT0aWeK/ZBMGRHKPz44It+blD2Ax4DaOIEfk0ohanXWkX8SE
         iXq39pn7IzTayRf0DMS+zxSzyRNiwdfjYAoOSH1gQ4G5D8ML+xNVGhKzyexBvPutt+Nn
         wCg2ZeGjx9L05hwZh8odMyqMxKhif4A1tr4vr+NIDvBmMqX8UTiMN8R354MzSavjS/Hh
         qx4RiSyxfMx8vGf5JEzx6vjn/tw0KPn/7DkmrA8MA9IM1nHCGeA07M0D+0IJIzgsMPGC
         BvQDzpRUQptobYzlOwsH4ZppYQiCgmvaO/nnBJ/mxZ34RbIgZhDyzGQaMV+017Y9s98M
         PrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5/2lkSN34z8RTeIIaRZasc8AXz7Kch8Ha5gpyZNhmKs=;
        b=F+OO8NGWwOzlxh0HyQkxNRNCGce6qNYqbcLwESgQIUNSID7NI1gcNsofLWuv7Aq0Na
         kkpOZmAl8NRKBGPbkUJRhSiE2juzaJh3AyPZ031BgB4dFdH2ZPlpXo0lEmdfGtWyAfzy
         H1WC286LWrnY96luSBrWiv7FuFlFwM2HmWRzlXCchSZ2tRHEtudIOgDJDbsyM642b5Ac
         pDhRen+AqLG3HBTxp5QxWoj60takWRcN9Nx5Vn8UvP2GoXkCx/TqTUfvWhvKhs8I3Wcq
         6PJyavOB4eC+w/2uKA0OgxMWK3p3bSN+BU7sbKobtBIKl7wLxWHHUhPE40o0cRLX3Fkc
         92rw==
X-Gm-Message-State: AHQUAuYVp95RZLzqaHxFoDrZVVDwfkfHmXza6d0Fpn4MSlBr9St8WEAw
        3Y5V4RfmHGYZ2k+x2OQgHSmkMGZ8
X-Google-Smtp-Source: AHgI3IaNULXxmtB/WqSkod2NWjG21rMqedZbSviyq9AgH76tjFZzoDVwoqEZwl7joWZoXl6FAFOe3A==
X-Received: by 2002:a63:960a:: with SMTP id c10mr6938245pge.106.1549410955072;
        Tue, 05 Feb 2019 15:55:55 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:54 -0800 (PST)
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
Subject: [PATCH net-next v3 09/12] netdevsim: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:23 -0800
Message-Id: <20190205235326.14600-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdevsim only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8d8e2b3f263e..75a50b59cb8f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -22,7 +22,6 @@
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
-#include <net/switchdev.h>
 
 #include "netdevsim.h"
 
@@ -148,26 +147,16 @@ static struct device_type nsim_dev_type = {
 	.release = nsim_dev_release,
 };
 
-static int
-nsim_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int nsim_get_port_parent_id(struct net_device *dev,
+				   struct netdev_phys_item_id *ppid)
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ns->sdev->switch_id);
-		memcpy(&attr->u.ppid.id, &ns->sdev->switch_id,
-		       attr->u.ppid.id_len);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = sizeof(ns->sdev->switch_id);
+	memcpy(&ppid->id, &ns->sdev->switch_id, ppid->id_len);
+	return 0;
 }
 
-static const struct switchdev_ops nsim_switchdev_ops = {
-	.switchdev_port_attr_get	= nsim_port_attr_get,
-};
-
 static int nsim_init(struct net_device *dev)
 {
 	char sdev_ddir_name[10], sdev_link_name[32];
@@ -214,7 +203,6 @@ static int nsim_init(struct net_device *dev)
 		goto err_bpf_uninit;
 
 	SET_NETDEV_DEV(dev, &ns->dev);
-	SWITCHDEV_SET_OPS(dev, &nsim_switchdev_ops);
 
 	err = nsim_devlink_setup(ns);
 	if (err)
@@ -493,6 +481,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 	.ndo_bpf		= nsim_bpf,
+	.ndo_get_port_parent_id	= nsim_get_port_parent_id,
 };
 
 static void nsim_setup(struct net_device *dev)
-- 
2.17.1

