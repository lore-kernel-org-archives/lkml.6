Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lm1ILTFYGlvgTwAAmS7hNA
	; Fri, 08 Jun 2018 10:19:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 387A1607E4; Fri,  8 Jun 2018 10:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B7E2B60590;
	Fri,  8 Jun 2018 10:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7E2B60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeFHKT3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:19:29 -0400
Received: from mx1.emlix.com ([46.4.235.150]:35004 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbeFHKT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:19:28 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 5D86825F2A7;
        Fri,  8 Jun 2018 12:19:26 +0200 (CEST)
Received: by mailer.emlix.com
        id 1fREUQ-0003cZ-Kw; Fri, 08 Jun 2018 12:19:26 +0200
From: Philipp Puschmann <pp@emlix.com>
To: shawnguo@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, pp@emlix.com,
        linux-kernel@vger.kernel.org, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
Date: Fri,  8 Jun 2018 12:19:24 +0200
Message-Id: <20180608101924.31195-1-pp@emlix.com>
Organization: emlix gmbh, Goettingen, Germany
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q/dl datasheets list the 5th selection value for ck01_sel as
video_27M_clk_root.

By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
as parent for IMX6QDL_CLK_CKO1_SEL.

Signed-off-by: Philipp Puschmann <pp@emlix.com>
---
 drivers/clk/imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d518ad5dc13..7e6a8f079634 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -65,7 +65,7 @@ static const char *ipg_per_sels[] = { "ipg", "osc", };
 static const char *ecspi_sels[] = { "pll3_60m", "osc", };
 static const char *can_sels[] = { "pll3_60m", "osc", "pll3_80m", };
 static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video_div",
-				    "dummy", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
+				    "video_27m", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
 				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio_div", };
 static const char *cko2_sels[] = {
 	"mmdc_ch0_axi", "mmdc_ch1_axi", "usdhc4", "usdhc1",
-- 
2.17.0
