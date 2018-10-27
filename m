Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B26C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FB92086C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FB92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeJ0WvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 18:51:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29007
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbeJ0WvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 18:51:13 -0400
X-IronPort-AV: E=Sophos;i="5.54,432,1534802400"; 
   d="scan'208";a="283512250"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 16:10:03 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: codecs: constify snd_soc_dai_ops structures
Date:   Sat, 27 Oct 2018 15:34:44 +0200
Message-Id: <1540647284-26728-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/codecs/ak4458.c   |    2 +-
 sound/soc/codecs/ak5558.c   |    2 +-
 sound/soc/codecs/hdac_hda.c |    2 +-
 sound/soc/codecs/tas6424.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 299ada4dfaa0..70d4c89bd6fc 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -456,7 +456,7 @@ static int ak4458_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_dai_ops ak4458_dai_ops = {
+static const struct snd_soc_dai_ops ak4458_dai_ops = {
 	.startup        = ak4458_startup,
 	.hw_params	= ak4458_hw_params,
 	.set_fmt	= ak4458_set_dai_fmt,
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 448bb90c9c8e..60f1f12c81ea 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -246,7 +246,7 @@ static int ak5558_startup(struct snd_pcm_substream *substream,
 					  &ak5558_rate_constraints);
 }
 
-static struct snd_soc_dai_ops ak5558_dai_ops = {
+static const struct snd_soc_dai_ops ak5558_dai_ops = {
 	.startup        = ak5558_startup,
 	.hw_params	= ak5558_hw_params,
 
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 2aaa83028e55..ffecdaaa8cf2 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -46,7 +46,7 @@ static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
 static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 						 struct snd_soc_dai *dai);
 
-static struct snd_soc_dai_ops hdac_hda_dai_ops = {
+static const struct snd_soc_dai_ops hdac_hda_dai_ops = {
 	.startup = hdac_hda_dai_open,
 	.shutdown = hdac_hda_dai_close,
 	.prepare = hdac_hda_dai_prepare,
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 36aebdb8f55c..aaba39295079 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -378,7 +378,7 @@ static struct snd_soc_component_driver soc_codec_dev_tas6424 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
+static const struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
 	.hw_params	= tas6424_hw_params,
 	.set_fmt	= tas6424_set_dai_fmt,
 	.set_tdm_slot	= tas6424_set_dai_tdm_slot,

