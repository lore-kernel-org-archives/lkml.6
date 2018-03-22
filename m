Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeCVWeL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:34:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43770 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeCVWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:34:08 -0400
X-Google-Smtp-Source: AG47ELuOR+sqFjDkseRDViXZ+uCBUh7CLaBlSLQozosFdeQkDubvsAkcAkcW5YG1bOB1XMjl3O2MkA==
From: Mathias Kresin <dev@kresin.me>
To: andrew@lunn.ch, f.fainelli@gmail.com, hauke@hauke-m.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: phy: intel-xway: add VR9 v1.1 phy ids
Date: Thu, 22 Mar 2018 23:31:39 +0100
Message-Id: <1521757899-27813-2-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521757899-27813-1-git-send-email-dev@kresin.me>
References: <1521757899-27813-1-git-send-email-dev@kresin.me>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phys embedded into the v1.1 of the VR9 SoC are using different phy
ids. Add the phy ids to use the driver for this VR9 version as well.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/net/phy/intel-xway.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index c7eff67..7d936fb 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -149,6 +149,8 @@
 #define PHY_ID_PHY22F_1_4		0xD565A410
 #define PHY_ID_PHY11G_1_5		0xD565A401
 #define PHY_ID_PHY22F_1_5		0xD565A411
+#define PHY_ID_PHY11G_VR9_1_1		0xD565A408
+#define PHY_ID_PHY22F_VR9_1_1		0xD565A418
 #define PHY_ID_PHY11G_VR9_1_2		0xD565A409
 #define PHY_ID_PHY22F_VR9_1_2		0xD565A419
 
@@ -312,6 +314,30 @@ static struct phy_driver xway_gphy[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 	}, {
+		.phy_id		= PHY_ID_PHY11G_VR9_1_1,
+		.phy_id_mask	= 0xffffffff,
+		.name		= "Intel XWAY PHY11G (xRX v1.1 integrated)",
+		.features	= PHY_GBIT_FEATURES,
+		.flags		= PHY_HAS_INTERRUPT,
+		.config_init	= xway_gphy_config_init,
+		.ack_interrupt	= xway_gphy_ack_interrupt,
+		.did_interrupt	= xway_gphy_did_interrupt,
+		.config_intr	= xway_gphy_config_intr,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	}, {
+		.phy_id		= PHY_ID_PHY22F_VR9_1_1,
+		.phy_id_mask	= 0xffffffff,
+		.name		= "Intel XWAY PHY22F (xRX v1.1 integrated)",
+		.features	= PHY_BASIC_FEATURES,
+		.flags		= PHY_HAS_INTERRUPT,
+		.config_init	= xway_gphy_config_init,
+		.ack_interrupt	= xway_gphy_ack_interrupt,
+		.did_interrupt	= xway_gphy_did_interrupt,
+		.config_intr	= xway_gphy_config_intr,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.2 integrated)",
@@ -346,6 +372,8 @@ static struct mdio_device_id __maybe_unused xway_gphy_tbl[] = {
 	{ PHY_ID_PHY22F_1_4, 0xffffffff },
 	{ PHY_ID_PHY11G_1_5, 0xffffffff },
 	{ PHY_ID_PHY22F_1_5, 0xffffffff },
+	{ PHY_ID_PHY11G_VR9_1_1, 0xffffffff },
+	{ PHY_ID_PHY22F_VR9_1_1, 0xffffffff },
 	{ PHY_ID_PHY11G_VR9_1_2, 0xffffffff },
 	{ PHY_ID_PHY22F_VR9_1_2, 0xffffffff },
 	{ }
-- 
2.7.4
