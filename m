Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F14C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2320840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198004;
	bh=e8uQXtz580xmLzODWsMx0M9RT/GzWLnSSY+bZdH4FDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LCuLIr2MH9Jq69Avgnc51/1Po0FZr9R+MshoVWkL6bV8XcjexCwzPz9XC8mM6RUVe
	 7YQsXLjXomlSAPFjKixoxI0u0bM60SdM0fq+f4J6E7eDdg7uzHLm1AdBqOnkDEEKdw
	 /k2Zl5+6jUTGmD8QwfJWEEevaDRkJwlbWSfEt1NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390935AbfBOCL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbfBOCLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A52121934;
        Fri, 15 Feb 2019 02:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196715;
        bh=e8uQXtz580xmLzODWsMx0M9RT/GzWLnSSY+bZdH4FDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLWimB99qAtN6phSfzdjuJddS0lfd5ogZPuWKibEEhwMyfYXYbNqtkROmNAzVTBFY
         SI7JIRaNolMCRIHFV8bER6ANrLobjE8gpudn2EhsOBNeuTNu1j7wyV08O7TfAOvn3N
         j2hLLL5u0IdEqn+WD2AviOixapEb8reTZbl5hPuQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 21/65] phy: ath79-usb: Fix the main reset name to match the DT binding
Date:   Thu, 14 Feb 2019 21:10:37 -0500
Message-Id: <20190215021121.177674-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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

