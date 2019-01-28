Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54555C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F1D2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="rcHZSc3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfA1QHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:07:30 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:44278 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbfA1QH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:07:27 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 389A15C12C0;
        Mon, 28 Jan 2019 17:07:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548691645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=1U/WijH2nR0SBxHUlsfoVbVuv72XV+2EhW2p1KqFEKY=;
        b=rcHZSc3z5n4+on+xtNKbcyumnlEpJLQP7WGERngc2A6vKFQ0a3ZD+0oNMlYNn0aosrgQOV
        1XVUOdOXmUE3i7ydQ3O3Ov7wp1CUnOBvdCkJ/yDWPZdcCmlqh9+8aJx2AiLMPpCekk76A5
        inCvhko0UNbAenJw7983wyuJJswvcWE=
From:   Stefan Agner <stefan@agner.ch>
To:     srinivas.kandagatla@linaro.org
Cc:     peng.fan@nxp.com, linux-imx@nxp.com, fabio.estevam@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] nvmem: allow to select i.MX nvmem driver for i.MX 7D
Date:   Mon, 28 Jan 2019 17:07:22 +0100
Message-Id: <20190128160722.23955-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx-ocotp nvmem driver supports the i.MX 7D SoC too. Allow to select
the imx-ocotp driver even if only the i.MX 7D SoC has been selected.

Fixes: 711d45477931 ("nvmem: octop: Add i.MX7D support")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470ee859..9bbe2816400a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -26,7 +26,7 @@ config NVMEM_IMX_IIM
 
 config NVMEM_IMX_OCOTP
 	tristate "i.MX6 On-Chip OTP Controller support"
-	depends on SOC_IMX6 || COMPILE_TEST
+	depends on SOC_IMX6 || SOC_IMX7D || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
-- 
2.20.1

