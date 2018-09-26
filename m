Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D40C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D10208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D10208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeIZTBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:01:30 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIZTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:01:30 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MI4gb-1g0xo714sR-00FAzJ; Wed, 26 Sep 2018 14:46:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: pxa: avoid AC97_BUS build warning
Date:   Wed, 26 Sep 2018 14:46:35 +0200
Message-Id: <20180926124645.1841850-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Paslmu6oCOV7BygejY9T2cBoJh+GkiVnwNcqwNUmwxRQt5Axwnx
 BcIQ/Cm7jdBH7iP0jZEycGKxfYfF1gbKXfsukF1vNaOMoJwIhPYUlzJoF4UPHV7tFO50mMy
 KTKMrd4ej3F/S3RLhyw0ZwXUH7rbUCVttqB22fx1sLs0F+fuBExND8qvP2p54u7fYD+7S8M
 Hi8ma0W3bqyDQBMP/1e1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OGmLdEDjc8M=:2CXxnncQ0uJ7LfBiETyng9
 Efzk/R+iThQwcWDlhyIhSo/Q3nvEiv5jCs2u27sgSaIJkSkZ+9HcEogA+r+n0stBtvYf1C63K
 8QlIjSw17K9dXG/0ycZnxzPXHI3uzlBRnZjj0TOnVa996huOfhA1fsPx17otbV1OT4UfBPK3R
 I/0oGvQgKpxxvH+ff5GC00xDI07LtuJj0h5UAKUej0TPZyF1WyQJpt1eSvCcQhsW/J23xTyjG
 pAHYiqqeyrOQVSEJuTrFtDKNgIceQfA7Xhd5N04uTKK0RI23I07R9CgLAsNAFIYqWyVET93y7
 qAugFyYfBNc84MwvLi/59UYrCVXH/inaYndhbM7XignRVO0X4rsyQdOc9xH69IZR7Bh+jWJ8l
 4oYpHj/kZlyTbFArZyzb7I9w5y3adhaRLCtC9gNQE6zUmbg8Nndm0z1erPpuaimHuHx94pmz2
 Ac+ThkayWeulAguFs54yFUM2CsjyHYXVyacm/ySZbf8OqOmzaz8bMcbWXT9v5RhPz7QQN7G6Z
 jn0UG0u7uvXzy9qCkcaVRpffDHmyXhCssRjSMaF5ZfZ71ifjKLVrGcuc/8YlJIYiWotbQIJql
 w0bOJBmiXSJgfD5DC0GUexWUTI6xe2QDJtLDqZP6lIO+6hlvCiimh22kmfwMzSqvqyUUOYX+A
 mSEQPcKW/BkzlgqwZMd/b4Ol64iZJgIRBW79xp2Wt+iWyNFH1KSao8FrGaI1rb92Ads4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting AC97_BUS_NEW from SND_PXA2XX_SOC_AC97 leads to a Kconfig
warning if any other driver selects AC97_BUS:

WARNING: unmet direct dependencies detected for AC97_BUS_COMPAT
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && AC97_BUS_NEW [=y] && !AC97_BUS [=y]
  Selected by [y]:
  - SND_SOC_WM9713 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && AC97_BUS_NEW [=y]

I don't know if that combination is supposed to work.
Assuming it is not, this adds a dependency on all users
for PXA to avoids the combination.

Fixes: 1c8bc7b3de5e ("ASoC: pxa: switch to new ac97 bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 29f577e6dfc0..943b44de1464 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -79,6 +79,7 @@ config SND_PXA2XX_SOC_TOSA
 	tristate "SoC AC97 Audio support for Tosa"
 	depends on SND_PXA2XX_SOC && MACH_TOSA
 	depends on MFD_TC6393XB
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -88,6 +89,7 @@ config SND_PXA2XX_SOC_TOSA
 config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
 	depends on SND_PXA2XX_SOC && MACH_E740
+	depends on !AC97_BUS
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -97,6 +99,7 @@ config SND_PXA2XX_SOC_E740
 config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
 	depends on SND_PXA2XX_SOC && MACH_E750
+	depends on !AC97_BUS
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -106,6 +109,7 @@ config SND_PXA2XX_SOC_E750
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
+	depends on !AC97_BUS
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -116,6 +120,7 @@ config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
 	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
 			MACH_CM_X300)
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -126,6 +131,7 @@ config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
 	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
 			MACH_PALMT5 || MACH_PALMTE2)
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -155,6 +161,7 @@ config SND_SOC_TTC_DKB
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
@@ -194,6 +201,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 config SND_PXA2XX_SOC_MIOA701
         tristate "SoC Audio support for MIO A701"
         depends on SND_PXA2XX_SOC && MACH_MIOA701
+	depends on !AC97_BUS
         select SND_PXA2XX_SOC_AC97
         select SND_SOC_WM9713
         help
-- 
2.18.0

