Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19555C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4112073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv3EmQBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfBFRqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:46:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39993 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbfBFRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so3406853pfo.7;
        Wed, 06 Feb 2019 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ArJyP52WUHjXEmWeKQMCdCvrHE5jBBDMmVZMHMTBbik=;
        b=kv3EmQBKIJRBUX3Frbcbe6KFkkmMEGxPkJQ6qWmZYdfjiTqynD3LGBH/9KLHL60owR
         UAhl3ayyTJOtT2LaiGQEyyDzK1MK9pLyTvBMpjI5/u+QirNI2MKuLmXUjRVWTn8p3QOE
         n7wACuqx4MKpzuuODLR20DDGp5BuFTHv1jlDAy+ImNGwkLvmOXQxSGsxeWk2ucIcSZrs
         CDHYin4crGq7xQVrR3F+yw0qlctUOHrqPVUyvL4drAFCJA00gN5DnbNWtZPG22bxnPRr
         N+H15YfpIcyBN599IOY3yOTcvThdS1zTIaFVnb46zyoPWbWvtxr1NjUrYnPB/xa2hiJX
         g+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ArJyP52WUHjXEmWeKQMCdCvrHE5jBBDMmVZMHMTBbik=;
        b=eJ/T8h/4HV7T/hwwm4c0Ob7O+VwJsEn7oXDX4s75B3q3CemzHpjPrOPcxDVDu9I2Sb
         J1b9sWoeonXX9tcrVNYGklHIWVdy1mVTOqCNx2gDAfBBtLoD3kVlc2ux+O1jfNnkZXU5
         gwmyLu3QELOkepWHC4ZRSWVnB1mUufnizpV1ms8WfCLbKJtra+KOHM5y8k4pWE3sdvhB
         6ZIeyGgWikk0fbKpJHj5aswN4gC4xLH1cZyxlXqyQtgHjaOtVGHDLyF3/XPVeDAxtCBf
         woX6ft+7QMBnhTSVywwHI72DeZuxQrNaA1QaegiczCYMIai5I+Fh3CJnHiL10rPUrC+9
         oeMQ==
X-Gm-Message-State: AHQUAuZaY9FZgtZSE3Ychpnqrrqb8SrIaeC4hs13p59Bj/wY63efTeL4
        IDFaqWcVMcvZINN8xtRpV1aPsNc6
X-Google-Smtp-Source: AHgI3IZwpAHiucfTIgaDWCi5SMXVYYBg98z3+aQaQCPIErVnsKSdPjpy0uDEQ23s/ojkHm2/n8TFmg==
X-Received: by 2002:a65:40ca:: with SMTP id u10mr10712961pgp.321.1549475180057;
        Wed, 06 Feb 2019 09:46:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:18 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v4 09/12] netdevsim: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:43 -0800
Message-Id: <20190206174546.23597-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdevsim only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8d8e2b3f263e..75a50b59cb8f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -22,7 +22,6 @@
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
-#include <net/switchdev.h>
 
 #include "netdevsim.h"
 
@@ -148,26 +147,16 @@ static struct device_type nsim_dev_type = {
 	.release = nsim_dev_release,
 };
 
-static int
-nsim_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int nsim_get_port_parent_id(struct net_device *dev,
+				   struct netdev_phys_item_id *ppid)
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ns->sdev->switch_id);
-		memcpy(&attr->u.ppid.id, &ns->sdev->switch_id,
-		       attr->u.ppid.id_len);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = sizeof(ns->sdev->switch_id);
+	memcpy(&ppid->id, &ns->sdev->switch_id, ppid->id_len);
+	return 0;
 }
 
-static const struct switchdev_ops nsim_switchdev_ops = {
-	.switchdev_port_attr_get	= nsim_port_attr_get,
-};
-
 static int nsim_init(struct net_device *dev)
 {
 	char sdev_ddir_name[10], sdev_link_name[32];
@@ -214,7 +203,6 @@ static int nsim_init(struct net_device *dev)
 		goto err_bpf_uninit;
 
 	SET_NETDEV_DEV(dev, &ns->dev);
-	SWITCHDEV_SET_OPS(dev, &nsim_switchdev_ops);
 
 	err = nsim_devlink_setup(ns);
 	if (err)
@@ -493,6 +481,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 	.ndo_bpf		= nsim_bpf,
+	.ndo_get_port_parent_id	= nsim_get_port_parent_id,
 };
 
 static void nsim_setup(struct net_device *dev)
-- 
2.17.1

