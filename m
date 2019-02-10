Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C163C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3D20874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWwpeLec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBJRx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42887 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfBJRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so3375319oto.9;
        Sun, 10 Feb 2019 09:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SHEuAD5/41y/dv28qKa6YR8/ZUVzpLi5sCtQnX1F7c=;
        b=pWwpeLecckkObrV1Bl0e/iAlssMNciITu6M5IXbeABlx7zXh395n/ECZFDNJVqRPrd
         i50Adfu4dskekO136gPzYGF9fLU6tZU67KHyS+KhS//wmN+QAO5dGpADIO9Jsp0fVJW8
         QgOkpeUlLdGBn8kilRMmAGqTPd48T+v1usgMMIcZK+9tOZzZgT3j7Ru/cP5+5+kqf/OQ
         SOOBjTW7e+gmlzHY5/C27Irz/D8jZ1UKEuHemv32Lj6PnzckU3hJod7Ed3ZcyPGtHEFy
         sM8LYY+gR17n9bFCng2myS0AF2YlkURPooNsJsFt72GGMqmB455Y8rxf+G0cPD7W3KOA
         z04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SHEuAD5/41y/dv28qKa6YR8/ZUVzpLi5sCtQnX1F7c=;
        b=uOsz7gZpB5KVzzkOPQLChTrmBi5w8k1qBmQHw3nRt3lD+zj4rzgxcUNG2dW7g2PmAm
         BtTnhrz90KCDns+KXEYPtvQntTSokxjvlhSy/P175erUtoJxFmrI8t4QLQuC4xx6fCgK
         JfdJPP6QTJStFi3xFdGl/wT/uKXfNoWIvbcV5wU7a4KaYJzZygVGDz1qCMrG1Agzgl+n
         pRDI7Xj+4CzRmoy8vBhLAxUasnTUCDJBPyF/Tf+qcriF/dlIxOl9BtjZiD8dAqf0QkU1
         1egmTqzNw2Zd0bBNh6+OPmRWO3v/4vkdX+KtYPJ0fE9eoN7JYyljqHwacx9drVdVM1Pd
         rVcA==
X-Gm-Message-State: AHQUAuapi1cMCD+TembkRqF0E+ymqbBE551BZprOthshfJaProWcClZN
        iL0RYpCj/HUkCAtK9suzJuvZ/OxW
X-Google-Smtp-Source: AHgI3IbQdJjDe/8Im8OJygIpeew6b0qU6/0exl0QkbsYb/DwWJJ4Zua8kCWgT17PB/AopX5Szb923Q==
X-Received: by 2002:a9d:3b65:: with SMTP id z92mr24109309otb.275.1549821203952;
        Sun, 10 Feb 2019 09:53:23 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 05/16] rocker: Check bridge flags during prepare phase
Date:   Sun, 10 Feb 2019 09:50:54 -0800
Message-Id: <20190210175105.31629-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 40 ++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..8657313b6f30 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1565,18 +1565,42 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 	return wops->port_attr_stp_state_set(rocker_port, state);
 }
 
+static int
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
 static int
 rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 					unsigned long brport_flags,
 					struct switchdev_trans *trans)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
 
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+		if (err)
+			return err;
+
+		if (brport_flags & ~brport_flags_s)
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
 						trans);
@@ -1593,20 +1617,6 @@ rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
 	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_support_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
-}
-
 static int
 rocker_world_port_attr_bridge_ageing_time_set(struct rocker_port *rocker_port,
 					      u32 ageing_time,
-- 
2.19.1

