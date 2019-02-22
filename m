Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33842C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC0206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jedwLRM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBWAAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfBWAAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so1816831pgq.4;
        Fri, 22 Feb 2019 16:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nuo4dpRE9ulHu0E+wlum6XOB46T2GQb5E3Eru2gkHj0=;
        b=jedwLRM663AEfpijeu14tk5kWc+E0khChSJruqPX6Ig2sd1t0N4Np25mj0RfJkUGup
         bXr6cbzVOjkJtOFRdZ6qFAtL1zilM+8Yx7bY8ZQ2wmbnl7nJXxzITW0g6o2vKQ6fT8mf
         /nLBnEP0YBvIdgIpcGfk1awSj3Wy+BYXyBE8e6ynCtXK02/X9tL2eeNVBljkVRVnvGpd
         lG1o8Bx6VLf+T3j9N7uySJmYv4JNt3YYPFnUtQ2pCLmzoly7iAqJNaLqXYHaMn5yFJ2B
         Gs1Hg+K91ba+R0wG4T8Hd3TyGkOJYHSZSN6HCjHgdASGjATtOAPcx70F3uwU/RdEctuJ
         BCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nuo4dpRE9ulHu0E+wlum6XOB46T2GQb5E3Eru2gkHj0=;
        b=agbFgwW6pudsXPsvpW01yN3mWD0mcR9S7veWPG/LJFw4Pvhh4HmBQVRLnfFeRkJTV2
         WmgPif1kErhYKf7sm+myoYTIO8ZZP8EtAjBx1DjSMiiBmoafBIIkrNAiKjZ5+3w6GUi6
         4F7p57+473kNFI+MoHXgfAaK0lFG8Hv54ULe9kKM6axsGzwgof4Mehzy3ULrpsqT+2iB
         ydikk+IcZ6X1GtCDE3zP2J7RDCMfwEEzFfd/gCrvoa4CpHe/KLIsXeGrGXnuXQecK5k9
         cMlF946b3YJu74W4+l2g8X9SzQlwVl7I3JlDcE0RcCjuUeLmOVMAfZA4TTI0BAfvYTLQ
         xs2g==
X-Gm-Message-State: AHQUAuYirBW2xDoBEZTS/DoOz5cruVbdZVpNNDN+ujub/5qtx77U0EFB
        Rn07T0Q1W+slhybUSzlZWoEKdPzb
X-Google-Smtp-Source: AHgI3IZRwmD/7VxcgHUkClhoJxVa47FE6sugwJv2wBqWIzbShN+My3rY4ipb6rX3AErXeF2GEeE74w==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr6802528pfg.71.1550880049723;
        Fri, 22 Feb 2019 16:00:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 6/8] staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Fri, 22 Feb 2019 15:59:24 -0800
Message-Id: <20190222235927.10295-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate setting a port's
attribute and use a blocking notifier to perform those tasks.

Prepare ethsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
swdev_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 018399ee8731..73efc2a5fd91 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1047,6 +1047,12 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET)
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
@@ -1103,6 +1109,19 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static int
+ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = swdev_port_attr_set(netdev, port_attr_info->attr,
+				  port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int port_switchdev_blocking_event(struct notifier_block *unused,
 					 unsigned long event, void *ptr)
 {
@@ -1115,6 +1134,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return ethsw_switchdev_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.17.1

