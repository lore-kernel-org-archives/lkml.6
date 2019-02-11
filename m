Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08453C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39B221B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blyiAXcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfBKTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:11:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43529 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfBKTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:11:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so5500857plb.10;
        Mon, 11 Feb 2019 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/u+Kp7GgYlDbKFbh6YAwMSm2Elg7F9P+dQ3wMoaKCw=;
        b=blyiAXcEzoAiAtY/XQPfKGkZIrnOlkb8ifQ0jwBIbvvfYB5VkNIeaeq7HUgA5tR70u
         seLRGL98vrh88Z1yHu9EAnnXw5uVNZgZDwP8olBqXT+JIKtT5ROdaarj9fAjLZrhkkDS
         UfSGI+XHx4h8qUbCdEd/+38zFc5uQaWj6lhgYIua1P2/c6tejO7UNpoBU1gYxU0ZPMtt
         EdwIQBCNtb8+FQSoOUYtaQFqFIED13BJWkjHHVKFfGWMNI2m0vDzgTxc8JPWAA+Z2yRK
         s+qobnnwW9SKAjJXZn5W9v9hwVWO68K4AwOgUDswNiwisa5bjbwTXj1Hrh1qdeTWle5F
         v9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/u+Kp7GgYlDbKFbh6YAwMSm2Elg7F9P+dQ3wMoaKCw=;
        b=WSHgIfj+/TmnojUHnlG0XM+bnQGZmLaBY4KQdrs+GoMwMIHzqR10y6/Ell6ef+wphl
         afz3Cz3qXg4ekWeIG81Pil22MDKfvVAkx9798s4uwcodP/A4c6zP5VlRH5MurluPlLQu
         aseJe09bq0j2K33Xq3UyKNK4N+vnanLLnBWFI1iBabbtnIHpA9pCqZg2YnhgocH4sDkF
         TRHYnjtcz0mFoLuoMSDA51IqyWTR6Z3IyG76qiVr/mTK0dTg03pYakFRMgDMozaOqMYA
         z204Js5aGl/59OYMR2UH0YEY9tgV5WsEtSplK7IUBRZnF/YajFyy3cnmX+Mpgft0hafz
         K05w==
X-Gm-Message-State: AHQUAuZEY0/CMxSZeDae7iK446S/I5yb+I6s/xmLpSX3jiMdEcRRJGC6
        /PiGtF2Vqi/00srpBAK4isBGmI8l
X-Google-Smtp-Source: AHgI3IbDoMH/38BmZxDFiDtNqXOZxfWY567eX/3dciKqeGqin9Wjtarx4yU5h4+C6bSGbYu5WUIIGA==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr39373804plb.182.1549912263106;
        Mon, 11 Feb 2019 11:11:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:11:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 8/9] net: switchdev: Replace port attr get/set SDO with a notification
Date:   Mon, 11 Feb 2019 11:10:00 -0800
Message-Id: <20190211191001.8623-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
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

Acked-by: Jiri Pirko <jiri@mellanox.com>
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
2.17.1

