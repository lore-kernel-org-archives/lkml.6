Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA10C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDE82054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEDZzKI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfBEWN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:13:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35498 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbfBEWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id b17so124531eds.2;
        Tue, 05 Feb 2019 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rZxXJwYxAkIqlWW9ToIz/na+DdIIiww4zlldV7I6DQs=;
        b=DEDZzKI1BfUChE7VxFL1xEBeKS8Rsoxa6scPRnQ2ZzB5udwViwKhAc5x+NWTWQnEnQ
         rghJcys2Rmw6QSbRod913RrTUu7EuHZTrATMiHc51YS2hzVgguFWMLcfO7sWBhaoyUrf
         kDNBwASMPmZHsxqM9bpH7S7zZQWP2JPiPZHXjW0j0pkXT/1+lwDOles+1F5UdfMmT20k
         SJKIuDBEQe5sprqXYDgzfQuOrfpEg3OYYLbTLxpK5bEDomVVlGqYlyf/3nLWSMDMBZCE
         Hj+x/KWRsZM+ZX0i+ODNKFbKRqpLpsKBmZ7xs2POyFtV+JoeIup5fKZgMZ5B1MKK191T
         +tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rZxXJwYxAkIqlWW9ToIz/na+DdIIiww4zlldV7I6DQs=;
        b=rXuPQzQfdFIoCJcnz688dB6AdiCQdDZt2UUa9T6P14oZYnuByNO/Es2/4DVimqSmz2
         k0kSIFwz5B4bpW+6LThQqMNtlOYN7c8/yQww2iZAZehrwDRpiuXFKbreYNIjaK7S4Onn
         p8h8eSYBkJGweeeXXFjHxrLjNT8IdU0FuC/kV/cGoDJlIdqjM6r9dJZrhqFDJhIXmvyb
         fAXSMqvMOdQ0QrA4TFiVzYKgEfuQajLeA5vkEw67xYncweHgcWjzkk46lCyIHgkHNvuP
         APQPfp/u9WwT3ryQM1Cb0tLqXPQGRgvIZM83zI+tyF20EJCo7jRyymNKBXhIkIq9AWT2
         Mkfg==
X-Gm-Message-State: AHQUAublRq5bSwlvAMCO47LuAvvC3UuswOc6xn5T0FwpwSI1s8ncOFAF
        UhyI09h625aW06go/HrjlWNdsW8Z
X-Google-Smtp-Source: AHgI3IaMPu/cleN90tLG1bSiTJvmPFhxVpFf2ZkwpzGwQoQGmCcULbaILr7ISMrJhBBD24pK4rSO0g==
X-Received: by 2002:a17:906:63c9:: with SMTP id u9mr5161580ejk.190.1549404829855;
        Tue, 05 Feb 2019 14:13:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:49 -0800 (PST)
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
Subject: [PATCH net-next v2 09/12] netdevsim: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:13:08 -0800
Message-Id: <20190205221311.18476-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdevsim only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8d8e2b3f263e..84de37478624 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -148,26 +148,16 @@ static struct device_type nsim_dev_type = {
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
@@ -214,7 +204,6 @@ static int nsim_init(struct net_device *dev)
 		goto err_bpf_uninit;
 
 	SET_NETDEV_DEV(dev, &ns->dev);
-	SWITCHDEV_SET_OPS(dev, &nsim_switchdev_ops);
 
 	err = nsim_devlink_setup(ns);
 	if (err)
@@ -493,6 +482,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 	.ndo_bpf		= nsim_bpf,
+	.ndo_get_port_parent_id	= nsim_get_port_parent_id,
 };
 
 static void nsim_setup(struct net_device *dev)
-- 
2.17.1

