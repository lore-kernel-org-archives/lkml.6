Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60756C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFA2218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAECEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:04:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfAECEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:04:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634790"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:04:05 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/21] ASoC: max98927: fix boolean assignments
Date:   Fri,  4 Jan 2019 20:02:41 -0600
Message-Id: <20190105020249.8639-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Coccinelle:
sound/soc/codecs/max98927.c:508:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:889:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:891:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:893:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98927.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 065303a46535..e53d2007f3be 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -505,7 +505,7 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		max98927->tdm_mode = 0;
+		max98927->tdm_mode = false;
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(max98927->regmap,
@@ -886,11 +886,11 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	if (!of_property_read_u32(i2c->dev.of_node,
 		"interleave_mode", &value)) {
 		if (value > 0)
-			max98927->interleave_mode = 1;
+			max98927->interleave_mode = true;
 		else
-			max98927->interleave_mode = 0;
+			max98927->interleave_mode = false;
 	} else
-		max98927->interleave_mode = 0;
+		max98927->interleave_mode = false;
 
 	/* regmap initialization */
 	max98927->regmap
-- 
2.17.1

