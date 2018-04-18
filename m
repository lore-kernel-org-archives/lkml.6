Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeDRMxA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:53:00 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36556 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeDRMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:52:58 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de
Cc: fabio.estevam@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] clk: imx6ul: fix periph clk2 clock mux selection
Date: Wed, 18 Apr 2018 14:52:54 +0200
Message-Id: <20180418125254.4397-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the data sheet the 3rd choice is the bypass clock
of pll2. This should not have any effect in practice as this
selection is not used currently.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 12320118f8de..2ed7dae39008 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -40,7 +40,7 @@ static const char *axi_alt_sels[] = { "pll2_pfd2_396m", "pll3_pfd1_540m", };
 static const char *axi_sels[] = {"periph", "axi_alt_sel", };
 static const char *periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll2_198m", };
 static const char *periph2_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll4_audio_div", };
-static const char *periph_clk2_sels[] = { "pll3_usb_otg", "osc", "osc", };
+static const char *periph_clk2_sels[] = { "pll3_usb_otg", "osc", "pll2_bypass_src", };
 static const char *periph2_clk2_sels[] = { "pll3_usb_otg", "osc", };
 static const char *periph_sels[] = { "periph_pre", "periph_clk2", };
 static const char *periph2_sels[] = { "periph2_pre", "periph2_clk2", };
-- 
2.17.0
