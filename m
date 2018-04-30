Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeD3I1J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:27:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33130 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeD3IZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:26 -0400
X-Google-Smtp-Source: AB8JxZq+2WIeKMrgOj68AYeMhIkcerU2/QrBDWh19sPdE44DtaeUMYwbuMtTBpIeMYP+kNaR/eLxvg==
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
Subject: [PATCH 06/12] ARM: davinci: dm365-evm: specify the chipselect in davinci_nand_pdata
Date: Mon, 30 Apr 2018 10:24:47 +0200
Message-Id: <20180430082453.8091-7-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 36b69a131cfa..307e88d99dd3 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -138,6 +138,7 @@ static struct mtd_partition davinci_nand_partitions[] = {
 };
 
 static struct davinci_nand_pdata davinci_nand_data = {
+	.core_chipsel		= 0,
 	.mask_chipsel		= BIT(14),
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
-- 
2.17.0
