Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeD3I1l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:27:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43407 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeD3IZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:22 -0400
X-Google-Smtp-Source: AB8JxZo0LDzjhPdPfAW1oSvEO+uadldboN/q17BeK+kWh1JwQOSy/eoCQ0yiKJlxyTFIRW/YCQY/Eg==
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
Subject: [PATCH 03/12] ARM: davinci: da850-evm: specify the chipselect in davinci_nand_pdata
Date: Mon, 30 Apr 2018 10:24:44 +0200
Message-Id: <20180430082453.8091-4-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da850-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 78a670aafea0..9f8041a0cf67 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -244,6 +244,7 @@ static struct davinci_aemif_timing da850_evm_nandflash_timing = {
 };
 
 static struct davinci_nand_pdata da850_evm_nandflash_data = {
+	.core_chipsel	= 1,
 	.parts		= da850_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(da850_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-- 
2.17.0
