Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEB4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A52087E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201A52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392937AbeKWHAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:00:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38295 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbeKWHAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:00:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D7605207AD; Thu, 22 Nov 2018 21:19:19 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82CBB20714;
        Thu, 22 Nov 2018 21:19:19 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] phy: mvebu-cp110-comphy: fix spelling in structure name
Date:   Thu, 22 Nov 2018 21:19:09 +0100
Message-Id: <20181122201909.5235-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the mvebu_comhy_conf structure to be mvebu_comphy_conf, which is
probably what the original author meant.

Fixes: d0438bd6aa09 ("phy: add the mvebu cp110 comphy driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Hello Kishon,

Sorry for such a trivial patch. As I used this driver as a base for
another comphy driver (Armada 3700, coming soon) I spot this mistake
but I would understand if you ignore the patch!

Thanks,
Miquèl


 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 86a5f7b9448b..31b9a1c18345 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -114,7 +114,7 @@
 #define MVEBU_COMPHY_LANES	6
 #define MVEBU_COMPHY_PORTS	3
 
-struct mvebu_comhy_conf {
+struct mvebu_comphy_conf {
 	enum phy_mode mode;
 	unsigned lane;
 	unsigned port;
@@ -129,7 +129,7 @@ struct mvebu_comhy_conf {
 		.mux = _mux,				\
 	}
 
-static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
+static const struct mvebu_comphy_conf mvebu_comphy_cp110_modes[] = {
 	/* lane 0 */
 	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
 	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
-- 
2.19.1

