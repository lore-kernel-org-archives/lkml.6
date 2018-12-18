Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2860921841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLRQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:08:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36502 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbeLRQIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:08:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EEA9B20824; Tue, 18 Dec 2018 17:08:10 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3DE920834;
        Tue, 18 Dec 2018 17:07:58 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [RESEND PATCH v2 2/3] arm64: dts: fsl: ls1046a: disable the flash controller by default
Date:   Tue, 18 Dec 2018 17:07:48 +0100
Message-Id: <20181218160750.6766-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the Integrated Flash Controller status to disabled so each board has
the option to enable it. All the existing users have status = "okay" so
there is no functional change.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50012d6..90dc3b616ea7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -200,6 +200,7 @@
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		qspi: spi@1550000 {
-- 
2.20.0

