Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeE3PNL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:13:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7992 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeE3PNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:13:06 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 May 2018 08:13:06 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ASoC: core: Fix return code shown on error for hw_params
Date: Wed, 30 May 2018 16:12:58 +0100
Message-ID: <1527693178-5038-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to hw_params for a component fails the error code is held by
the variable '__ret' but the error message displays the value held by
the variable 'ret'. Fix the return code shown when hw_params fails for
a component.

Fixes: b8135864d4d3 ("ASoC: snd_soc_component_driver has snd_pcm_ops")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2df4719a84db..9376eb476364 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -956,7 +956,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		if (__ret < 0) {
 			dev_err(component->dev,
 				"ASoC: %s hw params failed: %d\n",
-				component->name, ret);
+				component->name, __ret);
 			ret = __ret;
 		}
 	}
-- 
2.7.4
