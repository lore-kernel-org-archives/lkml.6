Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A358C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4C320C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4C320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJHXLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:11:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHXLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:11:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiMIY-1fWc0G0Pby-00fVlq; Mon, 08 Oct 2018 17:58:06 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiMIY-1fWc0G0Pby-00fVlq; Mon, 08 Oct 2018 17:58:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        ZH Chen <zh.chen@mediatek.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] pinctrl: mediatek: select GPIOLIB
Date:   Mon,  8 Oct 2018 17:57:43 +0200
Message-Id: <20181008155803.3322412-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:jKClmhriWAs+MlCh/VHoLgZ7FuufsHBdIdLZvnRc92T0PrIv2Mt
 pqnzDF1iDFmAT97BPTYruszKs2Dh1ryF4X/qvJdgURwDc+dWGibS7BFKm2dBCze2pmO6ZdL
 cOFgcSzqQ6tNEmqPNpKK17xgJaxUywUfukXVCUnEnaetOPP0dxOHRdlLDQCP4MSeV8af/mQ
 /1kxbiD1eEIaloqTeVYIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:se+1c5VYw8A=:mcRj2uevfsRj4JgRbeZt2O
 KlN6ebqNDMG12DmPGrc6I9HAOInKJY3WK/YXmrGCeL0oZBXSh8Tb2EPIw05HZIYKqdy7Cemfx
 mhaVebokG8CCV1uSaVfJDVPJm/BNYvN2kytlosFgBdutJgcD+dj7Bv7eHNegJGCZEWAW3W6+s
 03DCUDJ0oZcurkOpJHD9N7A4o5i7+j8QTq0HRIxwG9/GnN9l/8ut3pVX9pIcUQwLXjeoBz/L8
 5YH9fJn+bf2kP+rnlHlJrowjGM6b4ATF3dgsPYLs0RQmlC6XIzGkhw3L1Xb7YpnaXzoe60MI3
 Ekj8Nf56eokmSP2r/LR/N8El1iYT0av2ha5dPyVSKg7G2rbtgxUZNmKLvIBSQfJW7zcxusSaa
 VLtw+CiWtzxxiOgcfI6/6JelYswAVYg5xgp0+QLxQYYp78s6G5RcjLvSK7sqxEh/FkbjPugVw
 L+9vBkMScUDa84gzpdNOyLMSXpf4qt2AT7mfsBgHtGZEalMP4b0NMgh9ijxWeP49ua1WAiTh9
 sfsly1quxhB3NtLmbuJuxdYaH1Bns6P/PUG9Xyt3aLyOPWna7wUxOcbziGxWlNxFjy9n4Bxny
 uBjK0QEfEIaiz5lh1K8EhWCSUzR9a2oKiYbbX/6bpPb/QYAlearfYS7Y+E/dPHazt4axV51fo
 iYxO5bpXvOpB+ujDWCs/AG4Yoo3LehX90qMaZUMSicQzJrmrzID7W1PHSgENm2KfMxtU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the linux/gpio.h include means we no longer have a declaration
of gpiochip_lock_as_irq() when CONFIG_GPIOLIB is disabled:

drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_request_resources':
drivers/pinctrl/mediatek/mtk-eint.c:247:8: error: implicit declaration of function 'gpiochip_lock_as_irq'; did you mean 'spin_lock_irq'? [-Werror=implicit-function-declaration]
drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_release_resources':
drivers/pinctrl/mediatek/mtk-eint.c:272:2: error: implicit declaration of function 'gpiochip_unlock_as_irq'; did you mean 'spin_unlock_irq'? [-Werror=implicit-function-declaration]

Select it explictly instead.

Fixes: 1c5fb66afa2a ("pinctrl: Include <linux/gpio/driver.h> nothing else")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 05be5ddafec4..9d142e1da567 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -4,6 +4,7 @@ menu "MediaTek pinctrl drivers"
 config EINT_MTK
 	bool "MediaTek External Interrupt Support"
 	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
+	select GPIOLIB
 	select IRQ_DOMAIN
 
 config PINCTRL_MTK
-- 
2.18.0

