Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967759AbeEYSMK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:12:10 -0400
Received: from vern.gendns.com ([206.190.152.46]:46229 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967726AbeEYSMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:12:08 -0400
From: David Lechner <david@lechnology.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: David Lechner <david@lechnology.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups
Date: Fri, 25 May 2018 13:11:44 -0500
Message-Id: <20180525181150.17873-4-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525181150.17873-1-david@lechnology.com>
References: <20180525181150.17873-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkdev lookups for the ASP0/1 devices on TI DM355 were declared, but
not assigned to any LPSC. This assigns the clkdev lookups to the
correct LPSCs.

Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/clk/davinci/psc-dm355.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/psc-dm355.c b/drivers/clk/davinci/psc-dm355.c
index 6995ecea2677..128e7345b20c 100644
--- a/drivers/clk/davinci/psc-dm355.c
+++ b/drivers/clk/davinci/psc-dm355.c
@@ -41,14 +41,14 @@ static const struct davinci_lpsc_clk_info dm355_psc_info[] = {
 	LPSC(5,  0, timer3,      pll1_auxclk,  NULL,               0),
 	LPSC(6,  0, spi1,        pll1_sysclk2, spi1_clkdev,        0),
 	LPSC(7,  0, mmcsd1,      pll1_sysclk2, mmcsd1_clkdev,      0),
-	LPSC(8,  0, asp1,        pll1_sysclk2, NULL,               0),
+	LPSC(8,  0, asp1,        pll1_sysclk2, mcbsp1_clkdev,      0),
 	LPSC(9,  0, usb,         pll1_sysclk2, usb_clkdev,         0),
 	LPSC(10, 0, pwm3,        pll1_auxclk,  NULL,               0),
 	LPSC(11, 0, spi2,        pll1_sysclk2, spi2_clkdev,        0),
 	LPSC(12, 0, rto,         pll1_auxclk,  NULL,               0),
 	LPSC(14, 0, aemif,       pll1_sysclk2, aemif_clkdev,       0),
 	LPSC(15, 0, mmcsd0,      pll1_sysclk2, mmcsd0_clkdev,      0),
-	LPSC(17, 0, asp0,        pll1_sysclk2, NULL,               0),
+	LPSC(17, 0, asp0,        pll1_sysclk2, mcbsp0_clkdev,      0),
 	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
 	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
 	LPSC(20, 0, uart1,       pll1_auxclk,  uart1_clkdev,       0),
-- 
2.17.0
