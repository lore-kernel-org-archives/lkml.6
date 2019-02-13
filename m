Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A00C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D4A21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbfBMHFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:05:12 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34838 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388510AbfBMHFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:05:08 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 344B35F9C2; Wed, 13 Feb 2019 15:05:04 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 1/2] ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to cpvdd
Date:   Wed, 13 Feb 2019 15:04:56 +0800
Message-Id: <20190213070457.26049-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070457.26049-1-wens@csie.org>
References: <20190213070457.26049-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 datasheet lists the supply rail for the headphone amp's charge
pump as "CPVDD". cpvdd-supply is the name of the property for this power
rail specified in the device tree bindings. "HPVCC" was the name used in
the A33 datasheet for the same function.

Rename the supply so it matches the datasheet, bindings, and the subject
from the original commit.

Fixes: ca0412a05756 ("ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index df1fed0aa001..d105c90c3706 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -274,7 +274,7 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
-	SND_SOC_DAPM_REGULATOR_SUPPLY("hpvcc", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
 	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
@@ -362,7 +362,7 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
 	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
 	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
-	{ "Headphone Amp", NULL, "hpvcc" },
+	{ "Headphone Amp", NULL, "cpvdd" },
 	{ "HP", NULL, "Headphone Amp" },
 
 	/* Microphone Routes */
-- 
2.20.1

