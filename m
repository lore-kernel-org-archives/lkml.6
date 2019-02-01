Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE66C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufXaa+0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBAWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfBAWI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3883915pfi.5;
        Fri, 01 Feb 2019 14:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0nRYwYgw+BvFa1D+GykoH9AaCUY4nMLAH6xm5Ojg0w=;
        b=ufXaa+0t2BtBz+FNsqjVwDo3ktP3OhVjGwYo5GsiYuBMi6cZ+pVveHq2CTr4n57+aE
         ttGR4rSfJtF63USmPFxV3q30bvrAaUOBwpf5hJoOxnnaU8U79BXh8/YMGwcPIwsaRwY1
         ZdSCJLU5m/+/6pJZYBAcXfP9HWhemIjZyMi0/9EYpGFg6OZS4kqvkuP/9ijEUBU3TtR1
         EfGIwE4GrLcc3qvzPckFa4ff5CyI8BxD0ukf/D/0LFnvVDxP8Rj5qrjO0RoY4xo6Z2F0
         KZLnpPJsr13Zp9cyL3D5RuHtFsxTmyjOMVTjxNKlOcb/pWCvb27uO02HO3fehw1v4H0W
         uhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0nRYwYgw+BvFa1D+GykoH9AaCUY4nMLAH6xm5Ojg0w=;
        b=PwxsbWjI8iU1ah1I/hDnASRtORxbMMjQSwTVo7rV5G/LYttMN9OFODKepMD6UlS/7a
         6UBJR94aWg3HAmEtgE++6svhOceQ2QYOafDjyinnw/tXfCvNaarOhG0zxVpK/4aDlbFg
         Q9Nf0C/GlpqrB5NheE28Zi+wspWKQC9krk4RpEwUlEGcXnDy6I4uZqAPUMRRgvpDTSM/
         jUU1eOajEA6Rk6MsFhlQTSGa7yIttrQ/bTPj4CzL5iEjLOYeD2mE66Fw71Oe4jWfwnRX
         NkhAorx4FEl8+hVlZBEhYnTU75mmnefTy+KnFMDoWyWZYlLVh7R5Vq6KKBDs2wfm5lID
         zhlA==
X-Gm-Message-State: AJcUukcrStdxmqdpWpOU3YxnTQL+ISVoGE2wgGjLNsHqH7DMnCeHpI8G
        lJjAtppt0RK8NAwB2BWZJSDGeJnz
X-Google-Smtp-Source: ALg8bN7dGetpsRt7sWuGC2QAdBn2H+C9JN82l8qmaOY/oCStiZOMTqPkAAkN9Tm06rjLXPQwZZi/YQ==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr41193716pff.211.1549058904751;
        Fri, 01 Feb 2019 14:08:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: [RFC net-next 10/13] net/mlx5e: Handle SWITCHDEV_PORT_ATTR_GET event
Date:   Fri,  1 Feb 2019 14:06:54 -0800
Message-Id: <20190201220657.30170-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare mlx5e/en_rep.c to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET and simply translate that into the existing
switchdev_ops::switchdev_port_attr_get operation.

We register a single blocking switchdev notifier for the entire set of
representors given that mlx5e_rep_register_vport_reps() gets called for
an Ethernet device.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 45 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_rep.h  |  2 +-
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index dee0c8f3d4e9..fcfe1c9d3575 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5036,7 +5036,9 @@ static void *mlx5e_add(struct mlx5_core_dev *mdev)
 #ifdef CONFIG_MLX5_ESWITCH
 	if (MLX5_ESWITCH_MANAGER(mdev) &&
 	    mlx5_eswitch_mode(mdev->priv.eswitch) == SRIOV_OFFLOADS) {
-		mlx5e_rep_register_vport_reps(mdev);
+		err = mlx5e_rep_register_vport_reps(mdev);
+		if (err)
+			return NULL;
 		return mdev;
 	}
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 04736212a21c..9bac78e111c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1289,6 +1289,21 @@ static const struct switchdev_ops mlx5e_rep_switchdev_ops = {
 	.switchdev_port_attr_get	= mlx5e_attr_get,
 };
 
