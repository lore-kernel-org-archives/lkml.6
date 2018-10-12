Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B3FC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2912086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AtaCcmNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2912086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJMAhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:37:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51962 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeJMAhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KKVrPcS0wwUtmXlszKczBtwbqAX4/+k4JckQ+3kOGO4=; b=AtaCcmNg6btg
        TyLceNwDRBX5XTlNfMrTPuTw53nHnHTV9ynYdHSXQJ6OOYx9kElxv4jm4J8lw7s+MBYR+QL0aK0Eb
        Q9JYecleXZxdTxsr2Ui5VzXh9yDaPYHVzW7GXsnfNkSVRHdEnTtRRrfCXw0WedTj7mv7h6DIRbQrd
        3CSYg=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0qf-0006et-RL; Fri, 12 Oct 2018 17:03:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 681EC440078; Fri, 12 Oct 2018 19:03:37 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Make GPIO CSs honour the SPI_NO_CS flag" to the spi tree
In-Reply-To:  <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
Message-Id: <20181012170337.681EC440078@finisterre.ee.mobilebroadband>
Date:   Fri, 12 Oct 2018 19:03:37 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Make GPIO CSs honour the SPI_NO_CS flag

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

From 25972d0c33deb5c49708baa48e7796c8d0348e98 Mon Sep 17 00:00:00 2001
From: Phil Elwell <phil@raspberrypi.org>
Date: Fri, 12 Oct 2018 10:23:18 +0100
Subject: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag

The SPI configuration state includes an SPI_NO_CS flag that disables
all CS line manipulation, for applications that want to manage their
own chip selects. However, this flag is ignored by the GPIO CS code
in the SPI framework.

Correct this omission with a trivial patch.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fcbd4cfd2818..ea3e5e146764 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -775,7 +775,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, !enable);
+		/* Honour the SPI_NO_CS flag */
+		if (!(spi->mode & SPI_NO_CS))
+			gpio_set_value(spi->cs_gpio, !enable);
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
 		    spi->controller->set_cs)
-- 
2.19.0

