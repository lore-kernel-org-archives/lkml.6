Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CD3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87182217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYDWLZYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfB0Tpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:45:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0Tpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so8454407pgq.4;
        Wed, 27 Feb 2019 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gq/qAOtWNvcuwUtUaSW2EYY4Z4jqPnX1n6JjQenVLBM=;
        b=mYDWLZYQ1P9K2YrLg86WXa1TaoOWvcXq0t3hRPlJ66U/RDjehvNJBqsU/L7AYbp3t7
         mKH6T4aT0M/4LIa6jN6WokijtoJCiVEvMavKX+G//txl8BoTSbaAeMw15a4B3ntRwZe1
         dG5VL7heK5IXIJnTH51tWw/f9SrHS6VFXistx3SOlVNveeM/rvWX6RtECQwuQVTat89T
         JvkZyMSmC5I5HZTzx2LryAx6Jt25E9n+dZh5B6YDWJpxQog7Yk4hI9RaAahe0DvBPdGQ
         g7RN4n4/l0/OQHA0NuWoIdXE/NAh0UemJKbNzrKN7FwcwBiDofmcf0K4cr9Yo+JBCIq3
         8kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gq/qAOtWNvcuwUtUaSW2EYY4Z4jqPnX1n6JjQenVLBM=;
        b=ISW2m/Rbb1qPY3ycq9DrRU4K+UPonclkWdlPS8DlixPyxt+FunK8+AuwgWdmwPVRIo
         tANPN1TnIaH5odMVFO2fpHy26hEEg1F3Ex4qT954/4cFA4DfG436IvBlLzM+nwe2epBL
         FLJl867NRhzJvYwQdrC8z8/bV0q6WhjOlr/cNQQKr3NJEwEBXwj2LupK6FfM+wRxTG/n
         YI0V0cJRwxKi9wnuwuIDCq6VCxIHct06EeLLIoxwgbHDMOzVhK8QT2C3gCuwuWFNYBgk
         tbRqHQ5iuY9806VK2FyPzmRNlOrdtYAFTK48IruHlVS5RpKz3ElipTJXTe+IKDo18AgC
         dFZA==
X-Gm-Message-State: AHQUAuZVZtls2666Nx4WQ8tKLQHIerDIYiXfK1NVAgUIYfeRLyXg8mBu
        PEIZlvrmceNGGiMdvOR/ja8zzlUz
X-Google-Smtp-Source: AHgI3IaOSuxD5c723IsDmL1B9rpi5vGzghVJfO6KbZteWZDUHGPnGtSz7AosjywOWGACHWi/3jynbw==
X-Received: by 2002:a63:234c:: with SMTP id u12mr4688826pgm.282.1551296730092;
        Wed, 27 Feb 2019 11:45:30 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm17044642pgq.33.2019.02.27.11.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 3/8] net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Wed, 27 Feb 2019 11:44:27 -0800
Message-Id: <20190227194432.725-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare DSA to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
dsa_slave_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 7274499293c9..b089b43120e1 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1524,6 +1524,19 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int
+dsa_slave_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
+				      port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct dsa_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -1602,6 +1615,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1664,6 +1680,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

