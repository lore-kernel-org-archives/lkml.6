Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A275C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C1B21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfBKQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:50:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36501 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfBKQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:50:16 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtEma-0000iW-1H; Mon, 11 Feb 2019 17:50:12 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 3/3] nvmem: imx-ocotp: broaden Kconfig dependency
Date:   Mon, 11 Feb 2019 17:50:11 +0100
Message-Id: <20190211165011.5114-3-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211165011.5114-1-l.stach@pengutronix.de>
References: <20190211165011.5114-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX OCOTP controller is used in numerous Freescale/NXP
SoCs from the MXC family, so the strict dependency on the
i.MX6 SoC is too narrow. Broaden it to cover all the MXC
familiy members.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/nvmem/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470ee859..665f2494095a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -25,8 +25,8 @@ config NVMEM_IMX_IIM
 	  will be called nvmem-imx-iim.
 
 config NVMEM_IMX_OCOTP
-	tristate "i.MX6 On-Chip OTP Controller support"
-	depends on SOC_IMX6 || COMPILE_TEST
+	tristate "i.MX 6/7/8 On-Chip OTP Controller support"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
-- 
2.20.1

