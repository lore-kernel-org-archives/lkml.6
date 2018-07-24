Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6D9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D638E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D638E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbeGXNDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:03:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbeGXNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:03:54 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LpzzH-1gAvVU2V0h-00fiLG; Tue, 24 Jul 2018 13:57:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: mediatek: include chained_irq.h header
Date:   Tue, 24 Jul 2018 13:57:10 +0200
Message-Id: <20180724115722.1274065-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:pu6z03XZYAUPwPYaCMvSunngiXwsf9+Yh0/GFGUJKD1z9joMbct
 /+zlggqTGROD5zoEHJ4FUqWpsNg7GtFoehaiPlWPmj0Dpel8+ew656R60sdS77+vOSt3z/j
 dyXWw1Zwr7cfu7eEReOOA+QbbDpbpu3C6fEBdUjCc4ieUFkPa6VzCzi0nKWaRLHEHEAzOPt
 BBwiCSfDfTyo9iUjBo0eQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5CYKAEnta/Y=:+3cjpHxBhSvk+xZOskHK6n
 X2qK19CWH7FDdguTknbY9AMhh5a3p0agC18Xiv6PCtVIdS1RfH6axjPuID2Tm3Ki4suekIpPJ
 ZbW8L3kjpYM7QcbOgT/BmT3ls8WujBM5hz1gx7jcrDcrLioF5JQ4CLNHk5VKQX7Q0a2enYNQx
 +QlO/TjBilyglIiaUVaVTzNDDGG9Tnlx9T7MixlbJE9KHDHPtq5IhKliUyZdmZ9eAsN93UvGw
 7psxex/reWnvDM6zqwWQOHS+uNKP32P54NVOz9TydZFIzJHk/HUlkbqSeT4YggowJvXt14d5Y
 cTY6Jc0TZFG4KkR3sNan35OeuCqs2eFUqOMLnWILCzs98AWZ8FAIS0G5+eMF4t/2FeC391TfU
 wJ+wXoE/cDnRd8Q0bVWwFZ4z4F9SI3OaBwbvgnbJ6K9hO9NgrVBT0rV260h3CUlLf7yXCV5dS
 F747B0p18RwBWNn+CG6By+kdauERy/v/rwFica7pukImyBUnHHoXhtoP9NdVWEiROEGlavZDH
 ctON1ZQDen9XT4lMmz1vi5lFWQxrtNzPCFJglMPM81iLPb+mOKbjCzEaqEZ9Ys425mIe6n+0m
 zJPGv1VtWj9TAkM23nQxHQTGIO908GlgVxRPy7/D97QxR+YJjk/A739UHAXA4lcRQjKvpOBkN
 Xp8GPauCwqY8tH5nWkxGv0aKPuAFTYdzPXMgag0ZKrdnsialCSJzAqX7JIN5H9oS3j4M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some randconfig builds fail in the mtk-eint driver:

drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_handler':
drivers/pinctrl/mediatek/mtk-eint.c:324:2: error: implicit declaration of function 'chained_irq_enter'; did you mean 'rcu_irq_enter'? [-Werror=implicit-function-declaration]
  chained_irq_enter(chip, desc);
  ^~~~~~~~~~~~~~~~~
  rcu_irq_enter
drivers/pinctrl/mediatek/mtk-eint.c:367:2: error: implicit declaration of function 'chained_irq_exit'; did you mean 'rcu_irq_exit'? [-Werror=implicit-function-declaration]

The functions are declared in linux/irqchip/chained_irq.h, and including
that header makes it build in all configurations.

Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/mediatek/mtk-eint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index 30f3316747e2..a613e546717a 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
-- 
2.18.0

