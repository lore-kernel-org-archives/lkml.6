Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11949C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75A0218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZkCtsIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfB0BOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:14:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47023 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0BOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:14:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id c17so3938081plz.13;
        Tue, 26 Feb 2019 17:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZICwACNBLinWfOFo5BNxpXhARueQcYuojmKLKdZqLXk=;
        b=vZkCtsImSgiN4o2HP1QzeuDHH+LL/rES9XF7h1lhY705gSIhaJLRYD75GEzs7Yb1HK
         P/p2T61weQX35jAf32/fOvmP6km3GfU/0shiuZbfjodssmQX5gjxrThMUwSEuDNhejOl
         5a+9ipzltAgBwiC1i0V1OB6pkqjEAOMZpfMvSjgKJtEh7zaX0ub1JkYefbUQaKYTbzBS
         qbtdcFFgjSLA8TjIwCQndk1UbLdnptiZeuQZbKitRUDxxdMlQ+R0SEG/BK/LvsKgtc8U
         lcwOPENTFoQoXI43h4hA2a+VoOtUDX1hu+bJP1MKRFY/Dfbt2WyUcDMH9b8SkzIj7rj+
         hg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZICwACNBLinWfOFo5BNxpXhARueQcYuojmKLKdZqLXk=;
        b=CnJjvoJNuQGgh3PzWHTXR81F+sgy8JusIVLKAv909yRWW1UBCspeNAlcTr7wYahqhd
         03BXxiop2zB4f/CvKItJf/6XHP4GcCd+ztXjKs74HuvYfaBZdnDyifInmEriXQfriNp1
         0HlHX8SsPL8Dl9GJg+zECQxnW5vBfyxFIBUincGbjBVTZDep1a0+w+sV6YZ9BmgJrVqf
         W6/+NY/FuNAAL9QUWDilM6Sv8DDcC04jvLWC4tltd7Dxh12hpuPm1++ncK6lHCqjG7B9
         bkW785x03oAa6vQbkxHlLT8amL0Kp2yeeWdH40PSfbMCkYzt8ObCHlSluU8MtDFI6zuw
         Hl5w==
X-Gm-Message-State: AHQUAubc1qlrrxOVK9V0hFRfK5vVyd+fS9fCRfTAPFG0i6ESgcMP02cR
        QIk/iMe1CMTr+3CWB0RzVpBEwLId
X-Google-Smtp-Source: AHgI3IZzjdX1358jh3ucaGDGGccGyyvNdWBzC/ZhTWEjW8FLK9c3J9CfuRjGRaAlh9rcSAVFiXBDCQ==
X-Received: by 2002:a17:902:b7c7:: with SMTP id v7mr28778771plz.148.1551230080781;
        Tue, 26 Feb 2019 17:14:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:14:40 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Date:   Tue, 26 Feb 2019 17:14:20 -0800
Message-Id: <20190227011427.16487-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
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
index be4b13e66668..5087c06ceb4b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -132,6 +132,7 @@ enum switchdev_notifier_type {
 
 	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
 	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
+	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */
 
 	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
@@ -160,6 +161,13 @@ struct switchdev_notifier_port_obj_info {
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
@@ -212,7 +220,15 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
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
@@ -299,6 +315,17 @@ switchdev_handle_port_obj_del(struct net_device *dev,
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
index 362413c9b389..3560c19aa7e2 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -655,3 +655,54 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
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

