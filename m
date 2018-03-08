Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeCHJDW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:03:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37462 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeCHJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:03:12 -0500
X-Google-Smtp-Source: AG47ELugxI3lqe9XKv4lqKBAJ9NYOfrGk5dJKk1VqQrOOWvp5qkPpqZdPiXti4o0WNE6fnYxnY7gAA==
From: Richard Genoud <richard.genoud@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] clk: mvebu: armada-38x: add support for missing clocks
Date: Thu,  8 Mar 2018 10:03:00 +0100
Message-Id: <20180308090300.23544-1-richard.genoud@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearfog boards can come with a CPU clocked at 1600MHz (commercial)
or 1333MHz (industrial).

They have also some dip-switches to select a different clock (666, 800,
1066, 1200).

The funny thing is that the recovery button is on the MPP34 fq selector.
So, when booting an industrial board with this button down, the frequency
666MHz is selected (and the kernel didn't boot).

This patch add all the missing clocks.

The only mode I didn't test is 2GHz (uboot found 4294MHz instead :/ ).

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/clk/mvebu/armada-38x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/armada-38x.c b/drivers/clk/mvebu/armada-38x.c
index 394aa6f03f01..9ff4ea63932d 100644
--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -46,11 +46,11 @@ static u32 __init armada_38x_get_tclk_freq(void __iomem *sar)
 }
 
 static const u32 armada_38x_cpu_frequencies[] __initconst = {
-	0, 0, 0, 0,
-	1066 * 1000 * 1000, 0, 0, 0,
+	666 * 1000 * 1000,  0, 800 * 1000 * 1000, 0,
+	1066 * 1000 * 1000, 0, 1200 * 1000 * 1000, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
 	1600 * 1000 * 1000, 0, 0, 0,
-	1866 * 1000 * 1000,
+	1866 * 1000 * 1000, 0, 0, 2000 * 1000 * 1000,
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
@@ -76,11 +76,11 @@ static const struct coreclk_ratio armada_38x_coreclk_ratios[] __initconst = {
 };
 
 static const int armada_38x_cpu_l2_ratios[32][2] __initconst = {
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {1, 2}, {0, 1},
+	{1, 2}, {0, 1}, {1, 2}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {1, 2},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
@@ -91,7 +91,7 @@ static const int armada_38x_cpu_ddr_ratios[32][2] __initconst = {
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{1, 2}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {7, 15},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
