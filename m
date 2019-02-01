Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D0BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF97F2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEnvDuZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBAWIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33749 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfBAWIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so3897994pfb.0;
        Fri, 01 Feb 2019 14:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADHtnf2Pyj7Bb3/Osgn+6/bvWFlSO/mVEntxDCFTFHg=;
        b=aEnvDuZf2q2uToeKMG64FV2JZJmWkZU58TMfGpEQ2A489Od1iGs9Qt5g4k8DgKmVCM
         xKqGXnqKfUV1LXYlAp2/gd00E/L0eTTIZ/F2Yytlvm/9VUykbtIs3ONkMf6KPVoir4Pw
         Jyq/FlGUCtXm3wg39JKQV5yxn/4x+R9Z7i1nxGPYnF3OBZhNj4fkqp9PxIGlQ/MMLQ8c
         Z/YdlwuC+2KVvJNhap/EcK/MNYgoBOi4lCwGU4OFDV344DdR+ptLuIlfhNPeHmWonFMQ
         5U5u+DaYrBKRfLeKHDjRFw4TqYwqfiAmp7Gbb3pFW+2m1k0ZHyKzO9v39jkaPRKPauMa
         Os0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ADHtnf2Pyj7Bb3/Osgn+6/bvWFlSO/mVEntxDCFTFHg=;
        b=P1paGSbf3r6y6U5YRJ4KB8nDuS850mI74TTN1IMlO7cf0QbAtzb9gmdOG0D3iq2h6i
         vyXffT9Nz08O5rr+zwbSKCv1KMSOPlQg2MWAnsS/rtDQH21SiTSBF8ggBQsOjjRnloap
         I4yZ6dxIQ21G9VM6ipKBFFm4btrPe1LPza2gWmnusU+oJGYrG9DOLpSO7smC5HV1VAr8
         nFa1YE1G4mkk3yMyuuNcMLSEti+u3odNO++YvGp7e9Bk+sJGgZAeeKZ1+O7AEjlDCdri
         CdZEtxVErojGfnv/gyLQuM+PynSWBe7rDf0G8r84D6BjCKH3Ak7P0dU7rzzVqARRCRBD
         PsWw==
X-Gm-Message-State: AHQUAuYhUorPfSChyeYuNoNIP1wWj2QIMyit/kFROGXhnP0kNArEKSZu
        lnwmCk3GiCZdvWzKlGi6UKSLsYxO
X-Google-Smtp-Source: AHgI3Iba5jsGxoXHqXMZb+6zYCQhnXp3mJs1a4NSMSkT3l9wejkidJAyikZQAQNmYBKa/tzbLzdprA==
X-Received: by 2002:a65:49cd:: with SMTP id t13mr4016431pgs.376.1549058899738;
        Fri, 01 Feb 2019 14:08:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:08:18 -0800 (PST)
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
Subject: [RFC net-next 08/13] liquidio: Handle SWITCHDEV_PORT_ATTR_GET event
Date:   Fri,  1 Feb 2019 14:06:52 -0800
Message-Id: <20190201220657.30170-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201220657.30170-1-f.fainelli@gmail.com>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare bnxt to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET and simply translate that into the existing
switchdev_ops::switchdev_port_attr_get operation.

