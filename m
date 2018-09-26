Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A13C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91BC20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91BC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeIZTOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:14:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:14:09 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N18MG-1fbySb48KI-012aR3; Wed, 26 Sep 2018 15:00:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Florian Meier <florian.meier@koalo.de>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency
Date:   Wed, 26 Sep 2018 14:59:40 +0200
Message-Id: <20180926125957.2256982-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:H2e98QPkV/fyrevHDdROE0QZ7aPAqSjvNB6QFl1C60gyOS/Djo/
 q2D2sZlyGGl20SeeE3MUKxv3eFgeiKKIVNS7LD7gIJ6Ra/YdJDFNeH4061uFH7Cb1BrpWCr
 0vzNbxg3Vdx/wx49I+PIV5DGHSirviV+emrUEimWClimB3/pvNc7SCGQxgETiwB7LjVIA6y
 nrZ6JOE+9uM3WloTmLHUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gEvw0M90P7s=:uUMQRZfBzG8FXMGzziK6ah
 wq6h6CZLpKabiOsg3jtLOZfKOYHvrmMDkRZx9YENx8UwsKB6HoNOBevOqJqVXGI2f+iMCGCZH
 XBTr/Gq4ZvGPS3o363JazVB9UUOvIeUkVa6j3wR60vPYalZRNTEtWlvj58KefhUwdQ0r0n9yw
 Hw4dPjMRmjEyZJd8V75sQXOvEaxVk79sLyvjKM6WRaws/YWYhRDEZYRqVg6y805QFkLWb57jn
 NHjd80g9QySoiW893pSvlWmYqdaGC0Ll9tXXbAgXy8dhkek+FaS+BWVthHwTa2GHRJfy2wCZG
 n0yL7JuoItb9spD/sqvKkHvqsKpju/5VGek9AlrX2BBm0XEz1ftmke5AEQnSWCZ43TbcBLZpN
 VlXVT3NdOBWQgxQBr6/8/Eo8kqbz7x8rz33wS7+rN/fuTEmP7lYIimiMP3QbYsde5zNejdC0i
 NB4BVwM02SCLCgwP2el53symfFx902+t2A0KANTBt81hNhs9NZxDcwTersP6R9Bbb6/4c88WN
 lx+KoctiWNyyuMWD8cAUbFXw4j+oaJAnrUr13YDJcc7zkUNkbHP6EWe1GI/+YEjf3dQho62st
 JT1KAlquxzhjFYtF/RacVsRxZwH1awz+aAbUs+wmp8Siu6DSCvd0z5Tr8k4a5dCJKygeqMVFa
 6CUFkmKVG/9qCL40SJpXWtKcGtBNs5gkJDYF+D5jsCsdoBoQ0Wj7RW2lw0OMaYnvm6M8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting SND_SOC_WM8731 is only allowed when all its dependencies
are already there:

WARNING: unmet direct dependencies detected for SND_SOC_WM8731
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=m]
  Selected by [y]:
  - SND_SOC_MIKROE_PROTO [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && OF [=y]
  Selected by [m]:
  - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && (ARCH_AT91 [=y] || COMPILE_TEST [=y]) && ATMEL_SSC [=y] && SND_SOC_I2C_AND_SPI [=m]
  - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMPILE_TEST [=y] && SND_SOC_I2C_AND_SPI [=m]

Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/atmel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 81a0712d4f14..64f86f0b87e5 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -101,6 +101,7 @@ config SND_ATMEL_SOC_I2S
 config SND_SOC_MIKROE_PROTO
 	tristate "Support for Mikroe-PROTO board"
 	depends on OF
+	depends on SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8731
 	help
 	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
-- 
2.18.0

