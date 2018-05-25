Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966676AbeEYPvA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:51:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:50:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/sun4i: mark PM functions as __maybe_unused
Date: Fri, 25 May 2018 17:50:08 +0200
Message-Id: <20180525155030.3667352-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:C/yJg6rPGXVjaNrv1fHhRuKBVYGdzfq1JK3YSQ2ZG+cGbZyTPs5
 vlmW8dyp6S5xpAU+GUJdaaXkpx/IW6hE7J7JWqJnhHhzqi+TUmPvwbSuhvsYZJJ5CWkNvP7
 QlR5SkT4YMx21P2Yfh3rO/1HpUxVjpjol3hXP4Mm6VmIp3+on0S4FX17TXVqmjZCGMItWGM
 stdvVRqNIlCxXZswkjoAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ICEUGuBysa0=:/RdXe88a1HgZl263Agmy5Z
 0cXfG3cm1jTHR1YFx1urayjBwQkg3oAt6ZvNJqaMIlbx2pGIEjL/q1Xv320Xw7irS0xlfPrpx
 bgTj1ZffVtZzHlJuw2RDEaOAKeAIkivyRHNMvxkIESLSAChrvJzKTqtP5AfRJQORXmzLsJ7p+
 By55q5S+kgz74c17SV+x9viTkZp8j6OjAZ2SUs0U60af0tnnqZlHamu8+1zUQTkOqqlQxanZO
 wDLcvC25ioOvOzg84wkXtt6i3VW2DlIytC37swbgMmTL5hAZD6QPLHavqpYLZcZbSw1IussuR
 1Zm9nQu0i3jA+k8BlJd8xWt6nTAkejuQVXwwXiJBys6NiEi25aYKfbtlqK6ECUpDN79pgidix
 ue0RlZA6UISdH8MstQA0RsZnD7egA07LQeozUSv/TNsRsZT9ugHZX0X/2E6DSofL978WrCfZI
 r/OFKqAQwLIrT95iEpR/a5TkFF2lw2inpe61fQpbFlnUKK7e76XibMVF/jmOVjDWeI8McOJvP
 eR8GPtDsUNNKGcMS4MGvNSiDdI151WJer0qY+GZIovRHoENkB5XQTmGpF5XAkAnR1QLPMASUH
 LoqzWM14n4rphxSD+4lzY7ddEWxZU0zKrNyQ+hXwZ9A3bgRQydq33XVS4C2t+rChdDu2VuPKV
 C8jAPW0gkAlAx2sWkJyXtaQgQ5OkkF8biBEIjR3kB6w0F3uPURACiXKAatrfltVk3fZA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling CONFIG_PM produces a compile time warning when these
functions are not referenced:

drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1072:12: error: 'sun6i_dsi_runtime_suspend' defined but not used [-Werror=unused-function]
 static int sun6i_dsi_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1043:12: error: 'sun6i_dsi_runtime_resume' defined but not used [-Werror=unused-function]
 static int sun6i_dsi_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index bfbf761f0c1d..d4e7d16a2514 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1040,7 +1040,7 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun6i_dsi_runtime_resume(struct device *dev)
+static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1069,7 +1069,7 @@ static int sun6i_dsi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun6i_dsi_runtime_suspend(struct device *dev)
+static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-- 
2.9.0
