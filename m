Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD9E222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196593;
	bh=e8uQXtz580xmLzODWsMx0M9RT/GzWLnSSY+bZdH4FDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NOCe2GlUVlFOmw+7wKct7Wml8wYEf86g+32aMzSiqwjTPxILQ69IqtvlrK4uZBYfa
	 wTWqwbmSMM3eE1RMfYW8AC6OhoZdv1ytmSwW2xp0SfbOzwzYwaXx5SMogyAdB0GkoA
	 OU6oBn6vnjKqgb+z6bu9a0uJBZ2M3RwHG6biuaC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbfBOCJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388861AbfBOCJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F84E222A1;
        Fri, 15 Feb 2019 02:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196584;
        bh=e8uQXtz580xmLzODWsMx0M9RT/GzWLnSSY+bZdH4FDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjYVNam4lvcmw7oUxM3b7Q6GothnQkZrPmYlJhEmUUT30uNzDPrg9tmfTi4m9De/U
         Cmp2cipnqVO/ETPA4rKwgsRnCS8//im+xefMPB12v+da6vaxVSqUh75AyyyeoDa3o8
         DuBKCjPQlXK1fGU5iCVq6eieuXu2rM0aXekf1edQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 28/77] phy: ath79-usb: Fix the main reset name to match the DT binding
Date:   Thu, 14 Feb 2019 21:08:06 -0500
Message-Id: <20190215020855.176727-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

[ Upstream commit 827cb0323928952c0db9515aba9d534fb1285b3f ]

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
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

