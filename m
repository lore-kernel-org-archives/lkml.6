Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739EA218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq+GvGKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfB0BOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:14:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45931 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0BOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:14:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so7097611pls.12;
        Tue, 26 Feb 2019 17:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
        b=Kq+GvGKF34FGKEtRSFVfLhm6jO6TuOKRh0qVtw9NvnM+5ST5rdAdvJ8zRejVB7DtIv
         53Jn+RX2v3RPsEXNOoyTMQps3aAUDw49WbeE70Ujhe7epx8R29fFvPQMkYRuf/hyaLzB
         E8KGL2kyfHLznSdoilwgQpLdx5d45bKV3ax+I2YgJqn/DgSxwbKDhejDDyFUXBag/8h4
         assRohbRzP01vow9av3BYtuGKU9qEVbNX64o2qmG7r6Lq6BUYuagUBldAH8hi4iYELLc
         w6X/35T36JVEDZjOL0YhS1APyH9dgs/xp793WGKtxaRkZi69nZVkL5zgULeIVIsqIv0M
         C+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3n08U17XQLLrwYLiDWOdzsQAwXWMIAMlVMMr8OAosZo=;
        b=QIg6tnpImPNvCK6X6J9yj2dbZw6aRoI4NgfO26Q038JJfcd9bsofNLVHj+xRF0DJ2P
         50/jo12p3SNaCRPGtHICgEKn88IfTIW7CuJcZRRd00Lvv3CLrqH3f9LA37kw4k6N5g9M
         HNFHbKV0DNLMwsGeP6/Ro1zeSEyljhC2XH391PpOaD10xQw4Y3AdTulK0C2IoShx8L9Q
         HYb+O5xQvdn4qIRdmDnXsyFmPDX1Xir9xmXudLuo8tTeQkUpwqqs1GgIycpWJz/9HRoA
         9g4Iyu4t9bZUo+twmY4n6HAa+QfCsG30FTQC6bNUFUWDlxKgJtCNk2ovhOyYY+UTK03D
         jWzA==
X-Gm-Message-State: AHQUAuZFD8M3JiaLnw3oqwJuHatAkiWH3fG9T70+uZpSPmJHY6lk9sLI
        4X5Dn7pVRY4pzCM0WREwXPzQl59M
X-Google-Smtp-Source: AHgI3IZbv9AJWrxlwT7r413NO2MtLYA3uGs3JRFs9BuGbRdI77N1BrAT7TFN/vB7sMhnD0uDS+v6Zg==
X-Received: by 2002:a17:902:2848:: with SMTP id e66mr17665667plb.181.1551230085193;
        Tue, 26 Feb 2019 17:14:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:14:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 2/8] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Tue, 26 Feb 2019 17:14:21 -0800
Message-Id: <20190227011427.16487-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use notifiers towards that goal.

Prepare rocker to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET from both atomic and process context and use a
small helper to translate the event notifier into something that
rocker_port_attr_set() can process.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 309a6bf9130c..fc772cf079cc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2710,6 +2710,19 @@ static bool rocker_port_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &rocker_port_netdev_ops;
 }
 
+static int
+rocker_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = rocker_port_attr_set(netdev, port_attr_info->attr,
+				   port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 struct rocker_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -2779,6 +2792,9 @@ static int rocker_switchdev_event(struct notifier_block *unused,
 	if (!rocker_port_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
+
 	rocker_port = netdev_priv(dev);
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (WARN_ON(!switchdev_work))
@@ -2841,6 +2857,8 @@ static int rocker_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return rocker_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return rocker_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

