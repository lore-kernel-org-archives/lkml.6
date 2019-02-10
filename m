Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA94C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3C120874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFF8qviz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfBJRy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:54:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37556 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBJRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so13923182otq.4;
        Sun, 10 Feb 2019 09:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoEf5Fd90q4JOx/RAzYyPMDHBqBYHJwO/D8F0sElp4M=;
        b=SFF8qviz4fxEwgKMc+kkg6W/Ia+3p6O64ML8ipA1mqvuZzVY1QeSYO1qYySPZluGzz
         cKFVdjChvoM9H+3lvVUbPYj8UDvkllQkzkL/uMG3zhNOiX5wNGKa6jMHFqMbNbPb6WrC
         iR2x2fwRPVf4QjfDlIgb5BY4dHf5W2K2vPFdR4wdqTeMW32mZXfmZUTxT2AgY2Jx3FDS
         OCEi7lc1ci3tovGBKrGaAyZQJZ+NDm9IVGVWHoP71apdXRIfUuIgldIDQ/7C6C/OjW9a
         r6h4+i+KTH6sUJG+OyfQOVCO2fBPqV9qbOPqvDPm4N43yarCJQoltXhp1zagIuEuc4AF
         CW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoEf5Fd90q4JOx/RAzYyPMDHBqBYHJwO/D8F0sElp4M=;
        b=Z8/S+S31M3ZOile5mTQvnLq+hHX0GLlErUdG/ZHOyGQGWDLc+Aqs2eIkFNVsn24+do
         4r/VZp2NCw5WaT2vphT0pruI7XcTrfmcprx0elOhlskQaN9lq5VOcFvllN6BsT+7HQY8
         y2RgI4AZZN/pO+WeJqY0AaHBvgHww3xhI5JGDahR6fTrPY+DTKsHD9mEsVBZUK9jrTQa
         TLmAjRibzx8mYCanTLHLGkCPzlMVSnbwpZC0SFiDAyXKH/xpm7vZAGgmdd0N/6Mpa0K8
         sevl60KSkcJWCp1PsjP1bYklFtXeW8m5xj8YaQVQqXfhxcKuTajtoF1dl0UZGHTMRQzI
         lZzA==
X-Gm-Message-State: AHQUAuZt7KirsDfVKCHsTApiO4Xa89p0Z2dJJyGEMFpo5h5m+Slt5ysA
        3XTJbvxH8sTolJCw0/iu5qrB667A
X-Google-Smtp-Source: AHgI3IZOrGfct9pQPDz+2R+05bWF3KG7PVKyUmwyseCUEfLQtQpiCBcCUn6DlQQ2wMBGBVtmZ9RHPQ==
X-Received: by 2002:a9d:6419:: with SMTP id h25mr22238071otl.34.1549821202084;
        Sun, 10 Feb 2019 09:53:22 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:21 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 04/16] net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Date:   Sun, 10 Feb 2019 09:50:53 -0800
Message-Id: <20190210175105.31629-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
add support for a function that processes the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute and returns not supported
for any flag set, since DSA does not currently support toggling those
bridge port attributes (yet).

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa_priv.h |  3 +++
 net/dsa/port.c     | 10 ++++++++++
 net/dsa/slave.c    |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 1f4972dab9f2..97594f0b6efb 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -150,6 +150,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 			 struct switchdev_trans *trans);
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b23572..2ce3752203cf 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -177,6 +177,16 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans)
+{
+	if (brport_flags)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..9b499ba88aa7 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -295,6 +295,10 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_flags_set(dp, attr->u.brport_flags,
+						     trans);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.19.1

