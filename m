Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeCWQfB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:35:01 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42847 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCWQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:34:57 -0400
X-Google-Smtp-Source: AG47ELs2UXdPd98Z9Mgxkyjerrplp698cKmP+M/g+F0CbCNntEqvZhXM4vFzKSQQ2uJ16TvEy81BbA==
From: Stephen Boyd <swboyd@chromium.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/5] dt-bindings: gpio: Add a gpio-reserved-ranges property
Date: Fri, 23 Mar 2018 09:34:49 -0700
Message-Id: <20180323163453.96495-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Some qcom platforms make some GPIOs or pins unavailable for use
by non-secure operating systems, and thus reading or writing the
registers for those pins will cause access control issues.
Introduce a DT property to describe the set of GPIOs that are
available for use so that higher level OSes are able to know what
pins to avoid reading/writing.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/gpio/gpio.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index b5de08e3b1a2..a7c31de29362 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -151,9 +151,9 @@ in a lot of designs, some using all 32 bits, some using 18 and some using
 first 18 GPIOs, at local offset 0 .. 17, are in use.
 
 If these GPIOs do not happen to be the first N GPIOs at offset 0...N-1, an
-additional bitmask is needed to specify which GPIOs are actually in use,
-and which are dummies. The bindings for this case has not yet been
-specified, but should be specified if/when such hardware appears.
+additional set of tuples is needed to specify which GPIOs are unusable, with
+the gpio-reserved-ranges binding. This property indicates the start and size
+of the GPIOs that can't be used.
 
 Optionally, a GPIO controller may have a "gpio-line-names" property. This is
 an array of strings defining the names of the GPIO lines going out of the
@@ -178,6 +178,7 @@ gpio-controller@00000000 {
 	gpio-controller;
 	#gpio-cells = <2>;
 	ngpios = <18>;
+	gpio-reserved-ranges = <0 4>, <12 2>;
 	gpio-line-names = "MMC-CD", "MMC-WP", "VDD eth", "RST eth", "LED R",
 		"LED G", "LED B", "Col A", "Col B", "Col C", "Col D",
 		"Row A", "Row B", "Row C", "Row D", "NMI button",
-- 
Sent by a computer through tubes
