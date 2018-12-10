Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18462082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18462082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeLJUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:50:33 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:50:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8XDT-1haXVZ3cA5-014Sfu; Mon, 10 Dec 2018 21:49:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sdm845: add rt5663 codec select
Date:   Mon, 10 Dec 2018 21:49:28 +0100
Message-Id: <20181210204943.2581826-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w4rfAKEWTPZJpaAiTuYflTVGe/5i7m4IOgSdJRz95DM5CISUHP3
 IQRGk1dI69MWwkVv5h88eXhqRlJ2Lpw1hCq/kFDN70T/kvKzaB/+f8N7nrka9wZ9P/C+2Hk
 CHnEtO2JGZl7uW9F9L7kztAnlgkiRkmma2HX4/Kbi93yiSsc3ubeA6mS13gvytzMm12gl1m
 NDoOi78L568Tnijcq+r9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CDosaClC9D0=:4IHYXo13aNju6hQeZdLvXm
 nAU2dYnKq9TNx1vhvuWXMxE4DVHoXD3cAkJWyODaYq6AKAy4Doi5/70hge2Ktmfnvnfdaqj02
 54EzxwJW02ktjkN/gtFiBu9wKBm0qoVGUh4ptHzuohN2+24NCmo9sjWKRey7XlDbu0KlGaolM
 arf+5o1L1KvgJqulYh6JV2KbK4ov2LfIu8SyPupRYun+0s26tkVSA3B/4LWVX78KRc2IpQgi3
 Dk5Kbueg/fqJIaYn4Fq3Xc0l//CmY08n7gNpw2DlHJ/Ib7Bf0XMrhaz2yPW64jamMYzQS7plQ
 +y+orDdWl5LjQzbpGH3c5+EyGnFbF6uPozSKwCsaXCsFJKDjkTLXznw++NuoUjUmDu1mVhlEI
 a0/r6t6uum/Vp1m1O/f3FOhkTxjwRyLRWSlKIPRws9/Qe/6kofRiiRhyPeLbEMWDN11yFmPy2
 1NVllGgMWdnO7l/YGqj/LD5rkYmvEOvN+iiSzeA6iiZ5MfjlwsuUlIA/dSlUzTkfmyIoP11uR
 LPehfa97mPtPgyw0uUlXQVSgZKW5TjhTFzr9b+bFPcOMOg6G/UkPDYSc1LxXENAvT0F79EqHO
 fbHXCTJaT8d93JMICvzj/RTyHZ4rCEagkDFq0Z8Ce+d2FOnXhGs6PED5UrlN689bic4d2pdNn
 Bh4SgH4c+0tNIVKWTfO7ECYv+0p6LPSLSv6Zi7j6SzOGCyPKHWmSxDP677cof/yKYGjlWdr2H
 PeTyeH799WMH+icsJPLMPCoT/r++TSd5PfrWww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling into the codec driver adds a dependency on that being reachable
from the module:

ERROR: "rt5663_sel_asrc_clk_src" [sound/soc/qcom/snd-soc-sdm845.ko]
undefined!

Add the corresponding select statement, as it is done in the other user
(Intel).

Fixes: f7485875a687 ("ASoC: sdm845: Add configuration for headset codec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e48..1b9fc0665792 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -100,6 +100,7 @@ config SND_SOC_SDM845
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_RT5663
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.0

