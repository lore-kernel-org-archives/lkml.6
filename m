Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeDXRq0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:46:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43894 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeDXRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:46:23 -0400
From: Mark Brown <broonie@kernel.org>
To: Sean Wang <sean.wang@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: include <linux/ktime.h> from include/linux/regmap.h" to the regmap tree
In-Reply-To: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
Message-Id: <E1fB218-0003Z3-Qt@debutante>
Date: Tue, 24 Apr 2018 18:46:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: include <linux/ktime.h> from include/linux/regmap.h

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

>From f15cd6d99198e9c15229aefec639a34a6e8174c6 Mon Sep 17 00:00:00 2001
From: Sean Wang <sean.wang@mediatek.com>
Date: Mon, 23 Apr 2018 14:42:44 +0800
Subject: [PATCH] regmap: include <linux/ktime.h> from include/linux/regmap.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similar to the readx_poll_timeout() macro calling ktime_* and using
ktime_t type, which is declared in <linux/ktime.h>. So, make
include/linux/regmap.h explicitly include <linux/ktime.h>, like
include/linux/iopoll.h does.  Otherwise, users of the macro will see
below errors.

error: implicit declaration of function ‘ktime_add_us’
[-Werror=implicit-function-declaration]

error: implicit declaration of function ‘ktime_get’
[-Werror=implicit-function-declaration]

error: implicit declaration of function ‘ktime_compare’
[-Werror=implicit-function-declaration]

include/linux/regmap.h:128:2: error: unknown type name ‘ktime_t’
  ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 5f7ad0552c03..b6865f070464 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/rbtree.h>
+#include <linux/ktime.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/bug.h>
-- 
2.17.0
