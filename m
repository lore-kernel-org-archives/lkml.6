Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E104ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D857720657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D857720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbeGQPFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:05:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42435 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeGQPFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:05:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7DCE0208C4; Tue, 17 Jul 2018 16:32:06 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2F9CA206ED;
        Tue, 17 Jul 2018 16:31:56 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: [PATCH RESEND 1/5] spi: imx: Remove duplicate variable assignments
Date:   Tue, 17 Jul 2018 16:31:50 +0200
Message-Id: <20180717143154.28241-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields in struct spi_imx_data are assigned a different value twice
in a row, in spi_imx_setupxfer.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d3b21faf6b1f..d75153c995af 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1106,8 +1106,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
 		u32 mask;
 
-		spi_imx->dynamic_burst = 0;
-		spi_imx->remainder = 0;
 		spi_imx->read_u32  = 1;
 
 		mask = (1 << spi_imx->bits_per_word) - 1;
-- 
2.11.0

