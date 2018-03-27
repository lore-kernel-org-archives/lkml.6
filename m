Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeC0JU4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:20:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35346 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeC0JUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:20:48 -0400
X-Google-Smtp-Source: AG47ELuLbk5eUrYXbwiOSiNZx9BXKYfh2I87fiw6PoJ9+Ze9MjuRHNxnjFrAjnG/0vB12TOP1TQg6g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 8/8] clk: davinci: kill davinci_clk_reset_assert/deassert()
Date: Tue, 27 Mar 2018 11:20:31 +0200
Message-Id: <20180327092031.11251-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This code is no longer used. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/include/mach/clock.h | 21 ---------------------
 drivers/clk/davinci/psc.c                  | 18 ------------------
 2 files changed, 39 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

diff --git a/arch/arm/mach-davinci/include/mach/clock.h b/arch/arm/mach-davinci/include/mach/clock.h
deleted file mode 100644
index 42ed4f2f5ce4..000000000000
--- a/arch/arm/mach-davinci/include/mach/clock.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-davinci/include/mach/clock.h
- *
- * Clock control driver for DaVinci - header file
- *
- * Authors: Vladimir Barinov <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_DAVINCI_CLOCK_H
-#define __ASM_ARCH_DAVINCI_CLOCK_H
-
-struct clk;
-
-int davinci_clk_reset_assert(struct clk *c);
-int davinci_clk_reset_deassert(struct clk *c);
-
-#endif
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 063df62381ea..75c4bc6f23e3 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -295,24 +295,6 @@ static int davinci_lpsc_clk_reset(struct clk *clk, bool reset)
 	return 0;
 }
 
-/*
- * REVISIT: These exported functions can be removed after a non-DT lookup is
- * added to the reset controller framework and the davinci-rproc driver is
- * updated to use the generic reset controller framework.
- */
-
-int davinci_clk_reset_assert(struct clk *clk)
-{
-	return davinci_lpsc_clk_reset(clk, true);
-}
-EXPORT_SYMBOL(davinci_clk_reset_assert);
-
-int davinci_clk_reset_deassert(struct clk *clk)
-{
-	return davinci_lpsc_clk_reset(clk, false);
-}
-EXPORT_SYMBOL(davinci_clk_reset_deassert);
-
 static int davinci_psc_reset_assert(struct reset_controller_dev *rcdev,
 				    unsigned long id)
 {
-- 
2.16.1
