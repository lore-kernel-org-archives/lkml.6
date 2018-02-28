Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104350-1519816031-2-8103584627437003295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519816030; b=uWohnSPIUvQoCwTiq+Kl91saUR2dJ9BvCtiYkEYScm44QXm
    dxqpgxq46XqXroezHc2cbkx8W5F+cuNXj8o6HMqEGYeLg2UDASTWXf/9DCH7vVpB
    +Z48eptew31Q43N7wDh/FndOY0M7nh+R+edRV9bD0HUZhRAEgOO4ZrZQ2rhGlHx7
    4c7Eazvr+eWbK+KWyP0IpoIl3B91R7XwSf+ok3qx/SXUZ2sNpen3x0NaLkHoRMoZ
    e8sXcqtuCtsb8O8ak9E0QXxatCqMG+JDohG1dIHSRZiU8wO5tNJlUJXKdanuuxUE
    UXGLk61hsVerWkM8bkr/3Ha+v2W4PvIZT75b62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=arctest; t=1519816030; bh=votCHb/h7XWTOP
    zHCD7uEeqhGQMIllOhj3C5kyRypTA=; b=VmDExS/QQhpKcsPIjnRRPLz3072ANF
    pctSY3t9gMs0lRKVBFz7Jww8ICJV/o2KNVCeB3sfh15z6DnLgKvbnmQHRK2dijku
    8Vv97ssNLBW5fRof5+mPkxpoMIScVdRkx9zHfCfOLRBgEjri7bX575GlDEsHC9pP
    mgquT/j1Q0HXOqPEud+uvNRf3GuVsqHQV8QBgc1Uc7qPdmdiC0HzIcoIhlC2ZUxY
    wAut1tIbtEbcEcMT1DhBrCixr2Zjyau8uQ2hxInIShcay2IsUmEUFKfYg++hSgI7
    o4q9k5h09ZPymOEnjsqXsIdt3PQVx+9Tq+eg/4UirDXyhMb5bjCTAjaA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=jRUu96At x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=jRUu96At x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeB1LGx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 06:06:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeB1LGv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 06:06:51 -0500
From: Mark Brown <broonie@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        nicolas.ferre@microchip.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Applied "spi: atmel: init FIFOs before spi enable" to the spi tree
In-Reply-To: <1519727107-5821-1-git-send-email-eugen.hristev@microchip.com>
Message-Id: <E1eqzZO-0005Jw-Kt@debutante>
Date: Wed, 28 Feb 2018 11:06:46 +0000
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   spi: atmel: init FIFOs before spi enable

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

>From 9581329eff9db72ab4fbb46a594fd7fdda3c51b0 Mon Sep 17 00:00:00 2001
From: Eugen Hristev <eugen.hristev@microchip.com>
Date: Tue, 27 Feb 2018 12:25:07 +0200
Subject: [PATCH] spi: atmel: init FIFOs before spi enable

The datasheet recommends initializing FIFOs before
SPI enable. If we do not do it like this, there may be
a strange behavior. We noticed that DMA does not work properly
with FIFOs if we do not clear them beforehand or enable them
before SPIEN.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-atmel.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 4a11fc0d4136..b7936f815373 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1512,6 +1512,11 @@ static void atmel_spi_init(struct atmel_spi *as)
 {
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+
+	/* It is recommended to enable FIFOs first thing after reset */
+	if (as->fifo_size)
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+
 	if (as->caps.has_wdrbt) {
 		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
@@ -1522,9 +1527,6 @@ static void atmel_spi_init(struct atmel_spi *as)
 	if (as->use_pdc)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
-
-	if (as->fifo_size)
-		spi_writel(as, CR, SPI_BIT(FIFOEN));
 }
 
 static int atmel_spi_probe(struct platform_device *pdev)
-- 
2.16.1
