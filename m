Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21225C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7BB215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fqTaW8ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7BB215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeKVAFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbeKVAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mUSghe2efHNkf301YI9MNmu7vKCaH1lXh9fm2dyQf08=; b=fqTaW8yeCcbd
        JnMEt3uZ0aXi3Td+DuShZqMOF4uhNhrGVwX77JbilQwRDipFlzYDvp3oAa4RozlaG+DQg2DjWEosq
        V1xm30uhe6kPMk11kYXZ+fhEmfXqEhFc/wH3qktFM9l/YCZ7u86U6Jy1DJhGxYkmgYRKAHNzd5Ca2
        HW/LQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPSaX-0003Zr-16; Wed, 21 Nov 2018 13:30:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B69AE11250AE; Wed, 21 Nov 2018 13:30:40 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "spi: spi-qcom-qspi: Fix remaining driver nits" to the regulator tree
In-Reply-To: 
Message-Id: <20181121133040.B69AE11250AE@debutante.sirena.org.uk>
Date:   Wed, 21 Nov 2018 13:30:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-qcom-qspi: Fix remaining driver nits

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

From dc04f0e4ca82103889895615b3c2eb77110b1b1a Mon Sep 17 00:00:00 2001
From: Ryan Case <ryandcase@chromium.org>
Date: Mon, 22 Oct 2018 18:07:07 -0700
Subject: [PATCH] spi: spi-qcom-qspi: Fix remaining driver nits

Address remaining comments from original driver patch series

* Move RD_FIFO_CFG to be ordered corretly
* Expand spinlock comment

Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qcom-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b8163b40bb92..e0f061139c8f 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -90,6 +90,9 @@
 #define PIO_DATAOUT_1B		0x0020
 #define PIO_DATAOUT_4B		0x0024
 
+#define RD_FIFO_CFG		0x0028
+#define CONTINUOUS_MODE		BIT(0)
+
 #define RD_FIFO_STATUS	0x002c
 #define FIFO_EMPTY	BIT(11)
 #define WR_CNTS_MSK	0x7f0
@@ -99,9 +102,6 @@
 #define RDY_16BYTE	BIT(1)
 #define FIFO_RDY	BIT(0)
 
-#define RD_FIFO_CFG		0x0028
-#define CONTINUOUS_MODE		BIT(0)
-
 #define RD_FIFO_RESET		0x0030
 #define RESET_FIFO		BIT(0)
 
@@ -139,7 +139,7 @@ struct qcom_qspi {
 	struct device *dev;
 	struct clk_bulk_data clks[QSPI_NUM_CLKS];
 	struct qspi_xfer xfer;
-	/* Lock to protect data accessed by IRQs */
+	/* Lock to protect xfer and IRQ accessed registers */
 	spinlock_t lock;
 };
 
-- 
2.19.0.rc2

