Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532E72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUylNHRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfBYCjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:39:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45963 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfBYCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:39:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id t82so6041742oie.12;
        Sun, 24 Feb 2019 18:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQNn1WUD1tH4PUKngCu7NNi7bJYoR/t5I5ZYbIhwwKE=;
        b=BUylNHRxCDwSeW/V5eVVJZ8Td9HclgYr0zFhluqkNvQkL6gbvJh1PNkLX1G07Fk0q7
         xIY9spgzJWlQcbmo+oOOI/Ig9zUdKO4EPkFi1RHd54BNAeZiyM+VksQdK5yiS799W+Js
         +tWnWSbgv39NCIZaOYMwVwFYw7h+bnpNz7y+HTpkYxAAZNJwsnYaVT4nl8F1cL+irhH5
         9OqWAQoLVCQ03mqdNRzIGdKbWNkWMR+kBSWyg/5xSr/SrEPtDD50VYrAf4NHKvmEK7MB
         aA8xHm1KAFpuCzD1UlujLz9iFoZdJ4fO5glmw0XGoVTQCJddF5W6NCk6SDALMxALPQbv
         CRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQNn1WUD1tH4PUKngCu7NNi7bJYoR/t5I5ZYbIhwwKE=;
        b=LBXF4C/tBF5M+ou3I2xBX4i/Muls9+wQk3u+lwDHHKGaacuixDvtEIMACcF83AzDg5
         yqXhIWBnb+iAceMSfNXo4yv7ECPPa/iKVjLW1uNRXzXqmJ4/6DQ0jHH7L4Wq7F259o/w
         ccscki9nxFEsElqo6xTvSuoER+AT3OFz8st8i13hxMxcYnbUR3ahg3zkJb6hJwBsSH2l
         liW/uaQz6z1UzBn3gu7nAuimdvYprMKvFEs9pG1iGQWh9zMVb+PmfJz1OGcZLwEyu2aF
         ucC+f3oBC+xaJELBnBRBIvHJf0dVnyGKBdAoLH8j0iytP74bOSbUNi1x1wpwgFeBjwWz
         Veaw==
X-Gm-Message-State: AHQUAubDDVHduHa+b0gkuB/hccGGKOBxK1rIFNYqsIydi6N0wD6BKYcm
        abIX2+gXHwcErANhTsdorKK091u2
X-Google-Smtp-Source: AHgI3IZEfMC40UA367VJvYio7QNc6htf55Xd9I/UtwE9+fHAiAHnMo+eCIDeyV4+nMgmwJ2iGGIeyg==
X-Received: by 2002:aca:4911:: with SMTP id w17mr9659329oia.36.1551062348278;
        Sun, 24 Feb 2019 18:39:08 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id y137sm3724167oia.9.2019.02.24.18.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 18:39:07 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     idosch@mellanox.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] switchdev: Complete removal of switchdev_port_attr_get()
Date:   Sun, 24 Feb 2019 18:39:02 -0800
Message-Id: <20190225023902.18894-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have no more in tree users of switchdev_port_attr_get() after
d0e698d57a94 ("Merge branch 'net-Get-rid-of-switchdev_port_attr_get'")
so completely remove the function signature and body.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h   |  4 ----
 net/switchdev/switchdev.c | 42 ---------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 45310ddf2d7e..be4b13e66668 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -115,13 +115,9 @@ typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 /**
  * struct switchdev_ops - switchdev operations
  *
- * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
- *
  * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
  */
 struct switchdev_ops {
-	int	(*switchdev_port_attr_get)(struct net_device *dev,
-					   struct switchdev_attr *attr);
 	int	(*switchdev_port_attr_set)(struct net_device *dev,
 					   const struct switchdev_attr *attr,
 					   struct switchdev_trans *trans);
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..362413c9b389 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,48 +174,6 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-/**
- *	switchdev_port_attr_get - Get port attribute
- *
- *	@dev: port device
- *	@attr: attribute to get
- */
-int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
-{
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	struct switchdev_attr first = {
-		.id = SWITCHDEV_ATTR_ID_UNDEFINED
-	};
-	int err = -EOPNOTSUPP;
-
-	if (ops && ops->switchdev_port_attr_get)
-		return ops->switchdev_port_attr_get(dev, attr);
-
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
-		return err;
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
 static int __switchdev_port_attr_set(struct net_device *dev,
 				     const struct switchdev_attr *attr,
 				     struct switchdev_trans *trans)
-- 
2.19.1

