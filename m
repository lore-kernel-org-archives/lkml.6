Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeE3VyT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:54:19 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbeE3VyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:54:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: PCM1789: include gpio/consumer.h
Date: Wed, 30 May 2018 23:53:45 +0200
Message-Id: <20180530215407.1196429-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Rx9WLGTgobRy7l3v6hsbyoB0dPRPxEzWrQiatF8IBzCHqQWpRNT
 XR6Ck4ubwHkEJI+FY+y5KBEpXfDsdhNkMcvPwKL9Agx42FNfP2jVVjU34f1kSXFiuzr2zzB
 vT1ycdCHjuEcIFJeYiDbmAdt20+gR3YT/m1YqgwtZzuUdEnYBJyzh/hoUp+s0psosf7/8K0
 s73t2m588TNKF0/M5rWZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OwHvio7rd9I=:qY6yKCpHM+5rrBQcm+Nq7e
 u+SiH+iR9Q2F9gbcUyXzTVLIe6++DyLdQtStjnfVlIISp4+QxpJdk7ZAxJS6XXOpoQ1v+aCPV
 byWSBfqJ7baxafb2+xWFH+QYBuOCZ/2AYEkzswvDnd42nY4t4WNi2etbZrRUyjtSqJFABo9aj
 HRvSMu0XSmZAj8pPwFMI3hAprnPEk4hc4q6pMWrbLBzChCYloE3dKkzJEi2pDAsep6QQgg4rf
 FxznIgHOD+tfwBQh4sJtP1KBlYO23rqOFKM32ucFKs7psflFpTVFtF0QFt4VniZVhhY5SfDkf
 asvCElGlgc36BhIoJcQZF7Ubg6ZJntlqaqmvzi/3jJ9G2hS0SksRGMR7ERif/RpIxc+Ly9X8e
 DU2UUxU0ZEGXDR9klKOak9luL0vNhrj5q2cqSBwhNcGLnaVhNsOB8/qtohFdddNv0xMgY4yaB
 VLqD1zEcLDBngAvWrvGM3hznB9yLt1F6FkRW4XtG5vneceLIYpV3aUMxd17RgvRS9hjP7v1Qi
 J60CPmr2TwYO1YAf7aL5q76Bd8jB7JQEsv9oSiYGtYOecchcZEmTT2YDATMioolqZb/QNkoDv
 CTDpscUAqUFzC9FiLLmMTz7bBiwHrCuw9RiFGHLXC8RP7qXCZZFKyFFZvUmbw6kUZaCqP4lbm
 wglWvcuYeFxvhRuxkHsm0begb/6OFASy3qBoXqVPpus5zda83aYL+2AbENBNkqOxVKS/vkQ73
 9i2S5e+uNj6ulRul
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_GPIOLIB is disabled, this codec fails to build
because gpio/consumer.h is not included implicitly.

sound/soc/codecs/pcm1789.c: In function 'pcm1789_common_init':
sound/soc/codecs/pcm1789.c:247:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
  pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
                   ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: 4ae340d1be36 ("ASoC: codecs: Add support for PCM1789")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/pcm1789.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
index 507ac9412d6c..21f15219b3ad 100644
--- a/sound/soc/codecs/pcm1789.c
+++ b/sound/soc/codecs/pcm1789.c
@@ -3,7 +3,7 @@
 // Copyright (C) 2018 Bootlin
 // Mylène Josserand <mylene.josserand@bootlin.com>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/workqueue.h>
 
-- 
2.9.0
