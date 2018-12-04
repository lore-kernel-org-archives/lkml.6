Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD42F2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="k+2WoGm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD42F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeLDR1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:27:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeLDR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dnAn9MIjf7y9eaNiMLpKt8RDJllZb9rR5mqXvPs+E70=; b=k+2WoGm7rF6W
        GTlx7rJlRSm6a8my8EFmD2aJ4K2sJ+A0lAxVghPeML9ydWLpRsGS5qTgj4A+zoo3op+fP1y0HlkNv
        5qIMtkjQeREibdQ9fhgeyD7poj0B3GINXPtofXEy/3IA4v09WqjTni1X2GVvuYuxAAkuC8yHCTbqj
        fiiNc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUEU2-0007xz-Dv; Tue, 04 Dec 2018 17:27:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 10EFD11251E3; Tue,  4 Dec 2018 17:27:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: add support for octal mode I/O data transfer" to the spi tree
In-Reply-To:  <1543826226-30898-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20181204172742.10EFD11251E3@debutante.sirena.org.uk>
Date:   Tue,  4 Dec 2018 17:27:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: add support for octal mode I/O data transfer

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

From 6b03061f882de49b83ccf44beb3a12c920a2da1b Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Mon, 3 Dec 2018 08:39:06 +0000
Subject: [PATCH] spi: add support for octal mode I/O data transfer

Add flags for Octal mode I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 12 ++++++++++--
 include/linux/spi/spi.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b6fd8ea8ac0d..18ebc400249c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1633,6 +1633,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		case 4:
 			spi->mode |= SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |= SPI_TX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-tx-bus-width %d not supported\n",
@@ -1651,6 +1654,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		case 4:
 			spi->mode |= SPI_RX_QUAD;
 			break;
+		case 8:
+			spi->mode |= SPI_RX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
@@ -2839,7 +2845,8 @@ int spi_setup(struct spi_device *spi)
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
 	 */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
-		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
+		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
@@ -2848,7 +2855,8 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
 	ugly_bits = bad_bits &
-		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
+		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6be77fa5ab90..0c1ca5dedbb4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -154,7 +154,9 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
-#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.19.0.rc2

