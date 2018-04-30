Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeD3I0d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:26:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39002 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeD3IZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:29 -0400
X-Google-Smtp-Source: AB8JxZpPbX1Ynit0Jdc8d9PrWQARugMNeOYQwAeBU8bLBcSIkLEaBxhN986+9Se16efKT6f0AyF5uw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/12] ARM: davinci: mityomapl138: specify the chipselect in davinci_nand_pdata
Date: Mon, 30 Apr 2018 10:24:49 +0200
Message-Id: <20180430082453.8091-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have the core_chipsel field in davinci_nand_pdata. Use it
instead of the platform_device id number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index f442784eded3..2cce0d7d2f2a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -400,6 +400,7 @@ static struct mtd_partition mityomapl138_nandflash_partition[] = {
 };
 
 static struct davinci_nand_pdata mityomapl138_nandflash_data = {
+	.core_chipsel	= 1,
 	.parts		= mityomapl138_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(mityomapl138_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-- 
2.17.0
