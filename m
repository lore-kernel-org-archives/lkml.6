Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D52C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF4A2241D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="ZzjjuqQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4A2241D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeGELTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:19:08 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.130]:21136 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeGELTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789544;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OSVN2p69zXRHRFhYJukavhZUzoLmfc1FOo3vR1aDL4c=;
        b=ZzjjuqQVj2yVhyahnxDg9lbr04yJxuo8QewfeRNjldcqeVKqFmzd4P+AkgBDLWy3W7
        H6ayGbk19P6JBv682pJDZb2Xu4O0T4opruhgQO6+tjVySYPqc0vV393OLGpogL8QZVIP
        bU2YLldFj6W7qasXbRFDu6d+W86uJeHK1Xhgsi5iwPWYFXpYue+xzAN6+tA5heuTnMMA
        Escc52cAfPk7SYJbS/5Ss677pXX8BaTU57MdyPRSswidKicGD/kA7/x80duEt5WpAsVL
        //7/1F//vZ4eqp/GHhh3z94u7iE0JYgfOuFKiCbiDBJ2m94ITD2x4fUA1Q4cOW08E1Ke
        f0Ow==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BIT4iU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:18:29 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sumit Garg <sumit.garg@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip as it is not used
Date:   Thu,  5 Jul 2018 13:15:07 +0200
Message-Id: <1530789310-16254-12-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switching to the new FSL QSPI driver the property
'fsl,qspi-has-second-chip' is not needed anymore.

The driver now uses the 'reg' property to determine the bus and
the chipselect.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa..871189e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -247,7 +247,6 @@
 			clock-names = "qspi_en", "qspi";
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
 			big-endian;
-			fsl,qspi-has-second-chip;
 			status = "disabled";
 		};
 
-- 
2.7.4

