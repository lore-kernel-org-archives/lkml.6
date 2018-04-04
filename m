Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDDETh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:19:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33971 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDDETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:19:31 -0400
X-Google-Smtp-Source: AIpwx49aenHljfqBwR0D72otcqOKHIDZ8ra3cf1VenOtNSnmtHrn6hhNiSvRumQn3h+USshLbgOLOA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v4 3/3] ASoC: topology: Add definitions for mclk_direction values
Date: Wed,  4 Apr 2018 06:19:39 +0200
Message-Id: <20180404041939.23317-4-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404041939.23317-1-k.marinushkin@gmail.com>
References: <20180404041939.23317-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current comment makes not clear the direction of mclk. Previously, similar
description caused a misunderstanding for bclk_master and fsync_master.

This commit solves the potential confusion the same way it is solved for
bclk_master and fsync_master.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 include/uapi/sound/asoc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f3c4b46e39d8..b901cdbe532a 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -144,6 +144,10 @@
 #define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
 #define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
 
+/* DAI mclk_direction */
+#define SND_SOC_TPLG_MCLK_CO            0 /* for codec, mclk is output */
+#define SND_SOC_TPLG_MCLK_CI            1 /* for codec, mclk is input */
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -334,7 +338,7 @@ struct snd_soc_tplg_hw_config {
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
 	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
-	__u8 mclk_direction;    /* 0 for input, 1 for output */
+	__u8 mclk_direction;    /* SND_SOC_TPLG_MCLK_ value */
 	__le16 reserved;	/* for 32bit alignment */
 	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
 	__le32 bclk_rate;	/* BCLK freqency in Hz */
-- 
2.13.6
