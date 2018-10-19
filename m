Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F20ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8BD21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VKTwWL40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8BD21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJSUft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:35:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44406 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PynLrFwNeq4+TkN/uvMrmAN7nhUqL6NuhM7JUdQkavs=; b=VKTwWL40aoCc
        KG6h8Dp47mPA/A/K2QKwn8vwtfoKFQ9rvj3UD42vwrbh0AKoIxta99MaC3ZReXhb9m6HXlIPyl4Sr
        aYp0LXxt0kpEskJNCqrjWzrpdws7oiJ5cW6uRoKi2HQD7Sj0X2oJZ6MbxE1lEIOVAPfkOg8/YkU5+
        VX7Wk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTua-000053-8C; Fri, 19 Oct 2018 12:29:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F3F881122548; Fri, 19 Oct 2018 13:29:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: omap2-mcspi: Switch to readl_poll_timeout()" to the spi tree
In-Reply-To:  <20181015063829.26978-2-vigneshr@ti.com>
Message-Id: <20181019122951.F3F881122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:29:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: omap2-mcspi: Switch to readl_poll_timeout()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 4d3eea971b45792882a5b6b7bc7ceccea4ae6c76 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Mon, 15 Oct 2018 12:08:27 +0530
Subject: [PATCH] spi: omap2-mcspi: Switch to readl_poll_timeout()

Use standard readl_poll_timeout() macro for polling on status bits.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 508c61c669e7..985f00d8a964 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -33,6 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/gcd.h>
+#include <linux/iopoll.h>
 
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
@@ -353,19 +354,9 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
-	unsigned long timeout;
-
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (!(readl_relaxed(reg) & bit)) {
-		if (time_after(jiffies, timeout)) {
-			if (!(readl_relaxed(reg) & bit))
-				return -ETIMEDOUT;
-			else
-				return 0;
-		}
-		cpu_relax();
-	}
-	return 0;
+	u32 val;
+
+	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
 }
 
 static void omap2_mcspi_rx_callback(void *data)
-- 
2.19.0.rc2

