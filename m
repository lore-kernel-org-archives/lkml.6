Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E46CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B2120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeGXKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:43:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58552 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbeGXKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:43:16 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mfwsi-1fKiZT0zUS-00NB7y; Tue, 24 Jul 2018 11:37:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: axg-spdifout: select SND_PCM_IEC958
Date:   Tue, 24 Jul 2018 11:36:45 +0200
Message-Id: <20180724093705.1691747-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:ajL6zwNSpxYI+LB6xDn8DiUN4uJ/sCiKoo+3YpjkWjfL2chb7ab
 +xmf2ku71NFbOGSspMEStQhmc0RG53buKnypRSWiLDj5vGXJPdlqs6qX//5xg/tmhe1ggU2
 ro+jXhDr91e9J2YNKKKoK1z7pRVsIIEO8TUM2T1GRQ9s5I1bBvIs03bSQAvUOaD/sjhPFAD
 KaM+9Y3/QdIEBhGzkY28g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jEFgp+6BVCI=:HAR2hNr3FfoM5aHRSgTIWs
 FzoO85lTGa/PwRbaxjpIb6+D8iqMwhysR8/iXLtvRG15o07FZZEZNykyOB8sa1Mk9KzO9cxVW
 9DoY93mohHbmmVY4ysryH7qdRkN8U8xHwFpyrk8XHKmKWjDPLQXtviNt4hmEujEtVTi/MeE49
 U8ePWXsr39Vt8nESWM2ezaG81yZvMb4ecN89j4jTQzG60Vf7d9+QSHqZ2yfvEE0+zq237wzaO
 J+BHqQTU1CLVeA37ea09UuuenVm7r1joM0mULCSZASuoY5V4fxK8ByxB0gj740Ca6yneZ/9kg
 mqyopj1C/dEXJ1v4aOAeEsuTW1vckBhEkzMiZ8/7uYcoIaPyZaNp02q1sZ9ZTA9usQQ3iVbGc
 Wx1xgwsQGpA+ENiHae8Hq07ucCCC0EoOWjlGp9/lNRU3KwBXbZXeyfz28HGholYCf9T8jnFNd
 i3pVjxEqwwM1G/6BQruVUd3GbOI9niNreYS816rVjikynZgbpHWyjDcXi4P0va9Ka6SVsZN/Z
 O0UbztuTV56nIyj5SVukwTqxM1N996fgp0B9KQen1oUEQYuv6WSGj+tjF5Eoc6qXp+DfHTia6
 R45QsEXrsMqjbOWBzM17U9I52I10gjMrfvP9yH/Wg6rQdZfAjlvzx0/qn8tb9/v1dPs3+Fjab
 RJlHx/gcy1q6EX1J6nZbbNyYDaBpZmioptwdicOB4d76PHEESLo5QbirT0vg9/mzvy+c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SND_PCM_IEC958 is disabled, we get a link error for the
new driver:

sound/soc/meson/axg-spdifout.o: In function `axg_spdifout_hw_params':
axg-spdifout.c:(.text+0x650): undefined reference to `snd_pcm_create_iec958_consumer_hw_params'

The other users use 'select', so we should do the same here.

Fixes: 53eb4b7aaa04 ("ASoC: meson: add axg spdif output")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 4cf93c05a982..8af8bc358a90 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -56,6 +56,7 @@ config SND_MESON_AXG_SOUND_CARD
 
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
+	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
-- 
2.18.0

