Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79827216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="v/nCWmJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79827216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeI1FBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:01:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1FBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ht5aj4K3YxFS/0/RHSuqKTEwso0oYbvxuKFffwXId9o=; b=v/nCWmJlueDM
        fJ0bUtzpktLGbcwpHQPkKojJFZnYU3K583pojmHljhDqYyeYb444nLz3cFq/gGaIhQkNuwpUJ/RyT
        2fKPBNJNELDm4X/gJNe+XZRgH4v9ru6atOBB9RTgiWVi1IxojsI3dfeeXPrexx1ZGUxmYFoyz+HNA
        iIWAg=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5exL-0007UD-BV; Thu, 27 Sep 2018 22:40:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C5007440078; Thu, 27 Sep 2018 23:40:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-mem: Fix inverted logic in op sanity check" to the spi tree
In-Reply-To:  <20180925094655.11438-1-geert+renesas@glider.be>
Message-Id: <20180927224022.C5007440078@finisterre.ee.mobilebroadband>
Date:   Thu, 27 Sep 2018 23:40:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: Fix inverted logic in op sanity check

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

From aea3877e24f3acc6145094848dbb85f9ce85674a Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 25 Sep 2018 11:46:55 +0200
Subject: [PATCH] spi: spi-mem: Fix inverted logic in op sanity check

On r8a7791/koelsch:

    m25p80 spi0.0: error -22 reading 9f
    m25p80: probe of spi0.0 failed with error -22

Apparently the logic in spi_mem_check_op() is wrong, rejecting the
spi-mem operation if any buswidth is valid, instead of invalid.

Fixes: 380583227c0c7f52 ("spi: spi-mem: Add extra sanity checks on the op param")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index cc3d425aae56..62a7b80801d2 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -169,10 +169,10 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 	    (op->data.nbytes && !op->data.buswidth))
 		return -EINVAL;
 
-	if (spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->addr.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->data.buswidth))
+	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->data.buswidth))
 		return -EINVAL;
 
 	return 0;
-- 
2.19.0

