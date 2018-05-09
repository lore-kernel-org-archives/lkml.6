Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756585AbeEIOKu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:10:50 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:53735 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756457AbeEIOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:10:28 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>, <linux-gpio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] pinctrl: nand: meson-gxbb: fix missing data pins
Date: Wed, 9 May 2018 22:08:26 +0000
Message-ID: <20180509220827.22286-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509220827.22286-1-yixun.lan@amlogic.com>
References: <20180509220827.22286-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data pin 0-7 of the NAND controller are actually missing from
the nand pinctrl group, so we fix it here.

Fixes: cd1e3b01c7d3 ("pinctrl: amlogic: gxbb: add nand pins")
Reported-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 9079020259c5..2c97a2e07a5f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -627,8 +627,8 @@ static const char * const sdio_groups[] = {
 };
 
 static const char * const nand_groups[] = {
-	"nand_ce0", "nand_ce1", "nand_rb0", "nand_ale", "nand_cle",
-	"nand_wen_clk", "nand_ren_wr", "nand_dqs",
+	"emmc_nand_d07", "nand_ce0", "nand_ce1", "nand_rb0", "nand_ale",
+	"nand_cle", "nand_wen_clk", "nand_ren_wr", "nand_dqs",
 };
 
 static const char * const uart_a_groups[] = {
-- 
2.17.0
