Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F334CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1616207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNH3vmPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfBWAAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38935 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so1796276pfo.6;
        Fri, 22 Feb 2019 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oBI12FenCDDfRE6eSCrjheZca+vUirHEjPRbN/cZFcI=;
        b=nNH3vmPNCqA5lArtC+jLENEEu0G2foBRlxxfiElJzRy/33NReasyZgmXnLw+uN4PuP
         2bgZaG7MLeswvSWoshu6mjKi4BBFZIR6gvz8nbqNOQLvtKskRaoOMYUSwDVToSMZDqHE
         eMNOteNFHw/w4lKuTz63z/XNLppIxCqQ4LGkrh579tQxnx4PUMT+PCiyMimreMffkQWS
         HPekdwFdcpn8A+HfwYSu3LZ/XI31m0erYxk5/gxLdV+pu1kiMDCmVGQ8yLSkzUAV1w71
         VC/P3YKZDNfC84nhm3QS7ndAA6ZmepATDtYjviPTsVG0yfDGkg9te5DxtL5ReuD5L2n1
         ZzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oBI12FenCDDfRE6eSCrjheZca+vUirHEjPRbN/cZFcI=;
        b=DzZt9KmM8cztBFQYkSvoZ62Jlwr+stufP5SP+LIP+lOjevnaWccA4l7Q2L4nuMaTId
         Zm7t8coLk/SPaBY4MyV7NP2Qzw01w2+1TrEPL4ab6h+nA2Z7VkTrVF/HUlW0fKQ7ULjv
         apVj5lhGOQ/TzkU5RAHQ4vdxrJegL6zKY8Efe7QYNepGp+P5jTAHSaePHhWMgp5ADtfp
         LUHhizJAOFP/PL8w15qgZHvQWkoM+qXnbsk6T+KkDn2YBb0FI9dqFaoMJmcXmcX9hz+N
         b99hZeXCgKfGY+u12TL1q+YTcGbKoaXYNOupzStXNwsuY/pnPl5AbirRRmd6Hz0fKloZ
         H/+Q==
X-Gm-Message-State: AHQUAuYGrNJdJEsALTwHRmg8kB0Y1LUkKTjfx8qms8lA0PnWHlWeSjCi
        TgQVe8vzxBS2e/5UQRLfVqttc7fe
X-Google-Smtp-Source: AHgI3IZQkbQJVPABqJrRH3jlnVOYTIw021CrnL0D0YWkdYxvA6QGJ/6puvkraAWLRVFtq5PmNCgtxQ==
X-Received: by 2002:a62:b415:: with SMTP id h21mr6816213pfn.26.1550880027625;
        Fri, 22 Feb 2019 16:00:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:19 -0800
Message-Id: <20190222235927.10295-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing switchdev enabled drivers to veto specific
attribute settings from within the context of the caller, introduce a
new switchdev notifier type for port attributes.

Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   | 27 +++++++++++++++++++++
 net/switchdev/switchdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 45310ddf2d7e..ca56b7487540 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -136,6 +136,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -164,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
 	bool handled;
 };
 
+struct switchdev_notifier_port_attr_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_attr *attr;
+	struct switchdev_trans *trans;
+	bool handled;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
@@ -216,7 +224,15 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 			int (*del_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj));
 
+int switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans));
+
 #define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
+
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -303,6 +319,17 @@ switchdev_handle_port_obj_del(struct net_device *dev,
 	return 0;
 }
 
+static inline int
+switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	return 0;
+}
+
 #define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
 
 #endif
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..94400f5b8e07 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -697,3 +697,54 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(switchdev_handle_port_obj_del);
+
+static int __switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	struct net_device *lower_dev;
+	struct list_head *iter;
+	int err = -EOPNOTSUPP;
+
+	if (check_cb(dev)) {
+		port_attr_info->handled = true;
+		return set_cb(dev, port_attr_info->attr,
+			      port_attr_info->trans);
+	}
+
+	/* Switch ports might be stacked under e.g. a LAG. Ignore the
+	 * unsupported devices, another driver might be able to handle them. But
+	 * propagate to the callers any hard errors.
+	 *
+	 * If the driver does its own bookkeeping of stacked ports, it's not
+	 * necessary to go through this helper.
+	 */
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		err = __switchdev_handle_port_attr_set(lower_dev, port_attr_info,
+						       check_cb, set_cb);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	return err;
+}
+
+int switchdev_handle_port_attr_set(struct net_device *dev,
+			struct switchdev_notifier_port_attr_info *port_attr_info,
+			bool (*check_cb)(const struct net_device *dev),
+			int (*set_cb)(struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans))
+{
+	int err;
+
+	err = __switchdev_handle_port_attr_set(dev, port_attr_info, check_cb,
+					       set_cb);
+	if (err == -EOPNOTSUPP)
+		err = 0;
+	return err;
+}
+EXPORT_SYMBOL_GPL(switchdev_handle_port_attr_set);
-- 
2.17.1

