Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B22E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeFFKbb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:31:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44995 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeFFKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:31:30 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak4458: make structure soc_codec_dev_ak4458 static const
Date: Wed,  6 Jun 2018 11:31:23 +0100
Message-Id: <20180606103123.31719-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure soc_codec_dev_ak4458 is local to the source and do not
need to be in global scope and can be const, make it static const.

Cleans up sparse warnings:
warning: symbol 'soc_codec_dev_ak4458' was not declared. Should it
be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/ak4458.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 31ec0ba2e639..299ada4dfaa0 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -558,7 +558,7 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-struct snd_soc_component_driver soc_codec_dev_ak4458 = {
+static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
 	.probe			= ak4458_probe,
 	.remove			= ak4458_remove,
 	.controls		= ak4458_snd_controls,
-- 
2.17.0
