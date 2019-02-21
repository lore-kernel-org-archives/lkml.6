Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B048DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9492084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx5uDgr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfBUA67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:58:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45447 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:58:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so13184098pls.12;
        Wed, 20 Feb 2019 16:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oEsRiOyoTDS2Il8WB9wmLIZuhUcjnS7BnvM3RAeCqbk=;
        b=Hx5uDgr/gFZ9Uyu/47qLgrNO2f2Br0O933scvBL9J+2CR4jGP0x29l+ms4J3Qd+kEj
         LkplyFWTgHu/ujiwoGR8F4IvvMQT7DOK8iZlq+/E18tVLUZAjZdJs28fUWtsWgDl+Wm6
         0tlHZL774YcNFgzqYxbre8gnUNyZx+8iWIiaoOsoCms89Aop1SQllMCp1SWIFxDbJgVu
         5LCJBa/9X/MlFgSQ7VyRTWyViCod//uEc21QCNqfqVTbuD+YxGNdKNlWtPAyQaUAEQuz
         vvhGsWirostpm4JfR0mK2/Nw6tsSYLJaTH/SxEGpZj+cRj7oYTFvaNZh/wXn59DPc7dl
         MadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oEsRiOyoTDS2Il8WB9wmLIZuhUcjnS7BnvM3RAeCqbk=;
        b=qUg9gatblJ8LzbnGiTavmV2RWRY6j9gUwlmon1enggJuwgUaeUWXXgne/1RCH570LC
         2e7Rpm3J+IdK6xLfPv85P1xHhwTdrIDwC92n3AZRXjeT6bxoTM+VddCb/vWq8pOYmJOC
         WSGH5pflRnD6Tde9TBWRQ4iBZvvCegcH0iq+JcaGJGZFlbuJIZriAt63I14B99GA69t7
         oVU9eNTYZnCJnENIANLy/u+VhcexnJXwthbCnibbjsfBeCsDS7vGTnF8EBgfrz6fSJi6
         6TxrgG4TMFlaGf+TNufTK+i8QXZwV+W8/CabNynkwUGq7L0HaahW+f4wH8KTqfMloRfR
         Grqw==
X-Gm-Message-State: AHQUAuYRyi/ps6JBVdEtdOdu180J+J/tv+5EnyU5CMsmpGfqdU6L9N24
        Sm8MN+DeBtjIr8HNEVk+TGINMlzS
X-Google-Smtp-Source: AHgI3IZyJfDEEc8ArA7jPZmU0ZGfk5vCWdV/By2fJuV0BY1fgh3bXM+RjTcFVBLCb0Gm6ft+fVjZtw==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr38877714plv.43.1550710736329;
        Wed, 20 Feb 2019 16:58:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 5/8] rocker: Check Handle PORT_PRE_BRIDGE_FLAGS
Date:   Wed, 20 Feb 2019 16:58:23 -0800
Message-Id: <20190221005826.26317-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 55 +++++++++++++++++------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5ce8d5aba603..25129f7b5583 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1566,34 +1566,57 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 }
 
 static int
-rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
-					unsigned long brport_flags,
-					struct switchdev_trans *trans)
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
+static int
+rocker_world_port_attr_pre_bridge_flags_set(struct rocker_port *rocker_port,
+					    unsigned long brport_flags,
+					    struct switchdev_trans *trans)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
+
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
-		return 0;
+	err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+	if (err)
+		return err;
 
-	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
-						trans);
+	if (brport_flags & ~brport_flags_s)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
+rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
+					unsigned long brport_flags,
+					struct switchdev_trans *trans)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
-	if (!wops->port_attr_bridge_flags_support_get)
+	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
+						trans);
 }
 
 static int
@@ -2074,6 +2097,10 @@ static int rocker_port_attr_set(struct net_device *dev,
 							   attr->u.stp_state,
 							   trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = rocker_world_port_attr_pre_bridge_flags_set(rocker_port,
+							      attr->u.brport_flags,
+							      trans);
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
-- 
2.17.1

