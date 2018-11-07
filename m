Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E2F20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="PdWgkEI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E2F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbeKHA0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:26:41 -0500
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.130]:32733 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387788AbeKHA0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541602557;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7sISjrtZHwb4KNWDxD0+zIGjt4KLr0XgLY18GgBLMI0=;
        b=PdWgkEI7r2FkSn/NvNX5e4ipWJRCOBzh4emSRqYM0+dj60vdrz3xwGI/g+0fiL/dz/
        yu3uyuljtFKu3FcvoIdDyYc57gLg/PliD1D6BNcAmDMVlTfX0gcLD60aPzjdOt2WHwfJ
        ex/+eHQL2dUTDYm6H1/2myfJqgHJkaMlR5HQ94gZVbS2HD52p7JcjHEB8cXwQzFsqCM3
        KDqqOot1QYdiMdYvniDr6yQ5lhTOWbl9aS6a+sYz0XOZAU6tsfpHXWR8sf7bWR5v2bMO
        juEbLimix46jA24BUV849SSZCocNwMOrpS35FgRjgS5sdD+4xpi9Y8YdH6KMlxEQUuKY
        P6aA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx7ZdE8mPU5nMS5P2QgHAetWm5FNngAjmE0pFNjw="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4uA7EieUQu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 7 Nov 2018 15:44:40 +0100 (CET)
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
Subject: [PATCH v4 08/10] ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip as it is not used
Date:   Wed,  7 Nov 2018 15:43:25 +0100
Message-Id: <1541601809-16950-9-git-send-email-frieder.schrempf@kontron.de>
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

