Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C518C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD182085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="FM5RR2q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD182085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbeKHA0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:26:30 -0500
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.131]:11573 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:26:30 -0500
X-Greylist: delayed 697 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 19:26:29 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541602547;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=XkGBjJenHm2QpptULfwOGIIWUgS2xw1ZDpOajROzyuQ=;
        b=FM5RR2q/TB3ivBD1El4Ka1x2y+anEzth9FworSJpEY33QlvVhZyU29qteE4Kaf8BFV
        XzXspXSro2OIMQWYByzlLk0PXtv8xN8U0Q0HSpAEYgVnLfd0BfXaR/uXTwRHif+V3FVC
        b/9NHJS6mobt4EYntCfNW70sBayKx/DUYI9UY1Ig6uFTSqM1GxpWBrx+2gz0jb2Ocq5U
        aL06c7AZbVPZInCjkxWb6RcGR6FW837hiGiVAC7WR0MUpeLg/pDiabo7JGDf5l45LhTT
        RDq7rPIFa1JWhc1fiKiMDQDDilx/MTzO0OHFvF5L9oUrZeBWQeisLT5nASVfrNABE7xH
        +twQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx7ZdE8mPU5nMS5P2QgHAetWm5FNngAjmE0pFNjw="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4uA7EijUR0
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 7 Nov 2018 15:44:45 +0100 (CET)
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/10] ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip as it is not used
Date:   Wed,  7 Nov 2018 15:43:26 +0100
Message-Id: <1541601809-16950-10-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@exceet.de>

After switching to the new FSL QSPI driver the property
'fsl,qspi-has-second-chip' is not needed anymore.

The driver now uses the 'reg' property to determine the bus and
the chipselect.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50..9e083f6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -213,7 +213,6 @@
 			clock-names = "qspi_en", "qspi";
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
 			big-endian;
-			fsl,qspi-has-second-chip;
 			status = "disabled";
 		};
 
-- 
2.7.4

