Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6BA2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfAGTpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:45:09 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:15708 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfAGTpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:45:09 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a9a9:5e6d:35c6:d37d])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id B4CCC5FFCC;
        Mon,  7 Jan 2019 20:45:01 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/2] phy: ath79-usb: Fix the main reset name to match the DT binding
Date:   Mon,  7 Jan 2019 20:44:54 +0100
Message-Id: <20190107194454.16500-2-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107194454.16500-1-albeu@free.fr>
References: <20190107194454.16500-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted this driver several times before it got accepted. The
first series hasn't been accepted but the DTS binding did made it.
I then made a second series that added generic reset support to the
PHY core, this in turn required a change to the DT binding. This
second series seemed to have been ignored, so I did a third one
without the change to the PHY core and the DT binding update, and this
last attempt finally made it.

But two months later the DT binding update from the second series has
been integrated too. So now the driver doesn't match the binding and
the only DTS using it. This patch fix the driver to match the new
binding.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/phy/qualcomm/phy-ath79-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-ath79-usb.c b/drivers/phy/qualcomm/phy-ath79-usb.c
index f7d64f3910b4..09a77e556ece 100644
--- a/drivers/phy/qualcomm/phy-ath79-usb.c
+++ b/drivers/phy/qualcomm/phy-ath79-usb.c
@@ -69,7 +69,7 @@ static int ath79_usb_phy_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->reset = devm_reset_control_get(&pdev->dev, "usb-phy");
+	priv->reset = devm_reset_control_get(&pdev->dev, "phy");
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
 
-- 
2.19.1

