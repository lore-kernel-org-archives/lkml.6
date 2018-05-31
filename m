Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeEaLIY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:08:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51070 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754725AbeEaLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:06:41 -0400
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        kbuild test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: PCM1789: include gpio/consumer.h" to the asoc tree
In-Reply-To: <c99575a2-5172-b42e-dd18-6bc763fee361@infradead.org>
Message-Id: <E1fOLPg-00020r-K9@debutante>
Date: Thu, 31 May 2018 12:06:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: PCM1789: include gpio/consumer.h

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3217004ad97fdae6663e8e75c443d8e616cb7fd0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 23:53:45 +0200
Subject: [PATCH] ASoC: codecs: PCM1789: include gpio/consumer.h

When CONFIG_GPIOLIB is disabled, this codec fails to build
because gpio/consumer.h is not included implicitly.

sound/soc/codecs/pcm1789.c: In function 'pcm1789_common_init':
sound/soc/codecs/pcm1789.c:247:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
  pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
                   ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: 4ae340d1be36 ("ASoC: codecs: Add support for PCM1789")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.17.0
