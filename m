Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011C3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F08206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887534;
	bh=/I0TvypM2rGP+s4TWu8tiF/MP1pQF2U1qzL9LsgdJvs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=N/tDCfLctgnfTE6uyqRkR0RLQJT2IM/DICpubd7OBNERgVqgmHi/M6TDSH+E579py
	 1CIrI7q4GG5lZR9zKT62Bcpew/26pfwyl/RqObUgPLmwve+n99zZieSfntmmX+WED+
	 DWBeMFZ2ld126EBf72WnDPFwllWbAxr7sogtLbUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfAGS6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42006 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfAGS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WNQ0h9AF/1QFGYt+jhZRU4YGXb3cm+56ukOe3w6oCI0=; b=nu/przJAyjsk
        gVE204ZPfpvxNdlfoqG0xIlzCGO9BEb0GGz5bXLSPtSvwAMN666eHB1oeu+/X1Gq4Tz3Gx8eKsflG
        R/LefAVYjzKOs9toaHgjMRk1m1iaEZMSBAXgnnY8eOWHULCPFdlgpNwRCxCQYvlbJn+Ybdt1HlZEt
        fIFkg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6o-0007pq-H4; Mon, 07 Jan 2019 18:58:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1ABC31127491; Mon,  7 Jan 2019 18:58:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bcm590xx: Fix .enable_reg for BCM590XX_REG_VSR" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190107185846.1ABC31127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bcm590xx: Fix .enable_reg for BCM590XX_REG_VSR

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d6afa2bed00486767fd5f3255cc89c05ccb70c0a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 5 Jan 2019 11:28:17 +0800
Subject: [PATCH] regulator: bcm590xx: Fix .enable_reg for BCM590XX_REG_VSR

Current implementation missed the case BCM590XX_REG_VSR, so
bcm590xx_get_enable_register() returns 0 when id is BCM590XX_REG_VSR.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bcm590xx-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 92d6d7b10cf7..e49c0a7d5dd5 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -242,8 +242,12 @@ static int bcm590xx_get_enable_register(int id)
 		case BCM590XX_REG_SDSR2:
 			reg = BCM590XX_SDSR2PMCTRL1;
 			break;
+		case BCM590XX_REG_VSR:
+			reg = BCM590XX_VSRPMCTRL1;
+			break;
 		case BCM590XX_REG_VBUS:
 			reg = BCM590XX_OTG_CTRL;
+			break;
 		}
 
 
-- 
2.20.1

