Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1901C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB9120880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548679004;
	bh=0ksAVTdg9fJTwdReDG+3lpHgWq4+pNBikq6PM7r2Drw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zMBFn9d+sC9OnKUcufWM43sXQw+/PN1iP7A/3El/v2NthjQ9akiuUFjQpvq02PAFR
	 nY4Xi5wiBY+pMf9iTEt4+oOPWJDgxKyW1FWlec5TJYfcbuioos3QGwpZlsCyyngE10
	 z1JPZfXMZNsdMe7FsjVOJnyAR4oMeaAqvrKrBwlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfA1Mfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfA1Mfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yh7zlaGNNIvO7pFyA772SmFQ+acx1N9Pvh1mNLWhRew=; b=Uc6EG9gRZyX1
        wXBvvomT37/FF1OfMto01xp+PH7GRd5n9yHHHq0eLIp46Gyv2wmQ1Y1PIw6eyy9+EFZRd4kdHQM45
        DP6AaXtyUmGvnRXrzntDvTQPFW0h7096sgK8R8Q2gTJTM0bpxCYnRNDKduBCpEWN910Y1LqXqPpJk
        qkmLY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68Y-0002Sr-9V; Mon, 28 Jan 2019 12:35:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DA2951127D29; Mon, 28 Jan 2019 12:35:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mcp16502: Include linux/gpio/consumer.h to fix build error" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123537.DA2951127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Include linux/gpio/consumer.h to fix build error

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

From f3c6a1a194317f3a31ee2b2067bb0a41de64bc8b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 27 Jan 2019 16:51:22 +0800
Subject: [PATCH] regulator: mcp16502: Include linux/gpio/consumer.h to fix
 build error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix below build error:
drivers/regulator/mcp16502.c: In function ‘mcp16502_gpio_set_mode’:
drivers/regulator/mcp16502.c:135:3: error: implicit declaration of function ‘gpiod_set_value’; did you mean ‘gpio_set_value’? [-Werror=implicit-function-declaration]
   gpiod_set_value(mcp->lpm, 0);
   ^~~~~~~~~~~~~~~
   gpio_set_value
drivers/regulator/mcp16502.c: In function ‘mcp16502_probe’:
drivers/regulator/mcp16502.c:486:13: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
  mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
             ^~~~~~~~~~~~~~
             devm_gpio_free
drivers/regulator/mcp16502.c:486:40: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
  mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
                                        ^~~~~~~~~~~~~
                                        GPIOF_INIT_LOW

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 3479ae009b0b..0fc4963bd5b0 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/suspend.h>
+#include <linux/gpio/consumer.h>
 
 #define VDD_LOW_SEL 0x0D
 #define VDD_HIGH_SEL 0x3F
-- 
2.20.1

