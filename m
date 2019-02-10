Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D926C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD4120855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsYeMIVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBJXkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36024 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfBJXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so14704778otk.3;
        Sun, 10 Feb 2019 15:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifXkdhN3Db+p5XK7EE964Sj4BgFX95LGnnu/9MTO3AQ=;
        b=FsYeMIVaQTi184L9QS3dyayfbHkLaF+MIV8eKc1hnhmcFAnD34bbTrHG5IRsXxmY4M
         7lonOXTuMeJ/LsuTz4y9zmqci/zeCenkts5V9WqKdJykwuQJcUHcvIIVrDhmJeJim8vH
         ICul48Zb9Qb9eWnqN2gwq+WxAruk3zPVXbdD17lDAGOLfeDd0ibYOfiivWnJcxQ9hbEc
         R86YbnseK/IUD8BI8C2AopV8YGDYEgUtQASVp2A13GvDUJ/kuJJSYLwSMWcwmGz13PLD
         ZBjUsGmrFiyccBkN6+Jmrwl9O3dAQJkjBZB9PYTy66D/nWSnevTM+zz4DMJiafPwP2kK
         UNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifXkdhN3Db+p5XK7EE964Sj4BgFX95LGnnu/9MTO3AQ=;
        b=ZrfVzHKQxX3OQR47DTouMcCFK+ba2MpcdPfnyQG7TX9Xwmtsu4vdj5TgB6SR7ErStS
         hvUKKCIdppQa/o+Bf/rHlrVui9nZdnYy3H9DtOKBhlN6y//PeFKSp7w0kFhR3PQl/VPH
         TJNAAjUXdUsgGYweKf17Jy5AUMEd5ir9tlLxA3tIgZglFx5Fqrk2FlYUWGesFwxv8Cs5
         cTrBcZJymUOFLWQxhlSPY11gFORn5E8uFO48UUfbTU4OVpL5lcypQVfMCsS20dmSmyLN
         aJ05bE2pQrhog4kU+f4KEhm9W63zBv4AhHuA137W6xiiBVu9oscnJ0ykI7WJUwqYYg1B
         yF+w==
X-Gm-Message-State: AHQUAubs3TKJ9T14I+IqRxWzllrXLHPB424QoqGkhD4nU1n/hOUUkQrK
        23UoCZEmtt3ugJU1mcdUTl/KcEb2
X-Google-Smtp-Source: AHgI3IbduBVatitt4btcTF1GLVwQjYfKOHIqEz4BTMaRyEIGzjP/1Bbi8UgmEfcYg63KCpcc7b+rGQ==
X-Received: by 2002:a9d:3b21:: with SMTP id z30mr26962866otb.132.1549842029218;
        Sun, 10 Feb 2019 15:40:29 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 8/9] net: switchdev: Replace port attr get/set SDO with a notification
Date:   Sun, 10 Feb 2019 15:40:06 -0800
Message-Id: <20190210234007.16173-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
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

