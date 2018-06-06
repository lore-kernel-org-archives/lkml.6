Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73D63606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeFFJ53 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:57:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44566 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932260AbeFFJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:57:28 -0400
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak5558: make two structures static
Date: Wed,  6 Jun 2018 10:57:19 +0100
Message-Id: <20180606095719.30831-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure ak5558_pm and soc_codec_dev_ak5558 are local to the
source and do not need to be in global scope, so make them static.
Also make soc_codec_dev_ak5558 static.

Cleans up sparse warnings:
warning: symbol 'ak5558_pm' was not declared. Should it be static?
warning: symbol 'soc_codec_dev_ak5558' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/ak5558.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f4ed5cc40661..aebdd4f78f04 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -322,13 +322,13 @@ static int __maybe_unused ak5558_runtime_resume(struct device *dev)
 	return regcache_sync(ak5558->regmap);
 }
 
-const struct dev_pm_ops ak5558_pm = {
+static const struct dev_pm_ops ak5558_pm = {
 	SET_RUNTIME_PM_OPS(ak5558_runtime_suspend, ak5558_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 };
 
-struct snd_soc_component_driver soc_codec_dev_ak5558 = {
+static const struct snd_soc_component_driver soc_codec_dev_ak5558 = {
 	.probe			= ak5558_probe,
 	.remove			= ak5558_remove,
 	.controls		= ak5558_snd_controls,
-- 
2.17.0
