Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeCWQgJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:36:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37799 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeCWQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:34:59 -0400
X-Google-Smtp-Source: AG47ELurtOVrGk7sIWRHsYTZMGGbEH/p1yKHR031w9AK255350OCRD2Yl/nNoEZ0ZRhSx74jH4P8NQ==
From: Stephen Boyd <swboyd@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/5] gpiolib: Change bitmap allocation to kmalloc_array
Date: Fri, 23 Mar 2018 09:34:51 -0700
Message-Id: <20180323163453.96495-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to clear out these bits when we set them immediately
after. Use kmalloc_array() to skip clearing the bits.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cc0e1519da45..db3788d17ba0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -341,7 +341,7 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
 {
 	unsigned long *p;
 
-	p = kcalloc(BITS_TO_LONGS(chip->ngpio), sizeof(long), GFP_KERNEL);
+	p = kmalloc_array(BITS_TO_LONGS(chip->ngpio), sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-- 
Sent by a computer through tubes
