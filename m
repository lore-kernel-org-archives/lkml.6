Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE4D21525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XzYKcRa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE4D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbeHBQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:50:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbeHBQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=z+aT8V2XcdcuCxCxMdTUlbQjWtj2VbWEZItLwOjTQnA=; b=XzYKcRa3Gor8
        haQ4BXFcC/JVcTxgbjD5h1DzcYvIBCRm/Sz16GHGi7oqVXvuyft/JHxstTFRIZ7zNup3dM61xqIJE
        jYXd7p5CIVP23WPNSDMPpNK4de8TeSYybTg5ZMCQb9+IEn3ajScK9mzFnCj62lRP9z4/KbPEG265j
        kkG8U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flF3U-00027k-Be; Thu, 02 Aug 2018 14:58:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 032B11121BE5; Thu,  2 Aug 2018 15:58:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, richard@nod.at, broonie@kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, frieder.schrempf@exceet.de,
        pp@emlix.com, Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "mtd: m25p80: Call spi_mem_get_name() to let controller set a custom name" to the spi tree
In-Reply-To:  <1533214434-28761-4-git-send-email-frieder.schrempf@exceet.de>
Message-Id: <20180802145820.032B11121BE5@debutante.sirena.org.uk>
Date:   Thu,  2 Aug 2018 15:58:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mtd: m25p80: Call spi_mem_get_name() to let controller set a custom name

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

From b02b17f55b2e789b9747cf4dd2eaaa110439a4cc Mon Sep 17 00:00:00 2001
From: Frieder Schrempf <frieder.schrempf@exceet.de>
Date: Thu, 2 Aug 2018 14:53:54 +0200
Subject: [PATCH] mtd: m25p80: Call spi_mem_get_name() to let controller set a
 custom name

By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
set a custom name for the memory device if necessary.
This is useful to keep mtdparts compatible when controller drivers are
ported from the MTD to the SPI layer.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mtd/devices/m25p80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d2067f..aac488008216 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -202,6 +202,9 @@ static int m25p_probe(struct spi_mem *spimem)
 	if (data && data->name)
 		nor->mtd.name = data->name;
 
+	if (!nor->mtd.name)
+		nor->mtd.name = spi_mem_get_name(spimem);
+
 	/* For some (historical?) reason many platforms provide two different
 	 * names in flash_platform_data: "name" and "type". Quite often name is
 	 * set to "m25p80" and then "type" provides a real chip name.
-- 
2.18.0

