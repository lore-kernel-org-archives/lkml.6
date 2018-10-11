Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA0C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFB92075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Dy41Ttp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFB92075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJKW0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:26:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50308 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKW0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5eAST9ot5OoEgThXoaDbS4TmHolAHxmE7K4dc9ifqac=; b=Dy41Ttp2qgeC
        pu4pbprSwiK0oIHMJR4CmuHvFN2v7hTrQLr00PzyaHyY71RlfbBafYsuzlCHeL1sjqJvK4XGUq40Y
        U8RQ+CryAZdobza+JM6bQA+5TMlq2Y5/BR/V8ArhbRO9NJlKpip61tLevbeuXWvUFe4YxktDuUP9e
        lHN1Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcPx-0001uV-7F; Thu, 11 Oct 2018 14:58:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 00CC011223ED; Thu, 11 Oct 2018 15:58:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, jonnyc@amazon.com,
        ronenk@amazon.com, barakw@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>, linux-spi@vger.kernel.org
Subject: Applied "spi: dw: add compatible for Amazon's Alpine spi controller" to the spi tree
In-Reply-To:  <1539256807-25676-1-git-send-email-talel@amazon.com>
Message-Id: <20181011145825.00CC011223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:58:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: add compatible for Amazon's Alpine spi controller

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

From d49a30366793210cd64759edcdf7099a2e32efd6 Mon Sep 17 00:00:00 2001
From: Talel Shenhar <talel@amazon.com>
Date: Thu, 11 Oct 2018 14:20:06 +0300
Subject: [PATCH] spi: dw: add compatible for Amazon's Alpine spi controller

This compatible adds the ability for dw spi controller driver to work with
the dw spi controller found on Alpine chips.

The dw spi controller has an auto-deselect of Chip-Select, in case there is
no data inside the Tx FIFO. While working on platforms with Alpine chips,
auto-deselect mode causes an issue for some spi devices that can't handle
the Chip-Select deselect in the middle of a transaction. It is a normal
behavior for a Tx FIFO to be empty in the middle of a transaction, due to
busy cpu. In the Alpine chip family an option to change the default
behavior was added to the original dw spi controller to prevent this issue
of de-asserting Chip-Select once TX FIFO is empty. The change was to allow
SW manual control of the Chip-Select. With this change, as long as the
Slave Enable Register is asserted, the Chip-Select will be asserted. As a
result, it is necessary to deselect the Slave Select Register once the
transaction is done. This feature is enabled via a new device compatible
string called 'amazon,alpine-dw-apb-ssi'.  Once the driver identifies the
new compatible string, it enables the hw fixup logic, by writing to a
dedicated register found in the IP reserved area and will start manual
deselecting the Slave Select Register when the transfer ends.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 642d3fb1ef85..2864bc6b659c 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -2,7 +2,7 @@ Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
 - compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2"
+  "jaguar2", or "amazon,alpine-dw-apb-ssi"
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
-- 
2.19.0.rc2

