Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A898EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6DE208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TbbNxpCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6DE208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeGaQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:22:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbeGaQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+tKErjDa7k0tUCr1xVGxXqv/OHAx8Dl5Yjkb0ZNTfJk=; b=TbbNxpCZHJuF
        63mJ259oPb/nrccaQcsqj+NgjWXINkEPwp6LseCUMDcfN5GjQIhUV6pPE5xDLSY0GdsZmCJaEWrzx
        hMXIuEJT91fx9qEz67a/80zkXsd8Z7mSMKo7aPZUC9lkU13szh0SB44fvBptaGHo53T2+B4rnKJ5w
        2g62A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkVqJ-0007DG-3T; Tue, 31 Jul 2018 14:41:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D81C811242BD; Tue, 31 Jul 2018 15:41:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org
Subject: Applied "spi: dw: document Microsemi integration" to the spi tree
In-Reply-To:  <20180731143855.7131-2-alexandre.belloni@bootlin.com>
Message-Id: <20180731144142.D81C811242BD@debutante.sirena.org.uk>
Date:   Tue, 31 Jul 2018 15:41:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: document Microsemi integration

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

From f09757ab401ff332030f8e3a41cec6a44e6d9461 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 31 Jul 2018 16:38:53 +0200
Subject: [PATCH] spi: dw: document Microsemi integration

The integration of the Designware SPI controller on Microsemi SoCs requires
an extra register set to be able to give the IP control of the SPI
interface.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 204b311e0400..642d3fb1ef85 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,8 +1,10 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
-- compatible : "snps,dw-apb-ssi"
-- reg : The register base for the controller.
+- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
+  "jaguar2"
+- reg : The register base for the controller. For "mscc,<soc>-spi", a second
+  register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- 
2.18.0

