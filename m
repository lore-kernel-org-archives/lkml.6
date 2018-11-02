Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B66D20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B66D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKBU2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:28:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBU2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:28:49 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MSKly-1g7aEs36E4-00Sfre; Fri, 02 Nov 2018 12:20:58 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MSKly-1g7aEs36E4-00Sfre; Fri, 02 Nov 2018 12:20:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: pxa: change ac97 dependencies
Date:   Fri,  2 Nov 2018 12:20:39 +0100
Message-Id: <20181102112055.659197-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:ESqNhR/pZIkwUiJzsNsw109mDWNtgeDa26qYuT02SK8cuyfEmct
 FNtOVObVUeR9aw+CVyloUj+FFwO/MhTn7aWBAeO0zgDTJzy/ibGDTR4uprlGzUxhISxKSRB
 RRFKJIB4LXBquPPIH6TPXtN8rTzts1tOFWHwZ+Ui9BJlQVEJOgPDn8r6B8lkzPHA+rwaDdE
 IX09MIBeVZJk/6lVJBgMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gZ6fwWnECpI=:3BrnEWfYsZQu6elAT4zEAY
 PkQUw2doxPKEy12uRO65xi3V5RRA+RL/CZvMKjibcKJbgAUpY4O7b7FxfbojG8kBjD+XQnvUV
 SLySL7UPlqeiEePT9oMYehvHVPpETfo+HuJFTKitCv1y9YYJ3eAZOWxKjDZ/6VB7LwG9vFZGm
 G+Vp9Gwy897yrcH912z3T+LjCaOTUWyyHvsNH442hFnFz2la0aw4OIj7h+KE3ZuYzJCjGfoTg
 CFkwviJLDH5xg/PP+n5EkU7KwIjMjT6oZBuSH1BSbYlKpDf9vx60lsCuwlDkNYewc84lQGsn8
 4H7CQD4ZAXUF8QBd0tRF8Q4tKJ+ZABP+7GEl0a5MCbv8BCeVPZKOI8WVZFEaIu7f+5gq17Zyq
 rH3JtaD2+yc2E8Q4vEYOwWJcJRvEmW8sn50nF+gmI1mKOhCWtA8TEF+hHAsv0xWyLMJzPv4H4
 jYiXZezCJd5orIvMLmmwm4O/DBbqqKNQPWGQNdbaYzhyFbd9yObKnzZTRrXKZZ1gKT0tvI5Fj
 DIvwpjJVBvemM5/j40KEuwcSh0lArMQA2SFJTBb88VY4W85dJYijnspZQCP0XfciQI1K7hqzp
 xBfYCwoBRkt75hvYTVY5PjjdI2iIpFrWF3yvc18uS1+jLFxhZnxID5XvpzbhJLC5tLSOgB54f
 lwZc1x4nNB8Xt0j8CYdr0FofJ3579owU9b6MAMncK9uhVSas5nEiRKtVySZy7cEzbi9M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling both the old AC97_BUS code and the new AC97_BUS_COMPAT causes
problems because both modules provide an exported snd_ac97_reset()
function.

I had tried to fix the problem of having both coexist earlier, but
my patch only prevented them from being built-in. This is because
of a special Kconfig feature that lets a symbol have a dependency
on another one being disabled, but still allow both to be loadable
modules.

Changing the dependency to =n avoids that problem, now we can only
build the new driver if the old one is completely disabled.

If we could figure out a way to let rename one of the reset
functions and have each driver link to exactly the old or
the compat code, that would also work, but I could not find if
that's possible.

Fixes: bec5ecdf41d4 ("ASoC: pxa: avoid AC97_BUS build warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 943b44de1464..6075fc32e6b9 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -79,7 +79,7 @@ config SND_PXA2XX_SOC_TOSA
 	tristate "SoC AC97 Audio support for Tosa"
 	depends on SND_PXA2XX_SOC && MACH_TOSA
 	depends on MFD_TC6393XB
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -89,7 +89,7 @@ config SND_PXA2XX_SOC_TOSA
 config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
 	depends on SND_PXA2XX_SOC && MACH_E740
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -99,7 +99,7 @@ config SND_PXA2XX_SOC_E740
 config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
 	depends on SND_PXA2XX_SOC && MACH_E750
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -109,7 +109,7 @@ config SND_PXA2XX_SOC_E750
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -120,7 +120,7 @@ config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
 	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
 			MACH_CM_X300)
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -131,7 +131,7 @@ config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
 	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
 			MACH_PALMT5 || MACH_PALMTE2)
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -161,7 +161,7 @@ config SND_SOC_TTC_DKB
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
@@ -201,7 +201,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 config SND_PXA2XX_SOC_MIOA701
         tristate "SoC Audio support for MIO A701"
         depends on SND_PXA2XX_SOC && MACH_MIOA701
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
         select SND_PXA2XX_SOC_AC97
         select SND_SOC_WM9713
         help
-- 
2.18.0

