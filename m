Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794BA2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QEAgOUWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794BA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJHVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:09:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38262 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kuJAs+QY/TEoI3dRflqFoM/K8AZvjWo1KmEjmue3kss=; b=QEAgOUWkdGUd
        I29X+jWZDkp5iS/fhzDWVuCB8RkQwx4cSMXGvaNooifjgoB1iQQzjRfHHL4L29EQ1duonJRqKEta6
        O3wYCxJvQrdmePQIYO/1yNysz0DNE5/8rwoqi6zjCIl31nLDlqMLrbI695WT4gBVRQiFwQ8Qnbtpm
        ZCpiM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9W2D-0002hG-Cw; Mon, 08 Oct 2018 13:57:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 21E431122339; Mon,  8 Oct 2018 14:57:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spidev: Enable the Liebherr's BK4 board to work with spidev driver" to the spi tree
In-Reply-To:  <20180927223152.24990-1-lukma@denx.de>
Message-Id: <20181008135721.21E431122339@debutante.sirena.org.uk>
Date:   Mon,  8 Oct 2018 14:57:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spidev: Enable the Liebherr's BK4 board to work with spidev driver

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

From 5e9feb3544a72321553d17fcfa0c7e88435ea7ad Mon Sep 17 00:00:00 2001
From: Lukasz Majewski <lukma@denx.de>
Date: Fri, 28 Sep 2018 00:31:52 +0200
Subject: [PATCH] spidev: Enable the Liebherr's BK4 board to work with spidev
 driver

With this commit the DSPI driver on the BK4 board can be used for SPI
transmission managed from user space (via /dev/spidev0.0).

Example usage/testing:
insmod ./spi-fsl-dspi.ko
./spidev_test -D /dev/spidev0.0 -s 3000000 -v -H -b 8 -p "\xCC\x11\x22\x74"

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index cda10719d1d1..07f4d05563ea 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -669,6 +669,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lineartechnology,ltc2488" },
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
+	{ .compatible = "lwn,bk4" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.19.0.rc2

