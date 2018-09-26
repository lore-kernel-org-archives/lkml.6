Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD26C004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC56E2173F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC56E2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeI0BxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:53:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeI0BxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:53:24 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMoOy-1gNsyj1pIa-00ImP7; Wed, 26 Sep 2018 21:37:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm9712: fix unused variable warning
Date:   Wed, 26 Sep 2018 21:37:40 +0200
Message-Id: <20180926193750.2468414-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:ta/u0qgWp0cmBz/Syz+o2PFf8tnus0PbJDhOwnfrQ2MQVvO0EWE
 IEuLWswjfu3lv10DsFfnijVua6FQvTbrLLxJ/3E9F6sxr4+uyqRYm10YiMJqNzNsyruwHjK
 iGHsq1PJlSkHJlkmck7x6RbBbT0y+ZISjb5ncTpuWV97d9yEYbSnd1dp2ZMYjZb82eqGMTe
 b8cQPiJcPbD7MX6q+oUPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I89YepxwDdw=:Rn2dZ4ApVZBRng68itqPrb
 zqq0gmfPzQ61jJfHXEF0gUYJ9DNi1MoxAkCr5wKE3MWGKrNbQwj/EP1MbgIyD+RKdE8ApLood
 DSiAXqvWao9gakxyed4HpJJtTsnbEaWATk/g7SYikuTdLgiiPv8dLrOv8CaN7z9zzeiEOliYC
 pcfiPjg1gZgllv1zZP7sL34GRbXHxHVieZWil2/FvMIqaAvy6dWla3yDt8207Qd7hXQVvwJT/
 Sq1Nr5oMxzk3u5Ca4c8FpwzuUlXMOQ4uzlPi3rVofbX9yPxmtL8FjcfNkn0FVf2Cmza4nnYeo
 AzeBa6qnGuNaHpWzv4pDkcyz1ThFneAO7s18jRp8n5hH0HWoUo1BwXzgSvsByYPGs+SogVMKu
 AaAhokwoD0RRd/SORTVl6VjkHRCDOcuWSIKOuni/b5EWSwFZeug0Q9ZJfq3EEVFnsTLL4RDZt
 WDRSjpLX/pWE6dKb8ApeZ5bc40rymkGVUPWbuh7GDRWFicnCYV5C7JESaRiotf5+yfJZXZe3s
 IKLjFmu8Oo6haie0ICVpxS2WdRYojalqDSubP6DNciteTvVzsg7Y5/Vpv8NUvyFAuJ9eppbnQ
 0z5TF1dCfz/kLVTZPaWVWBva9c7dx/r/w8uN8X74/stG2PZR8jf2hkLaIBmZ94s4T3qkTSNEk
 X0qdL7+eqGATreqOSpWBqOtUAAs6QhTuslgVyZNQWqvOcB54/Q0OK1XGQL1CRFevwBU4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ret' variable is now only used in an #ifdef, and causes a
warning if it is declared outside of that block:

sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
sound/soc/codecs/wm9712.c:641:6: error: unused variable 'ret' [-Werror=unused-variable]

Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/wm9712.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index ade34c26ad2f..e873baa9e778 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -638,13 +638,14 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 {
 	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap;
-	int ret;
 
 	if (wm9712->mfd_pdata) {
 		wm9712->ac97 = wm9712->mfd_pdata->ac97;
 		regmap = wm9712->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
+		int ret;
+
 		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
 						      WM9712_VENDOR_ID_MASK);
 		if (IS_ERR(wm9712->ac97)) {
-- 
2.18.0

