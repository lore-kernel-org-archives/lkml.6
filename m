Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9CC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C16F218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uetxnquO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbfBOWyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:54:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41594 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404614AbfBOWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so77938plk.8;
        Fri, 15 Feb 2019 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3WXfPa3CqTn5iWZnGqAfG6E5Sj9YIB4siZ2SZASyrj4=;
        b=uetxnquOXmK0TnmGX8mCFyy7VgZ1q1UcL/ItrBcstMxpK0JSQUHfwZiylBWguK8rNB
         W4JROa49SmlmkB1SZhAWL+Am83+OYcxYkuNJYFs0LlLBDWfGAUkDNCaXPHK3SbDz35VV
         gLSCoMbCIVblK0bByueYXlqFWoKkI7yciWV3x5Nkn5hRW5Wq1VZeWtF81wLRNKNovcop
         lmGAd4nbjaHsEkShkCsvwQDQccrcf8TJvkjpt+KtnkqG6QEXtQc4Tpk9G9vITddnl+5q
         qlbTc/OWB/+ZTKUTLBdmfYhAEWgN18RhMMsfd7eNk0UACgWQAP2MhH9YY09xpfZg7z+x
         LgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3WXfPa3CqTn5iWZnGqAfG6E5Sj9YIB4siZ2SZASyrj4=;
        b=U/r/hg2PaQqCVwG7AhRo5l+bVQkZoXMMl7q3/MFETFToOftS+BuB5KZVHesfbiBo4F
         sjkkNT/AstiloQpy5Kw8R9GWiN/ck8r4fTys2vtfgpoxaqAV06HtenRW5vWwonAwWbbP
         a3nhCBZt8j9LgP2eXJqEY3z1dcZpKSoe9SyydZ6wiLwXenlFOmRiU+zK4bLORTr6wBo4
         AEV3dxSO8SXmI4WEM5TrtoW+V4DYh515+jErIcycI9Dzz3qnrge+4HHEK5bZYP/z+qfZ
         kKtRPFbZLbbwv9fTvc2oyZjiqlG5I1UXZ6dWhc9kDrtIj6SKKHSaXX6FHcSeizd2C+tl
         KEsw==
X-Gm-Message-State: AHQUAuZsP3/fOztuyeQ00KJIylsZQfpndwO4QQQ+6IFIrwVhFdb5I3S5
        B4Kua892rr012pmRZcEcbY40/3mN
X-Google-Smtp-Source: AHgI3IYdtKlpiZBYnvSt5ve5l31AF8jH1BuFjDQzUgtaerLdeDc5WbVKHSPy3/cSxLLrxT4+Comvlw==
X-Received: by 2002:a17:902:be05:: with SMTP id r5mr1705471pls.48.1550271207350;
        Fri, 15 Feb 2019 14:53:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 6/9] rocker: Check Handle PORT_PRE_BRIDGE_FLAGS
Date:   Fri, 15 Feb 2019 14:53:10 -0800
Message-Id: <20190215225313.32303-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 56 ++++++++++++++++++-----
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5ce8d5aba603..2102e449c037 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1566,34 +1566,62 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 }
 
 static int
-rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
-					unsigned long brport_flags,
-					struct switchdev_trans *trans)
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
 
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
+static int
+rocker_world_port_attr_bridge_pre_flags_set(struct rocker_port *rocker_port,
+					    unsigned long brport_flags,
+					    struct switchdev_trans *trans)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
+
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
 	if (switchdev_trans_ph_prepare(trans))
 		return 0;
 
-	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
-						trans);
+	err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+	if (err)
+		return err;
+
+	if (brport_flags & ~brport_flags_s)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
+rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
+					unsigned long brport_flags,
+					struct switchdev_trans *trans)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
 
-	if (!wops->port_attr_bridge_flags_support_get)
+	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
+						trans);
 }
 
 static int
@@ -2074,6 +2102,10 @@ static int rocker_port_attr_set(struct net_device *dev,
 							   attr->u.stp_state,
 							   trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = rocker_world_port_attr_bridge_pre_flags_set(rocker_port,
+							      attr->u.brport_flags,
+							      trans);
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
-- 
2.17.1

