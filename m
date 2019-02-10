Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE87C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685E820855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okpI6JkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBJXka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35159 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBJXkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so10642581otm.2;
        Sun, 10 Feb 2019 15:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mF0clASfsS+m8euYRGx6YKoVXE9ceDzoQVGxi2l5BWo=;
        b=okpI6JkB7O6+EYzhc8grCHHY2p1MWQHFqCm5IjFaBL6ohtySKmzavRdxkOHIWkFFUK
         4J149xPhTx/1WSC2n2P/1/cCFSIbw/kTWVDqg0gCXnZWTedCar2SlJuJ284xEgwwp+wz
         kXponMFi43X55uUxP+HAPM7addZxOvXBf1tfimLGbx0Hwerl1SMvidtN1qLsyGoVgeIz
         rGaMqdrp1+De3fOyG5AQIz9vz4dN8tAOf0KU8i3zVSGoFkm+RC/YliXdrGqjnD7iNxrI
         VsIHj9tzkQ+HtW7MhHtoRdmeD7Vu6Np6ELWCDluTXpgNKrgIGYGXAd5sU4AqRlyfB8BB
         zvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mF0clASfsS+m8euYRGx6YKoVXE9ceDzoQVGxi2l5BWo=;
        b=ED/S2utji53dMDh2oO7D/6GUflgR87TmM3x50BvBjHHPDVFM3CD8bQ1lcLclCNLnmH
         8mAkaFwLQRgZW3ynSANIyIWUzObN6QtoZsx88c5l6O0WG4BzpunkDMtcwC4mFp71gGWh
         MPlYfg3PHZcFtkZKheMWCZ5pGT54IzeMR7zzogBdTBep95Wl1h4A8OITHBc8JiSpgvF8
         zkZqkNHdbcYU4pttQ3df79YNMyBnPH7CGKL3i7WQSFJ7cBgLlve657GzDktA8WyxBOpT
         NbkrQjXx8HZo+6+WAN5ltaypwgxdGLzNhjUrDYbSVU8uyPOfw96QdTB5gBOAIsVL5g09
         q93A==
X-Gm-Message-State: AHQUAuZJOZI0fkF/N6Alf2DjDnJu1qu5eSY2K44EspI7A2wrorHDfbiu
        JXtIB1PJdKEaT4eZbMFtHyqfWj6J
X-Google-Smtp-Source: AHgI3IYgQDtJWMWvNDm6F+4YsqsL92sODLQujN6p6QKKTFeo/A16OOW5ruXEqfmUj2F1T1yxKN37ZQ==
X-Received: by 2002:a9d:6a92:: with SMTP id l18mr18784628otq.81.1549842023736;
        Sun, 10 Feb 2019 15:40:23 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 5/9] net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Sun, 10 Feb 2019 15:40:03 -0800
Message-Id: <20190210234007.16173-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare ocelot to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
ocelot_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 195306d05bcd..850a49033a30 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1582,6 +1582,24 @@ struct notifier_block ocelot_netdevice_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_netdevice_nb);
 
+static int
+ocelot_switchdev_port_attr_event(unsigned long event,
+		struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = ocelot_port_attr_set(netdev, port_attr_info->attr,
+					   port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 					   unsigned long event, void *ptr)
 {
@@ -1600,6 +1618,9 @@ static int ocelot_switchdev_blocking_event(struct notifier_block *unused,
 						    ocelot_netdevice_dev_check,
 						    ocelot_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET: /* fallthrough */
+		return ocelot_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

