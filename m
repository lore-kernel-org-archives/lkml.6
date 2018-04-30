Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeD3I14 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:27:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44218 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeD3IZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:21 -0400
X-Google-Smtp-Source: AB8JxZp/S+cN8kCDPiohaVGQlsAfTBaEHUW9ia8k4Tb+/u96/gWdj6pSLe+ihMJk4Pedu8KFZIxNWA==
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
Subject: [PATCH 02/12] ARM: davinci: da830-evm: specify the chipselect in davinci_nand_pdata
Date: Mon, 30 Apr 2018 10:24:43 +0200
Message-Id: <20180430082453.8091-3-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index d283faefaf97..7cfb6f7e39e7 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -304,6 +304,7 @@ static struct davinci_aemif_timing da830_evm_nandflash_timing = {
 };
 
 static struct davinci_nand_pdata da830_evm_nand_pdata = {
+	.core_chipsel	= 1,
 	.parts		= da830_evm_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(da830_evm_nand_partitions),
 	.ecc_mode	= NAND_ECC_HW,
-- 
2.17.0
