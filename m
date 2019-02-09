Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A1C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B92720821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3XHoISq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfBIAeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:34:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:34:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so2296866pgs.2;
        Fri, 08 Feb 2019 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eXtacsKqxbHGP01d8QM1lxtn2gwNPrj6Brpw2m3z2EM=;
        b=j3XHoISqFdO3t+haAWRzw9Gv2cdGVpboT/bZ90rCPhgCETs075f/J2ywhMZi7xY8Am
         jR9+N9yZhNjBmcLkSHRNbZwrWao+/Wzz9sY/W+xp4hC3HsxQB1JGvqpahXm5a5I+agsH
         NC4Vj91sqhBRNPvDtwoOLI7Nza0Xn9piW+5DAblwHVt/laWar1zT49gV1m1iL05f4j/v
         wBWt7SYHZoe3hC0lvl9Ji0/lEYRiRfrKjKr8jXvz98iCM7yFlDRaT2ShbIBz7yFoTTg0
         CTJkyoJ9i9WdcUL1kujHLXxbVzE1WpeQn3R8Hui312QGMyPUl+RON4VRztdsgYfSIYk4
         7syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eXtacsKqxbHGP01d8QM1lxtn2gwNPrj6Brpw2m3z2EM=;
        b=KXSF2LzAqz1SUPeHouoKWsg9jVKET+/AJIKtRl1oKhS37G7cpYjmxxbyoIzEgvydAk
         zYfGVcXF62nYxsB8mjLu8DGRhJ275COeLwSjeP1L0GqMkR5nfCBANkWdzgpvPWL3yrO/
         NDbGoFNiVLdkIIEE1FoMEoqosD/ccm0nNo8mP0OJFKmPHWQ4XV6/V2wM9xUSYK/HGmyh
         dYhji4TAhvFrOROfNjVOhS1nb+kQxMAtkJkQ1CSlltrOOXpxWxRV3t772PIUTjreGGcF
         Knfdux41PZz3mQ4CS5PwDAdOffQLWRihIhsmXYhZs3jN32Yu7CKejsl5CGQXGq8WI49a
         XN4w==
X-Gm-Message-State: AHQUAuaP2tuB/tenPPqa3mDFQrK6M1nIFhPvg3bB2oYsnQeDxNz0MXCa
        tPBGkm6fmVpfXPs9nXt87mOhm6JY
X-Google-Smtp-Source: AHgI3Ib1W0cwC2m7zyy3M/UEAsAs2LzfIH2EzwmJbwKD4F7tr8J3y7iwdCPKSH5LiJwPLCZZJJewUA==
X-Received: by 2002:a63:3703:: with SMTP id e3mr7775718pga.348.1549672440985;
        Fri, 08 Feb 2019 16:34:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:34:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 12/16] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri,  8 Feb 2019 16:32:44 -0800
Message-Id: <20190209003248.31088-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
mlxsw_sp_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6b09d68671cf..29ffb5cac777 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3410,6 +3410,23 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
 	}
 }
 
+static int
+mlxsw_sp_switchdev_port_attr_event(unsigned long event, struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
+					     port_attr_info->trans);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 					     unsigned long event, void *ptr)
 {
@@ -3433,6 +3450,8 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return mlxsw_sp_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

