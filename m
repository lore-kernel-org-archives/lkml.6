Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80220C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3960B214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Rezd0yaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3960B214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeHBMDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:03:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeHBMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HdNUifJ+JgZQDGvWEB+Jb+aSX8AiCGORbzUcXqO24SE=; b=Rezd0yaJN0lH
        LtpMc2yTEpgNgFJokVx55wZkTNNBWK+1W5tLSkHSk+I2vveIPMGjHfNqzTB2oXMXeTa+n3M0pRavi
        RSR+ELz4iNlVmMjDCvsunOO5xg5QItgs0Vpr3/EgQniHpJFifx0/NL5N5PrASwUi7qOlOjQVOTDYG
        fZe3o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flAam-0001sL-Tu; Thu, 02 Aug 2018 10:12:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A50D71124241; Thu,  2 Aug 2018 11:12:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: uniphier: remove unnecessary include headers" to the spi tree
In-Reply-To:  <1533184963-28508-1-git-send-email-hayashibara.keiji@socionext.com>
Message-Id: <20180802101224.A50D71124241@debutante.sirena.org.uk>
Date:   Thu,  2 Aug 2018 11:12:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: uniphier: remove unnecessary include headers

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

From 07ebbbe458790d3c75f4a2f3634d8e04f66b389b Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Thu, 2 Aug 2018 13:42:43 +0900
Subject: [PATCH] spi: uniphier: remove unnecessary include headers

This commit removed include headers of linux/of.h and linux/of_platform.h,
because they are not used.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 089985465890..5a6137fe172d 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -10,8 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
-- 
2.18.0