+static int mlx5e_rep_swdev_port_attr_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	rc = mlx5e_attr_get(dev, port_attr_info->attr);
+	port_attr_info->handled = true;
+
+	return notifier_from_errno(rc);
+}
+
 static const struct net_device_ops mlx5e_netdev_ops_vf_rep = {
 	.ndo_open                = mlx5e_vf_rep_open,
 	.ndo_stop                = mlx5e_vf_rep_close,
@@ -1321,6 +1336,22 @@ static const struct net_device_ops mlx5e_netdev_ops_uplink_rep = {
 	.ndo_get_vf_stats        = mlx5e_get_vf_stats,
 };
 
+static int mlx5e_rep_swdev_blocking_event(struct notifier_block *nb,
+					  unsigned long event, void *ptr)
+{
+	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
+
+	if (netdev->netdev_ops != &mlx5e_netdev_ops_vf_rep)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return mlx5e_rep_swdev_port_attr_event(event, netdev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
+
 bool mlx5e_eswitch_rep(struct net_device *netdev)
 {
 	if (netdev->netdev_ops == &mlx5e_netdev_ops_vf_rep ||
@@ -1798,11 +1829,20 @@ static void *mlx5e_vport_rep_get_proto_dev(struct mlx5_eswitch_rep *rep)
 	return rpriv->netdev;
 }
 
-void mlx5e_rep_register_vport_reps(struct mlx5_core_dev *mdev)
+static struct notifier_block mlx5e_rep_swdev_nb = {
+	.notifier_call = mlx5e_rep_swdev_blocking_event,
+};
+
+int mlx5e_rep_register_vport_reps(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_eswitch *esw = mdev->priv.eswitch;
 	int total_vfs = MLX5_TOTAL_VPORTS(mdev);
 	int vport;
+	int rc;
+
+	rc = register_switchdev_blocking_notifier(&mlx5e_rep_swdev_nb);
+	if (rc)
+		return rc;
 
 	for (vport = 0; vport < total_vfs; vport++) {
 		struct mlx5_eswitch_rep_if rep_if = {};
@@ -1812,6 +1852,8 @@ void mlx5e_rep_register_vport_reps(struct mlx5_core_dev *mdev)
 		rep_if.get_proto_dev = mlx5e_vport_rep_get_proto_dev;
 		mlx5_eswitch_register_vport_rep(esw, vport, &rep_if, REP_ETH);
 	}
+
+	return rc;
 }
 
 void mlx5e_rep_unregister_vport_reps(struct mlx5_core_dev *mdev)
@@ -1822,4 +1864,5 @@ void mlx5e_rep_unregister_vport_reps(struct mlx5_core_dev *mdev)
 
 	for (vport = total_vfs - 1; vport >= 0; vport--)
 		mlx5_eswitch_unregister_vport_rep(esw, vport, REP_ETH);
+	unregister_switchdev_blocking_notifier(&mlx5e_rep_swdev_nb);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.h b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.h
index edd722824697..b9e0507f6100 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.h
@@ -162,7 +162,7 @@ struct mlx5e_rep_sq {
 };
 
 void *mlx5e_alloc_nic_rep_priv(struct mlx5_core_dev *mdev);
-void mlx5e_rep_register_vport_reps(struct mlx5_core_dev *mdev);
+int mlx5e_rep_register_vport_reps(struct mlx5_core_dev *mdev);
 void mlx5e_rep_unregister_vport_reps(struct mlx5_core_dev *mdev);
 bool mlx5e_is_uplink_rep(struct mlx5e_priv *priv);
 int mlx5e_add_sqs_fwd_rules(struct mlx5e_priv *priv);
-- 
2.17.1

