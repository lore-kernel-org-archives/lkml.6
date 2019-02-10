Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E1FC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE020874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga9NuVRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBJRyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:54:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35837 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfBJRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id z19so9874562otm.2;
        Sun, 10 Feb 2019 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHbE9uV6OJihboPBricQmFVWhk9d/x0XEMpL4qW8zEg=;
        b=ga9NuVRTf+76T7F63I0At4BMjiHjjyiJUyTurr1/K2cV5/F4Wqj4H8Bza925ptIGz3
         y7AEmW4k8D7s1CyBf+UEmhar1a2KSoKDDiCQhaaz8E9JhW6uRTujxuvjUfLRZQcohrFS
         ZKQZejX+emIG7Jn7vlpxaKElkAuvjfGz8gp4k2Ba/KI1KJDhWL+nNikMpK8bfhi+xLSp
         NFwassSAWCfIHaZgJLLegulW8IQR+ymU8qWqL43n7zHfcyjhQLdY7+krJA1RkKqgV5hv
         6n1LOkPO9klAZWrHHB6BcPc+yzZi6CjU3q0f6D6CWxMc1kecvA0/PdFWJtRrowrjaYvU
         wWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHbE9uV6OJihboPBricQmFVWhk9d/x0XEMpL4qW8zEg=;
        b=GkZ+Vw5T0nTam1Wh1uggF/BwGmFwO2FkG2nxAn6UUhnfExT70tARzTgvM16q7nycC8
         /36ugSAmJiObuEPsFWcdmtfRN/8sHPzKGvy7Q7OuAi5lR+h2ya/gAEHFFut4a4t/i+l9
         kymucmiP2zYBo/MIwAjAHjwAt95eQj8IPY7ffWsT9jFgcIQ2ay4mCFqxAnILdEPwsJFq
         KaMjqZWnj0lEqLWUH9BwdabmyY6mVtdf9g5D4DPRLlfeUM/6hAtikE0+jq9LUDTR8orx
         FuRO6F1IaxZpjhqDefKxXyLaqeNoIRcwuNIHeNXE63fTNPXGrPJGl3Kur3d8YSUiBAVj
         LBRQ==
X-Gm-Message-State: AHQUAuZTuz8n3LBplwY5otvkNgsM9q4GEMuZP4bIi4SXErxjdR9SSJ+D
        E5JzuPkIGDA+p7pwhp7VPlWukzPW
X-Google-Smtp-Source: AHgI3IanprX1G12M5T+FfZ2hTIa4tOdiKOqe5OhTMtQMGzgqMi5HKkrQ/dXxm/+lg6nNeSvb85CKjg==
X-Received: by 2002:a9d:6419:: with SMTP id h25mr22239291otl.34.1549821223002;
        Sun, 10 Feb 2019 09:53:43 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:42 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 15/16] net: switchdev: Replace port attr set SDO with a notification
Date:   Sun, 10 Feb 2019 09:51:04 -0800
Message-Id: <20190210175105.31629-16-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 net/switchdev/switchdev.c | 92 ++++++++++-----------------------------
 1 file changed, 22 insertions(+), 70 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..fab96d978924 100644
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
+				      const struct switchdev_attr *attr,
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
2.19.1

