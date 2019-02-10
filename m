Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D43FC282DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212EE20874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+11KNTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBJRxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39988 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBJRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so13890375oth.7;
        Sun, 10 Feb 2019 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTCnNF6EGhkskPwVXdaxmOsTc+jRbd5uHwdDTwPkIvk=;
        b=P+11KNTmszO9F9LaVfeFCxVum+ebZA8/jAIhHH3WfBgn3D/YTPFGj+JxJsfBB1LN19
         O9XtpatHSqiYOx08l87htOPQ8hTz4ypsv0UxxLW5sTq1xYQYlDBqrpaHl9nrkMvElky+
         2COeXQxDZhUfYkrJV0edxifK7bqEdNCkN61wZ6v3fIm4j9eyN8b7t51xiG7iYB7eLKmn
         VPtnjKpj9LSmuS3/B+0Wy9yURk3SdoNTCDmx/n7xanFUTPU2WlByfT1wCwlhEtl0cxtX
         3YCSGOozGCRfuW0G6fKtTGLMoWKXqcJS0VgwYPmOMyg0Q/8F9ayhQrDRArpnDgg5Zj4t
         jf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTCnNF6EGhkskPwVXdaxmOsTc+jRbd5uHwdDTwPkIvk=;
        b=Eg1nC/Q9JwoaTj66a+2oerH1j/FYkWizKCO/HwWoiOYJe5329j9bEQ5cgljjXkCDMZ
         GvCV/fuIlCUdFgZH9Gl1+ta+4sX0vWMYhLU25C9s8zCKXbXPYd+ynL7n9prKi9WWDznA
         oVXD09xSlySnO7io4KYESR4kE8yI+QIgl/BZMIeELYTN2XAvtw03Wtnrpcq8XhufyAMc
         9p9aTmHO3BmTOj3j9CrmiurXSHu8tcTSNBpx4avCI8SjHz7wI3jnq916wQiYoSgyUSzt
         8jvl25fQb/Lf8qz+u5ZQ8mcHI8CVUi6GBkRNf96u+m/stDlsXZWsctb+5e3wq1+76nhl
         0RoQ==
X-Gm-Message-State: AHQUAuafIcQbYjukAhan+KHIhtj4v84A7gmyl/QVGep2fw7s5/ZblON6
        2spsMG7i+hggeOxW/gntSvhKlaiZ
X-Google-Smtp-Source: AHgI3IbfMjAQarkw4x08MBkiCV2SiLDG5iDslovpQCuQp+GDIXKAcId6zDMHDRRUHRQURLZYICYwYA==
X-Received: by 2002:a9d:7482:: with SMTP id t2mr3453170otk.180.1549821207803;
        Sun, 10 Feb 2019 09:53:27 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 07/16] net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Date:   Sun, 10 Feb 2019 09:50:56 -0800
Message-Id: <20190210175105.31629-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted the bridge code and the drivers to check for
bridge port(s) flags at the time we try to set them, there is no need
for a get() -> set() sequence anymore and
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  4 ----
 drivers/net/ethernet/rocker/rocker_main.c              |  4 ----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c                |  3 ---
 include/net/switchdev.h                                |  2 --
 net/dsa/slave.c                                        | 10 +---------
 5 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 468a6d513074..8242a373f6e7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -455,10 +455,6 @@ static int mlxsw_sp_port_attr_get(struct net_device *dev,
 		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
 					       &attr->u.brport_flags);
 		break;
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
-					       BR_MCAST_FLOOD;
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 8657313b6f30..375c4c908bea 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2075,10 +2075,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
 							      &attr->u.brport_flags);
 		break;
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
-								      &attr->u.brport_flags_support);
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 6228c4375835..79635d1091df 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -651,9 +651,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
 			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
 			(port_priv->flood ? BR_FLOOD : 0);
 		break;
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..e2083824e577 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -45,7 +45,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
@@ -62,7 +61,6 @@ struct switchdev_attr {
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
-		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 9b499ba88aa7..7b33be6f1954 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -385,15 +385,7 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 static int dsa_slave_port_attr_get(struct net_device *dev,
 				   struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = 0;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
-- 
2.19.1

