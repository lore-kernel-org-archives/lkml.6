Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F407C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA8E206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+b/DXzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfBWAAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33128 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so1796308plp.0;
        Fri, 22 Feb 2019 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8X7vtYjVQnNJDwRTElP6c8FfW5/t8soTvCPa27QLBik=;
        b=q+b/DXzcS6W5CeZ6vLBdPVVJRK/vbGMXeTQe8yvt+YwVijM4Z6K24DkzDBMh57agwr
         jtCTmx7Ebb7W2PSo/pts+vCp22lqsu9FmyWZOyYKGYnuMFdmlBBnpkcxPilA8GJ0GoGO
         6jiajuVO9yU6YWo37P6fh/hE+9mip8OF2iw0/av85zLvvzCtUkCjlYSJp/5G7RoP3R4i
         Gvz6WCYxQ886M3QDg+52T9ThiMIymz4r8g9q+8iQmNQTOsNSn/dU+Q9891ATb2/gnIuV
         sSiokFD4M3v2X712o43zOKG+ei4ah9qnn7SRv1ij7Qqe1KSnQ56MB1eE9IT5dnZv00fq
         r2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8X7vtYjVQnNJDwRTElP6c8FfW5/t8soTvCPa27QLBik=;
        b=CdVTU6iUEMJNpIJmnRIg3dWK5zkUrrwG4aUReozD2MlkTf//HdZvBcBUZ5CX+tIz8M
         f64MW3aldgD/ERZK5SSZgwCA9TSjLv6o2WAY8fGPCsSywN+eMYeH7B4wa4cYoE1Tf5Pi
         ++oHrdZ4vcUvmuRVHmU6gPFCNkCPz0vM9+pN3qEw17Kpcz7Z2U8Lz6gR1B39Yf+tmlsn
         32h1B2YQmvIeYuCdcQYayFQLA8oGojCx+E2CW+yhJYg/+veE5Q0k8R1zUvK8VUEQhar+
         89wUsbvMG4PmvSNz/TuPpkKFVO0eSOCYegSh6tz7EZpvfGcOURWHoojRSw4AFXWYJ05I
         yfHQ==
X-Gm-Message-State: AHQUAuYXTsQRTBTQlux3slJ8q/6SGqnQVJYG9uvD1SZModc65TBXvigP
        RVNe68UNF3FWKbEJrYMrQBVsII7B
X-Google-Smtp-Source: AHgI3Ia3km/CopzvUFvwOyrs4f3UOhPIBbk49ReGRIPZbPD2s6HfUQN3dheyUj7ZQNZtnRPl38LbQQ==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr6706599plz.148.1550880036462;
        Fri, 22 Feb 2019 16:00:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 3/8] net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:21 -0800
Message-Id: <20190222235927.10295-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
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
index a78b2bba0332..49a5b29fe884 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1422,6 +1422,19 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
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
@@ -1500,6 +1513,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1562,6 +1578,8 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dsa_slave_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

