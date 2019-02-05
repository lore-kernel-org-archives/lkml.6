Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C89C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6C2183E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkn8gYv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfBEX4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:56:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43139 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfBEXzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so2249411plb.10;
        Tue, 05 Feb 2019 15:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I7rRGkpXq7CkNzOX7vahMr99VKUy5W50XI5Z7ov8fk4=;
        b=jkn8gYv3qkiSn5JABAd6ykI/Gl94wgE8ZlnfErhQWQV6GuVK9FAz2wZCYYWoAU456D
         GPr3lq1Z/7v040rTPlIEFaJAjmpKfDLcZxDtT8h2vUxRoFARj3ZgTzAFIB0x+KH5TuRG
         flT5ZNGOsvdOsYfK4B15CdeLYflN+cwlA0NLdgOQAC5pSIwvn0qVChR1AKIe6AdcDT22
         pszfJ2bcie1LGQ+pNxpIR8/36NefiqRKJXTcg3Wkqf6joMr6J/SrbPUM6xGYczX6KcaC
         0Aj+aGpasuR70xGaUYEZ7NO0rPH0YFbQzd7XOsWuLzlvH0on01PhP+lTf/V97GmIvNDn
         FJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I7rRGkpXq7CkNzOX7vahMr99VKUy5W50XI5Z7ov8fk4=;
        b=PRL+xeCp1i26wi0b5vqMJS6bf1wEGscFQ5tY1LRYuaySJva976QNl3aM7ort1DfLq8
         +LS3owcSd7WLp4VcYbTR6f+RYCQ0HwRbDR8qEdKfWYIkqxCXPwEgH28xhuTCBiveex0z
         1UjhBX3ey8WsuFuwmmYqwS4uwKVh9tJEk/kzeFPo952E8Gcin2ShKz/ILe5h1cWnxdnu
         F2sP4qB1nCxSfdeeOhu9hDR2Yfvjqf9P3t6gWYZLfbC8T/0DP0x4M/b5ZiOO3ssS4i4s
         pPzylYOJYfPwqpS4RVYTzU7JMGCWRkXUOhWZQbWbSuS1FpyaeeFsGcn5CxDdEWWW5ipK
         YqcA==
X-Gm-Message-State: AHQUAuY03gWJveA/Q9QmHDozSDR8MqLcZKHE4LV/l8OdxtpqzzDzthq0
        wwGxJb9aojkbiFs0Z351N2NLoyeH
X-Google-Smtp-Source: AHgI3IZZqHMpzbmhgcRv8MAKWC3sBdlW3P63wUrVMt34W700plIBWwgeVJNgkXhKI981gh/Zg9z/mQ==
X-Received: by 2002:a17:902:282a:: with SMTP id e39mr7817727plb.26.1549410953379;
        Tue, 05 Feb 2019 15:55:53 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:52 -0800 (PST)
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
Subject: [PATCH net-next v3 08/12] rocker: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:22 -0800
Message-Id: <20190205235326.14600-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
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

