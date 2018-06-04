Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeFDUrM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:47:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46838 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeFDUrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:47:11 -0400
X-Google-Smtp-Source: ADUXVKJWabNARTKF6ZFPLKrDBcOcnc5KnnZcBTDQEdavKNyDewNMebY6Fyb2YOY4/tjdlhviqDX1vA==
Date: Mon, 4 Jun 2018 15:47:02 -0500
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel][PATCH 3/3] ASoC: TSCS42xx: Add headphone auto switching
Message-ID: <cec911cd9111bb4ae25bb9ec2df3af134bc49c58.1528143829.git.steven.eckhoff.opensource@gmail.com>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add headphone auto switching controls

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 6 ++++++
 sound/soc/codecs/tscs42xx.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index c79c075228a6..4f56d2937a35 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -641,6 +641,12 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Mic Bias */
 	SOC_SINGLE("Mic Bias Boost Switch", 0x71, 0x07, 1, 0),
 
+	/* Headphone Auto Switching */
+	SOC_SINGLE("Headphone Auto Switching Switch",
+			R_CTL, FB_CTL_HPSWEN, 1, 0),
+	SOC_SINGLE("Headphone Detect Polarity Toggle Switch",
+			R_CTL, FB_CTL_HPSWPOL, 1, 0),
+
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
 	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
diff --git a/sound/soc/codecs/tscs42xx.h b/sound/soc/codecs/tscs42xx.h
index d4a30bcbf64b..9b15bf89c4d0 100644
--- a/sound/soc/codecs/tscs42xx.h
+++ b/sound/soc/codecs/tscs42xx.h
@@ -34,6 +34,7 @@ enum {
 #define R_DACSR         0x19
 #define R_PWRM1         0x1A
 #define R_PWRM2         0x1B
+#define R_CTL		0x1C
 #define R_CONFIG0       0x1F
 #define R_CONFIG1       0x20
 #define R_DMICCTL       0x24
@@ -1110,6 +1111,13 @@ enum {
 #define RV_PWRM2_VREF_DISABLE \
 	 RV(FV_PWRM2_VREF_DISABLE, FB_PWRM2_VREF)
 
+/******************************
+ *      R_CTL (0x1C)          *
+ ******************************/
+
+/* Fiel Offsets */
+#define FB_CTL_HPSWEN                        7
+#define FB_CTL_HPSWPOL                       6
 
 /******************************
  *      R_CONFIG0 (0x1F)      *
-- 
2.17.0
