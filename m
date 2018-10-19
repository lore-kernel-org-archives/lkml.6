Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1142ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD14C21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="m4r3Huef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD14C21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeJSUgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:36:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44874 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeJSUgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Z53R2Ku4mlXxgm9avLjjU3yQ0+l/mB6jFz56EmqFi6s=; b=m4r3HuefhFUh
        eKBCnezhAmr+xD+Uu8tgvSAYDYqzIHA1weX586z1iwC2LdSRb3+ISkx0f1ACg9btphLVg0/KN333I
        N2S1JNx3Vr+cHv7dJah9g2J3lDXiTRTzK/jMPAG4Nh+AXIZMZ0Vl0KH9hg6+BHJvT+8s8b0iRSx6r
        5FDiA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTuk-00005O-CL; Fri, 19 Oct 2018 12:30:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 196D21122548; Fri, 19 Oct 2018 13:30:02 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: pxa2xx: fix PCI dependency" to the spi tree
In-Reply-To:  <20181017185128.2634666-1-arnd@arndb.de>
Message-Id: <20181019123002.196D21122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:30:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: fix PCI dependency

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

From 23aa9fdea2d364924fadf3dcc1509bd578ac1f00 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 20:50:52 +0200
Subject: [PATCH] spi: pxa2xx: fix PCI dependency

The code reorganization broke building without CONFIG_PCI:

drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
drivers/spi/spi-pxa2xx.c:1457:15: error: implicit declaration of function 'pci_match_id'; did you mean 'pci_map_sg'? [-Werror=implicit-function-declaration]

Add back an #ifdef around the code block that requires it.

Fixes: 87ae1d2d7077 ("spi: pxa2xx: Add devicetree support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 612cc49db28f..c1c30109dd1f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1453,9 +1453,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_id = of_match_device(pdev->dev.driver->of_match_table,
 					&pdev->dev);
+#ifdef CONFIG_PCI
 	else if (dev_is_pci(pdev->dev.parent))
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
+#endif
 	else if (adev)
 		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
-- 
2.19.0.rc2

