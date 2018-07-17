Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62975ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181102147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="izOqrHW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181102147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbeGQOsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:48:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbeGQOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8BiViFkrlSWs+63g75oZGz2X3TITob2r+D5k1svwldo=; b=izOqrHW2qk+A
        ArS0vracosFIBT0FGU3enNZw96lvOjOoz3T6tgicTdPSv2ci9fb2fGCI3L3aPuACj4dzTb1xf5yqS
        OB4VV59BomdzKaBTbpe1/s0E40hyacDNpaBW7LbneNeaHYGEAS+D55N9Cgfshxorcxju7nlTnXrK4
        Pru4g=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffQlL-00027t-R2; Tue, 17 Jul 2018 14:15:35 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffQlL-0000Nw-7u; Tue, 17 Jul 2018 15:15:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer" to the spi tree
In-Reply-To:  <20180717043329.4209-1-andrew.smirnov@gmail.com>
Message-Id: <E1ffQlL-0000Nw-7u@debutante>
Date:   Tue, 17 Jul 2018 15:15:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer

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

From 5f8f80356eccfaae1db8a827626ae4fc2eb62831 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 16 Jul 2018 21:33:29 -0700
Subject: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer

Upper layer users of SPI device drivers may rely on 'actual_length',
so it is important that information is correctly reported. One such
example is spi_mem_exec_op() function that will fail if
'actual_length' of the data transferred is not what was requested. Add
necessary code to populate 'actual_length.

Cc: Mark Brown <broonie@kernel.org>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: cphealy@gmail.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 89a1e7a4fe5d..9e598642ca66 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -358,6 +358,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct spi_message *message = dspi->cur_msg;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int ret = 0;
@@ -377,8 +378,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len
-				* dspi->bytes_per_word;
+			const int len =
+				dma->curr_xfer_len * dspi->bytes_per_word;
+			curr_remaining_bytes -= len;
+			message->actual_length += len;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 		}
-- 
2.18.0