We register a single blocking switchdev notifier for the PF part of the
driver, and we register another blocking switchdev notifier, following
what was done with the existing netdevice notifier within the VF
representor driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 48 ++++++++++++++++++-
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 45 ++++++++++++++++-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 3d24133e5e49..b9d48e4181fc 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -162,6 +162,8 @@ static int liquidio_set_vf_link_state(struct net_device *netdev, int vfidx,
 
 static struct handshake handshake[MAX_OCTEON_DEVICES];
 static struct completion first_stage;
+static int liquidio_switchdev_blocking_event(struct notifier_block *nb,
+					     unsigned long event, void *ptr);
 
 static void octeon_droq_bh(unsigned long pdev)
 {
@@ -469,12 +471,25 @@ static struct pci_driver liquidio_pci_driver = {
 #endif
 };
 
+static struct notifier_block liquidio_blocking_nb = {
+	.notifier_call = liquidio_switchdev_blocking_event,
+};
+
 /**
  * \brief register PCI driver
  */
 static int liquidio_init_pci(void)
 {
-	return pci_register_driver(&liquidio_pci_driver);
+	int rc;
+
+	rc = register_switchdev_blocking_notifier(&liquidio_blocking_nb);
+	if (rc)
+		return rc;
+	rc = pci_register_driver(&liquidio_pci_driver);
+	if (rc)
+		unregister_switchdev_blocking_notifier(&liquidio_blocking_nb);
+
+	return rc;
 }
 
 /**
@@ -483,6 +498,7 @@ static int liquidio_init_pci(void)
 static void liquidio_deinit_pci(void)
 {
 	pci_unregister_driver(&liquidio_pci_driver);
+	unregister_switchdev_blocking_notifier(&liquidio_blocking_nb);
 }
 
 /**
@@ -3261,6 +3277,36 @@ static const struct net_device_ops lionetdevops = {
 	.ndo_get_vf_stats	= liquidio_get_vf_stats,
 };
 
+static int lio_pf_attr_event(unsigned long event, struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	rc = lio_pf_switchdev_attr_get(dev, port_attr_info->attr);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(rc);
+}
+
+static int liquidio_switchdev_blocking_event(struct notifier_block *nb,
+					     unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	if (dev->netdev_ops != &lionetdevops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return lio_pf_attr_event(event, dev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
+
 /** \brief Entry point for the liquidio module
  */
 static int __init liquidio_init(void)
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index de61060721c4..d396c004c1be 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -468,6 +468,21 @@ static const struct switchdev_ops lio_vf_rep_switchdev_ops = {
 	.switchdev_port_attr_get        = lio_vf_rep_attr_get,
 };
 
+static int lio_vf_rep_swdev_port_attr_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int rc;
+
+	if (event != SWITCHDEV_PORT_ATTR_GET)
+		return NOTIFY_DONE;
+
+	rc = lio_vf_rep_attr_get(dev, port_attr_info->attr);
+	port_attr_info->handled = true;
+
+	return notifier_from_errno(rc);
+}
+
 static void
 lio_vf_rep_fetch_stats(struct work_struct *work)
 {
@@ -538,7 +553,6 @@ lio_vf_rep_create(struct octeon_device *oct)
 
 		if (register_netdev(ndev)) {
 			dev_err(&oct->pci_dev->dev, "VF rep nerdev registration failed\n");
-
 			free_netdev(ndev);
 			goto cleanup;
 		}
@@ -664,20 +678,49 @@ static struct notifier_block lio_vf_rep_netdev_notifier = {
 	.notifier_call = lio_vf_rep_netdev_event,
 };
 
+static int lio_vf_rep_swdev_event(struct notifier_block *nb,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
+
+	if (ndev->netdev_ops != &lio_vf_rep_ndev_ops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_GET:
+		return lio_vf_rep_swdev_port_attr_event(event, ndev, ptr);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block lio_vf_rep_swdev_nb = {
+	.notifier_call = lio_vf_rep_swdev_event,
+};
+
 int
 lio_vf_rep_modinit(void)
 {
+	int rc;
+
 	if (register_netdevice_notifier(&lio_vf_rep_netdev_notifier)) {
 		pr_err("netdev notifier registration failed\n");
 		return -EFAULT;
 	}
 
+	rc = register_switchdev_blocking_notifier(&lio_vf_rep_swdev_nb);
+	if (rc) {
+		unregister_netdevice_notifier(&lio_vf_rep_netdev_notifier);
+		return rc;
+	}
+
 	return 0;
 }
 
 void
 lio_vf_rep_modexit(void)
 {
+	unregister_switchdev_blocking_notifier(&lio_vf_rep_swdev_nb);
 	if (unregister_netdevice_notifier(&lio_vf_rep_netdev_notifier))
 		pr_err("netdev notifier unregister failed\n");
 }
-- 
2.17.1

