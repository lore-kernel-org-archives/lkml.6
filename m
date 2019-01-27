Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538BC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23820881
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfA0T7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:59:51 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:42220 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0T7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:59:50 -0500
Received: from localhost.localdomain (85-76-101-7-nat.elisa-mobile.fi [85.76.101.7])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 39D5530152;
        Sun, 27 Jan 2019 21:59:48 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] staging: octeon: fix broken phylib usage
Date:   Sun, 27 Jan 2019 21:54:50 +0200
Message-Id: <20190127195450.12480-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2b3e88ea6528 ("net: phy: improve phy state checking")
added checks for phylib usage, and this triggers with OCTEON ethernet
and results in broken networking.

Fix by replacing phy_start_aneg() with phy_start().

Fixes: 2b3e88ea6528 ("net: phy: improve phy state checking")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index 2848fa71a33d..d6248eecf123 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -170,7 +170,7 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
 		return -ENODEV;
 
 	priv->last_link = 0;
-	phy_start_aneg(phydev);
+	phy_start(phydev);
 
 	return 0;
 no_phy:
-- 
2.17.0

