Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEF620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfAQMdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:33:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42250 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfAQMdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:33:40 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B39B11A00BA;
        Thu, 17 Jan 2019 13:33:38 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A5CB91A0023;
        Thu, 17 Jan 2019 13:33:38 +0100 (CET)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 34E8C20637;
        Thu, 17 Jan 2019 13:33:38 +0100 (CET)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        davem@davemloft.net, oss@buserror.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH net] net: phy: add missing phy driver features
Date:   Thu, 17 Jan 2019 14:33:33 +0200
Message-Id: <1547728413-20233-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy drivers for CS4340 and TN2020 are missing their
features attributes. Add them.

Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
Reported-by: Scott Wood <oss@buserror.net>
Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
This patch should be merged to 4.20 stable.
---
 drivers/net/phy/cortina.c    | 1 +
 drivers/net/phy/teranetics.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index 8022cd3..1a4d04a 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -88,6 +88,7 @@ static int cortina_probe(struct phy_device *phydev)
 	.phy_id		= PHY_ID_CS4340,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Cortina CS4340",
+	.features       = PHY_10GBIT_FEATURES,
 	.config_init	= gen10g_config_init,
 	.config_aneg	= gen10g_config_aneg,
 	.read_status	= cortina_read_status,
diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index 22f3bdd..9124718 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -80,6 +80,7 @@ static int teranetics_match_phy_device(struct phy_device *phydev)
 	.phy_id		= PHY_ID_TN2020,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Teranetics TN2020",
+	.features       = PHY_10GBIT_FEATURES,
 	.soft_reset	= gen10g_no_soft_reset,
 	.aneg_done	= teranetics_aneg_done,
 	.config_init    = gen10g_config_init,
-- 
1.9.1

