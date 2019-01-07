Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E90206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887629;
	bh=DAVSOEfLbLxjBmAhanIBfOlNJpRzS08DRj0R2TlvcOE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=esEUP1m9yGFAMrOme4V4KzCLe0rxNm/Yi5gpruJU+YZG/UKWwWdIGpE1mwQYfnOwm
	 YwCMG+mcM3s8OQZP2AboiaJQhmtNfNjbnSWTWYSAdUY5f6QeGi/AmlHlZNcDwLrDsr
	 wqZeZynczgBrH9Flipd3dN3kil0eWpIjrIJvufJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfAGTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:00:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42908 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfAGS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bPpFLdt1RsxemTLkKfv9pv5f9X+G5jh2tEpv2eU+UXI=; b=oxmPfy+A7xTi
        /4uXzbJ8NQ3wwu0X/DYtGGIYnK05nNLQhx5ZXBTmIEZdo1ldyubgNvSJSv9vextvvsF+LuBfoUyo8
        mpKQGyiwZR3NVgtPlPwmYg5rJ6Zb6dQ+r6csjQGHZtCwyIA55bqBJdBYmX/Q+pBvmJFnOkZaQKJJP
        D0RuY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7D-0007qy-Er; Mon, 07 Jan 2019 18:59:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 12A251127491; Mon,  7 Jan 2019 18:59:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Gapinski <cezary.gapinski@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: stm32: use explicit CPOL and CPHA mode bits" to the spi tree
In-Reply-To:  <1545688840-23992-6-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185911.12A251127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: use explicit CPOL and CPHA mode bits

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

From d6cea11b092a2c28ecf8371c093214cbb112e926 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:31 +0100
Subject: [PATCH] spi: stm32: use explicit CPOL and CPHA mode bits

Driver supports SPI mode 0 to 3 not only the mode 3.
Use SPI_CPOL and SPI_CPHA indicates that these bits
can be changed to obtain modes 0 - 3.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8310f14fe273..f7056b767477 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1142,7 +1142,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_MODE_3 | SPI_CS_HIGH | SPI_LSB_FIRST |
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_3WIRE | SPI_LOOP;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
-- 
2.20.1

