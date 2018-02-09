Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeBIT3J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:29:09 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41543 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeBIT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:28:17 -0500
X-Google-Smtp-Source: AH8x226WmOYQ7ZtMsr5B6vEIJRRaGw6XQPNdWlW7vsG5T0p0R3hg+BervHK9qzdk2+CL7OpwWmeKlw==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 7/7] watchdog: coh901327: make use of timeout-secs provided in devicetree
Date: Fri,  9 Feb 2018 20:27:24 +0100
Message-Id: <20180209192724.1227-8-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209192724.1227-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

Following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt to make use of
the parameter logic.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/coh901327_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 4410337f4f7f..437f865e5c6b 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -67,7 +67,7 @@
 #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
 
 /* Default timeout in seconds = 1 minute */
-static unsigned int margin = 60;
+static unsigned int margin;
 static int irq;
 static void __iomem *virtbase;
 static struct device *parent;
-- 
2.15.1
