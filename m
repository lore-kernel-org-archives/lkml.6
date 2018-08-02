Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFEBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DE82151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Jb1hTj0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DE82151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbeHBQuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:50:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbeHBQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tbA76uaxrUSkRL7tPhRcLk7xQp75/pizrkqZvjkumfQ=; b=Jb1hTj0EKeUg
        +rJQos6khWd/hCxQEMjtSWjO1xpEQDVjMpqcPdbdt0Z007zjUO5ZtO/XGqjblkOF/LE6uhA3Qia6E
        PKYPmE1Pb3busH9oJqIAMm47ngi/4FA7zSNbeG53CF00kqb+CpQo6TunDGSFbRjVSZtngtgOzdPz9
        LbGic=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flF3b-000283-0e; Thu, 02 Aug 2018 14:58:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BC5CB1121BE5; Thu,  2 Aug 2018 15:58:26 +0100 (BST)
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
Subject: Applied "spi: spi-mem: Fix a typo in the documentation of struct spi_mem" to the spi tree
In-Reply-To:  <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
Message-Id: <20180802145826.BC5CB1121BE5@debutante.sirena.org.uk>
Date:   Thu,  2 Aug 2018 15:58:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: Fix a typo in the documentation of struct spi_mem

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

From 06bcb5168d7d49aa3ed449ff13a6d13c30afc3f0 Mon Sep 17 00:00:00 2001
From: Frieder Schrempf <frieder.schrempf@exceet.de>
Date: Thu, 2 Aug 2018 14:53:52 +0200
Subject: [PATCH] spi: spi-mem: Fix a typo in the documentation of struct
 spi_mem

Fix a typo in the @drvpriv description.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi-mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index bb4bd15ae1f6..951a2e949d5f 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -122,7 +122,7 @@ struct spi_mem_op {
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
- * @drvpriv: spi_mem_drviver private data
+ * @drvpriv: spi_mem_driver private data
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
-- 
2.18.0

