Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527312175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oLBKPdov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527312175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbeKNEfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:35:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47026 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKNEfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=K/UP177TqbET2ItmR+Sfh12hHwLV3k/4GXl/GiLaOpo=; b=oLBKPdovBCOO
        sloh4g+tZkXtUZ5aAQu5mZ5HFu0h7aUvI7rBqv1Pr4EGytrfcTtyt1hHhqAiGR/C/qyKbysB3nkkL
        zEH8y3ijZoKjYLoNPY7Jbn1UrqhXBtIn63D2vXkwOphajKaPYJtWEU18t7y8lkvwh+SkdyAIHHdVA
        ycCeE=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMdXa-0002QY-OQ; Tue, 13 Nov 2018 18:35:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id ECDDF440079; Tue, 13 Nov 2018 18:35:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Deal with slaves that return from transfer_one() unfinished" to the spi tree
In-Reply-To:  <20181113102228.820214-3-lkundrak@v3.sk>
Message-Id: <20181113183548.ECDDF440079@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 18:35:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Deal with slaves that return from transfer_one() unfinished

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

From 810923f3bf06c11022b7bb370dd3130a956a222e Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Tue, 13 Nov 2018 11:22:24 +0100
Subject: [PATCH] spi: Deal with slaves that return from transfer_one()
 unfinished

Some drivers, such as spi-pxa2xx return from the transfer_one callback
immediately, idicating that the transfer will be finished asynchronously.

Normally, spi_transfer_one_message() synchronously waits for the
transfer to finish with wait_for_completion_timeout(). For slaves, we
don't want the transaction to time out as it can complete in a long time
in future. Use wait_for_completion_interruptible() instead.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 62 +++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca59406b0b7..498d3b9bf3ae 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1037,6 +1037,42 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return __spi_map_msg(ctlr, msg);
 }
 
+static int spi_transfer_wait(struct spi_controller *ctlr,
+			     struct spi_message *msg,
+			     struct spi_transfer *xfer)
+{
+	struct spi_statistics *statm = &ctlr->statistics;
+	struct spi_statistics *stats = &msg->spi->statistics;
+	unsigned long long ms = 1;
+
+	if (spi_controller_is_slave(ctlr)) {
+		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
+			dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
+			return -EINTR;
+		}
+	} else {
+		ms = 8LL * 1000LL * xfer->len;
+		do_div(ms, xfer->speed_hz);
+		ms += ms + 200; /* some tolerance */
+
+		if (ms > UINT_MAX)
+			ms = UINT_MAX;
+
+		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
+						 msecs_to_jiffies(ms));
+
+		if (ms == 0) {
+			SPI_STATISTICS_INCREMENT_FIELD(statm, timedout);
+			SPI_STATISTICS_INCREMENT_FIELD(stats, timedout);
+			dev_err(&msg->spi->dev,
+				"SPI transfer timed out\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
@@ -1050,7 +1086,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	unsigned long long ms = 1;
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
@@ -1079,28 +1114,9 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				goto out;
 			}
 
-			if (ret > 0) {
-				ret = 0;
-				ms = 8LL * 1000LL * xfer->len;
-				do_div(ms, xfer->speed_hz);
-				ms += ms + 200; /* some tolerance */
-
-				if (ms > UINT_MAX)
-					ms = UINT_MAX;
-
-				ms = wait_for_completion_timeout(&ctlr->xfer_completion,
-								 msecs_to_jiffies(ms));
-			}
-
-			if (ms == 0) {
-				SPI_STATISTICS_INCREMENT_FIELD(statm,
-							       timedout);
-				SPI_STATISTICS_INCREMENT_FIELD(stats,
-							       timedout);
-				dev_err(&msg->spi->dev,
-					"SPI transfer timed out\n");
-				msg->status = -ETIMEDOUT;
-			}
+			ret = spi_transfer_wait(ctlr, msg, xfer);
+			if (ret < 0)
+				msg->status = ret;
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
-- 
2.19.1

