Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E720883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nCXH3k3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802E720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbeKHAcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:32:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w9iqxeOsnMqFBW1cabo5w5Vs0pRPu6QnRsW4husLuLQ=; b=nCXH3k3rcU4w
        tEvLkjqCNmURfoGfkXd9a22/CsLZEZD0rJjovXLlhWlhbzMir4XZCtc9NJJfZN9b1DFEmdNL9ok45
        zdrRoLj76AexMAk9iOQA2Dbw1+OvupgRHndGbUKrJ9f/mWPzqJR8R0LBmwgh3jxuUTXBw5Dg8tOE7
        ZahXo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPKd-0006bE-Lw; Wed, 07 Nov 2018 15:01:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5C5601124E14; Wed,  7 Nov 2018 15:01:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: omap-spi: Add compatible for AM654 SoC" to the spi tree
In-Reply-To:  <20181107103926.32550-2-vigneshr@ti.com>
Message-Id: <20181107150123.5C5601124E14@debutante.sirena.org.uk>
Date:   Wed,  7 Nov 2018 15:01:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: omap-spi: Add compatible for AM654 SoC

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

From abc61f47a70f7c8331f00eff1ccb6557a9d4c224 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Wed, 7 Nov 2018 16:09:25 +0530
Subject: [PATCH] spi: omap-spi: Add compatible for AM654 SoC

AM654 SoC has same McSPI IP as OMAP2+ platforms. Add new compatible to
support McSPI on AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 2ba5f9c023ac..487208c256c0 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -2,6 +2,7 @@ OMAP2+ McSPI device
 
 Required properties:
 - compatible :
+  - "ti,am654-mcspi" for AM654.
   - "ti,omap2-mcspi" for OMAP2 & OMAP3.
   - "ti,omap4-mcspi" for OMAP4+.
 - ti,spi-num-cs : Number of chipselect supported  by the instance.
-- 
2.19.0.rc2

