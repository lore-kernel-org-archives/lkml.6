Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C64C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639923FFC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4639923FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeGFNcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:32:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbeGFNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:32:07 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MFUge-1fN6xK0CjU-00ELHn; Fri, 06 Jul 2018 15:31:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA
Date:   Fri,  6 Jul 2018 15:30:48 +0200
Message-Id: <20180706133104.129049-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:wNv9Sv3K1g7i+aQP/a4XHyQRN95VwjEANy86niLpbGaR2FVnmZk
 Wwg7VYFJoMhZIek/uNBOS3Hp6c5BTnhRHL08LMYzsW/e0A3aIZN98vRNU48XBzg6SRYtCBA
 Ma801uNZwJocuhJAuFrcgZfA+7NSlPcubRNUEtN6mHqT3IU9XPeEr/4MZzoW3dArjjCzaiE
 sOuufs+YHzjMxYPyDNepw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O4XS8bgmlKA=:e7XV0AoGiv8kU8Cx8VVAL6
 XaO1cFgKNOOscJxmN30+QViJraOBjBaaYP2sg1M7hd1wdDrhD+BGFtK46Y8XOZ3J+3GBBciLf
 IU4X54cFwxeP0q9ODXHUoJBlA+o0dnEKynpNeeUWxI0v4wYCATx0CVZDUP8qhctzGlbY/9/w8
 vXT3I7wewf71hFLhmD/3Bn30wA7TaFcvebZ7QFq2fOEbvcvaNNRuiuYr3mlCAxfVKdy2ilxFi
 SBrxYABH0Sh0C6KKpphf1+UotaN6kPtRJRLETXygi581QRmsXw0nRLxosiagJNRagbfsErE8q
 TGVvcG8TIjemoBmRdPeltUvvdYtpSt7xP5tYvO/1ayk1RNfY1TawsFsrBlY6FJb6rRrXH7Gbs
 Rd8gs7VLKBn23aZO4rJJ/2mDQVwh+Lu/pIhu4nyCauwJIoJh7h6U6rf/Ry/pLSU2qGWmxNGOz
 sk+0f6JKLXWNZobv60r088xXpllEkNA5L3c75J/RIeCNplsD/hzO6oEZCCgz0QeWBGZVeWdec
 nzoG+o8vG0FX/sdrASmy3YF31T/KgDbeUdwYcEyD2QmGgTuwjKtJqqG1o+BDXkNljl7QQO5E1
 aw8ABixDnrltJQBozfIy3T7TBv68CMuoI8FHqPk01DhAlJfjAkfEuFOAVdb8PqwrwbSTs9+IL
 Uo6fQ6kiPyu21XL+YWUk9yOlTQy0WA6igFm+5OkTuu5xoKsJNLZNDqbo+fC77bdnAR8E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the moment, we can't enable CONFIG_SND_PXA_SOC_SSP unless we are
building for ARM PXA or MMP:

WARNING: unmet direct dependencies detected for PXA_SSP
  Depends on [n]: PLAT_PXA [=n]
  Selected by [y]:
  - SND_PXA_SOC_SSP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

This adds an explicit dependency for it.

Fixes: 0a94cf345740 ("ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 2fc02c227f69..776e148b0aa2 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -34,6 +34,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
+	depends on PLAT_PXA
 	select PXA_SSP
 	select SND_PXA2XX_LIB
 
-- 
2.9.0

