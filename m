Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F312C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144920821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEWF2cuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBIAeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:34:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:34:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so2441147pfi.5;
        Fri, 08 Feb 2019 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JXWongBRQ6HqJ5lydNBt8c+EIA0CX3r1EYUcWFECq4k=;
        b=tEWF2cuSfWGrJ8V1uZfIOfSI6/RErNXjQVxDOSR2NZFiDhmNy4yPN/mbtZ5euDRRKC
         5Wr0crN6I0DpVGaN93VKfZ7wOkuh6CZSn+YJKF10k7QlWFaS+DLj/MJFug9ZT+M5AmRL
         p+8gdshS7nrLpqNii9qDenmjgyoiO3HfVP0hDXSFa6PUEN/2UR1YUsSdhA9yq6P0T9TE
         LeYZUwY8fCq9jSocyoCC2ftHCDSp2iyX34QL6H1njwp8mlaHn7iBQxV8DS3hv5B6SuAK
         BSrFIMhLHxdEqcBoDGc4WdJ3JuO5DC4MX8WnwD/cHxJW5NN7/D8or1W0rYsvcpq1EhCB
         wE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JXWongBRQ6HqJ5lydNBt8c+EIA0CX3r1EYUcWFECq4k=;
        b=moQiv8bIqBpC92FSd46NpAR/6xPa/+2QVqOLhBtCZiTZo5ByrFJAO/LqxZupGDoABX
         KKdTGqXEvBYxj0ynZJgh8Q8bOurq2Fn7BmiRQDYHxiPAFVWOmRKireoXDkaaWReFwokI
         TXqz9gANpElWmk80ObTLDXDUb8NIW+SnuJYn0tyReUpPi1xf6JSQ2p0LNGrkuLoSzt6O
         zxF9ZD0K4vLXBsPBMYtlAkWntT8VbvShFKTkdKaC5Np80b9fTldilLTp3A67UZZEDHUS
         bKTTVdg7d7/bvItY5GvVABDYneUUoAmUQYPbeeP0o/gocV0QB/2kFsLzucAQGHSR919a
         subg==
X-Gm-Message-State: AHQUAuaEwLz8KGlNC6lg/ZFbyzKZebuj2Mv+H9vDHBUpWAaHr7E3QQlU
        O8HR0JDpkG6jd9212k3LFHu8uKQ3
X-Google-Smtp-Source: AHgI3IbQwON2MC4avhPKs44m5ThDGNNyt1QcSztP9rX4tFH1rJv0EcIvW96v8j4U/cluGN33zOZ7Rw==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr12687708pgv.31.1549672454456;
        Fri, 08 Feb 2019 16:34:14 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:34:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 15/16] net: switchdev: Replace port attr set SDO with a notification
Date:   Fri,  8 Feb 2019 16:32:47 -0800
Message-Id: <20190209003248.31088-16-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
from all clients, which were migrated to use switchdev notification in
the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_SET.

Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   | 18 --------
 net/switchdev/switchdev.c | 92 ++++++++++-----------------------------
 2 files changed, 22 insertions(+), 88 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 4c5f7e5430cf..5387ff6f41c5 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -111,21 +111,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
-/**
- * struct switchdev_ops - switchdev operations
- *
- * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
- *
- * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
- */
-struct switchdev_ops {
-	int	(*switchdev_port_attr_get)(struct net_device *dev,
-					   struct switchdev_attr *attr);
-	int	(*switchdev_port_attr_set)(struct net_device *dev,
-					   const struct switchdev_attr *attr,
-					   struct switchdev_trans *trans);
-};
-
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -224,7 +209,6 @@ int switchdev_handle_port_obj_del(struct net_device *dev,
 			int (*del_cb)(struct net_device *dev,
 				      const struct switchdev_obj *obj));
 
-#define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -311,8 +295,6 @@ switchdev_handle_port_obj_del(struct net_device *dev,
 	return 0;
 }
 
-#define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
-
 #endif
 
 #endif /* _LINUX_SWITCHDEV_H_ */
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..5a053e20363e 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,81 +174,31 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-/**
- *	switchdev_port_attr_get - Get port attribute
- *
- *	@dev: port device
- *	@attr: attribute to get
- */
-int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
+				      struct net_device *dev,
+				      struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	struct switchdev_attr first = {
-		.id = SWITCHDEV_ATTR_ID_UNDEFINED
-	};
-	int err = -EOPNOTSUPP;
+	int err;
+	int rc;
 
-	if (ops && ops->switchdev_port_attr_get)
-		return ops->switchdev_port_attr_get(dev, attr);
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.trans = trans,
+		.handled = false,
+	};
 
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
+	rc = call_switchdev_blocking_notifiers(nt, dev, &attr_info.info, NULL);
+	err = notifier_to_errno(rc);
+	if (err) {
+		WARN_ON(!attr_info.handled);
 		return err;
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to get attr on
-	 * each port.  Return -ENODATA if attr values don't
-	 * compare across ports.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = switchdev_port_attr_get(lower_dev, attr);
-		if (err)
-			break;
-		if (first.id == SWITCHDEV_ATTR_ID_UNDEFINED)
-			first = *attr;
-		else if (memcmp(&first, attr, sizeof(*attr)))
-			return -ENODATA;
 	}
 
-	return err;
-}
-EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
-
-static int __switchdev_port_attr_set(struct net_device *dev,
-				     const struct switchdev_attr *attr,
-				     struct switchdev_trans *trans)
-{
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	int err = -EOPNOTSUPP;
-
-	if (ops && ops->switchdev_port_attr_set) {
-		err = ops->switchdev_port_attr_set(dev, attr, trans);
-		goto done;
-	}
-
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
-		goto done;
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to set attr on
-	 * each port.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = __switchdev_port_attr_set(lower_dev, attr, trans);
-		if (err)
-			break;
-	}
-
-done:
-	if (err == -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP)
-		err = 0;
+	if (!attr_info.handled)
+		return -EOPNOTSUPP;
 
-	return err;
+	return 0;
 }
 
 static int switchdev_port_attr_set_now(struct net_device *dev,
@@ -267,7 +217,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -286,7 +237,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = false;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
 	switchdev_trans_items_warn_destroy(dev, &trans);
-- 
2.17.1

