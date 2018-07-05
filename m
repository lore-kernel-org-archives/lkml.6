Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108FD2241D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="iOD11cCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108FD2241D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeGELSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:18:53 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.131]:28843 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeGELSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530789526;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zs/YevK2K32CcF3EeD2mz043+fLTwED17u5t/DPU2oY=;
        b=iOD11cCJYfboeabndj6WSJisEQZjJ8oWGVmiRzxKLjiDfHfQTU9jx68UGFUss29PYq
        9WBrDE2aRjRNyoc2biJXKFNoeAPU/XUTm3xN0KDyHgZSvLR11elMtdCtRxVRZ8t4nHd7
        vcMLElp6i7sFMzHeGdatOmt2/zpfCfP8TwlAGD3iHe+npnmHApBO2iej2DGLJinx9c0F
        KN/1j0CjfIpQVaJH5F3PnBHMg1XeOqWgDQGI6LRG8l537d3i0QFBZ+9tpU8NEaC19YoM
        2uC/smfNEHjbCoWS+AkQEHo9ZF0/PyguILNkrOhk7/9k22zf3Q/+1wOz3hgP7WQwMXqs
        2MXg==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+daE87UU5bgm7XHzClQnm8VxHglxo5wj3H1fls="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id a0925bu65BIF4iQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 13:18:15 +0200 (CEST)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip as it is not used
Date:   Thu,  5 Jul 2018 13:15:06 +0200
Message-Id: <1530789310-16254-11-git-send-email-frieder.schrempf@exceet.de>
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
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index 6a83f30..d3a1a73 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -203,7 +203,6 @@
 };
 
 &qspi {
-	fsl,qspi-has-second-chip;
 	status = "okay";
 
 	flash: flash@0 {
-- 
2.7.4

