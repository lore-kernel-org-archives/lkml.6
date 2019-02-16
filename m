Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9526B222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1XJOaYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404902AbfBPE4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43056 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404671AbfBPE4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so20122484ota.10;
        Fri, 15 Feb 2019 20:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifXkdhN3Db+p5XK7EE964Sj4BgFX95LGnnu/9MTO3AQ=;
        b=W1XJOaYQ+Gsgi6lQkh4kw6lQw02nDIat48i6PqsN+TBuxOgWmbPJzRxB7LWmY0aKUP
         +0zPpzWN79KnuEng2KiVcpFc0+llB1sw39TNsKCT8xUs+WhBg2TNRhth9t6iZcTJJrjD
         3LcRUxFuHT7ulf4Y1N0AVW6y9l0vm8hm1BiLam0+eX/6ieN7a13Oqh95uGihFGLovWaT
         XTwRutTulVZnQcFHAjeDRtVuzV0r5+rDE+bMjVUcIat1kdYOb96BZ5y8JKzlcslbMiYt
         udng80c7sTOO9TL7xiwneSBs39+8zGjDDHUo9SnNuZbU6A6eHX3Q93SBCButZSpMtIGL
         HM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifXkdhN3Db+p5XK7EE964Sj4BgFX95LGnnu/9MTO3AQ=;
        b=lsfc4wecdSbAucan8o3J9cABLKgjjyLluEKMEUf4HG/t2GvwyCJixoigCBeI/SkG7W
         af1i8gQEm5eDGneR4xlcD1ZuHsdt82o6AzcK4pp+7Bg6D8lCrsYD20tkX8gmCWakCzyt
         +SXpReZedkoDsXamJAz2RepyOf/HsjvrFIuzb7TXbenv9TtFWlOXH5s+TQmXe9TrRrKJ
         v+Uyk53S+RycemePL1kJWLtvIxVx8QOk9f+z94URbCEJljXRRO2Xw0xTl8DxvVjjEx5u
         2uaPVXW6KI4HhLwjnvZporNpeD4ocgp58S+Xr3/FOAVaIEIuNbF4Bdh7s79OYGvwPaAG
         u7nw==
X-Gm-Message-State: AHQUAuaerIxdWs4VWxFq84MAroZXyIuMRd93q0C7ea6yPhHuID8vMHAo
        XaUesRDE5wQ/J956bKc7Aow5uM3B
X-Google-Smtp-Source: AHgI3IYcUSmJh5rEbgaxxOZQy0jtbIz13axowprhialaHP/7rXYC+lzAmx9hTYWnNxwm6v3ZkVLdJg==
X-Received: by 2002:a9d:64c1:: with SMTP id n1mr8017247otl.175.1550292978395;
        Fri, 15 Feb 2019 20:56:18 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 8/9] net: switchdev: Replace port attr get/set SDO with a notification
Date:   Fri, 15 Feb 2019 20:55:55 -0800
Message-Id: <20190216045556.3514-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop switchdev_ops.switchdev_port_attr_get and _set. Drop the uses of
this field from all clients, which were migrated to use switchdev
notification in the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_GET and _SET.

Update switchdev_port_attr_get() to dispatch to this new function. Drop
__switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/switchdev/switchdev.c | 107 +++++++++++++-------------------------
 1 file changed, 37 insertions(+), 70 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..8fc3db2179f5 100644
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
-	}
-
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
 	}
 
-done:
-	if (err == -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP)
-		err = 0;
+	if (!attr_info.handled)
+		return -EOPNOTSUPP;
 
-	return err;
+	return 0;
 }
 
 static int switchdev_port_attr_set_now(struct net_device *dev,
@@ -267,7 +217,9 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET,
+					 dev, (struct switchdev_attr *)attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -286,7 +238,9 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = false;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET,
+					 dev, (struct switchdev_attr *)attr,
+					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
 	switchdev_trans_items_warn_destroy(dev, &trans);
@@ -338,6 +292,19 @@ int switchdev_port_attr_set(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_attr_set);
 
+/**
+ *	switchdev_port_attr_get - Get port attribute
+ *
+ *	@dev: port device
+ *	@attr: attribute to get
+ */
+int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+{
+	return switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_GET, dev,
+					  attr, NULL);
+}
+EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
+
 static size_t switchdev_obj_size(const struct switchdev_obj *obj)
 {
 	switch (obj->id) {
-- 
2.19.1

