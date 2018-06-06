Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 457B7601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeFFJ3i (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:29:38 -0400
Received: from mx1.emlix.com ([46.4.235.150]:46994 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbeFFJ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:29:36 -0400
From: Philipp Puschmann <pp@emlix.com>
To: shawnguo@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, pp@emlix.com,
        linux-kernel@vger.kernel.org, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6SX_CLK_CKO1_SEL
Date: Wed,  6 Jun 2018 11:29:28 +0200
Message-Id: <20180606092928.11724-1-pp@emlix.com>
Organization: emlix gmbh, Goettingen, Germany
Sender: linux-kernel-owner@vger.kernel.org
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
