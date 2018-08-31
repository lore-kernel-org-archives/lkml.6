Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2522077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aKa11xsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2522077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeHaTvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:51:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeHaTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HIkulPgt2r5ATh5gF6O5HWDeXgF5e+2mtKzgz5t+RTM=; b=aKa11xszEoYc
        IBMmr3kKRn81dGopjdhJK6fgBnYRZDaHw3eOsmUmor9CQi0nlpekPPTEATxvuGZdnG3SQS1MyIdqA
        qI4MxN3UZ8pznpENIuk4fXyXzcvmt/vuRC7EzUfdlu25UXjLF6JztR5XWK5u6NEfxjKuFRLykF1ga
        usH7E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fvlZo-0003yA-Ag; Fri, 31 Aug 2018 15:43:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 183C911226FE; Fri, 31 Aug 2018 16:43:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw-mmio: avoid hardcoded field mask" to the spi tree
In-Reply-To:  <20180831114046.27094-1-alexandre.belloni@bootlin.com>
Message-Id: <20180831154312.183C911226FE@debutante.sirena.org.uk>
Date:   Fri, 31 Aug 2018 16:43:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw-mmio: avoid hardcoded field mask

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

From c1d8b0825d50e1eb6b6ea2cb9e450637dba9b4e2 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 31 Aug 2018 13:40:46 +0200
Subject: [PATCH] spi: dw-mmio: avoid hardcoded field mask

Define a mask for the IF_SI_OWNER field.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 351f49976161..a768461614a0 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -36,6 +36,7 @@ struct dw_spi_mmio {
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
 #define OCELOT_IF_SI_OWNER_OFFSET		4
 #define JAGUAR2_IF_SI_OWNER_OFFSET		6
+#define MSCC_IF_SI_OWNER_MASK			GENMASK(1, 0)
 #define MSCC_IF_SI_OWNER_SISL			0
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2
@@ -102,7 +103,7 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 
 	/* Select the owner of the SI interface */
 	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   0x3 << if_si_owner_offset,
+			   MSCC_IF_SI_OWNER_MASK << if_si_owner_offset,
 			   MSCC_IF_SI_OWNER_SIMC << if_si_owner_offset);
 
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
-- 
2.19.0.rc1

