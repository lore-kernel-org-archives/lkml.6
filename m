Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeD3IZX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:25:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46961 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeD3IZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:20 -0400
X-Google-Smtp-Source: AB8JxZrKOT+91ym0W2k0xUD8rROeVXDi1LeEncrhCdAFp4fLAEaNfjKQdvOlh83lpyjBST9Kw4cipw==
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
Subject: [PATCH 01/12] mtd: nand: davinci: store the core chipselect number in platform data
Date: Mon, 30 Apr 2018 10:24:42 +0200
Message-Id: <20180430082453.8091-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We have the 'ti,davinci-chipselect' property in the device tree, but
when using platform data the driver silently uses the id field of
struct platform_device as the chipselect. This is confusing and we
almost broke the nand support again recently after converting the
platform to common clock framework (which changed the device id in the
clock lookup - the problem is gone now that we no longer acquire the
clock in the nand driver.

This patch adds a new filed - core_chipsel - to the platform_data.
Subsequent patches will convert the platforms to using this new field.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/mtd-davinci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/mtd-davinci.h b/include/linux/platform_data/mtd-davinci.h
index f1a2cf655bdb..879a59f97dac 100644
--- a/include/linux/platform_data/mtd-davinci.h
+++ b/include/linux/platform_data/mtd-davinci.h
@@ -56,6 +56,8 @@ struct davinci_nand_pdata {		/* platform_data */
 	uint32_t		mask_ale;
 	uint32_t		mask_cle;
 
+	uint32_t		core_chipsel;
+
 	/* for packages using two chipselects */
 	uint32_t		mask_chipsel;
 
-- 
2.17.0
